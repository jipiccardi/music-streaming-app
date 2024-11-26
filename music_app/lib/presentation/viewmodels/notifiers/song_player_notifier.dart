import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/data/providers.dart';
import 'package:music_app/domain/songs_repository.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/states/song_player_state.dart';

// TODO move to a better singleton
final player = AudioPlayer();

class SongPlayerNotifier
    extends AutoDisposeFamilyNotifier<SongPlayerState, String> {
  late final SongsRepository songsRepository =
      ref.read(songsRepositoryProvider);

  @override
  SongPlayerState build(String arg) {
    return const SongPlayerState();
  }

  Future<void> setSong(String songId) async {
    state = state.copyWith(screenState: const BaseScreenState.loading());
    try {
      log('Updating Song');

      final song = await songsRepository.getSongById(songId);
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        song: song,
      );

      await player.setAudioSource(AudioSource.uri(Uri.parse(song!.filePath)));
 
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }

  Future<void> tooglePlayStatus() async {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }
}
