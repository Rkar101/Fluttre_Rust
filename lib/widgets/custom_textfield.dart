import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    required this.width,
    required this.onTap,
    required this.onTapOutside,
    required this.line,
    this.textStyle,
    this.hintText,
    this.readOnly,
    this.onChanged,
    this.focusNode,
    this.keyboardType,
  });
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final String text;
  final TextEditingController controller;
  final double width;
  final int line;
  final TextStyle? textStyle;
  final String? hintText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(widget.text, style: widget.textStyle),
        const SizedBox(height: 5),
        Container(
          width: widget.width,
          // constraints: BoxConstraints(
          //     maxHeight: double.infinity, minHeight: height * 0.055),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryFixed,
            ),
          ),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            style: widget.textStyle,
            readOnly: widget.readOnly ?? false,
            autofocus: false,
            controller: widget.controller,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            minLines: widget.line,
            maxLines: 20,
            cursorColor: Colors.blueAccent,
            decoration: InputDecoration(
              //  labelStyle: widget.textStyle,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: const Color.fromARGB(141, 212, 214, 217),
              ),
              constraints: BoxConstraints(minHeight: height * 0.055),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class TravelTextFieldWidget extends StatefulWidget {
  const TravelTextFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    required this.width,
    required this.onTap,
    required this.onTapOutside,
    required this.line,
    this.focusNode,
    this.onChanged,
    required this.enabled,
  });
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final String text;
  final TextEditingController controller;
  final double width;
  final int line;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool? enabled;
  @override
  State<TravelTextFieldWidget> createState() => _TravelTextFieldWidgetState();
}

class _TravelTextFieldWidgetState extends State<TravelTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final borderColor = Theme.of(context).colorScheme.secondaryFixed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width,
          constraints: BoxConstraints(minHeight: height * 0.055),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor),
          ),
          child: TextFormField(
            enabled: widget.enabled ?? false,
            focusNode: widget.focusNode,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 14,
            ),
            autofocus: false,
            onChanged: widget.onChanged,
            controller: widget.controller,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            maxLines: widget.line,
            cursorColor: Colors.blueAccent,
            decoration: InputDecoration(
              hintText: 'Enter destination',
              hintStyle: const TextStyle(color: Colors.grey),
              constraints: BoxConstraints(minHeight: height * 0.05),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
