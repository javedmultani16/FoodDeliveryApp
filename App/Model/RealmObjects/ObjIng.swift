//
//  ObjIng.swift
//
//  Created by Javed Multani on 16/11/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ObjIng: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kObjIngTitleKey: String = "Title"
  private let kObjIngPriceKey: String = "Price"

  // MARK: Properties
  public var title: String?
  public var price: Int?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    title = json[kObjIngTitleKey].string
    price = json[kObjIngPriceKey].int
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[kObjIngTitleKey] = value }
    if let value = price { dictionary[kObjIngPriceKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: kObjIngTitleKey) as? String
    self.price = aDecoder.decodeObject(forKey: kObjIngPriceKey) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: kObjIngTitleKey)
    aCoder.encode(price, forKey: kObjIngPriceKey)
  }

}
