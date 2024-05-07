Sample

Displays list from https://pastebin.com/raw/nH5NinBi
Detail from https://pastebin.com/raw/uj6vtukE

Applied MVVM 
iOS - 16.0
SwiftUI

### Scenarios (Acceptance Criteria)

```  
Given application has internet connection
When user launches the application
User can preview list of properties
```

``` 
Given application has NO internet connection
When user launches the application
User recieves no internet connection message and possibility to retry
```

``` 
Given application has internet connection
When user launches the application
User can preview list of properties 
When user taps first property
User is navigated to preview only first property
```

``` 
Given application has NO internet connection
When user taps any specific show
User is shown a message about no internet connection
```
