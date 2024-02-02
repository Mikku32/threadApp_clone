// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/Delete/cubit/delete_cubit.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/home/cubit/home_cubit.dart';
import 'package:form_app/update/cubit/update_cubit.dart';
import 'package:form_app/update/views/edit_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomeData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              toolbarHeight: 50,
              title: Image.asset(
                'assets/Threads Logo.png',
                height: 30,
                width: 30,
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HomeError) {
                  return Center(
                      child: Text(
                    state.message,
                  ));
                }
                if (state is HomeSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<HomeCubit>().getHomeData();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(children: [
                        for (final thread in state.threads)
                          Container(
                            child: Column(children: [
                              ListTile(
                                leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage(thread.user.image)),
                                title: Row(children: [
                                  Text(
                                    thread.user.username,
                                    style: GoogleFonts.robotoSlab(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Spacer(),
                                  if (DateTime.now()
                                          .difference(thread.createdAt)
                                          .inDays >
                                      0)
                                    Text(
                                      "${DateTime.now().difference(thread.createdAt).inDays}d",
                                      style: GoogleFonts.robotoSlab(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    )
                                  else if (DateTime.now()
                                          .difference(thread.createdAt)
                                          .inHours >
                                      0)
                                    Text(
                                      "${DateTime.now().difference(thread.createdAt).inHours}h",
                                      style: GoogleFonts.robotoSlab(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    )
                                  else if (DateTime.now()
                                          .difference(thread.createdAt)
                                          .inMinutes >
                                      0)
                                    Text(
                                      "${DateTime.now().difference(thread.createdAt).inMinutes}m",
                                      style: GoogleFonts.robotoSlab(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    )
                                  else
                                    Text(
                                      "${DateTime.now().difference(thread.createdAt).inSeconds}s",
                                      style: GoogleFonts.robotoSlab(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  SizedBox(width: 10),
                                  if (thread.user.id ==
                                      (context.read<AuthCubit>().state
                                              as AuthSuccess)
                                          .user
                                          .id)
                                    IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor: Color.fromARGB(
                                                  255, 122, 122, 122),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    padding: EdgeInsets.only(
                                                        top: 30),
                                                    height: 150,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            child: Column(
                                                                children: [
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .push(
                                                                          MaterialPageRoute(
                                                                              builder: (context) => EditThread(
                                                                                    content: thread.content,
                                                                                    id: thread.id,
                                                                                  )),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            50,
                                                                      )),
                                                                  Text(
                                                                    'Edit',
                                                                    style: GoogleFonts
                                                                        .robotoSlab(
                                                                            color:
                                                                                Colors.black),
                                                                  )
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            child: BlocConsumer<
                                                                DeleteCubit,
                                                                DeleteState>(
                                                              listener:
                                                                  (context,
                                                                      state) {
                                                                if (state
                                                                    is DeleteError) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    content: Text(
                                                                        "Something went wrong"),
                                                                  ));
                                                                }
                                                                if (state
                                                                    is DeleteSuccess) {
                                                                  context
                                                                      .read<
                                                                          HomeCubit>()
                                                                      .getHomeData();
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    content: Text(
                                                                        "Thread deleted successfully"),
                                                                  ));
                                                                }
                                                              },
                                                              builder: (context,
                                                                  state) {
                                                                if (state
                                                                    is DeleteLoading) {
                                                                  return CircularProgressIndicator();
                                                                }
                                                                return Column(
                                                                    children: [
                                                                      InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            context.read<DeleteCubit>().deleteThread(thread.id);
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            size:
                                                                                50,
                                                                          )),
                                                                      Text(
                                                                        'Delete',
                                                                        style: GoogleFonts.robotoSlab(
                                                                            color:
                                                                                Colors.black),
                                                                      )
                                                                    ]);
                                                              },
                                                            ),
                                                          )
                                                        ]));
                                              });
                                        },
                                        icon: Icon(
                                          Icons.more_horiz_outlined,
                                          color: Colors.white,
                                        ))
                                ]),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      thread.content,
                                      style: GoogleFonts.robotoSlab(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(height: 10),
                                    if (thread.image != null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                            width: 350,
                                            child: Image.network(
                                              thread.image.toString(),
                                              // fit: BoxFit.fill,
                                            )),
                                      ),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      GestureDetector(
                                          onTap: () {},
                                          child: LikeButton(
                                            size: 20,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        color: Colors.white,
                                      )
                                    ]),
                                    SizedBox(height: 10),
                                    Text(
                                      "${thread.likesCount} likes",
                                      style: GoogleFonts.robotoSlab(
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.2,
                              )
                            ]),
                            margin: EdgeInsets.all(10),
                          ),
                      ]),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )));
  }
}
