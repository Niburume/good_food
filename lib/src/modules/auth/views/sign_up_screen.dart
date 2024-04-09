import 'package:mall/src/extensions/build_context.dart';

import '../../../utils/strings.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../components/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
          Navigator.pop(context);
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(80))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          30, kToolbarHeight, 30, kToolbarHeight),
                      child: Column(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: MyTextField(
                                          controller: nameController,
                                          hintText: 'Name',
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          prefixIcon: const Icon(
                                              CupertinoIcons.person_fill),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Please fill in this field';
                                            } else if (val.length > 30) {
                                              return 'Name too long';
                                            }
                                            return null;
                                          }),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: MyTextField(
                                          controller: emailController,
                                          hintText: 'Email',
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          prefixIcon: const Icon(
                                              CupertinoIcons.mail_solid),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Please fill in this field';
                                            } else if (!emailRexExp
                                                .hasMatch(val)) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          }),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: MyTextField(
                                          controller: passwordController,
                                          hintText: 'Password',
                                          obscureText: obscurePassword,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          prefixIcon: const Icon(
                                              CupertinoIcons.lock_fill),
                                          onChanged: (val) {
                                            if (val!
                                                .contains(RegExp(r'[A-Z]'))) {
                                              setState(() {
                                                containsUpperCase = true;
                                              });
                                            } else {
                                              setState(() {
                                                containsUpperCase = false;
                                              });
                                            }
                                            if (val
                                                .contains(RegExp(r'[a-z]'))) {
                                              setState(() {
                                                containsLowerCase = true;
                                              });
                                            } else {
                                              setState(() {
                                                containsLowerCase = false;
                                              });
                                            }
                                            if (val
                                                .contains(RegExp(r'[0-9]'))) {
                                              setState(() {
                                                containsNumber = true;
                                              });
                                            } else {
                                              setState(() {
                                                containsNumber = false;
                                              });
                                            }
                                            if (val
                                                .contains(specialCharRexExp)) {
                                              setState(() {
                                                containsSpecialChar = true;
                                              });
                                            } else {
                                              setState(() {
                                                containsSpecialChar = false;
                                              });
                                            }
                                            if (val.length >= 8) {
                                              setState(() {
                                                contains8Length = true;
                                              });
                                            } else {
                                              setState(() {
                                                contains8Length = false;
                                              });
                                            }
                                            return null;
                                          },
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscurePassword =
                                                    !obscurePassword;
                                                if (obscurePassword) {
                                                  iconPassword =
                                                      CupertinoIcons.eye_fill;
                                                } else {
                                                  iconPassword = CupertinoIcons
                                                      .eye_slash_fill;
                                                }
                                              });
                                            },
                                            icon: Icon(iconPassword),
                                          ),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Please fill in this field';
                                            } else if (!passwordRexExp
                                                .hasMatch(val)) {
                                              return 'Please enter a valid password';
                                            }
                                            return null;
                                          }),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "⚈  1 uppercase",
                                              style: TextStyle(
                                                  color: containsUpperCase
                                                      ? Colors.green
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                            ),
                                            Text(
                                              "⚈  1 lowercase",
                                              style: TextStyle(
                                                  color: containsLowerCase
                                                      ? Colors.green
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                            ),
                                            Text(
                                              "⚈  1 number",
                                              style: TextStyle(
                                                  color: containsNumber
                                                      ? Colors.green
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "⚈  1 special character",
                                              style: TextStyle(
                                                  color: containsSpecialChar
                                                      ? Colors.green
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                            ),
                                            Text(
                                              "⚈  8 minimum characters",
                                              style: TextStyle(
                                                  color: contains8Length
                                                      ? Colors.green
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    !signUpRequired
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: kToolbarHeight,
                                            child: TextButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    MyUser myUser =
                                                        MyUser.empty;
                                                    myUser.email =
                                                        emailController.text;
                                                    myUser.name =
                                                        nameController.text;

                                                    setState(() {
                                                      context
                                                          .read<SignUpBloc>()
                                                          .add(SignUpRequired(
                                                              myUser,
                                                              passwordController
                                                                  .text));
                                                    });
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                    elevation: 3.0,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12))),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 5),
                                                  child: Text(
                                                    'Sign Up',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )),
                                          )
                                        : const CircularProgressIndicator()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: kToolbarHeight,
                                child: Center(
                                  child: Text(
                                    "Already have an account? Sign In",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
