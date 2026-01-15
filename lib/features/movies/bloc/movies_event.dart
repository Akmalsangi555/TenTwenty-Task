import 'package:equatable/equatable.dart';
import 'package:tentwenty_task/features/movies/models/movie.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object?> get props => [];
}

class LoadAll extends MoviesEvent {
  const LoadAll();
}

class SelectMovie extends MoviesEvent {
  final Movie movie;
  const SelectMovie(this.movie);
  @override
  List<Object?> get props => [movie];
}

class LoadMovieDetails extends MoviesEvent {
  final int movieId;
  const LoadMovieDetails(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class SearchMovies extends MoviesEvent {
  final String query;
  const SearchMovies(this.query);
  @override
  List<Object?> get props => [query];
}
