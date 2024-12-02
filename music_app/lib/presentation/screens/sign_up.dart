import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/providers.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const name = 'SignUpScreen';

  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    final state = ref.read(signUpViewModelProvider);

    _passwordController = TextEditingController(text: state.password);
    _passwordController.addListener(() {
      ref
          .read(signUpViewModelProvider.notifier)
          .updatePassword(_passwordController.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpViewModelProvider);
    final notifier = ref.read(signUpViewModelProvider.notifier);

    return Scaffold(
      body: state.screenState.when(
        idle: () => _SignUp(
          togglePasswordVisibility: notifier.togglePasswordVisibility,
          isPasswordVisible: state.isPasswordVisible,
          passwordController: _passwordController,
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp({
    required this.togglePasswordVisibility,
    required this.isPasswordVisible,
    required this.passwordController,
  });

  final void Function() togglePasswordVisibility;
  final bool isPasswordVisible;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              autocorrect: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  onPressed: togglePasswordVisibility,
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
