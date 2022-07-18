# SmartString

Powerful and small library written in **Swift** that will allow you to create complex attributed strings. Easily chain Strings + SmartStrings to create the perfect style, and register substrings Tap Getures handlers.

## Features

- [x] Powerful and intuitive APIs
- [x] Easily chain SmartString + Strings 
- [x] XML Tagged string styles
- [x] Tap Gestures handlers directly on substrings
- [x] Create and store predefined & reusable Styles
- [x] Ideal for anyone who builds UI from code

## Example

* Basic
```swift
let smartString = "Hello world!"
    .font(.boldSystemFont(ofSize: 30))
    .color(.blue)
    .underline()
    .shadow(SmartShadow())
    .onTap { string in
        print(string) // This will print "Hello world!"
    }

label.smartString = smartString

// Using Closures

let smartString = "Hello world!"
    .font { .boldSystemFont(ofSize: 30) }
    .color { .blue }
    .shadow { .default }
    .underline()

label.smartString = smartString
```

Result

<img src="DocsAssets/example_1.png" alt="" width=200/>

### Predefined Style
```swift
let style = SmartStringStyle { style in
    style.font = .systemFont(ofSize: 21)
    style.color = .red
    style.underlined = true
    style.shadow = .default
    style.onTap = { string in
        print(string)
    }
}

label.smartString = "Hello world!".style(style)
```

Result

<img src="DocsAssets/example_2.png" alt="" width=200/>

### String + SmartString interpolation
```swift
let smartString = "Hello"
    .font(.boldSystemFont(ofSize: 30))
    .color(.green)
    .underline()
    .italic()
    .shadow(.default)
+ " world!"
    .font(.systemFont(ofSize: 24))
    .color(.purple)
    
label.smartString = smartString
```

Result

<img src="DocsAssets/example_3.png" width=200/>

### String + SmartString interpolation using predefined Styles
```swift
let style1 = SmartStringStyle { style in
    style.color = .green
    style.font = .boldSystemFont(ofSize: 30)
    style.shadow = .default
}
        
let style2 = SmartStringStyle { style in 
    style.color = .purple
    style.font = .systemFont(ofSize: 24)
}
        
let smartString = "Hello"
    .style(style1)
+ " world!"
    .style(style2)
    
label.smartString = smartString
```

Result

<img src="DocsAssets/example_4.png" width=200/>

### Label substring Tap Handlers

```swift
let smartString = "Hello "
    .font { .systemFont(ofSize: 18) }
    .onTap { string in
        print(string) // This will print "Hello " when tapping the substring "Hello " within the label
    }
+ "world"
    .color(.red)
    .bold()
    .onTap { string in
        print(string) // This will print "world" when tapping the substring "world" within the label
    }
+ "!"
    
label.smartString = smartString
```

Result

<img src="DocsAssets/example_5.png" width=200/>

## Author

SmartString is maintained by Valerio Sebastianelli: [valerio.alsebas@gmail.com](mailto:valerio.alsebas@gmail.com)
