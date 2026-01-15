import 'package:equatable/equatable.dart';
import 'package:tentwenty_task/features/movies/models/movie.dart';

enum MoviesStatus { initial, loading, loaded, failure }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<Movie> upcoming;
  final List<Movie> popular;
  final List<Movie> nowPlaying;
  final List<Movie> searchResults;
  final Movie? selected;
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.upcoming = const [],
    this.popular = const [],
    this.nowPlaying = const [],
    this.searchResults = const [],
    this.selected,
  });
  MoviesState copyWith({
    MoviesStatus? status,
    List<Movie>? upcoming,
    List<Movie>? popular,
    List<Movie>? nowPlaying,
    List<Movie>? searchResults,
    Movie? selected,
  }) {
    return MoviesState(
      status: status ?? this.status,
      upcoming: upcoming ?? this.upcoming,
      popular: popular ?? this.popular,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      searchResults: searchResults ?? this.searchResults,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
    status,
    upcoming,
    popular,
    nowPlaying,
    searchResults,
    selected,
  ];
}
