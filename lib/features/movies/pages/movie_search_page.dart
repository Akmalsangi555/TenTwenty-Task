
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/core/app_theme.dart';
import 'package:tentwenty_task/core/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tentwenty_task/features/movies/models/movie.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_bloc.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_event.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_state.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _currentQuery = '';
  bool _hasSearched = false;

  // Dummy category data
  final List<Map<String, String>> _categories = [
    {
      'name': 'Comedies',
      'image':
          'https://image.tmdb.org/t/p/w500/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg',
    },
    {
      'name': 'Crime',
      'image':
          'https://image.tmdb.org/t/p/w500/aq4Pwv5Xeuvj6HZGtx2sFk0y5iC.jpg',
    },
    {
      'name': 'Family',
      'image':
          'https://image.tmdb.org/t/p/w500/7GsM4mtM0worCtIVeiQt28HieeN.jpg',
    },
    {
      'name': 'Documentaries',
      'image':
          'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
    },
    {
      'name': 'Dramas',
      'image':
          'https://image.tmdb.org/t/p/w500/iUgygt3fscRoKWCV1d0C3FbM9ht.jpg',
    },
    {
      'name': 'Fantasy',
      'image':
          'https://image.tmdb.org/t/p/w500/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg',
    },
    {
      'name': 'Holidays',
      'image':
          'https://image.tmdb.org/t/p/w500/aq4Pwv5Xeuvj6HZGtx2sFk0y5iC.jpg',
    },
    {
      'name': 'Horror',
      'image':
          'https://image.tmdb.org/t/p/w500/7GsM4mtM0worCtIVeiQt28HieeN.jpg',
    },
    {
      'name': 'Sci-Fi',
      'image':
          'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
    },
    {
      'name': 'Thriller',
      'image':
          'https://image.tmdb.org/t/p/w500/iUgygt3fscRoKWCV1d0C3FbM9ht.jpg',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _currentQuery = '';
        _hasSearched = false;
      });
      return;
    }
    setState(() {
      _currentQuery = query;
      _hasSearched = true;
    });
    context.read<MoviesBloc>().add(SearchMovies(query));
  }

  void _openDetail(Movie movie) {
    Navigator.of(context).pushNamed(AppRouter.detail, arguments: movie);
  }

  Widget _buildCategoryCard(Map<String, String> category) {
    return GestureDetector(
      onTap: () {
        _searchController.text = category['name']!;
        _performSearch(category['name']!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: category['image']!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppTheme.surface,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppTheme.surface,
                  child: const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Text(
                    category['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () => _openDetail(movie),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: movie.posterUrl,
                width: 130,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 120,
                  color: AppTheme.surface,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 120,
                  color: AppTheme.surface,
                  child: const Icon(Icons.error, color: AppTheme.textSecondary),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (movie.genres.isNotEmpty)
                      Text(
                        movie.genres.first,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.more_horiz_outlined,
                color: AppTheme.lightBlueColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryCard(_categories[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'TV shows, movies and more',
                      hintStyle: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.textPrimary,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      isDense: false,
                      alignLabelWithHint: false,
                    ),
                    onChanged: (value) {
                      setState(() {});
                      _performSearch(value);
                    },
                  ),
                ),
                if (_searchController.text.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchController.clear();
                        _performSearch('');
                        // Navigate back when clear is pressed
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppTheme.textPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            // Show categories when no search query
            if (_currentQuery.isEmpty && !_hasSearched) {
              return _buildCategoriesGrid();
            }

            // Show loading state
            if (state.status == MoviesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show error state
            if (state.status == MoviesStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to search movies'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _performSearch(_currentQuery),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Show "item not found" when search results are empty
            if (_hasSearched && state.searchResults.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Item not found',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Show search results
            if (state.searchResults.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Results',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${state.searchResults.length} Results Found',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.searchResults.length,
                      itemBuilder: (context, index) {
                        return _buildMovieCard(state.searchResults[index]);
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
