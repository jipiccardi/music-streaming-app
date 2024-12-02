import 'package:music_app/presentation/utils/base_screen_state.dart';

class SignUpState {
  final BaseScreenState screenState;
  final bool isPasswordVisible;
  final String password;

  const SignUpState({
    this.screenState = const BaseScreenState.idle(),
    this.isPasswordVisible = false,
    this.password = '',
  });

  SignUpState copyWith({
    BaseScreenState? screenState,
    bool? isPasswordVisible,
    String? password,
  }) {
    return SignUpState(
      screenState: screenState ?? this.screenState,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      password: password ?? this.password,
    );
  }
}
