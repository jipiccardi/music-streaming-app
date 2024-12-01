import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/presentation/screens/playlists_list.dart';
import 'package:music_app/presentation/screens/songs_list.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/providers.dart';

class NewPlaylistScreen extends ConsumerStatefulWidget {
  static const name = 'NewPlaylistScreen';

  const NewPlaylistScreen({super.key, required this.origin});

  // sadly, it will be easier to have a edit playlist screen... or not?
  final String origin;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewPlaylistScreenState();
}

class _NewPlaylistScreenState extends ConsumerState<NewPlaylistScreen> {
  final Map<String, bool> _selectedSongs = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newPlaylistViewModelProvider('').notifier).setAvailableSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newPlaylistViewModelProvider(''));

    return Scaffold(
      appBar: AppBar(
        title: widget.origin == 'edit'
            ? const Text('Edit Playlist')
            : const Text('Create Playlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: state.screenState.when(
                idle: () {
                  return ListView.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      final song = state.songs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(song.title),
                          trailing: Checkbox(
                            value: _selectedSongs[song.id] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                _selectedSongs[song.id] = value ?? false;
                              });
                            },
                          ),
                        ),
                      );
                    },
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
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  _onSaveButtonPressed();
                },
                child: const FaIcon(
                  FontAwesomeIcons.floppyDisk,
                  size: 45.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSaveButtonPressed() {
    final state = ref.read(newPlaylistViewModelProvider('').notifier);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String playlistName = '';
        return AlertDialog(
          title: const Text('Playlist Name'),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: const InputDecoration(hintText: "playlist name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                if (playlistName.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                        const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text('Playlist name cannot be empty')),
                      )
                      .closed
                      .then((reason) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    }
                  });
                } else {
                  await state.savePlaylist(
                      playlistName, _selectedSongs.keys.toList());
                  if (context.mounted) context.pushNamed(PlaylistScreen.name);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
