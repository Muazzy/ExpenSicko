import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@immutable
class CustomFormField extends StatefulWidget {
  final String labelText;
  bool isPassword;
  final Color primaryColor;
  final Color textColor;
  final TextEditingController textEditingController;
  CustomFormField({
    super.key,
    required this.labelText,
    required this.isPassword,
    required this.primaryColor,
    required this.textColor,
    required this.textEditingController,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //cuz the textfeild's border radius is also the same
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      elevation: 1.5,
      shadowColor: bodyTextColor.withOpacity(0.8),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.isPassword,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 16,
          // fontWeight: FontWeight.w400,
        ),
        cursorColor: widget.primaryColor.withOpacity(0.5),
        decoration: InputDecoration(
          suffixIcon: widget.labelText.contains('Password')
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(
                      widget.isPassword
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: widget.textColor.withOpacity(0.5),
                      size: 16,
                    ),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(left: 12, right: 12),
          labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: widget.textColor.withOpacity(0.5),
              ),
          floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: widget.textColor.withOpacity(0.5),
              ),
          label: Text(
            widget.labelText,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
