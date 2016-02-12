//
//  ProfileManager.swift
//  Antidote
//
//  Created by Dmytro Vorobiov on 19/10/15.
//  Copyright © 2015 dvor. All rights reserved.
//

import Foundation

private struct Constants {
    static let SaveDirectoryPath = "saves"
}

class ProfileManager {
    private(set) var allProfileNames: [String]

    init() {
        allProfileNames = []

        reloadProfileNames()
    }

    func createProfileWithName(name: String) throws {
        let path = pathFromName(name)

        try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)

        reloadProfileNames()
    }

    func deleteProfileWithName(name: String) throws {
        let path = pathFromName(name)

        try NSFileManager.defaultManager().removeItemAtPath(path)

        reloadProfileNames()
    }

    func renameProfileWithName(fromName: String, toName: String) throws {
        let fromPath = pathFromName(fromName)
        let toPath = pathFromName(toName)

        try NSFileManager.defaultManager().moveItemAtPath(fromPath, toPath: toPath)

        reloadProfileNames()
    }

    func pathForProfileWithName(name: String) -> String {
        return pathFromName(name)
    }
}

private extension ProfileManager {
    func saveDirectoryPath() -> String {
        let path: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return path.stringByAppendingPathComponent(Constants.SaveDirectoryPath)
    }

    func pathFromName(name: String) -> String {
        let directoryPath: NSString = saveDirectoryPath()
        return directoryPath.stringByAppendingPathComponent(name)
    }

    func reloadProfileNames() {
        let fileManager = NSFileManager.defaultManager()
        let savePath = saveDirectoryPath()

        let contents = try? fileManager.contentsOfDirectoryAtPath(savePath)

        allProfileNames = contents?.filter {
            let path = (savePath as NSString).stringByAppendingPathComponent($0)

            var isDirectory: ObjCBool = false
            fileManager.fileExistsAtPath(path, isDirectory:&isDirectory)

            return isDirectory.boolValue
        } ?? [String]()
    }
}
