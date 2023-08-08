# SoBored
SoBored is an app that helps you find things to do when you're bored. You can get random activities to cure your boredom, or if you’re in the mood to do something specific, you can also get activities based on specific parameters. 

## Screenshots
| Home Screen | Activity Screen | Custom Search Screen |
| --- | --- |  --- |
| ![Home Screen](https://github.com/YSBoomOfficial/SoBored/blob/main/App%20Screenshots/Home.png) | ![Activity Screen](https://github.com/YSBoomOfficial/SoBored/blob/main/App%20Screenshots/Activity.png) | ![Custom Search Screen](https://github.com/YSBoomOfficial/SoBored/blob/main/App%20Screenshots/CustomSearch.png) |

## Bored API
For more information about the API used in this app see [boredapi.com](https://www.boredapi.com).

## Additional Info
### How was it built?
- SwiftUI
- MVVM Architecture
- URLSession and Swift Concurrency (async/await) for Networking
- No 3rd party libraries

### Focus areas for personal development
- Good Architecture, Good Project structure and following best practices for SwiftUI
- Making Views Reusable
- Experimenting with UI Design (eg: NavigationLink styling on the Home Screen)
- Getting better at Testing 

### Future Directions/ Feature Suggestions
- fetch a list of activities
- allow user to save activities locally (tbd: `CoreData`, `GRDB`, `Realm`)
- allow user to start and complete activities. (`ActivityKit`/ Live Activities, Timer API)
- use `WidgetKit` to make a Random Activity Widget 
- Remind user to complete activities (`UNUserNotification`)

- make custom backend to remove reliance on 3rd party service (tbd: `Spring Boot`, `Vapor`)
