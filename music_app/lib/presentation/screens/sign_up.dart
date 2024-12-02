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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final state = ref.read(signUpViewModelProvider);

    _emailController = TextEditingController(text: state.email);
    _passwordController = TextEditingController(text: state.password);
    _repeatPasswordController =
        TextEditingController(text: state.repeatPassword);

    _emailController.addListener(() {
      ref
          .read(signUpViewModelProvider.notifier)
          .updateEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      ref
          .read(signUpViewModelProvider.notifier)
          .updatePassword(_passwordController.text);
    });
    _repeatPasswordController.addListener(() {
      ref
          .read(signUpViewModelProvider.notifier)
          .updateRepeatPassword(_repeatPasswordController.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpViewModelProvider);
    final notifier = ref.read(signUpViewModelProvider.notifier);

    return Scaffold(
      body: state.screenState.when(
        idle: () => _SignUp(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
          repeatPasswordController: _repeatPasswordController,
          isPasswordVisible: state.isPasswordVisible,
          togglePasswordVisibility: notifier.togglePasswordVisibility,
          isRepeatPasswordVisible: state.isRepeatPasswordVisible,
          toggleRepeatPasswordVisibility:
              notifier.toggleRepeatPasswordVisibility,
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
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    required this.isRepeatPasswordVisible,
    required this.toggleRepeatPasswordVisibility,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  final void Function() togglePasswordVisibility;
  final void Function() toggleRepeatPasswordVisibility;

  final bool isPasswordVisible;
  final bool isRepeatPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
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
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
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
              const SizedBox(height: 30),
              TextFormField(
                controller: repeatPasswordController,
                obscureText: !isRepeatPasswordVisible,
                autocorrect: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Repeat Password',
                  hintText: 'Repeat password',
                  suffixIcon: IconButton(
                    onPressed: toggleRepeatPasswordVisibility,
                    icon: Icon(
                      isRepeatPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please repeat your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (formKey.currentState?.validate() ?? false) {

                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
