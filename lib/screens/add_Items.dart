import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_login/screens/bottom_bar.dart';
import 'package:todo_login/screens/notification_bar.dart';
import 'cart_items.dart';
import 'items.dart';

class AddItems extends StatefulWidget {
  final Function addItem;
  const AddItems({super.key, required this.addItem});
  @override
  State<AddItems> createState() => _AddItemsState();
}
class _AddItemsState extends State<AddItems> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String _name = '';
  String price = '';
  String _shortDisc = '';
  String _longDisc = '';
  int _currentindex = 1;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
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
          key: _formKey,
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
                    child: _image != null?
                    Image.file(_image!,fit: BoxFit.cover,):
                        Icon(Icons.image,size: 50,color: Colors.white54,)
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
                    decoration: InputDecoration(
        
                        hintText: "Enter Product Name",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        border: InputBorder.none
        
                    ),
                    onSaved: (value) => _name=value!,
        
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
                      decoration: InputDecoration(
        
                          hintText: "Enter Product Price",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          border: InputBorder.none
        
                      ),
                      onSaved: (value) => price=value!,
        
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
                   maxLines: 2,
                    minLines: null,
                    decoration: InputDecoration(
        
                        hintText: "Enter Product Description",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        border: InputBorder.none
        
                    ),
                    onSaved: (value) => _shortDisc=value!,
        
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
                    maxLines: 3,
                    minLines: null,
                    decoration: InputDecoration(
        
                        hintText: "Enter Product Long Description",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        border: InputBorder.none
        
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product price';
                      }
                      return null;
                    },
                    onSaved: (value) => _longDisc = value!,
        
        
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
        
                        if(_formKey.currentState!.validate() &&   _image != null){
                          _formKey.currentState?.save();
                          widget.addItem(Item(
                              image: _image!.path,
                              name: _name,
                              shortDisc: _shortDisc,
                              longDisc: _longDisc,
                              price: price,
        
        
                          ));
                          Navigator.pop(context);
        
                        }
        
                      },
                      child: Text('Submit',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),
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
              case 1:
                   Navigator.pop(context);
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationBar()));
              case 3:
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartItems()));
            }
          }),
    );
  }
}
