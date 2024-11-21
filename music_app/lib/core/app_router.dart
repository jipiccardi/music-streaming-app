import 'package:go_router/go_router.dart';
import '../presentation/screens/songs_list.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return '/songs';
      }
    ),
    GoRoute(
      path: '/songs',
      name: SongsListScreen.name,
      builder: (context, state) => const SongsListScreen(),
    )
  ],
);
