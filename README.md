# SelectionDialog
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/SelectionDialog.svg?style=flat)](http://cocoapods.org/pods/selectiondialog)
[![License](https://img.shields.io/cocoapods/l/SelectionDialog.svg?style=flat)](http://cocoapods.org/pods/selectiondialog)
[![Platform](https://img.shields.io/cocoapods/p/SelectionDialog.svg?style=flat)](http://cocoapods.org/pods/selectiondialog)
[![Build Status](https://travis-ci.org/kciter/SelectionDialog.svg?branch=master)](https://travis-ci.org/kciter/SelectionDialog)

Simple selection dialog inspired from [ios-custom-alertview](https://github.com/wimagguc/ios-custom-alertview)

# Preview
<img src="https://github.com/kciter/SelectionDialog/raw/master/Images/preview.png" width='375px' alt="Preview Image">

## Requirements
* iOS 8.0+
* Swift 3
* Xcode 8.0
 
## Installation
### CocoaPods
```ruby
use_frameworks!
pod "SelectionDialog"
```
### Manually
To install manually the KCSelectionDialog in an app, just drag the `SelectionDialog/*.swift` file into your project.

## Usage
### Swift
```swift
let dialog = SelectionDialog(title: "Dialog", closeButtonTitle: "Close")
dialog.addItem(item: "I have icon :)", icon: UIImage(named: "Icon1")!)
dialog.addItem(item: "I have icon and handler :D", icon: UIImage(named: "Icon2")!, didTapHandler: { () in
    print("Item didTap!")
})
dialog.addItem(item: "I have nothing :(")
dialog.show()
```

If you want to launch the dialog at the starting point of the app, make sure you put the code inside DispatchQueue.main.async. Otherwise it will not work
```swift
override func viewDidLoad() {
    DispatchQueue.main.async {
        let dialog = SelectionDialog(title: "Dialog", closeButtonTitle: "Close")
        dialog.addItem(item: "I have icon :)", icon: UIImage(named: "Icon1")!)
        dialog.addItem(item: "I have icon and handler :D", icon: UIImage(named: "Icon2")!, didTapHandler: { () in
            print("Item didTap!")
        })
        dialog.addItem(item: "I have nothing :(")
        dialog.show()
    }
}
```
