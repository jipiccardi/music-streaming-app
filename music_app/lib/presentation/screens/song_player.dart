import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/domain/song.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/providers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      await ref
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
            playAndStopSong: (song) => _playAndStopSong(song),
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

  Future<void> _playAndStopSong(Song song) async {
    ref
        .read(songPlayerViewModelProvider(widget.songId).notifier)
        .tooglePlayStatus(song);
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
  final Future<void> Function(Song) playAndStopSong;
  final Future<void> Function(String) nextSong;
  final Future<void> Function(String) previousSong;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                song.title, // Song name
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/default_art_cover.png', // Asset image path
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  previousSong(song.id);
                },
                child: const FaIcon(FontAwesomeIcons.backward, size: 30),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  playAndStopSong(song);
                },
                child: FaIcon(song.isPlaying
                    ? FontAwesomeIcons.pause
                    : FontAwesomeIcons.play,
                    size: 30),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  nextSong(song.id);
                },
                child: const FaIcon(FontAwesomeIcons.forward, size: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
