import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_login/screens/cart_items.dart';
import 'package:todo_login/screens/user_bottom_sheet.dart';

class BottomBar extends StatefulWidget {
  final Function (int) onTap;
  final int currentindex;
  BottomBar({super.key,required this.currentindex,required this.onTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}
class _BottomBarState extends State<BottomBar> {
  bool _isBottomSheetVisible = false;

  void _showbottomsheet(){
    if (_isBottomSheetVisible) {
      Navigator.of(context).pop();
      _isBottomSheetVisible = false;
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return UserBottomSheet();// Replace with your BottomSheet content
        },
      ).then((value) {
        _isBottomSheetVisible = false;
      });
      _isBottomSheetVisible = true;
    }

  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
          color:Colors.black12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: Icon(
                  Icons.home,
                  color: widget.currentindex==1? Colors.cyan:Colors.white70,
                  size: 40,),
                onTap: (){
                  setState(() {
                    widget.onTap(1);
                  });

                },
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: Icon(
                  Icons.notifications,
                  color: widget.currentindex==2? Colors.cyan:Colors.white70,
                  size: 40,),
                onTap: (){
                  setState(() {
                    widget.onTap(2);
                  });

                },
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: Icon(
                  Icons.shopping_cart,
                  color: widget.currentindex==3? Colors.cyan:Colors.white70,
                  size: 40,),
                onTap: (){
                  setState(() {
                    widget.onTap(3);
                  });

                },
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: Icon(
                  Icons.person,
                  color: widget.currentindex == 4 ? Colors.cyan:Colors.white70,
                  size: 40,),
                onTap: (){
                  setState(() {
                     _showbottomsheet();
                  });

                },
              ),
            ],
          ),
        );


  }
}
