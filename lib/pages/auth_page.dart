// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/pages/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              Color.fromRGBO(215, 117, 255, 0.5),
              Color.fromRGBO(215, 188, 117, 0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 60,
                    ),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black38,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Text(
                      'Minha Loja',
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'Anton',
                        color:
                            Theme.of(context).accentTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  AuthForm(), //widget de formulario
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
