import 'package:flutter/material.dart';
InputDecoration myInputDecoration(String hint) => InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor : Colors.red[900],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red[900],width: 3.0
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3.0
                    )
                  )
                ) ;
final myTextStyle = TextStyle(
  color: Colors.white
) ;