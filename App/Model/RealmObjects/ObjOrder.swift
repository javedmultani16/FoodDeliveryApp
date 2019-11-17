//
//  ObjOrder.swift
//
//  Created by Javed Multani on 16/11/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ObjOrder: NSObject,NSCoding,Codable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kObjOrderTitleKey: String = "Title"
  private let kObjOrderIngKey: String = "Ing"
  private let kObjOrderPriceKey: String = "Price"

  // MARK: Properties
  public var title: String?
  public var ing: String?
  public var price: String?

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
    title = json[kObjOrderTitleKey].string
    ing = json[kObjOrderIngKey].string
    price = json[kObjOrderPriceKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[kObjOrderTitleKey] = value }
    if let value = ing { dictionary[kObjOrderIngKey] = value }
    if let value = price { dictionary[kObjOrderPriceKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: kObjOrderTitleKey) as? String
    self.ing = aDecoder.decodeObject(forKey: kObjOrderIngKey) as? String
    self.price = aDecoder.decodeObject(forKey: kObjOrderPriceKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: kObjOrderTitleKey)
    aCoder.encode(ing, forKey: kObjOrderIngKey)
    aCoder.encode(price, forKey: kObjOrderPriceKey)
  }

}
