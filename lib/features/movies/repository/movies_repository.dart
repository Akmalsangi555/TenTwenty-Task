import 'package:tentwenty_task/features/movies/models/movie.dart';

class MoviesRepository {
  // Dummy data for now - API implementation will be done later
  Future<List<Movie>> getUpcomingMovies() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Movie(
        id: 1,
        title: 'Free Guy',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg',
        overview:
            'A bank teller discovers he is actually a background player in an open-world video game.',
        genres: ['Action', 'Comedy', 'Sci-Fi'],
        releaseDate: '2021-08-13',
        rating: 7.2,
        trailerKey: 'X2m-08cOAbc',
        runtime: 115,
      ),
      Movie(
        id: 2,
        title: 'The King\'s Man',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/aq4Pwv5Xeuvj6HZGtx2sFk0y5iC.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/4OTYefcAlaShn6TGVK33UtdLWEr.jpg',
        overview:
            'As a collection of history\'s worst tyrants and criminal masterminds gather to plot a war to wipe out millions, one man must race against time to stop them.',
        genres: ['Action', 'Adventure', 'Comedy'],
        releaseDate: '2021-12-22',
        rating: 6.4,
        trailerKey: '5mkmbq3_5mA',
        runtime: 131,
      ),
      Movie(
        id: 3,
        title: 'Jojo Rabbit',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/7GsM4mtM0worCtIVeiQt28HieeN.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/1q3Fc8KkfGgS0z3oW5z3qJZ3x3x.jpg',
        overview:
            'A young boy in Hitler\'s army finds out his mother is hiding a Jewish girl in their home.',
        genres: ['Comedy', 'Drama', 'War'],
        releaseDate: '2019-10-18',
        rating: 8.0,
        trailerKey: 'tLm8i1x1hUQ',
        runtime: 108,
      ),
      Movie(
        id: 4,
        title: 'Dune',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/jYEW5xZkZk2WTrdbMGAPFuBqbDc.jpg',
        overview:
            'Paul Atreides leads a rebellion to restore his family\'s reign over the desert planet Arrakis.',
        genres: ['Sci-Fi', 'Adventure'],
        releaseDate: '2021-10-22',
        rating: 8.0,
        trailerKey: 'n9xhJrPXop4',
        runtime: 155,
      ),
      Movie(
        id: 5,
        title: 'No Time to Die',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/iUgygt3fscRoKWCV1d0C3FbM9ht.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/1Rr5SrvHxXHuA8jKnd3rq9odku9.jpg',
        overview:
            'James Bond has left active service. His peace is short-lived when Felix Leiter, an old friend from the CIA, turns up asking for help.',
        genres: ['Action', 'Thriller', 'Adventure'],
        releaseDate: '2021-10-08',
        rating: 7.3,
        trailerKey: 'BIhNsAtPbPI',
        runtime: 163,
      ),
      Movie(
        id: 6,
        title: 'Timeless',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg',
        overview:
            'A time-traveling adventure series following a team of heroes.',
        genres: ['Fantasy', 'Sci-Fi', 'Adventure'],
        releaseDate: '2016-10-03',
        rating: 7.8,
        trailerKey: 'X2m-08cOAbc',
        runtime: 45,
      ),
      Movie(
        id: 7,
        title: 'In Time',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/aq4Pwv5Xeuvj6HZGtx2sFk0y5iC.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/4OTYefcAlaShn6TGVK33UtdLWEr.jpg',
        overview:
            'In a future where people stop aging at 25 and must work to buy themselves more time, a man is accused of murder and goes on the run.',
        genres: ['Sci-Fi', 'Action', 'Thriller'],
        releaseDate: '2011-10-28',
        rating: 6.7,
        trailerKey: '5mkmbq3_5mA',
        runtime: 109,
      ),
      Movie(
        id: 8,
        title: 'A Time To Kill',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/7GsM4mtM0worCtIVeiQt28HieeN.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/w1280/1q3Fc8KkfGgS0z3oW5z3qJZ3x3x.jpg',
        overview:
            'A young lawyer defends a black man accused of murdering two men who raped his 10-year-old daughter.',
        genres: ['Crime', 'Drama', 'Thriller'],
        releaseDate: '1996-07-24',
        rating: 7.4,
        trailerKey: 'tLm8i1x1hUQ',
        runtime: 149,
      ),
    ];
  }

  Future<Movie> getMovieDetails(int movieId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final movies = await getUpcomingMovies();
    final movie = movies.firstWhere((m) => m.id == movieId);

    return movie;
  }

  Future<String?> getMovieTrailer(int movieId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final movies = await getUpcomingMovies();
    final movie = movies.firstWhere((m) => m.id == movieId);

    return movie.trailerKey;
  }

  Future<List<Movie>> searchMovies(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final allMovies = await getUpcomingMovies();
    final lowerQuery = query.toLowerCase();

    return allMovies.where((movie) {
      return movie.title.toLowerCase().contains(lowerQuery) ||
          movie.overview.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Legacy methods for backward compatibility
  List<Movie> upcoming() {
    return [];
  }

  List<Movie> popular() {
    return [];
  }

  List<Movie> nowPlaying() {
    return [];
  }
}
