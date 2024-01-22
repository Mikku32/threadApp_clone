// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/profile/cubit/profile_cubit.dart';
import 'package:form_app/profile/widgets/logout_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
     final userId = (context.read<AuthCubit>().state as AuthSuccess).user.id;
    context.read<ProfileCubit>().getProfileThreads(userId);
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfileError) {
                return Center(
                    child: Text(
                  'fgvg',
                ));
              }
              if (state is ProfileSuccess) {
                //Content in the Authentication model stored in profiledata
                final profiledata=(context.read<AuthCubit>().state as AuthSuccess).user;
                
                return Column(children: [
                  Center(
                      child: Column(children: [
                        SizedBox(height: 30),
                    CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(profiledata.image)),
                        SizedBox(height: 20),
                    Text('${profiledata.firstName} ${profiledata.lastName}',style: GoogleFonts.robotoSlab(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('@${profiledata.username}',style: GoogleFonts.roboto(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal),),
                    Text(profiledata.bio,style: GoogleFonts.bioRhyme(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w300),),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(onPressed: (){},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white))),
                            backgroundColor: MaterialStateProperty.all(Colors.black),),
                            child: Text('Edit Profile',
                             style: GoogleFonts.roboto(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal),),
                        ),
                        
                        ElevatedButton(onPressed: (){},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white))),
                            backgroundColor: MaterialStateProperty.all(Colors.black),),
                        child: Text('Share Profile',
                        style: GoogleFonts.roboto(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal))),

                      ]
                    ),
                    SizedBox(height: 20,),
        
                    for (final thread in state.threads)
                   Container(
                           margin: EdgeInsets.all(10),
                           child: Column(
                             children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(thread.user.image)
                                ),
                                title: Row(
                                  children: [
                                    Text(thread.user.username, style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                    Spacer(),
                                   
                                    Text('${DateTime.now().difference(thread.createdAt).inDays.toString() }d',style:GoogleFonts.robotoSlab(fontWeight: FontWeight.w300,color: Colors.white,fontSize: 15) ,),
                                    const SizedBox(width: 10),
                                    Icon(Icons.more_horiz, color: Colors.white),
                                  ]
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 45),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(thread.content, style: GoogleFonts.robotoSlab(color: Colors.white, fontSize: 15),),
                                    SizedBox(height: 10),
                                    if(thread.image != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 300,
                                        width: 350,
                                        child: Image.network(thread.image.toString(),fit: BoxFit.fill,)),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children:const [
                                      LikeButton(),
                                        SizedBox(width: 10,),
                                        Icon(Icons.chat_bubble_outline, color: Colors.white,)
                                      ]
                                    ),
                                    SizedBox(height: 10),
                                    Text('${thread.likesCount.toString()} likes', style: GoogleFonts.robotoSlab(color: Colors.white),)
                                  ],
                                ),
                                ),
                              Divider(thickness: 0.2,)
                             ]
                           ),  
                         ),
                    
                    
                  ])
                  ),
                  
                ]);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
