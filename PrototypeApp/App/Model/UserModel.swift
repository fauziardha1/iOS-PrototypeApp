//
//  UserModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/24.
//
import RealmSwift

class Todo: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var status: String = ""
   @Persisted var ownerId: String
   convenience init(name: String, ownerId: String) {
       self.init()
       self.name = name
       self.ownerId = ownerId
   }
}
