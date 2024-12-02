import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/data/repositories/providers.dart';
import 'package:music_app/data/repositories/users_repository.dart';
import 'package:music_app/presentation/viewmodels/states/sign_up_state.dart';
import 'package:music_app/services/firestore_auth_service.dart';

class SignUpNotifier extends Notifier<SignUpState> {
  late final UsersRepository usersRepository =
      ref.read(usersRepositoryProvider);
  late final FirestoreAuthService authService = FirestoreAuthService();

  @override
  SignUpState build() {
    return const SignUpState();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }
}
