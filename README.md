# MARVEL UNIVERSE CHARACTERS

This application was created as a practice and shows a simply VIPER master-detail application. Main screen shows a list of characters of Marvel Universe, where user can search by "nameStartsWith". 
The results are limited by page. This value may be replaced on MUConstants.swift file. This screen provides also a pagination section, where user can navigate between them.
All data shown on this app is obtained from public API https://developer.marvel.com/docs

## Created with 🛠

* Xcode 13.1
* Cocoapods 1.10.1

## Steps to build ▶️

* Run `pod install` to install project dependencies.
* You need create account on API page documentatión in order to obtain your private and public API key. After obtain them, put this information on fields `Public Marvel Api Key` and `Private Marvel Api Key` of info.plist allocated as `marvel/Core/OtherFiles/Info.plist`
* You can build and laun the app.

## Next steps 🚀

The development of this structure of app is not completed. Will be complete it over time.

### Improve detail view

Adding information about events, and adding actions to comic and series button.

### Add tests

Adding necesary test to project.
