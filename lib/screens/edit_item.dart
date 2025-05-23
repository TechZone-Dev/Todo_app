import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_login/screens/items.dart';
import 'package:todo_login/screens/storage.dart';
import 'bottom_bar.dart';
import 'cart_items.dart';
import 'notification_bar.dart';

class EditItem extends StatefulWidget {
  final Item item;
  const EditItem({super.key,required this.item});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _shortDiscController;
  late TextEditingController _longDiscController;
  File? _imageFile;
  late String _image;
  int _currentindex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController =  TextEditingController(text: widget.item.name);
    _priceController= TextEditingController(text: widget.item.price);
    _shortDiscController = TextEditingController(text: widget.item.shortDisc);
    _longDiscController = TextEditingController(text: widget.item.longDisc);
    _image = widget.item.image;

  }
  Future<void> _pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile= File(pickedFile.path);
      } else {
        _imageFile = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan.withOpacity(0.5),
        iconTheme: IconThemeData(
            color: Colors.white54,
            size: 30
        ),
        title: Text('Items Maker',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),),
      body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                        ),
                        child: _imageFile != null?
                        Image.file(_imageFile!,fit: BoxFit.cover,): _image.isNotEmpty?Image.file(File(_image)): Icon(Icons.image,size: 50,color: Colors.white54,)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                          width: MediaQuery.of(context).size.width*0.46,
                          height: MediaQuery.of(context).size.height*0.072,

                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(

                                hintText: "Enter Product Name",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                          width: MediaQuery.of(context).size.width*0.46,
                          height: MediaQuery.of(context).size.height*0.072,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                          ),
                          child: TextFormField(
                            controller: _priceController,
                            decoration: InputDecoration(

                                hintText: "Enter Product Price",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none

                            ),


                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    width: MediaQuery.of(context).size.width,

                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: TextFormField(
                      controller: _shortDiscController,
                      maxLines: 2,
                      minLines: null,
                      decoration: InputDecoration(
                          hintText: "Enter Product Title",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          border: InputBorder.none

                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    width: MediaQuery.of(context).size.width,

                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: TextFormField(
                      controller: _longDiscController,
                      maxLines: 3,
                      minLines: null,
                      decoration: InputDecoration(

                          hintText: "Enter Product  Description",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          border: InputBorder.none

                      ),

                    ),

                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.07,

                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan.shade300,
                        ),
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            String imagePath = _imageFile != null ? _imageFile!.path : _image;
                            Item updatedItem = Item(
                              name: _nameController.text,
                              price: _priceController.text,
                              shortDisc: _shortDiscController.text,
                              longDisc: _longDiscController.text,
                              image: imagePath,
                            );
                           Navigator.pop(context,updatedItem);
                          }
                        },
                        child: Text('Update',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            ),
          ),
        ),

      bottomNavigationBar: BottomBar(
          currentindex: _currentindex,
          onTap:(index){
            switch(index){
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationBar()));
              case 3:
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartItems()));

            }
          }),
    );
  }
}
