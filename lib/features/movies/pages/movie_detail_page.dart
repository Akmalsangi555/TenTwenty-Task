
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/core/app_theme.dart';
import 'package:tentwenty_task/core/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tentwenty_task/features/movies/models/movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_bloc.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_event.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_state.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Movie? _detailedMovie;

  @override
  void initState() {
    super.initState();
    _detailedMovie = widget.movie;
    _loadMovieDetails();
  }

  void _loadMovieDetails() {
    context.read<MoviesBloc>().add(LoadMovieDetails(widget.movie.id));
  }

  void _watchTrailer() {
    final movie = _detailedMovie ?? widget.movie;
    if (movie.trailerKey != null && movie.trailerKey!.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              TrailerPlayerPage(trailerKey: movie.trailerKey!),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Trailer not available')));
    }
  }

  void _bookTickets() {
    Navigator.of(context).pushNamed(
      AppRouter.dateSelection,
      arguments: _detailedMovie ?? widget.movie,
    );
  }

  // Genre colors matching the screenshot
  Color _getGenreColor(String genre, int index) {
    final colors = [
      const Color(0xFF15D2BC),
      const Color(0xFFE26CA5),
      const Color(0xFF564CA3),
      const Color(0xFFCD9D0F),
    ];
    return colors[index % colors.length];
  }

  String _formatReleaseDate(String date) {
    if (date.isEmpty) return 'In Theaters';
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        final year = parts[0];
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        final months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ];
        return 'In Theaters ${months[month - 1]} $day, $year';
      }
    } catch (e) {
      // If parsing fails, return as is
    }
    return 'In Theaters $date';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state.selected != null && state.selected?.id == widget.movie.id) {
          setState(() {
            _detailedMovie = state.selected;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: Stack(
          children: [
            // Movie poster background
            Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 0.45,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: _detailedMovie?.backdropUrl ?? widget.movie.backdropUrl,
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
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.9),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Column(
              children: [
                // AppBar with back button
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text('Watch',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppTheme.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _detailedMovie?.title ?? widget.movie.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatReleaseDate(
                            _detailedMovie?.releaseDate ??
                                widget.movie.releaseDate,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.white),
                        ),
                        const SizedBox(height: 24),
                        // Action buttons
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.lightBlueColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _bookTickets,
                            child: Text(
                              'Select Seats',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: AppTheme.lightBlueColor,
                              side: BorderSide(
                                color: AppTheme.lightBlueColor,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _watchTrailer,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  size: 24,
                                  color: AppTheme.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Watch Trailer',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Genres',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.textSecondary202C),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                          (_detailedMovie?.genres ?? widget.movie.genres)
                              .asMap()
                              .entries
                              .map(
                                (entry) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: _getGenreColor(
                                  entry.value,
                                  entry.key,
                                ),
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                              child: Text(
                                entry.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600,
                                    color: AppTheme.white),
                              ),
                            ),
                          )
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        // Overview
                        Text(
                          'Overview',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.textSecondary202C),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _detailedMovie?.overview ?? widget.movie.overview,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppTheme.textSecondary8F),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrailerPlayerPage extends StatefulWidget {
  final String trailerKey;
  const TrailerPlayerPage({super.key, required this.trailerKey});

  @override
  State<TrailerPlayerPage> createState() => _TrailerPlayerPageState();
}

class _TrailerPlayerPageState extends State<TrailerPlayerPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerKey,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false, loop: false),
    )..addListener(_listener);
  }

  void _listener() {
    if (_controller.value.isReady && !_isPlayerReady) {
      setState(() {
        _isPlayerReady = true;
      });
    }
    if (_controller.value.playerState == PlayerState.ended) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppTheme.primary,
                progressColors: ProgressBarColors(
                  playedColor: AppTheme.primary,
                  handleColor: AppTheme.primary,
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
