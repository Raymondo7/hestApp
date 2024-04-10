import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
/*import 'package:kofacademy/api/formations_services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';*/

const primColor = Color(0xFF00009F);
const secColor = Color(0xFFFFFFFF);

stylish(double size, Color color, {isBold = false}) {
  return TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color);
}

screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer une adresse e-mail';
    }
    // Expression régulière pour valider l'adresse e-mail
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }
    return null;
  }
}

loading(BuildContext context, String message) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: secColor,
      elevation: 20.0,
      content: SizedBox(
        height: 200,
        width: screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO:: package
            LoadingAnimationWidget.flickr(
              leftDotColor: primColor,
              rightDotColor: Colors.purple,
              size: 75,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: stylish(25, primColor, isBold: true),
            )
          ],
        ),
      ),
    ),
  );
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length == 9) {
      final formattedText =
          '${text.substring(0, 2)}${text.substring(2, 4)}${text.substring(4, 6)}${text.substring(6, 8)}';
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    return newValue;
  }
}