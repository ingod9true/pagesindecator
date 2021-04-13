
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'defalut_button.dart';
import 'my_model.dart';
import 'package:rxdart/rxdart.dart';

class Body extends StatefulWidget {
  Body({Key key,}) : super(key: key);
 @override
 BodyState createState() => BodyState();
}

class BodyState extends State<Body> {

  StreamController<Txs> ctl = StreamController();
  Stream<Txs> get tStream => ctl.stream;

  StreamController<int> dot = StreamController();
  Stream<int> get dotStream => dot.stream.distinct();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        StreamProvider<Txs>(
          create: (context) => tStream.map((txs){
            return Txs(age: txs.age * 2, name:"shzne" );
          } ), initialData:Txs(age: 1,name: "sz"),),
        StreamProvider<int>(create: (context) => dotStream.debounceTime(Duration(seconds: 1)), initialData: 0)
        ],
      child:Material(
      child:  Container(
        color:  Color(0xFFF3F3F3),
        child:
        Column(
          children: [
            SizedBox(height: 100,),

            Consumer<Txs>(builder: (context, Txs model, child){
              print(model.name);
              return Text("${model.age}",
              style: TextStyle(color: Colors.red, fontSize: 45, fontWeight: FontWeight.bold),);
            }),

            Spacer(),

          Consumer<int>(builder: (context, int idx, child){

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
              return  AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: 5),
                  height: 6,
                  width: idx == index ? 20:6,
                  decoration: BoxDecoration(
                    color: idx == index ? Color(0xFFFF7643) : Color(0xFFD8D8D8),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
    }
    ),
            );
          }),

            Spacer(),
            DefaultButton(
                text: "add +1",
                press: (){
                 int ag = Random().nextInt(50);
                  ctl.add(Txs(age: ag,name: "zz"));
                  dot.add(Random().nextInt(5));
                }),
          ],
        )
        ,
      ),
    ),);
  }



  @override
  void dispose() {
    ctl.close();
    dot.close();
    super.dispose();
  }
}
