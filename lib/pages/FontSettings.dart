import 'package:flutter/material.dart';


class FontSettings extends StatefulWidget {
  const FontSettings({super.key});

  @override
  State<FontSettings> createState() => _FontSettingsState();
}

class _FontSettingsState extends State<FontSettings> {

  double _currentSliderValue = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title:  Text('a'),
        ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child:
              Column(
                children: [
                  Text('Font Size'),
                  StatefulBuilder(
                      builder: (context,state){
                        return Container(
                          child: Slider(
                            min: 1,
                            max: 10,
                            divisions: 10,
                            value: _currentSliderValue,
                            onChanged: (value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                        );

                      }
                  )]
                ,
              ),
            ),
          )),
    );
  }
}
