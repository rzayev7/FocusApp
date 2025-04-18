import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  bool _reminder = true;

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _pickDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _submitTask() {
    // Save or submit logic
    Navigator.pop(context); // Return to previous screen
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _selectedTime.format(context);
    final formattedDate = DateFormat('EEEE, dd MMM yyyy').format(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('What are you planning\nto do today? 🚀',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),

            const Text('Task'),
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Lorem ipsum dolor',
              ),
            ),
            const SizedBox(height: 24),

            const Text('Date'),
            Row(
              children: [
                GestureDetector(
                  onTap: _pickTime,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(formattedTime, style: const TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Text(DateFormat('a').format(DateTime.now()).toUpperCase()), // AM/PM
                const SizedBox(width: 12),
                Switch(
                  value: _reminder,
                  onChanged: (val) => setState(() => _reminder = val),
                )
              ],
            ),
            const SizedBox(height: 16),

            CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              onDateChanged: _pickDate,
            ),

            const Spacer(),

            // Done button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Done', style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
