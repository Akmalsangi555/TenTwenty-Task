import 'package:flutter/material.dart';
import 'package:tentwenty_task/core/app_theme.dart';
import 'package:tentwenty_task/features/movies/models/movie.dart';

class SeatSelectionPage extends StatefulWidget {
  final Movie movie;
  const SeatSelectionPage({super.key, required this.movie});

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final List<String> _selectedSeats = [];
  final List<String> _rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final int _seatsPerRow = 10;

  bool _isSeatAvailable(String seatId) {
    // Simulate some seats being unavailable
    final unavailableSeats = [
      'A3',
      'A4',
      'B5',
      'C7',
      'D2',
      'E9',
      'F1',
      'G6',
      'H8',
      'I4',
      'J10',
    ];
    return !unavailableSeats.contains(seatId);
  }

  bool _isSeatSelected(String seatId) {
    return _selectedSeats.contains(seatId);
  }

  void _toggleSeat(String seatId) {
    setState(() {
      if (_selectedSeats.contains(seatId)) {
        _selectedSeats.remove(seatId);
      } else {
        _selectedSeats.add(seatId);
      }
    });
  }

  Color _getSeatColor(String seatId) {
    if (_isSeatSelected(seatId)) {
      return AppTheme.primary;
    }
    if (!_isSeatAvailable(seatId)) {
      return Colors.grey.shade800;
    }
    return AppTheme.surface;
  }

  Widget _buildSeat(String seatId) {
    final isAvailable = _isSeatAvailable(seatId);
    final isSelected = _isSeatSelected(seatId);

    return GestureDetector(
      onTap: isAvailable ? () => _toggleSeat(seatId) : null,
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: _getSeatColor(seatId),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: isSelected
              ? const Icon(Icons.check, color: Colors.white, size: 18)
              : isAvailable
              ? null
              : const Icon(Icons.close, color: Colors.grey, size: 16),
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.surface.withOpacity(0.3),
            AppTheme.surface.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SCREEN',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              letterSpacing: 4,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(AppTheme.surface, 'Available'),
          _buildLegendItem(Colors.grey.shade800, 'Unavailable'),
          _buildLegendItem(AppTheme.primary, 'Selected'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(widget.movie.title),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildScreen(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: _rows.map((row) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                child: Text(
                                  row,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ...List.generate(_seatsPerRow, (index) {
                                final seatNumber = index + 1;
                                final seatId = '$row$seatNumber';
                                return _buildSeat(seatId);
                              }),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLegend(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected Seats',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      _selectedSeats.isEmpty
                          ? 'None'
                          : _selectedSeats.join(', '),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _selectedSeats.isEmpty
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Booking ${_selectedSeats.length} seat(s) for ${widget.movie.title}',
                                ),
                              ),
                            );
                          },
                    child: Text(
                      'Book ${_selectedSeats.length} Seat${_selectedSeats.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
