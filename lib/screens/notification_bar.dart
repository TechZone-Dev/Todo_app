import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_login/screens/home_page.dart';

import 'bottom_bar.dart';
import 'cart_items.dart';

class NotificationBar extends StatelessWidget {
  const NotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    int _currentindex = 2;
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
      appBar: AppBar(title: Text('Notifications',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),),
        iconTheme: IconThemeData(
          color:Colors.white
        ),
        backgroundColor: Colors.cyan.withOpacity(0.5),
      ),
      bottomNavigationBar: BottomBar(
          currentindex: _currentindex,
          onTap:(index){
            switch(index){
              case 1:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

              case 3:
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartItems()));


            }
          }),
    );
  }
}
