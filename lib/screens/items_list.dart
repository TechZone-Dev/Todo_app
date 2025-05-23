import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_login/screens/bottom_bar.dart';
import 'package:todo_login/screens/cart_items.dart';
import 'package:todo_login/screens/items.dart';
import 'package:todo_login/screens/notification_bar.dart';


class ItemsList extends StatefulWidget {
  final Item item;
   ItemsList({super.key,required this.item});
  @override
  State<ItemsList> createState() => _ItemsListState();
}
class _ItemsListState extends State<ItemsList> {
  int _currentindex=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
          appBar: AppBar(
          title: Text('ITEM DETAIL',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
            backgroundColor: Colors.cyan.withOpacity(0.5),
            iconTheme: IconThemeData(
                color: Colors.white,

            ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(File(widget.item.image)),
                  fit: BoxFit.cover,
                ),
              ),
              ),
              SizedBox(height: 10,),
              Text(widget.item.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.grey),),
              Row(
                children: [
                  Text('RS:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),),
                  SizedBox(width: 5,),
                  Text(widget.item.price,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),)
                ],
              ),
              Text(widget.item.shortDisc,style: TextStyle(fontSize: 20,color: Colors.teal),),
              Text('Description:',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.deepOrangeAccent),),
              Text(widget.item.longDisc,style: TextStyle(color: Colors.black26),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(widget.item != null){
                        final prefs = await SharedPreferences.getInstance();
                        List<String>? cartItems = prefs.getStringList('cartItems');
                        if(cartItems == null){
                          cartItems = [];
                        }
                        cartItems.add(jsonEncode(widget.item.toJson()));
                        prefs.setStringList('cartItems', cartItems);

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to Cart', style: TextStyle(fontSize: 20, color: Colors.cyanAccent, fontWeight: FontWeight.w500),),
                              backgroundColor: Colors.brown.withOpacity(0.5),

                            ));
                      }



                    },
                    child: Text('Add to Cart', style: TextStyle(color: Colors.teal, fontSize: 16)),
                  )

                ],
              )
          
              
          
          
            ],
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NotificationBar()));
              case 3:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CartItems()));

            }
          }),
    );
    }
}