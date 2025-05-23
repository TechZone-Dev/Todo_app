import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_login/screens/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email='';
  bool _obscurePassword =true;
  bool _obscureRetypePassword =true;
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _retypePassword = '';
  bool _ischecked = false;
  Future<void> _login() async{
  if (_formKey.currentState!.validate() && _ischecked) {
    final prefs=await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('email', _email);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  } else if (!_ischecked) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Please agree to the terms')),
  );}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(

            child: Form(
              key: _formKey,

              child: SingleChildScrollView(
                child: Column(
                  children: [
                   SizedBox(height: 0,),
                   Text('Sign In',
                     style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,

                     ),),
                    SizedBox(height: 50,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,

                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(25),
                              boxShadow:[ BoxShadow(
                                color: Colors.blueGrey.shade200,
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              )]
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                hintText: 'e-mail',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26,
                                ),
                                labelText: 'E-mail',

                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.withOpacity(0.8),
                                )
                              ),
                              validator: (value){
                                if(value==null || value.isEmpty || !value.contains('@')){
                                  return "Please enter valid email address";

                                }
                                _email=value;

                                return null;

                              }

                            ),),
                          SizedBox(height: 25,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(25),
                                boxShadow:[ BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                )]
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed:(){
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      } ,
                                      icon: Icon(
                                        _obscurePassword?
                                            Icons.visibility : Icons.visibility_off,
                                      ),
                                  ),

                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26,
                                  ),
                                  labelText: 'Password',

                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.withOpacity(0.8),
                                  )
                              ),
                              obscureText: _obscurePassword,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please enter a password';
                                }
                                if(value.length<8){
                                  return'Password should contain at least one uppercase letter';
                                }
                                if(!value.contains(RegExp(r'[!@#$%6&*()_+-={}?"?/><]'))){
                                  return'Password should contain at least one special character';
                                }
                                if(!value.contains(RegExp(r'[A-Z]'))){
                                  return'Password should contain at least one special character';
                                }
                                _password=value;
                                return null;
                              },),),
                          SizedBox(height: 25,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(25),
                                boxShadow:[ BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                )]
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed:(){
                                      setState(() {
                                        _obscureRetypePassword = !_obscureRetypePassword;
                                      });
                                    } ,
                                    icon: Icon(
                                      _obscureRetypePassword?
                                      Icons.visibility : Icons.visibility_off,
                                    ),
                                  ),
                                  hintText: 'retype password',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26,
                                  ),
                                  labelText: 'Retype Password',

                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.withOpacity(0.8),
                                  )
                              ),
                              obscureText: _obscureRetypePassword,
                              validator: (value){
                                if(value==null || value.isEmpty ){
                                  return ' Re-type Password';
                                }
                                _retypePassword=value;
                                if(_password != _retypePassword){
                                return 'Password don\'t match';

                                }
                                return null;
                              },),),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Checkbox(
                                  value: _ischecked,
                                  onChanged: (value){
                                      setState(() {
                                        _ischecked = value!;
                                      });
                                  },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)),
                                activeColor: Colors.cyan,
                                checkColor: Colors.white,
                                side: BorderSide(color: Colors.cyan,width: 3),


                              ),
                              Text('Remember me',style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            child:ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan,
                                elevation: 4,
                                shadowColor: Colors.blueGrey.shade100,

                              ),


                               onPressed: _login,



                              child: Text('Sign In',style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Colors.white ),
                              ),),
                          ),

                        ],
                      ),

                    )

                  ],
                ),
              ),
            ),
          ),
    );


  }
}