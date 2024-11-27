import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/domain/song.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/providers.dart';

class SongPlayerScreen extends ConsumerStatefulWidget {
  static const name = 'SongPlayerScreen';
  const SongPlayerScreen(
      {super.key, required this.songId, required this.playlist});

  final String songId;
  final List<String> playlist;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SongPlayerScreenState();
}

class _SongPlayerScreenState extends ConsumerState<SongPlayerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(songPlayerViewModelProvider(widget.songId).notifier)
          .setSong(widget.songId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(songPlayerViewModelProvider(widget.songId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: state.screenState.when(
        idle: () {
          if (state.song == null) {
            return const Center(child: Text('Unexpected error, try again'));
          }
          return _SongPlayer(
            song: state.song!,
            playAndStopSong: _playAndStopSong,
            nextSong: (id) => _nextSong(id),
            previousSong: (id) => _previousSong(id),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Future<void> _playAndStopSong() async {
    ref
        .read(songPlayerViewModelProvider(widget.songId).notifier)
        .tooglePlayStatus();
  }

  Future<void> _nextSong(String currentId) async {
    final currentIndex = widget.playlist.indexOf(currentId);
    String nextId;
    if (currentIndex == widget.playlist.length - 1) {
      nextId = widget.playlist[0];
    } else {
      nextId = widget.playlist[currentIndex + 1];
    }

    ref
        .read(songPlayerViewModelProvider(widget.songId).notifier)
        .setSong(nextId);
  }

  Future<void> _previousSong(String currentId) async {
    final currentIndex = widget.playlist.indexOf(currentId);
    String previousId;
    if (currentIndex == 0) {
      previousId = widget.playlist[0];
    } else {
      previousId = widget.playlist[currentIndex - 1];
    }

    ref
        .read(songPlayerViewModelProvider(widget.songId).notifier)
        .setSong(previousId);
  }
}

class _SongPlayer extends StatelessWidget {
  const _SongPlayer(
      {required this.song,
      required this.playAndStopSong,
      required this.nextSong,
      required this.previousSong});

  final Song song;
  final Future<void> Function() playAndStopSong;
  final Future<void> Function(String) nextSong;
  final Future<void> Function(String) previousSong;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              playAndStopSong();
            },
            child: const Text('PlayStop Button'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              nextSong(song.id);
            },
            child: const Text('Next Button'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              previousSong(song.id);
            },
            child: const Text('Previous Button'),
          ),
        ],
      ),
    );
  }
}
