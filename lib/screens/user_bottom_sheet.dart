import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_login/screens/login_screen.dart';

class UserBottomSheet extends StatefulWidget {

  UserBottomSheet({super.key});
  @override
  State<UserBottomSheet> createState() => _UserBottomSheetState();
}
class _UserBottomSheetState extends State<UserBottomSheet> {
  String? _email;
  void _getValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email');
    });}
  @override
  void initState() {
    super.initState();
    _getValue();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(_email ?? "No value",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.06,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent.withOpacity(0.5),
                    ),
                    onPressed: () async {
                      final prefs=await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      prefs.remove('email');
                      Navigator.pushAndRemoveUntil(
                          context,
                           MaterialPageRoute(builder: (context)=> LoginScreen()),
                          (Route<dynamic> route) => false
                      );},
                    child: Text('logout',style: TextStyle(fontSize: 20,color: Colors.red.withOpacity(0.8),fontWeight: FontWeight.bold),)
                ),
              ),
            ],
          ),
        )
      );

  }
}
