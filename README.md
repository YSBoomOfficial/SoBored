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

### Currently Working on
- [ ] Adding Unit Tests and UI Tests
	- [`NetworkingManager`](https://github.com/YSBoomOfficial/SoBored/blob/main/SoBored/Shared/Networking/Networking%20Manager/NetworkingManager.swift) and [`NetworkingError`](https://github.com/YSBoomOfficial/SoBored/blob/main/SoBored/Shared/Networking/Networking%20Manager/NetworkingError.swift) - [Unit Tests](https://github.com/YSBoomOfficial/SoBored/blob/main/SoBored%20Tests/NetworkingManagerTests.swift)
	- [`URLBuilder`](https://github.com/YSBoomOfficial/SoBored/blob/main/SoBored/Shared/Networking/URL%20Builder/URLBuilder.swift) and [`QueryType`](https://github.com/YSBoomOfficial/SoBored/blob/main/SoBored/Shared/Networking/URL%20Builder/QueryType.swift) - [Unit Tests](https://github.com/YSBoomOfficial/SoBored/blob/main/SoBored%20Tests/URLBuilderTests.swift)
- [ ] Adding more features and fetching options (eg: fetch a list of activities)
- [ ] Fixing an issue where an alert appears twice

### Focus areas for personal development
- Good Architecture, Good Project structure and following best practices for SwiftUI
- Making Views Reusable
- Experimenting with UI Design (eg: NavigationLink styling on the Home Screen) 
