import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text_hint;
  final void Function()? onTab;
  final void Function(String?)? onSave;
  final void Function(String?)? onChange;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final Widget? icon;
  final Widget? icon2;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final bool? obscureText;
  CustomTextField(
      {Key? key,
      this.textStyle,
      required this.text_hint,
      this.suffix,
      this.hintTextStyle,
      this.onTab,
      required this.textInputType,
      required this.textInputAction,
      this.onSave,
      required this.validator,
      this.textDirection,
      this.textAlign,
      this.controller,
      this.icon,
      this.icon2,
      this.obscureText,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onChanged: onChange,
        cursorWidth: 2,
        obscureText: obscureText == null ? false : obscureText!,
        controller: controller,
        onTap: onTab,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        onSaved: onSave,
        validator: validator,
        textDirection: textDirection,
        textAlign: textAlign ?? TextAlign.center,
        cursorHeight: 20,
        maxLines: text_hint=='about'?5:1,
        style: textStyle ?? TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
          counterText: '',
          hintText: text_hint,
          hintStyle: hintTextStyle ??
              const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
          suffixIcon: icon,
          suffix: suffix,
          prefixIcon: icon2,
          fillColor: Color.fromARGB(255, 243, 243, 243),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: const TextStyle(fontSize: 14),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
