// @dart=2.9
import 'package:flutter/material.dart';
import 'package:vertical_stepper/vertical_stepper.dart';
import 'package:vertical_stepper/vertical_stepper.dart' as step;
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() => runApp(MaterialApp(
  home:HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage  extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  bool wynik=false;
  String numer="";


  List<step.Step> steps = [
    step.Step(
        shimmer: false,
        title: "Zamówienie złożone",
        iconStyle: Colors.green,
        content:Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("21/01/2022 11:30 Zamówienie zostało złożone"),
          ),
        ),
    ),
       step.Step(
        shimmer: false,
        title: "W tranzycie",
        iconStyle: Colors.green,
        content:Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("22/01/2022 9:40 Przesyłka przyjęta w punkcie sortowniczym"),
          ),
        ),
    ),
   step.Step(
        shimmer: false,
        title: "Wysyłka w toku",
        iconStyle: Colors.green,
        content:Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("22/01/2022 13:40 Przesyłka została przygotowana i wysłana do punktu odbioru"),
          ),
        ),
    ),
   step.Step(
        shimmer: false,
        title: "Gotowa do odbioru",
        iconStyle: Colors.blue,
        content:Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("23/01/2022 11:20 Przesyłka dotarła do punktu odbioru"),
          ),
        ),
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
    body: content(),
    );
  }
  Widget content(){
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
                 bottomRight: Radius.circular(50),
            )
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT6Yc_N3xC9akfMD4yRs9kwCBKoaRrie9z-Rg&usqp=CAU",
                  height:100,
                  ),
                  Text("Monitor Paczek",style:TextStyle(fontSize:50),
                  )
                ],
              ),
            ),
          ),
        ),
        body()
      ],
    );
  }
  Widget body(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 35.0),
        child: Text("Numer Przesyłki :",
          style: TextStyle(fontSize: 16),
        ),
      ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30,0,20,0),
          child: Row(
    children: [
      Container(
            height: 60,
            width: 310,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              onChanged: (text){
                numer=text;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "np. #123456789"),
            ),
            ),
            SizedBox(width: 30,
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  //wynik=numer!="";
                  if (numer.length==10 && numer[0]=="#" && double.tryParse(numer.substring(1))!=null)
                    wynik=true;
                  else{
                    wynik=false;
                    Fluttertoast.showToast(
                      msg: "Zły format numeru paczki. Przykładowy numer: # + 9cio liczbowy kod",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  }
                });
              },

              child: Icon(
                Icons.search,
                size:20,
              ),
            )
          ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        wynik? Padding(
          padding: const EdgeInsets.fromLTRB(30,2,20,0),
          child: Row(
            children: [
              Text(
                "Wynik ",
                style: TextStyle(fontSize: 25),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    wynik=false;
                  });
                },
                child: Icon(
                  Icons.close,
                  size: 25,
                ),
              )
            ],
          ),
        )
            :SizedBox(),
        SizedBox(

        ),
        wynik
        ? Padding(
          padding: const EdgeInsets.fromLTRB(15,2,15,0),
          child: VerticalStepper(
            steps: steps,
            dashLength: 2,
          ),
        )
            : Center(
              child: Transform(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Lottie.network(
                "https://assets2.lottiefiles.com/packages/lf20_t24tpvcu.json", height:324,),
              ),
            )
      ],
    );
  }
}

