
# Nagwa Task

This project is a Flutter application structured using Clean Architecture principles.
It emphasizes a clear separation of concerns, scalable project structure, standardized API handling, navigation, and reusable UI components.


### Steps To Run This Applicaon 

1. Install dependencies:
   
   flutter pub get
 

1. Run the application:
   
   flutter run
  



## Design Decisions and Assumptions

- Clean Architecture:
  - Data Layer: Handling data sources, networking, and models.
  - Domain Layer: Entities and repositories interfaces (if added later).
  - Presentation Layer: UI, widgets, blocs, and screens.

- Network Handling:
  - dio is used for HTTP requests.
  - pretty_dio_logger is used to log API requests and responses.
  - Standardized API results using ApiResult.
  - Centralized error management via ApiErrorHandler.
  - Helper class NetworkHelper simplifies HTTP methods.

- State Management:
  - flutter_bloc is used for predictable and scalable state management.

- Navigation:
  - go_router is used for declarative and powerful routing.

- Dependency Injection:
  - get_it is used to manage app dependencies and services.

- UI Enhancements:
  - Custom widgets like AppButton, AppLoading, and AppErrorWidget are created for consistent design.
  - toastification is used for showing toast messages.
  - loading_animation_widget provides custom loading animations.
  - cached_network_image caches images efficiently.
  - readmore widget is used to handle expandable text.
  - flutter_staggered_grid_view is used for staggered grid layouts.

- Utilities:
  - connectivity_plus is used to detect network connectivity changes.
  - flutter_native_splash is used to configure native splash screens.

- Extensions:
  - Utility extensions (like onTap) are used to simplify and clean up UI code.

- Constants:
  - Constants like images and strings are centralized under the constants folder.

Assumptions made:
- API responses are JSON formatted.
- Internet connection is required for dynamic content.
- Errors are handled gracefully and reported to the user.

## Libraries Used


dio: Advanced networking

pretty_dio_logger: API call logging

toastification: Toast notifications

go_router: Navigation management

get_it: Dependency injection

flutter_bloc: State management

connectivity_plus: Connectivity monitoring

flutter_native_splash: Splash screen configuration

loading_animation_widget: Loading animations

cached_network_image: Image caching

readmore: Expandable/collapsible text

flutter_staggered_grid_view: Advanced grid layouts



## Notes About the Implementation

- AppErrorWidget shows a friendly error message with a retry action.
- AppButton standardizes button styles across screens.
- AppLoading displays a loading spinner consistently.
- NetworkHelper abstracts API calls with error handling.
- ApiResult ensures that all network responses are consistently wrapped in success or failure.
- Scalable Architecture: New features can be easily added by replicating the same module structure.

## Project Structure Overview

```
lib/
├── core/
│   ├── constants/         # App constants like images
│   ├── extensions/        # Custom useful extensions
│   ├── network/           # API handling (dio, error handlers, network helper)
│   └── shared_widgets/    # Reusable UI components (Button, Error, Loading)
├── features/
│   └── (Each feature has its own module)
└── main.dart              # App entry point
```

## Author

- [Your Name Here]
