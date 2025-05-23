import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_login/screens/add_Items.dart';
import 'package:todo_login/screens/bottom_bar.dart';
import 'package:todo_login/screens/edit_item.dart';
import 'package:todo_login/screens/items.dart';
import 'package:todo_login/screens/items_list.dart';
import 'package:todo_login/screens/notification_bar.dart';
import 'package:todo_login/screens/storage.dart';
import 'cart_items.dart';


class HomePage extends StatefulWidget {
   const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<Item> items = [];
  int _currentindex = 1;

  @override
  void initState() {
    super.initState();
    Storage.loadItems().then((loadedItems) {
      setState(() {
        items = loadedItems;
      });
    });
  }
  void _addItem(Item item) async {
    setState(() {
      items.add(item);
    });
    await Storage.saveItems(items);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan.withOpacity(0.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text("TODO APP",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      AddItems(addItem: (item) => _addItem(item))),
                );
              },
              child: Icon(Icons.add_card_rounded,
                color: Colors.white,
                size: 30,
                semanticLabel: 'add_card',),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Product",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                          prefixIcon: Icon(
                            Icons.search, size: 25, color: Colors.white70,)

                      ),
                    ),),),
                Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.689,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.cyanAccent.withOpacity(0.6),
                              child: Column(

                                children: [
                                  Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.18,
                                        width: MediaQuery.of(context).size.width*0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: items[index].image.isNotEmpty ?
                                    Image.file(File(items[index].image,),
                                      fit: BoxFit.cover,) :
                                    Icon(Icons.image_not_supported),


                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(items[index].name, style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,),),
                                          SizedBox(height: 2,),
                                          Row(
                                            children: [
                                              Text('RS:',style: TextStyle(color: Colors.white,),),
                                              Text(items[index].price,style: TextStyle(color: Colors.white,),),
                                            ],
                                          ),
                                          Text(items[index].shortDisc,style: TextStyle(color: Colors.white,),),
                                        ],
                                      ),
                                    ),
                                  )

                                 ],
                              ),


                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsList(item: items[index])));
                            },
                            onLongPress: (){

                                showDialog(
                                    context: context,
                                    builder: (context)=>AlertDialog(
                                      title:  Text('Edit Items'),
                                      content: Text('Here you can edit your item:'),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditItem(item: items[index],))).then((value){
                                                if(value!=null) {
                                                  setState(() {
                                                    items[index] = value;
                                                    Storage.saveItems(items);
                                                  });
                                                }
                                               Navigator.pop(context);
                                              }
                                              );
                                            },
                                            child: Text('Edit')),
                                        TextButton(
                                            onPressed: () async{
                                              setState(() {
                                                items.removeAt(index);
                                              });
                                              await Storage.saveItems(items);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Delete')),
                                      ],
                                    )
                                );



                            },
                          );
                        }

                    ),
                  ),
                ),
              ]
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