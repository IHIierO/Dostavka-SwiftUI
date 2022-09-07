//
//  RealmMigration.swift
//  dostavka
//
//  Created by Artem Vorobev on 11.07.2022.
//

import RealmSwift

enum RealmMigrator {
  // 1
  static private func migrationBlock(
    migration: Migration,
    oldSchemaVersion: UInt64
  ) {
    // 2
    if oldSchemaVersion < 15 {
        
    }
  }
  static var configuration: Realm.Configuration {
    Realm.Configuration(schemaVersion: 15, migrationBlock: migrationBlock)
  }
}
