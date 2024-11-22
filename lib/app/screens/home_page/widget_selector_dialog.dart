import 'package:flutter/material.dart';

class WidgetSelectorDialog extends StatefulWidget {
  final List<String> selectedWidgets;

  const WidgetSelectorDialog({super.key, required this.selectedWidgets});

  @override
  State<WidgetSelectorDialog> createState() => _WidgetSelectorDialogState();
}

class _WidgetSelectorDialogState extends State<WidgetSelectorDialog> {
  List<String> tempSelected = [];

  @override
  void initState() {
    super.initState();
    tempSelected = [...widget.selectedWidgets];
  }

  void toggleSelection(String widget) {
    setState(() {
      tempSelected.contains(widget)
          ? tempSelected.remove(widget)
          : tempSelected.add(widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Widgets"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text("Textbox"),
            value: tempSelected.contains("Textbox"),
            onChanged: (_) => toggleSelection("Textbox"),
          ),
          CheckboxListTile(
            title: Text("Imagebox"),
            value: tempSelected.contains("Imagebox"),
            onChanged: (_) => toggleSelection("Imagebox"),
          ),
          CheckboxListTile(
            title: Text("Save Button"),
            value: tempSelected.contains("Save Button"),
            onChanged: (_) => toggleSelection("Save Button"),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, tempSelected),
            child: Text("Save")),
      ],
    );
  }
}
