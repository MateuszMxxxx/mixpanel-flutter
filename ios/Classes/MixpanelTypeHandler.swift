 import Foundation
 import Mixpanel

 class MixpanelTypeHandler {

    static func mixpanelPanelTypeValue(_ object: Any) -> MixpanelType? {
        switch object {
        case let value as NSNumber:
            return value as MixpanelType

        case let value as String:
            return value as MixpanelType

        case let value as Date:
            return value as MixpanelType

        case let value as URL:
            return value

        case let value as NSNull:
            return value

        case let value as MixpanelType:
            return value

        case let value as [Any]:
            return value.map { mixpanelPanelTypeValue($0) }

        default:
            return nil
        }
    }

    static func mixpanelProperties(properties: Dictionary<String, Any>? = nil, mixpanelProperties: Dictionary<String, Any>? = nil) -> Dictionary<String, MixpanelType> {
        var properties = (properties != nil) ? properties : [:]

        if let mixpanelProperties = mixpanelProperties {
            properties?.merge(dict: mixpanelProperties)
        }

        var allProperties = Dictionary<String, MixpanelType>()

        for (key, value) in properties ?? [:] {
            allProperties[key] = mixpanelPanelTypeValue(value)
        }

        return allProperties
    }
 }

 extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
 }
