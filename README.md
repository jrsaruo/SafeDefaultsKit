# SafeDefaultsKit
![iOS 10.0+](https://img.shields.io/badge/platform-iOS%2010%2B-blue.svg?style=flat)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)

Pure-Swift library for safe access to UserDefaults
- [Requirements](#requirements)
- [Features](#features)
- [Usage](#usage)
- [Caution](#caution)
- [License](#license)


## Requirements
* Xcode 9
* Swift 4.0+
* iOS 10.0+


## Features
### Safe access by using Enum as key
You can define original keys and safely access to `UserDefaults` by using them.
```swift
// Initialize your Defaults
let defaults = YourDefaults()

// Set value for Defaults
defaults.set("saved string", forKey: .definedKey)

// Get value from Defaults
print(defaults.string(forKey: .definedKey) ?? "no value") // -> "saved string"

// Remove value from Defaults
defaults.removeObject(forKey: .definedKey)
print(defaults.string(forKey: .definedKey) ?? "no value") // -> "no value"
```

### Divide Defaults
By dividing Defaults for each purposes, it becomes easier to manage keys.
```swift
let loginInfoDefaults = LoginInfoDefaults() // LoginInfoDefaults has "loginDate" key
loginInfoDefaults.set(Date(), forKey: .loginDate)

let settingDefaults = SettingDefaults() // SettingDefaults has "mainColor" key
settingDefaults.set("red", forKey: .mainColor)
```


## Usage
At first, declare the type that conforms to the `SafeDefaults` protocol. This requires nested Enum named `Keys` that conforms to the `DefaultsKey` protocol and stores **string raw values**, and its cases are used as keys for your Defaults.

### Simplest Declaration
```swift
struct SampleDefaults: SafeDefaults {

    enum Keys: String, DefaultsKey {
        case userName
    }

}

SampleDefaults().set("Tom", forKey: .userName)
// same as: UserDefaults.standard.set("Tom", forKey: "userName")
```

### Customize the key name for UserDefaults
`DefaultsKey` requires the `uniqueValue` property, used as the key name for `UserDefaults`.
`uniqueValue`'s **default value is its raw value**.
```swift
struct SampleDefaults: SafeDefaults {

    enum Keys: String, DefaultsKey {
        case userName = "customizedKeyForUserName"
    }
}

SampleDefaults().set("Tom", forKey: .userName)
// same as: UserDefaults.standard.set("Tom", forKey: "customizedKeyForUserName")
```

If you declare `uniqueValue` explicitly, it is used as the key name instead of the raw value.
```swift
struct SampleDefaults: SafeDefaults {

    enum Keys: String, DefaultsKey {
        case userName

        // customize the key name for UserDefaults
        var uniqueValue: String {
            return "SampleDefaults.\(Keys.self).\(self.rawValue)"
        }
    }

}

SampleDefaults().set("Tom", forKey: .userName)
// same as: UserDefaults.standard.set("Tom", forKey: "SampleDefaults.Keys.userName")
```


<a name="caution"></a>
## :warning: Caution
### Difference from UserDefaults
getter methods for double, float, integer return **optional** value. If the specified key doesn‘t exist, these methods return `nil`.
```swift
UserDefaults.standard.removeObject(forKey: "removed")

UserDefaults.standard.integer(forKey: "removed") // -> 0
YourDefaults().integer(forKey: .removed) // -> nil
```

### Keys.uniqueValue is NOT guaranteed to be unique entirely
`uniqueValue` is used as key name for `UserDefaults` and default is its raw value, so **there is fear that some keys conflict each other**.

#### :x: NG sample
```swift
struct BookDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case id
    }
}

struct ComicDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case id // MARK: This uniqueValue conflicts with that of BookDefaults.Keys.id
    }
}

BookDefaults().set(5, forKey: .id) // same as: UserDefaults.set(5, forKey: "id")
ComicDefaults().set(10, forKey: .id) // same as: UserDefaults.set(10, forKey: "id")
print(BookDefaults().integer(forKey: .id)!) // -> 10 (not 5)
```

#### :o: Avoid the same case name
```swift
struct BookDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case bookID
    }
}

struct ComicDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case comicID
    }
}

BookDefaults().set(5, forKey: .bookID) // same as: UserDefaults.set(5, forKey: "bookID")
ComicDefaults().set(10, forKey: .comicID) // same as: UserDefaults.set(10, forKey: "comicID")
print(BookDefaults().integer(forKey: .bookID)!) // -> 5
```

#### :o: Set differerent rawValues explicitly
```swift
struct BookDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case id = "bookID"
    }
}

struct ComicDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case id = "comicID"
    }
}

BookDefaults().set(5, forKey: .id) // same as: UserDefaults.set(5, forKey: "bookID")
ComicDefaults().set(10, forKey: .id) // same as: UserDefaults.set(10, forKey: "comicID")
print(BookDefaults().integer(forKey: .id)!) // -> 5
```

#### :o: Declare uniqueValue by yourself
It is possible to customize key name for UserDefaults by declaring `uniqueValue`. For example, you can use your Defaults' name as the namespace.
```swift
struct BookDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case id

        var uniqueValue: String {
            // use "BookDefaults.Keys" as the namespace
            return "BookDefaults.\(Keys.self).\(self.rawValue)"
        }
    }
}

struct ComicDefaults: SafeDefaults {
    enum Keys: String, DefaultsKey {
        case id

        var uniqueValue: String {
            return "ComicDefaults.\(Keys.self).\(self.rawValue)"
        }
    }
}

BookDefaults().set(5, forKey: .id) // same as: UserDefaults.set(5, forKey: "BookDefaults.Keys.id")
ComicDefaults().set(10, forKey: .id) // same as: UserDefaults.set(10, forKey: "ComicDefaults.Keys.id")
print(BookDefaults().integer(forKey: .id)!) // -> 5
```


## License
SafeDefaultsKit is under MIT license. See the [LICENSE](LICENSE) file for more info.
