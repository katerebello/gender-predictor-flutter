import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // var res = http.get(url);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,primarySwatch: Colors.deepPurple,textTheme: GoogleFonts.poppinsTextTheme()),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();

  var gender;
  var probability;
  predictGender(String name)  async {
   if(_formKey.currentState!.validate()){
    var url = Uri.parse("https://api.genderize.io/?name=$name");


    var res = await http.get(url);
    //convert string response to json 
    var body = jsonDecode(res.body);
    gender = "Gender: ${body['gender']}";
    probability = "Probability: ${body['probability']*100}%";
    setState(() {
      
    });
   }
  }

  final _formKey = GlobalKey<FormState>();

  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return (screenSize.width < 540)
    //for small screens
    ? Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top:50),
                  child: Column(
                    children: [
                      Text(
                        "Gender Predictor",
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      // Image.asset('assets/code.png',width: 100,),
                      Image.asset('assets/bg.png',fit: BoxFit.fill),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: "Enter Name",
                                  labelText: "Name",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusColor: Colors.white,
                                ),
                                validator: (value){
                                  if(value == null || value.isEmpty ){
                                    return "Name Can't be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: (){
                              predictGender(_nameController.text);
                            }, 
                            child: Text('Submit'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if(probability != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left:50,
                                right:50,
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(gender,style: TextStyle(fontSize: 20),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(probability,style: TextStyle(fontSize: 20),),
                                    ],
                                  )
                              )
                              ),
                            ), 
                          SizedBox(
                            height: 20,
                          ),
                    ],
                  ),
              ),
            ),
          ),
        ),
    ): 
    Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height:20,
              ),
              Text(
                "Gender Predictor",
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height:50,
              ),
              Center(
                      child: Row(
                        children: [
                          // Image.asset('assets/code.png',width: 100,),
                          Image.asset('assets/bg.png',fit: BoxFit.fill,width: screenSize.width/2,),
                          
                          Column(
                            children: [
                              Form(
                                key: _formKey,
                                child:  Container(
                                  width: screenSize.width/3,
                                  child:TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Name",
                                    labelText: "Name",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusColor: Colors.white,
                                  ),
                                  validator: (value){
                                    if(value == null || value.isEmpty ){
                                      return "Name Can't be empty";
                                    }
                                      return null;
                                  },
                                ),
                                ),
                              ),   
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  predictGender(_nameController.text);
                                }, 
                                child: Text('Submit'),
                              ),
                               if(probability != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left:50,
                                right:50,
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(gender,style: TextStyle(fontSize: 20),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(probability,style: TextStyle(fontSize: 20),),
                                    ],
                                  )
                              )
                              ),
                            ), 
                            ],
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