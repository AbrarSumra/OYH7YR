import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ubixstar_assignment/app/screens/home_page/image_detail_model.dart';
import 'package:ubixstar_assignment/app/screens/widget/button_l.dart';
import 'package:ubixstar_assignment/app/screens/widget/mobile_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fireStore = FirebaseFirestore.instance;

  TextEditingController textController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool isLoading = false;
  bool isTextBox = false;
  bool isImageText = false;
  bool isSaveBtn = false;

  void saveData() async {
    // Validation
    if (!isTextBox && !isImageText) {
      Fluttertoast.showToast(
        msg: "Add at least a widget to save.",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (isTextBox && textController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "TextBox cannot be empty.",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (isImageText && imageController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Image URL cannot be empty.",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final imageDetailModel = ImageDetailModel(
        text_box: isTextBox ? textController.text : "",
        image_box: isImageText ? imageController.text : "",
      );

      await fireStore.collection('image_detail').add(imageDetailModel.toJson());

      Fluttertoast.showToast(
        msg: "Data saved successfully!",
        backgroundColor: Colors.green,
      );

      textController.clear();
      imageController.clear();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to save data: $e",
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void alertBox() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Widgets"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: const Text("Text box"),
                    value: isTextBox,
                    onChanged: (bool? value) {
                      setStateDialog(() {
                        isTextBox = value!;
                      });
                      setState(() {}); // Update the main state
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Image box"),
                    value: isImageText,
                    onChanged: (bool? value) {
                      setStateDialog(() {
                        isImageText = value!;
                      });
                      setState(() {}); // Update the main state
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Save Button"),
                    value: isSaveBtn,
                    onChanged: (bool? value) {
                      setStateDialog(() {
                        isSaveBtn = value!;
                      });
                      setState(() {}); // Update the main state
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dynamic Widgets",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (isTextBox)
                    KMobileTextField(
                      hintText: "Enter Text",
                      controller: textController,
                      icon: Icons.text_fields_outlined,
                    ),
                  const SizedBox(height: 20),
                  if (isImageText)
                    KMobileTextField(
                      hintText: "Enter Image Url",
                      controller: imageController,
                      icon: Icons.image,
                    ),
                  const SizedBox(height: 20),
                  if (isSaveBtn)
                    ButtonL(
                      isLoading: isLoading,
                      onTap: saveData,
                      title: "Save",
                    ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: alertBox,
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
