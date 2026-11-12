import 'package:flutter/material.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';

class CustomPopUp<T> extends StatefulWidget {
  const CustomPopUp({
    super.key,
    this.onTap,
    this.focusNode,
    required this.text,
    required this.width,
    this.textStyle,
    this.hintText,
    required this.onSelected,
    required this.selectedText,
    required this.itemBuilder,
  });
  final void Function()? onTap;
  final FocusNode? focusNode;
  final String text;
  final double width;
  final TextStyle? textStyle;
  final String? hintText;
  final void Function(T) onSelected;
  final String selectedText;
  final List<PopupMenuEntry> Function(BuildContext) itemBuilder;

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
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
          child: PopupMenuButton(
            shadowColor: Colors.grey,
            color: Colors.white,
            surfaceTintColor: Colors.blue,
            constraints: BoxConstraints(minWidth: context.width * 0.8),
            offset: const Offset(0, 40),
            onSelected: widget.onSelected,
            icon: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.selectedText),
                Spacer(),
                Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
            itemBuilder: widget.itemBuilder,
          ),
        ),
      ],
    );
  }
}
