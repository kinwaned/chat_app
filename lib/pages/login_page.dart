import 'package:elearning_app/components/my_button.dart';
import 'package:elearning_app/components/my_text_field.dart';
import 'package:elearning_app/components/my_texy.dart';
import 'package:elearning_app/components/sqaure_tile.dart';
import 'package:elearning_app/cubits/chat_cubit/chat_cubit.dart';import 'package:elearning_app/pages/chat_page.dart';
import 'package:elearning_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../blocs/auth_bloc.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatelessWidget {
  final passwordController = TextEditingController();

  static String id = 'LoginPage';
  final emailController = TextEditingController();
  bool isLoading = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).receiveMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBart(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset('images/kinway.png', width: 120),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Welcome back, you\'ve been missed!',
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: 'Email',
                          obscureText: false,
                          controller: emailController,
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
                          controller: passwordController,
                          suffixIcon: const Icon(Icons.lock)),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(
                              text: 'Forgot passowrd?',
                              color: Color(0xff979797),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email!, password: password!));
                          } else {}
                        },
                        text: 'Sign In',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: MyText(
                                text: 'Or continue with',
                                color: Color(0xff979797),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SquareTile(
                              imagePath: 'images/sm_icons/icons8-google.svg'),
                          SizedBox(
                            width: 25,
                          ),
                          SquareTile(
                              imagePath: 'images/sm_icons/icons8-facebook.svg'),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text: 'Not a member?',
                            color: Color(0xff979797),
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: MyText(
                              text: 'Register Now',
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
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
