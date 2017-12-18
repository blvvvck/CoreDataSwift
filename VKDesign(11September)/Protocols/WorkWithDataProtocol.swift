//
//  WorkWithDataProtocol.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 29/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

protocol WorkWithDataProtocol {
 
    func syncSave<T: NSObject>(with: T)
    func asyncSave<T: NSObject>(with: T, completionBlock: @escaping (Bool) -> ())
    func syncGetAll<T: NSObject>() -> [T]?
    func asyncGetAll<T: NSObject>(completionBlock: @escaping ([T]) -> ())
    func syncFind<T: NSObject>(id: String) -> T? where T: HasIdProtocol
    func asyncFind<T: NSObject>(id: String, completionBlock: @escaping (T?) -> ()) where T: HasIdProtocol
}
