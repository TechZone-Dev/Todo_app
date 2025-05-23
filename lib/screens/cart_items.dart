import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_login/screens/bottom_bar.dart';
import 'package:todo_login/screens/notification_bar.dart';
import 'package:todo_login/screens/storage.dart';
import 'home_page.dart';
import 'items.dart';

class CartItems extends StatefulWidget {
    CartItems({super.key,});
    @override
    State<CartItems> createState() => _CartItemsState();
  }
  class _CartItemsState extends State<CartItems> {
  List<Item> _cartItems = [];
    int _currentindex = 3;
    Future<void> _loadCartItems() async{
      final prefs=await SharedPreferences.getInstance();
        List<String>? cartItemString = prefs.getStringList('cartItems');
        if(cartItemString != null){
          setState(() {
            _cartItems = cartItemString.map((string) => Item.fromJson(jsonDecode(string))).toList();
          });
        }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _loadCartItems();
  }

    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        backgroundColor: Colors.tealAccent.shade100,
        appBar: AppBar(title: Text('Cart Items',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 25),),
          backgroundColor: Colors.cyan.withOpacity(0.5),
          iconTheme: IconThemeData(
             color: Colors.white
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: ListView.builder(

                shrinkWrap: true,
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.18,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,

                    ),
                    child: Row(

                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(
                           image: FileImage(File(
                               _cartItems[index].image

                           )),
                         fit: BoxFit.cover
                       ),
                       ),

                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(_cartItems[index].name,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),
                             Row(

                               children: [
                                 Text('RS:',style: TextStyle(fontSize:15,color: Colors.white ),),
                                 Text(_cartItems[index].price,style: TextStyle(fontSize: 15,color: Colors.white),),
                               ],
                             ),
                             Container(
                               width: MediaQuery.of(context).size.width*0.51,
                               child: Text(_cartItems[index].shortDisc,style: TextStyle(color: Colors.white),),
                             )


                           ],
                         ),

                          Row(
                            children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                                onPressed: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Order Placed')));

                                },
                                child:Text('Conform Order',style: TextStyle(color: Colors.white,fontSize: 10),)),
                            SizedBox(width: 5,),
                            ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: () async{
                                    setState(() {
                                      _cartItems.removeAt(index);
                                    });
                                    final prefs = await SharedPreferences.getInstance();
                                    List<String> cartItemString = _cartItems.map((item) => jsonEncode(item.toJson())).toList();
                                    prefs.setStringList('cartItems', cartItemString);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Item Removed')));

                                  },
                                  child:Text('Remove',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ])
                        ],
                      )

                    ],
                    ),
                  );

                },
              )


        ),



        bottomNavigationBar: BottomBar(
            currentindex: _currentindex,
            onTap:(index){
              switch(index){
                case 1:
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (Route<dynamic> route)=>false);
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationBar()));
              }
            }),
      );


       }

    }

