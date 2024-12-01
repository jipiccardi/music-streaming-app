import 'package:go_router/go_router.dart';
import 'package:music_app/presentation/screens/new_playlist.dart';
import 'package:music_app/presentation/screens/song_player.dart';
import '../presentation/screens/playlists_list.dart';
import '../presentation/screens/songs_list.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        redirect: (context, state) {
          return '/songs';
        }),
    GoRoute(
      path: '/songs',
      name: SongsListScreen.name,
      builder: (context, state) => const SongsListScreen(),
    ),
    GoRoute(
      path: '/songs/:id',
      name: SongPlayerScreen.name,
      builder: (context, state) => SongPlayerScreen(
        songId: state.pathParameters['id'] ?? '',
        playlist: state.extra as List<String>,
      ),
    ),
    GoRoute(
      path: '/playlist',
      name: PlaylistScreen.name,
      builder: (context, state) => const PlaylistScreen(),
    ),
    GoRoute(
      path: '/new-playlist/:origin',
      name: NewPlaylistScreen.name,
      builder: (context, state) => NewPlaylistScreen(
        origin: state.pathParameters['origin'] ?? '',
      ),
    )
  ],
);
