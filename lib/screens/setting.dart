import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}
int a=0;
class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xff60e1c8),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ( Text("Setting")),
          ),

        ),

    body: Column(
        children: [

          Expanded(
            child: Row(
              children: [
                FlatButton(
                  onPressed: () {
      setState(() {
        a=0;
        ThemeData.light();
        });
                    },

         child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                     borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 100,
                    width: 140,
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    setState(() {
                      a=1;
                      //ThemeData.dark();
                      // runApp();
                   //   runApp(Setting());
                    });
                  },
         child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 100,
                width: 140,
              ),
                ),
              ],
            ),
          ),
        ],
    ),
      ),
    );
  }
}

