# MyGuitars - SwiftUI Learning Journey

A hands-on project showcasing the evolution from CoreData to SwiftData in a SwiftUI environment, built with MVVM architecture and of course, a nice tool to add informtaion about your Guitarsenal!

## Project Overview

This app serves as a practical exploration of SwiftUI's capabilities and modern iOS data persistence approaches. Initially developed with CoreData, it has been refactored to leverage SwiftData, Apple's newest framework for data persistence.
Initially I followed Paul Hudson 100 days of SwiftUI where the goal was to learn some bassic about SwiftUI. There were some techniques I didn't know and now, might not like or agree, so I will be making some changes just to make sure I have an App that follow some best practices.

## Technical Highlights

- **Framework Migration**: Demonstrates the transition from CoreData to SwiftData
- **Architecture**: Implements MVVM pattern with dependency injection
- **UI Framework**: Built entirely in SwiftUI
- **iOS Version**: Supports iOS 17+ (required for SwiftData)

## Key Features

- Modern Swift concurrency patterns
- Clean architecture principles
- Reactive data updates through SwiftData
- Dependency injection for better testability

## Data Layer Evolution

### CoreData (Initial Implementation)
- NSManagedObject subclasses
- NSPersistentContainer setup
- CRUD operations via NSManagedObjectContext

### SwiftData (Current Implementation)
- @Model macro for data models
- ModelContainer and ModelContext management
- Swift-native data persistence


## Learning Takeaways

- SwiftUI view lifecycle management
- State management patterns
- Data persistence best practices
- MVVM implementation strategies

## Future Improvements

- [ ] Enhanced error handling
- [ ] Unit test coverage
- [ ] UI test implementation
- [ ] Documentation updates

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `YourApp.xcodeproj` in Xcode
3. Build and run

## Contributing

Feel free to submit issues and enhancement requests!

## License

There is nothing proprietary here and the App is free at the App Store. If you think you can use this for something good and cool, please feel free to take it. 

So...

MIT License

Copyright (c) 2024 - Lim4 Consulting Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
