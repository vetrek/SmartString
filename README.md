# SmartString

A powerful and small library that will allow the creation of complex String Styles. Provides also an easy way to handle **TAPPING** on each substring!


## Usage

### Basic usage
```swift
let smartString = "Hello world!"
    .font(.boldSystemFont(ofSize: 30))
    .color(.blue)
    .underline()
    .shadow(SmartShadow()
)

label.smartString = smartString

// Using Closures
let smartString = "Hello world!"
    .font(.boldSystemFont(ofSize: 30))
    .color(.blue
    .shadow(SmartShadow()
)

label.smartString = smartString
```

Result

<img src="DocsAssets/example_1.png" alt="" width=200/>

### Using a predefined Style
```swift
let style = SmartStringStyle(
    color: .blue,
    font: .boldSystemFont(ofSize: 30),
    shadow: SmartShadow(
    offset: CGSize(width: 2, height: 2),
    radius: 2,
    color: .red
)

label.smartString = "Hello world!".style(style)
```

Result

<img src="DocsAssets/example_2.png" alt="" width=200/>

### String style interpolation
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

### String style interpolation using Styles
```swift
let style1 = SmartStringStyle(
    color: .green,
     font: .boldSystemFont(ofSize: 30),
   shadow: .default
)
        
let style2 = SmartStringStyle(
    color: .purple,
     font: .systemFont(ofSize: 24)
)
        
let smartString = "Hello"
    .style(style1)
+ " world!"
    .style(style2)
    
label.smartString = smartString
```

Result

<img src="DocsAssets/example_4.png" width=200/>

### Tap Handlers!

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






