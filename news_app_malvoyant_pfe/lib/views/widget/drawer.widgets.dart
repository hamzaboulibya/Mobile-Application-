import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/global.params.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [ DrawerHeader(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                 ],
              ),
          ),
          child: Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("images/LogoYourNews.png"),
              radius:50,
            ),
           ),
          ),
          //... 3 point c-a-d une copier de l'lemeent :(GlobalParams.menus as List)
         ...(GlobalParams.menus as List).map((item){
           return Column(
             children: [
               ListTile(
               title: Text(item["title"],style: TextStyle(fontSize: 20),),
               leading: item['icon'],
               trailing: Icon(Icons.arrow_right, color: Colors.blue,),
               onTap: (){
               Navigator.of(context).pop();
               Navigator.pushNamed(context, "${item['route']}");
               },
            ),
             //  Divider(color: Colors.blue, height: 4,),
               SizedBox(height: 10,),
            ],
           );
         },
         )
        ],
      ),
    );
  }
}

