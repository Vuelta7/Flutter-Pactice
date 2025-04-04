import 'package:flutter/material.dart';
import 'package:practice_app/introduction%20for%20learn-n/widget/introduction_utils.dart';
import 'package:practice_app/introduction%20for%20learn-n/widget/retro_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLogo(),
              buildTitleText('Learn-N'),
              const SizedBox(height: 40),
              buildRetroButton(
                'Register',
                Colors.black,
                () {},
              ),
              const SizedBox(height: 15),
              buildRetroButton(
                'Log In',
                Colors.black,
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
