import 'package:expence_tracker_app/models/expence.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddNewExpencce extends StatefulWidget {
  const AddNewExpencce(
      {super.key, required this.onAddExpence, required this.expence});
  final void Function(ExpenceModel expence) onAddExpence;
  final ExpenceModel expence;

  @override
  State<AddNewExpencce> createState() => _AddNewExpencceState();
}

class _AddNewExpencceState extends State<AddNewExpencce> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.lowest;

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

  void _handleSaveExpences() {
    // Form validation
    // final _enteredAmount = double.tryParse(_amountController.text.trim());

    if (_titleController.text.trim().isEmpty || _descController.text.isEmpty) {
      // Show an error message
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
      // Create a new expense model
      ExpenceModel updatedExpence;
      print(widget.expence.id);

      // If the expense has a title, it means it's an existing expense, so update it
      if (widget.expence.title.isNotEmpty) {
        updatedExpence = ExpenceModel(
          id: widget.expence.id,
          title: _titleController.text,
          decsription: _descController.text,
          date: _selectedDate,
          category: _selectedCategory,
        );
      } else {
        // If the existing expense doesn't have a title, it means it's a new expense
        updatedExpence = ExpenceModel(
          id: const Uuid().v4(),
          title: _titleController.text,
          decsription: _descController.text,
          date: _selectedDate,
          category: _selectedCategory,
        );
      }

      // Add or update the expense
      widget.onAddExpence(updatedExpence);

      // Close the screen
      Navigator.pop(context);
    }
  }

  //dispose methodes (this will clear the data form)
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  //init state
  @override
  void initState() {
    super.initState();
    //set the initial values for the form
    if (widget.expence.title.isNotEmpty) {
      _titleController.text = widget.expence.title;
      _descController.text = widget.expence.decsription;
      _selectedDate = widget.expence.date;
      _selectedCategory = widget.expence.category;
    }
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
                hintText: "Add the Task title", label: Text("Task Title")),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),

          Row(
            children: [
              //amount
              Expanded(
                child: TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    hintText: "Enter the task description",
                    label: Text("Description"),
                    // prefixText: "\$ ",
                  ),
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
