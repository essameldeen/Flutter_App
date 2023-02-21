import 'dart:math';

import 'package:app_test/modules/bmi_result/bmi_result.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height = 120;
  int age = 18;
  int weight = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: Column(
        children: [
          Expanded (
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale= !isMale;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isMale? Colors.blue: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(image: AssetImage("assets/images/female.png"),
                                height: 70.0,
                              width: 70.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "MALE",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: (){

                        setState(() {
                            isMale= !isMale;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isMale? Colors.grey[300]: Colors.blue,

                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(image: AssetImage("assets/images/female.png"),
                              height: 70.0,
                              width: 70.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "FEMALE",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "HEIGHT",
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(
                         "${height.round()}",
                          style:const  TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5.0,),
                       const  Text(
                          "CM",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Slider(value: height, onChanged: (value){
                      setState(() {
                          height =value;
                      });

                    },
                    max: 220,
                      min: 80,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
             children: [
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     decoration: BoxDecoration(
                         color: Colors.grey[300],
                         borderRadius: BorderRadius.circular(10.0)),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:  [
                       const  Text(
                         "AGE",
                         style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                       ),
                         Text(
                         "$age",
                         style: TextStyle(
                             fontSize: 30.0, fontWeight: FontWeight.bold),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                         FloatingActionButton(
                           onPressed: (){
                             setState(() {
                               age--;
                             });

                           },mini: true,
                           child: const Icon(Icons.remove),),
                         FloatingActionButton(
                           onPressed: (){
                             setState(() {
                               age++;
                             });
                           },mini: true,
                           child: const Icon(Icons.add),)
                       ],)
                     ],),
                   ),
                 ),
               ),
               const SizedBox(width: 20.0,),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     decoration: BoxDecoration(
                         color: Colors.grey[300],
                         borderRadius: BorderRadius.circular(10.0)),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:  [
                         const  Text(
                           "Weight",
                           style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                         ),
                           Text(
                           "$weight",
                           style: TextStyle(
                               fontSize: 30.0, fontWeight: FontWeight.bold),
                         ),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                           children: [
                           FloatingActionButton(
                             onPressed: (){
                               setState(() {
                                 weight--;
                               });
                             },mini: true,
                             child: const Icon(Icons.remove),),
                           FloatingActionButton(
                             onPressed: (){
                               setState(() {
                                 weight++;
                               });

                             },mini: true,
                             child: const Icon(Icons.add),)
                         ],)
                       ],),
                   ),
                 ),
               ),
             ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            height: 50.0,
            child: MaterialButton(
              onPressed: () {
                var result = weight / pow(height/100,2);
                Navigator.push(context,
                MaterialPageRoute(builder:(context)=>BmiResultScreen(
                  result: result.round(),
                  isMale: isMale,
                  age:  age,
                )),
                );
              },
              child: const Text(
                "CALCULATE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
