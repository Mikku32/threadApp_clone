// ignore_for_file: prefer_const_constructors
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:form_app/Common/views/navigation_bar.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';

import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
         child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
        child: 
                Stack(
                  children: [
                    Container(

                      child: Column(children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "English (US)",
                            style: GoogleFonts.robotoSerif(
                              color: Color.fromARGB(255, 192, 186, 186),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset(
                          "assets/Threads Logo.png",
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color.fromARGB(255, 78, 77, 77),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 8,
                            ),
                            child: TextField(
                                controller: emailcontroller,
                                style: GoogleFonts.robotoSerif(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username, email or Phone number",
                                    hintStyle: GoogleFonts.robotoSerif(
                                      color: Color.fromARGB(255, 192, 186, 186),
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color.fromARGB(255, 78, 77, 77),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 8,
                            ),
                            child: TextField(
                                controller: passwordcontroller,
                                style: GoogleFonts.robotoSerif(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password...",
                                    hintStyle: GoogleFonts.robotoSerif(
                                      color: Color.fromARGB(255, 192, 186, 186),
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child:
                           BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                  content: Text("Invalid email or password",
                                  style: GoogleFonts.robotoSerif(
                                    color: Colors.white,
                                    fontSize: 15,),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 145, 15, 6),
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 10,
                                )
                                );
                              }
                              if (state is AuthSuccess) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavigationTabs()));
                              }
                              
                            },
                            builder: (context, state) => state is AuthLoading 
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    )
                                )
                                : ElevatedButton(
                              onPressed: () {
                                final email = emailcontroller.text;
                                final password = passwordcontroller.text;
                    
                                context.read<AuthCubit>().login(email, password);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: StadiumBorder()),
                              child: Text(
                                "Log in",
                                style: GoogleFonts.robotoSerif(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        )
                                 
                      ]),
                    ),
                     Align(
              alignment: Alignment.bottomCenter,
                child: Image.asset('assets/Meta_Logo 1.png')),
                  ],
                ),
        ),
              
            ),
          );
        
  }
}
