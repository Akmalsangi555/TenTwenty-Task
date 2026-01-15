# TenTwenty Task - Movie Booking App

A Flutter application that lists upcoming movies using The Movie Database (TMDB) API and allows users to book movie tickets.

## Features

- **Movie List Screen**: Displays all upcoming movies in a list format
- **Movie Detail Screen**: Shows detailed information about a selected movie
- **Watch Trailer**: Full-screen YouTube trailer player with auto-play functionality
- **Movie Search**: Search for movies using TMDB API
- **Seat Selection**: Interactive seat mapping UI for booking tickets

## Setup

### API Key Configuration

Before running the app, you need to configure your TMDB API key:

1. Get a free API key from [The Movie Database](https://www.themoviedb.org/documentation/api)
2. Open `lib/features/movies/repository/movies_repository.dart`
3. Replace the `apiKey` constant value with your actual API key:
   ```dart
   static const String apiKey = 'YOUR_API_KEY_HERE';
   ```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Configure your TMDB API key (see above)

3. Run the app:
   ```bash
   flutter run
   ```

## API Endpoints Used

- `GET /movie/upcoming` - Fetch upcoming movies
- `GET /movie/{movie_id}` - Fetch movie details
- `GET /movie/{movie_id}/videos` - Fetch movie trailers
- `GET /search/movie` - Search movies

## Dependencies

- `flutter_bloc` - State management
- `http` - API calls
- `cached_network_image` - Image caching
- `youtube_player_flutter` - YouTube trailer playback
