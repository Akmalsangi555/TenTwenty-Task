
import 'package:flutter/material.dart';
import 'package:tentwenty_task/features/movies/pages/home_page.dart';
import 'package:tentwenty_task/features/movies/pages/movie_detail_page.dart';
import 'package:tentwenty_task/features/movies/pages/movie_search_page.dart';
import 'package:tentwenty_task/features/movies/pages/seat_selection_page.dart';
import 'package:tentwenty_task/features/movies/models/movie.dart';

class AppRouter {
  static const String home = '/';
  static const String detail = '/detail';
  static const String search = '/search';
  static const String seatSelection = '/seat-selection';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case detail:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie));
      case search:
        return MaterialPageRoute(builder: (_) => const MovieSearchPage());
      case seatSelection:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => SeatSelectionPage(movie: movie),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
