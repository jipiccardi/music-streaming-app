import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/data/repositories/playlists_repository.dart';
import 'package:music_app/data/repositories/providers.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/states/playlists_list_state.dart';

class PlaylistsNotifier extends Notifier<PlaylistsState> {
  late final PlaylistsRepository playlistsRepository =
      ref.read(playlistsRepositoryProvider);

  @override
  PlaylistsState build() {
    return const PlaylistsState();
  }

  Future<void> fetchPlaylists() async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );

    try {
      final playlists = await playlistsRepository.getAllPlaylists();
      state = state.copyWith(
          screenState: const BaseScreenState.idle(), playlists: playlists);
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }

  Future<void> deletePlaylist(String id) async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );

    try {
      await playlistsRepository.removePlaylist(id);
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        playlists: state.playlists
            .where((playlist) => playlist.id != id)
            .toList(),
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }
}
