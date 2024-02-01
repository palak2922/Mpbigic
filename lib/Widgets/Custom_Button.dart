import 'package:flutter/material.dart';
import 'custom_Text.dart';
import 'custom_loader.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Function onpressed;
  final Color buttoncolor;
  final Color txtcolor;
  final double borderRadius;

  CustomButton({required this.label, this.isLoading = false, required this.onpressed,
    required this.buttoncolor, required this.txtcolor, this.borderRadius = 10.0});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            if (!isLoading) {
              onpressed();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: Colors.transparent,width: 2),
                boxShadow: [
                  BoxShadow(
                    color: buttoncolor == Colors.white? Colors.black12 : Colors.transparent,
                    blurRadius: 10,
                    spreadRadius: 1
                  )
                ]
              ),
              height: 48,
              child: isLoading
                  ? CustomLoader(
                      color: Color(0xff004A99),
                      size: 25.0,
                    )
                  : Center(
                      child: Txt(
                        text: label,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: txtcolor,
                        textAlign: TextAlign.center,
                        // style: TextStyle(
                        //   color: txtcolor, //Colors.black,
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 18,
                        // ),
                        // style: customButtonStyle,
                      ),
                    ),
            ),
          )),
    );
  }
}
