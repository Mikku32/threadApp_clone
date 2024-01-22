import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/Common/views/navigation_bar.dart';
import 'package:form_app/auth/cubit/auth_cubit.dart';
import 'package:form_app/home/cubit/home_cubit.dart';
import 'package:form_app/profile/cubit/profile_cubit.dart';
import 'package:form_app/upload/cubit/upload_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _contentcontroller = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _image;

  void _pickImage({ImageSource source = ImageSource.gallery}) async {
    _image = await _imagePicker.pickImage(
      source: source,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 50,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationTabs(),
                ));
              },
              icon: Image.asset('assets/close.png'),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<UploadCubit, UploadState>(
                  listener: (context, state) {
                    if (state is UploadError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Really bro... Really?"),
                      ));
                    }

                    if (state is UploadSuccess) {
                      context.read<HomeCubit>().getHomeData();
                      _contentcontroller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Thread created successfully"),
                      ));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => NavigationTabs(),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is UploadLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          final content = _contentcontroller.text;
                          context
                              .read<UploadCubit>()
                              .createThread(content, _image);
                        },
                        child: Row(children: [
                          Image.asset(
                            'assets/add_square.png',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add',
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      );
                    }
                  },
                ),
              )
            ]),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (context.read<AuthCubit>().state as AuthSuccess).user.image)),
                title: Text('@${(context.read<AuthCubit>().state as AuthSuccess).user.username}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                subtitle: Text(
                  '${DateTime.now().day}-0${DateTime.now().month}-${DateTime.now().year}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 65),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            controller: _contentcontroller,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: GoogleFonts.robotoSerif(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Your content here....",
                                hintStyle: GoogleFonts.robotoSerif(
                                  color: Color.fromARGB(255, 192, 186, 186),
                                ))),
                        SizedBox(height: 20),
                        if (_image != null)
                          Image.file(
                            File(_image!.path),
                            height: 200,
                            width: 200,
                          ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Color.fromARGB(255, 122, 122, 122),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  
                                  ),

                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 30),
                                     height: 150,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                         SizedBox(
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                   _pickImage(source: ImageSource.camera);
                                                },
                                                child: Icon(Icons.camera_alt,size: 50,)),
                                              Text('Camera',style: GoogleFonts.robotoSlab(color: Colors.black),)
                                            ]
                                          ),
                                         ),
                                          
                                         SizedBox(
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: (){ _pickImage(source: ImageSource.gallery);},
                                                child: Icon(Icons.image,size: 50,)),
                                              Text('Gallery',style: GoogleFonts.robotoSlab(color: Colors.black),)
                                            ]
                                          ),
                                         )
                                         
                                        ]));
                                  });
                            },
                            icon: Image.asset('assets/attachFile.png')),
                      ])),
            ])),
      ),
    );
  }
}
