
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../blocs/auth_bloc.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../components/my_texy.dart';
import '../helper/show_snack_bar.dart';
import 'chat_page.dart';

class RegisterPage extends StatelessWidget {
  String? email;

  String? password;

  bool isLoading = false;

  static String id = 'RegisterPage';

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else if (state is RegisterSuccess) {
            Navigator.pushNamed(context, ChatPage.id, arguments: email);
            isLoading = false;
          } else if (state is RegisterFailure) {
            showSnackBart(context, state.errMessage);
            isLoading = false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SafeArea(
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create a new account',
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // MyTextField(
                        //     hintText: 'Full Name',
                        //     obscureText: false,
                        //     suffixIcon: const Icon(Icons.person)),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextFormField(
                            onChanged: (data) {
                              email = data;
                            },
                            hintText: 'Email',
                            obscureText: false,
                            suffixIcon: const Icon(Icons.mail)),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextFormField(
                            onChanged: (data) {
                              password = data;
                            },
                            hintText: 'Password',
                            obscureText: true,
                            suffixIcon: const Icon(Icons.lock)),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(RegisterEvent(email: email!, password: password!));
                            } else {}
                          },
                          text: 'Sign Up',
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              text: 'Already a member?',
                              color: Color(0xff979797),
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: MyText(
                                text: 'Login',
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
