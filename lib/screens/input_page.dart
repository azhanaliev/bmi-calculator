import 'dart:ui';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/bmi_functionality.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender gender;
  int height = 180;
  int weight = 60;
  int age = 29;

  // void updateColour(Gender gender) {
  //   if (gender == Gender.male) {
  //     if (maleCardColour == inactiveCardColour) {
  //       maleCardColour = activeCardColour;
  //       femaleCardColour = inactiveCardColour;
  //     } else {
  //       maleCardColour = inactiveCardColour;
  //     }
  //   }
  //   if (gender == Gender.female) {
  //     if (femaleCardColour == inactiveCardColour) {
  //       femaleCardColour = activeCardColour;
  //       maleCardColour = inactiveCardColour;
  //     } else {
  //       femaleCardColour = inactiveCardColour;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                onPress: () {
                  setState(() {
                    gender = Gender.male;
                  });
                },
                cardChild: IconContent(
                  icon: FontAwesomeIcons.mars,
                  label: 'MALE',
                ),
                colour: gender == Gender.male
                    ? kActiveCardColour
                    : kInactiveCardColour,
              )),
              Expanded(
                  child: ReusableCard(
                onPress: () {
                  setState(() {
                    gender = Gender.female;
                  });
                },
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  label: 'FEMALE',
                ),
                colour: gender == Gender.female
                    ? kActiveCardColour
                    : kInactiveCardColour,
              )),
            ],
          )),
          Expanded(
              child: ReusableCard(
            colour: kActiveCardColour,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HEIGHT',
                  style: kTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      height.toString(),
                      style: kNumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kTextStyle,
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555)),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120,
                    max: 220,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                )
              ],
            ),
          )),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WEIGHT',
                        style: kTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  weight--;
                                });
                              }),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPress: () {
                                setState(() {
                                  weight++;
                                });
                              }),
                        ],
                      )
                    ]),
                colour: kActiveCardColour,
              )),
              Expanded(
                  child: ReusableCard(
                cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'AGE',
                        style: kTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  age--;
                                });
                              }),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPress: () {
                                setState(() {
                                  age++;
                                });
                              }),
                        ],
                      )
                    ]),
                colour: kActiveCardColour,
              )),
            ],
          )),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              BMIFunctionality calc =
                  BMIFunctionality(height: height, weight: weight);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            bmiResult: calc.calculateBMI(),
                            resultText: calc.getResult(),
                            interpretaion: calc.getInterpretation(),
                          )));
            },
          )
        ],
      ),
    );
  }
}
