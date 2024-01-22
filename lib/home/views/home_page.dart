// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/home/cubit/home_cubit.dart';
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
              listener: (context, state) {
              },
              builder: (context, state) {
                if (state is HomeError) {
                  return Center(
                    child: Text(
                      state.message,
                    )
                  );
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
                           child: Column(
                             children: [
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(thread.user.image)
                                ),
                                title: Row(
                                  children: [
                                    Text(thread.user.username, style: GoogleFonts.robotoSlab(fontSize: 18,color: Colors.white),),
                                    Spacer(),

                                  
                                    if(DateTime.now().difference(thread.createdAt).inDays>0)
                                    Text(DateTime.now().difference(thread.createdAt).inDays.toString() + "d",style:GoogleFonts.robotoSlab(fontWeight: FontWeight.w300,color: Colors.white) ,)
                                    else if(DateTime.now().difference(thread.createdAt).inHours>0)
                                    Text(DateTime.now().difference(thread.createdAt).inHours.toString() + "h",style:GoogleFonts.robotoSlab(fontWeight: FontWeight.w300,color: Colors.white) ,)
                                    else 
                                    Text(DateTime.now().difference(thread.createdAt).inMinutes.toString() + "m",style:GoogleFonts.robotoSlab(fontWeight: FontWeight.w300,color: Colors.white) ,),
                                    
                                 
                                    SizedBox(width: 10),
                                    Icon(Icons.more_horiz, color: Colors.white),
                                  ]
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(thread.content, style: GoogleFonts.robotoSlab(color: Colors.white,fontSize: 15),),
                                    SizedBox(height: 10),
                                    if(thread.image != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        height: 300,
                                        width: 350,
                                        child: Image.network(thread.image.toString(),fit: BoxFit.fill,)),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                       GestureDetector(
                                         onTap: (){
                                          
                                         },
                                         child: LikeButton(
                                           size: 20,
                                       
                                         )
                                       ),
                                        SizedBox(width: 10,),
                                        Icon(Icons.chat_bubble_outline, color: Colors.white,)
                                      ]
                                    ),
                                    SizedBox(height: 10),
                                    Text(thread.likesCount.toString() + " likes", style: GoogleFonts.robotoSlab(color: Colors.white),)
                                  ],
                                ),
                                ),
                              Divider(thickness: 0.2,)
                             ]
                           ),
                           
                           margin: EdgeInsets.all(10),  
                         ),
                         
                        
                       ]),
                     ),
                   );
                }
               return  Center(
                 child: CircularProgressIndicator()
               ); 
              },
            )));
  }
}
