import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wieght_tracker_app/business%20logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:wieght_tracker_app/helper/utility.dart';
import 'package:wieght_tracker_app/presentation/screens/home_screen.dart';
import 'package:wieght_tracker_app/presentation/widgets/common/custom_button.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => listener(context, state),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image.asset('assets/img.png'),
                const SizedBox(height: 150),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return CustomButton(
                        text: 'Anonymous authentication',
                        onPressed: () {
                          var authCubit = AuthCubit.get(context);
                          authCubit.authenticateAnonymously();
                        });
                  }
                }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
  void listener(context, state) {
    if (state is AuthSuccess) {
      Utility.navigateTo(context, HomeScreen());
    } else if (state is AuthFailed) {
      const snackBar = SnackBar(
        content: Text('There is a problem'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
