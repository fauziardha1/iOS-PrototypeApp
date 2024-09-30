//
//  ViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/24.
//

import UIKit
import RealmSwift
import Realm

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemPink
        
        createTODO()
        createBizkitIPMap()
        print("data")
    }
    
    func createTODO() {
        var realm: Realm?
        do {
            realm = try Realm()
        } catch {
            print("failed to create realm object")
        }
        
        let todo = Todo(name: "Do laundry", ownerId: UUID().uuidString)
        do {
            try realm?.write {
                realm?.add(todo)
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func createBizkitIPMap() {
        var ipmap = BizkitIPMapModel()
        ipmap.addRealm {
            ipmap.deviceName = "Hello"
            ipmap.ipAddress = UUID().uuidString
        }
    }
    
   
}


public class BizkitIPMapModel: HBBaseModel {
    @objc open dynamic var deviceName: String = ""
    @objc open dynamic var ipAddress: String = ""
}


open class HBBaseModel: Object {
    @objc open dynamic var hbId: String = ""
    @objc open dynamic var hbModified = false
    @objc open dynamic var isUploaded = false
    @objc open dynamic var realmDownSync = false

    override public static func primaryKey() -> String? {
        return "hbId"
    }

    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }

    required public override init() {
        super.init()
        self.generateHbId()
        self.hbModified = false
    }

    required public init?(dictionary: NSDictionary?) {
        super.init()
    }

    public init(hbId: String!) {
        super.init()

        if hbId == nil || hbId == "" {
            self.generateHbId()
        } else {
            self.hbId = hbId
        }
    }

    required public init(value: Any, schema: RLMSchema) {
        super.init()
    }

    open func generateHbId() {
        self.hbId = UUID().uuidString
    }

    open func deleteRealm() {
        if let realm = self.realm {
            if !realm.isInWriteTransaction {
                try! realm.write {
                    realm.delete(self)
                }
            } else {
                realm.delete(self)
            }
            
            realm.refresh()
        }
    }

    open func addRealm(_ writeBlock: @escaping (() -> Void) = {}) {
        let realm = try! Realm()

        if realm.isInWriteTransaction {
            writeBlock()
            realm.add(self, update: .all)
            return
        }
        
        realm.beginWrite()
        writeBlock()
        realm.add(self, update: .all)
        try! realm.commitWrite()
        
        realm.refresh()
    }

    func setValueForNonStandard(_ value: AnyObject, forKey key: String) {

    }

    open func getDictionary() -> NSDictionary {
        let d = NSMutableDictionary()
        d["hbId"] = self.hbId
        return d
    }

    open func getDictionaryJsonable() -> NSDictionary {
        let d = self.getDictionary()
        return d
    }

    open class var userDefaultKey: String {
        return ""
    }


    public static func arrayHbIdFromObjectArray<T: HBBaseModel>(dataArray array: [T]) -> NSArray {
        let a = NSMutableArray()

        for i in array {
            let d = i.getDictionary()
            a.add(d["hbId"]!)
        }

        return a
    }

    public static func arrayFromObjectArray<T: HBBaseModel>(dataArray array: [T]) -> NSArray {
        let a = NSMutableArray()

        for i in array {
            a.add(i.getDictionary())
        }

        return a
    }

    public static func objectArrayFromArrayHbId<T: HBBaseModel>(_ array: NSArray, type: T.Type) -> [T] {
        var data = [T]()

        let allData = self.getAllRealm(type)

        for i in array {
            if let t = allData.filter({ $0.hbId == i as! String }).first {
                data.append(t)
            }
        }

        return data
    }

    open class func objectFromHbId<T: HBBaseModel>(_ hbId: String) -> T? {
        let first = self.getRealm(NSPredicate(format: "hbId = %@", hbId), type: T.self).first

        return first
    }

    public static func objectArrayFromArray<T: HBBaseModel>(_ array: NSArray) -> [T] {
        var data = [T]()

        for i in array {
            let d = i as! NSDictionary
            let t = T(dictionary: d)

            // If it return nill, just ignore it
            if t == nil {
                continue
            }

            t!.addRealm()

            data.append(t!)
        }

        return data
    }


    // Realm related functions //
    open class func getRealmResults<T: HBBaseModel>(_ predicate: NSPredicate!, type: T.Type? = nil) -> Results<T> {
        if predicate == nil {
            let d = try! Realm().objects(T.self)
            return d
        }

        let d = try! Realm().objects(T.self).filter(predicate)
        return d
    }

    open class func getRealm<T: HBBaseModel>(_ predicate: NSPredicate, type: T.Type? = nil) -> [T] {
        let d = try! Realm().objects(T.self).filter(predicate)

        return Array(d)
    }

    open class func getAllRealm<T: HBBaseModel>(_ result: T.Type? = nil) -> [T] {
        let d = try! Realm().objects(T.self)

        return Array(d)
    }

    open class func removeAllRealm<T: HBBaseModel>(_ type: T.Type) {
        let realm = try! Realm()

        try! realm.write {
            realm.delete(realm.objects(type))
        }
    }

    open class func resetSync<T: HBBaseModel>(_ type: T.Type) {
        let realm = try! Realm()

        try! realm.write {
            let predicate = NSPredicate(format: "realmDownSync = %@", NSNumber(value: false))
            realm.delete(realm.objects(type).filter(predicate))
            realm.objects(type).forEach({ $0.realmDownSync = false })
        }
    }

    public static func getArrayHbId<T: HBBaseModel>(_ data: [T]?) -> [String]? {
        if data == nil {
            return nil
        }

        var ids = [String]()

        for i in data! {
            ids.append(i.hbId)
        }

        return ids
    }

    open class func getAllDictionary<T: HBBaseModel>(_ type: T.Type) -> NSArray {
        return self.arrayFromObjectArray(dataArray: self.getAllRealm(type))
    }
    
    open class func getByHbId<T: HBBaseModel>(_ hbId: String, type: T.Type) -> T? {
        let realm = try! Realm()
        return realm.objects(type).filter("hbId = %@", hbId).first
    }
    
    open class func getByHbId(_ hbId: String) -> Self? {
        let realm = try! Realm()
        return realm.objects(self).filter("hbId = %@", hbId).first
    }
}


extension HBBaseModel {
    public func writeToRealm( completion: @escaping (Error?) -> Void = {_ in }) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(self, update: .all)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    public func deleteFromRealm(completion: @escaping (Error?) -> Void = {_ in }) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.delete(self)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
}
