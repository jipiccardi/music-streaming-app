import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/domain/song.dart';
import 'package:music_app/presentation/screens/song_player.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/providers.dart';
import 'package:music_app/presentation/widgets/song_item.dart';

class SongsListScreen extends ConsumerStatefulWidget {
  static const name = 'SongsListScreen';

  const SongsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SongsListScreenState();
}

class _SongsListScreenState extends ConsumerState<SongsListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(songsListViewModelProvider.notifier).fetchSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(songsListViewModelProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Songs'),
        ),
        body: state.screenState.when(
            idle: () {
              return _SongsList(
                songs: state.songs,
                onSongTap: (song) => _onSongTap(context, song.id, state.songs.map((song) => song.id).toList()),
              );
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (error) {
              log('Error: $error');
              return Center(
                child: Text('Error: $error'),
              );
            }));
  }

  void _onSongTap(BuildContext context, String songId, List<String> playlist) async {
    context.pushNamed(SongPlayerScreen.name, pathParameters: {'id': songId},extra: playlist);
    return;
  }
}

class _SongsList extends StatelessWidget {
  const _SongsList({
    required this.songs,
    required this.onSongTap,
  });

  final List<Song> songs;
  final Function(Song) onSongTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return SongItem(
          song: song,
          onTap: () => onSongTap(song),
        );
      },
    );
  }
}
