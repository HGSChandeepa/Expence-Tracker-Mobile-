import 'package:flutter/material.dart';

class AddNewExpencce extends StatefulWidget {
  const AddNewExpencce({super.key});

  @override
  State<AddNewExpencce> createState() => _AddNewExpencceState();
}

class _AddNewExpencceState extends State<AddNewExpencce> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  //dispose methodes (this will clear the data form)
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 48),
      child: Column(
        children: [
          // title
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                hintText: "Add the Expence title", label: Text("Title")),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),

          Row(
            children: [
              //amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    hintText: "Enter the aoumt",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),

          //buttons actions

          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                ),
                child: const Text("Close"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                child: const Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
