import 'package:flutter/material.dart';
import 'package:skizzo/constants.dart';

class RowBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double fontSize;
  final bool isLoading;
  final bool isDisabled;
  final Color color;
  final Color textColor;

  const RowBtn(
      {required this.text,
      required this.onPressed,
      this.textColor = Colors.white,
      this.fontSize = 18,
      this.isLoading = false,
      this.isDisabled = false,
      this.color = kSecondaryColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: kDefaultBorderRadius,
            ),
            child: ClipRRect(
              borderRadius: kDefaultBorderRadius,
              child: MaterialButton(
                onPressed: isDisabled ? null : onPressed,
                textColor: Colors.white,
                color: color,
                disabledColor: isDisabled ? kDisabledButtonColor : color,
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: !isLoading
                        ? Text(
                            text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                              color: textColor,
                            ),
                          )
                        : const CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
