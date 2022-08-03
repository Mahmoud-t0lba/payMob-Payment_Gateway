import 'package:flutter/material.dart';

import 'constants.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = payColor,
  double radius = 3,
  var function,
  String? text,
}) {
  return Container(
    width: width,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text!,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget defaultFormField({
  TextEditingController? controller,
  TextInputType? type,
  var onSubmit,
  var onChange,
  var onTap,
  bool isPassword = false,
  String? validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  var suffixPressed,
  bool? isClickable = true,
  bool? autocorrect,
}) {
  return TextFormField(
    autocorrect: false,
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    enabled: isClickable,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    validator: (val) {
      if (val!.isEmpty) {
        return '$validate';
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffix),
            )
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}

void navigateAndFinish(
  context,
  widget,
) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) {
      return false;
    },
  );
}
