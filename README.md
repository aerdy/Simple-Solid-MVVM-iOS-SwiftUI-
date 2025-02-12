# How SOLID Principles Are Applied
1. Single Responsibility Principle (SRP):
- NetworkService is responsible only for fetching data.
- ListMovieViewModel is responsible only for managing the state and business logic.
- ContentView is responsible only for displaying the UI.

2. Open/Closed Principle (OCP):
- The NetworkServiceProtocol allows for extending the app with different data sources (e.g., local JSON, another API) without modifying the existing code.

3. Liskov Substitution Principle (LSP):
- Any class conforming to NetworkServiceProtocol can replace NetworkService without breaking the app.

4. Interface Segregation Principle (ISP):
- NetworkServiceProtocol is a small, focused interface that only includes the fetchListMovie method.

5. Dependency Inversion Principle (DIP):
- ListMovieViewModel depends on the NetworkServiceProtocol abstraction, not the concrete NetworkService.
