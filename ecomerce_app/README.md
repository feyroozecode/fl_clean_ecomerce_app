# ecomerce_app

## Overview
This project is a Flutter-based e-commerce application that showcases a variety of products. It is structured to promote best practices in Flutter development, including separation of concerns, consistent styling, and modular architecture.

## Project Structure
The project is organized into several directories, each serving a specific purpose:

- **lib/src/common**: Contains common resources used throughout the application.
  - `app_colors.dart`: Defines a class `AppColors` for consistent color usage.
  - `app_sizes.dart`: Defines a class `AppSizes` for consistent sizing and spacing.

- **lib/src/features/home**: Contains the home feature of the application.
  - **data**: 
    - `product_repository.dart`: Contains the `ProductRepository` class for fetching product data.
  - **domain**: 
    - `product.dart`: Defines the `Product` class representing product entities.
  - **presentation**: 
    - `home_screen.dart`: Contains the `HomeScreen` class, which is the main UI for the home screen.
    - **widgets**: 
      - `product_card.dart`: Defines the `ProductCard` widget for displaying individual product information.

- **lib/src/features/details**: Contains the details feature of the application.
  - **presentation**: 
    - `product_details_screen.dart`: Contains the `ProductDetailScreen` class for displaying detailed product information.

- **lib/src/main.dart**: The entry point of the application, initializing the app and setting up navigation.

- **pubspec.yaml**: Configuration file for dependencies and assets.

## Features
- **Responsive Design**: The application is designed to be responsive, adapting to different screen sizes.
- **State Management**: Utilizes Flutter's built-in state management for handling UI state.
- **FutureBuilder**: Implements `FutureBuilder` for asynchronous data fetching, providing loading indicators and error handling.
- **Modular Widgets**: Breaks down the UI into reusable widgets for better maintainability.

## Setup Instructions
1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd ecomerce_app
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the application:
   ```
   flutter run
   ```

## Usage Guidelines
- Follow the established directory structure for adding new features or components.
- Use the `AppColors` and `AppSizes` classes to maintain consistency in styling and layout.
- Ensure that all data fetching is handled through the `ProductRepository` to keep the data layer separate from the UI layer.

## Best Practices
- Keep UI code separate from business logic.
- Use descriptive names for classes and methods to enhance readability.
- Regularly refactor code to improve structure and maintainability.
- Write unit tests for critical components to ensure reliability.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.