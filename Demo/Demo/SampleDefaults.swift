//
//  SampleDefaults.swift
//  Demo
//
//  Created by Yusaku Nishi on 2017/12/20.
//

import SafeDefaultsKit

struct ProfileDefaults: SafeDefaults {
    
    enum Keys: String, DefaultsKey {
        case firstname // the key name is "firstname"
        case lastname // the key name is "lastname"
        case age = "userAgeKey" // the key name is "userAgeKey"
    }
    
}

struct SettingDefaults: SafeDefaults {
    
    enum Keys: String, DefaultsKey {
        case mainColorIndex // the key name is "SettingDefaults.Keys.mainColorIndex"
        case syncWithCloud // the key name is "SettingDefaults.Keys.syncWithCloud"
        
        var uniqueValue: String {
            return "SettingDefaults.\(Keys.self).\(self.rawValue)"
        }
    }
    
}
