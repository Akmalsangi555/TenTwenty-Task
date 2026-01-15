import 'package:bloc/bloc.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_event.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_state.dart';
import 'package:tentwenty_task/features/movies/repository/movies_repository.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository repository;
  MoviesBloc(this.repository) : super(const MoviesState()) {
    on<LoadAll>(_onLoadAll);
    on<SelectMovie>(_onSelectMovie);
    on<LoadMovieDetails>(_onLoadMovieDetails);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onLoadAll(LoadAll event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: MoviesStatus.loading));
    try {
      final upcoming = await repository.getUpcomingMovies();
      emit(state.copyWith(status: MoviesStatus.loaded, upcoming: upcoming));
    } catch (_) {
      emit(state.copyWith(status: MoviesStatus.failure));
    }
  }

  void _onSelectMovie(SelectMovie event, Emitter<MoviesState> emit) {
    emit(state.copyWith(selected: event.movie));
  }

  Future<void> _onLoadMovieDetails(
    LoadMovieDetails event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      final movie = await repository.getMovieDetails(event.movieId);
      emit(state.copyWith(selected: movie));
    } catch (_) {
      // Handle error
    }
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copyWith(status: MoviesStatus.loading));
    try {
      final results = await repository.searchMovies(event.query);
      emit(state.copyWith(status: MoviesStatus.loaded, searchResults: results));
    } catch (_) {
      emit(state.copyWith(status: MoviesStatus.failure));
    }
  }
}
