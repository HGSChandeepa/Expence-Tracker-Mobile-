import 'package:expence_tracker_app/models/expence.dart';
import 'package:flutter/material.dart';

class AddNewExpencce extends StatefulWidget {
  const AddNewExpencce({super.key, required this.onAddExpence});
  final void Function(ExpenceModel expence) onAddExpence;

  @override
  State<AddNewExpencce> createState() => _AddNewExpencceState();
}

class _AddNewExpencceState extends State<AddNewExpencce> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.travel;

  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime.now();

  //opendate modal
  Future<void> _openDateModal() async {
    try {
      final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);

      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //handle the save form for expences
  void _handleSaveExpences() {
    //form validate
    final _enteredAmount = double.tryParse(
        _amountController.text.trim()); // ten >> null  || "100"  >> 100.00

    if (_titleController.text.trim().isEmpty ||
        (_enteredAmount == null || _enteredAmount <= 0)) {
      //show a error message

      showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Enter Valid Data"),
            content: const Text(
              'A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      return;
    } else {
      //create a new expence model and enter to the expenceList

      final ExpenceModel newExpence = ExpenceModel(
          title: _titleController.text,
          amount: _enteredAmount,
          date: _selectedDate,
          category: _selectedCategory);

      //append the new expance
      widget.onAddExpence(newExpence);

      Navigator.pop(context);
    }
  }

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
                      prefixText: "\$ "),
                  keyboardType: TextInputType.number,
                ),
              ),

              //date picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(formatedDate.format(_selectedDate)),
                    IconButton(
                        onPressed: _openDateModal,
                        icon: const Icon(Icons.date_range_rounded))
                  ],
                ),
              )
            ],
          ),

          //buttons actions

          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent),
                      ),
                      child: const Text("Close"),
                    ),
                    ElevatedButton(
                      onPressed: _handleSaveExpences,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
