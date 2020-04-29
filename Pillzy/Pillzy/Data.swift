//
//  Data.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/30/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import Foundation
import RealmSwift

let config = Realm.Configuration(schemaVersion:1)
let realm = try! Realm(configuration: config)
let res = realm.objects(Pill.self)
