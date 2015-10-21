# KCSelectionDialog
![Swift 2.0](https://img.shields.io/badge/Swift-2.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/KCSelectionDialog.svg?style=flat)](http://cocoapods.org/pods/kcselectiondialog)
[![License](https://img.shields.io/cocoapods/l/KCSelectionDialog.svg?style=flat)](http://cocoapods.org/pods/kcselectiondialog)
[![Platform](https://img.shields.io/cocoapods/p/KCSelectionDialog.svg?style=flat)](http://cocoapods.org/pods/kcselectiondialog)
[![Build Status](https://travis-ci.org/kciter/KCSelectionDialog.svg?branch=master)](https://travis-ci.org/kciter/KCSelectionDialog)

Simple selection dialog inspired from [ios-custom-alertview](https://github.com/wimagguc/ios-custom-alertview)

# Preview
<img src="https://github.com/kciter/KCSelectionDialog/raw/master/Images/preview.png" width='375px' alt="Preview Image">

## Requirements
* iOS 8.0+
* Swift 2
* Xcode 7.0
 
## Installation
### Cocoapods
```ruby
use_frameworks!
pod "KCSelectionDialog"
```
### Manually
To install manually the KCSelectionDialog in an app, just drag the `KCSelectionDialog/*.swift` file into your project.

## Usage
### Swift
```swift
let dialog = KCSelectionDialog(title: "Dialog", closeButtonTitle: "Close")
dialog.addItem(item: "I have icon :)", icon: UIImage(named: "Icon1")!)
dialog.addItem(item: "I have icon and handler :D", icon: UIImage(named: "Icon2")!, didTapHandler: { () in
    print("Item didTap!")
})
dialog.addItem(item: "I have nothing :(")
dialog.show()
```

### Objective-C
```objc
KCSelectionDialog *dialog = [[KCSelectionDialog alloc] initWithTitle:@"Dialog" closeButtonTitle:@"Close"];
[dialog addItemWithItem:@"I have icon :)" icon:[UIImage imageNamed:@"Icon1"]];
[dialog addItemWithItem:@"I have icon and handler :D" icon:[UIImage imageNamed:@"Icon2"] didTapHandler:^{
    NSLog(@"Item didTap!");
}];
[dialog addItemWithItem:@"I have nothing :("];
[dialog show];
```

## TODO
* Update `README.md`
* Add appearance
* Swift 1.2 support
