import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

enum Planet {Pluto, Mars, Venus}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Planet _planet = Planet.Pluto;
  var _weightTextFieldController = TextEditingController();

  var _message = 'Enter your weight';
  var _result = "";

  void handleRadioBox(Planet value){
    setState(() {
      _planet = value;
      String planetString ="";
      double result;
      if(_weightTextFieldController.text.isNotEmpty){
        var earthWeight = int.parse(_weightTextFieldController.text);
        switch(_planet){
          case Planet.Pluto:
            result = earthWeight / 0.06;
            planetString = "Pluto";
            break;
          case Planet.Mars:
            result = earthWeight / 0.38;
            planetString = "Mars";
            break;
          case Planet.Venus:
            result = earthWeight / 0.91;
            planetString = "Venus";
            break;
          default:
        }
      }
      _result = 'Your weight on planet $planetString is ${result.toStringAsFixed(2)} Kg';
    });
  }

  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    KeyboardVisibilityNotification().addNewListener(
      onHide: ()=> handleRadioBox(_planet)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Weight On Planet X'),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: InkWell(
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.blueGrey.shade700,
          child: new ListView(
            children: [
              Center(
                  child: Container(
                    child: Image.asset(
                      'images/planet.png',
                      height: _height /3 ,
                      width: _width /2 ,
                    ),
                    alignment: Alignment.topCenter,
                  )
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _weightTextFieldController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Your weight on Earth'
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        onChanged: handleRadioBox,
                        groupValue: _planet,
                        value: Planet.Pluto,
                      ),
                      Text(
                        'Pluto',
                        style: TextStyle(
                            fontSize: 22
                        ),
                      ),
                      Radio(
                        onChanged: handleRadioBox,
                        groupValue: _planet,
                        value: Planet.Mars,
                      ),
                      Text(
                        'Mars',
                        style: TextStyle(
                            fontSize: 22
                        ),
                      ),
                      Radio(
                        onChanged: handleRadioBox,
                        groupValue: _planet,
                        value: Planet.Venus,
                      ),
                      Text(
                        'Venus',
                        style: TextStyle(
                            fontSize: 22
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0,20,0,0),
                child: Center(
                  child: new Text(
                    _weightTextFieldController.text.isEmpty ? _message : _result,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                )
              )
            ],
          ),
        ),
        onTap: ()=> handleRadioBox(_planet),
      )
    );
  }
}
