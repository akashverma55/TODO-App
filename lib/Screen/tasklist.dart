import 'package:flutter/material.dart';
import 'package:mytodoapp/Screen/AddUpdate/AddTask.dart';

class Tasklist extends StatefulWidget {
  const Tasklist({super.key});

  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  final List<dynamic> data = [
    {
      "title": "Finalize Q3 Report",
      "description":
          "Compile sales data and performance metrics for the quarterly review meeting.",
      "date": "Aug 29, 2025",
      "time": "4:00 PM",
      "isCompleted": false,
    },
    {
      "title": "Team Lunch at Cafe Luna",
      "description":
          "Celebrate the successful project launch with the entire development team.",
      "date": "Aug 29, 2025",
      "time": "1:00 PM",
      "isCompleted": true,
    },
    {
      "title": "Doctor's Appointment",
      "description":
          "Annual check-up with Dr. Sharma. Remember to bring previous reports.",
      "date": "Sep 1, 2025",
      "time": "10:30 AM",
      "isCompleted": false,
    },
    {
      "title": "Plan Weekend Trip",
      "description":
          "Research destinations and book accommodation for the upcoming long weekend.",
      "date": "Sep 2, 2025",
      "time": "8:00 PM",
      "isCompleted": false,
    },
    {
      "title": "Pay Electricity Bill",
      "description":
          "Due by the end of the month. Use the online portal to complete the payment.",
      "date": "Aug 30, 2025",
      "time": "12:00 PM",
      "isCompleted": true,
    },
    {
      "title": "Submit Project Proposal",
      "description":
          "Send the final draft of the 'Project Phoenix' proposal to the review board.",
      "date": "Sep 5, 2025",
      "time": "5:00 PM",
      "isCompleted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
  final completedCount = data.where((task) => task['isCompleted'] == true).length;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 80),
            TaskListHeading(taskCompleted: completedCount, dataLength:data.length),
            MyDivider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1.5, color: Colors.white),
                    ),
                    child: TaskCard(
                      title: data[index]["title"],
                      description:data[index]["description"],
                      date: data[index]["date"],
                      time: data[index]["time"],
                      onEdit: () {
                        print("Editing first task");
                      },
                      onDelete: () {
                        print("Deleting first task");
                      },
                      isCompleted: data[index]["isCompleted"],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Addtask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Divider(
        indent: 50,
        // endIndent: 100,
        thickness: 2,
        color: Colors.white,
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isCompleted;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.onEdit,
    required this.onDelete,
    this.isCompleted = false,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Checkbox
            Transform.scale(
              scale: 1.5, // Makes the checkbox slightly larger
              child: Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
                activeColor: Colors.teal,
                shape: CircleBorder(),
              ),
            ),
            const SizedBox(width: 12.0),

            // 2. Main Content (Title, Description, Date/Time)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      // Strikethrough text when task is completed
                      decoration: _isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Description
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                      decoration: _isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Date and Time Row
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        widget.date,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 16.0),
                      Icon(Icons.access_time, size: 16.0, color: Colors.grey),
                      const SizedBox(width: 4.0),
                      Text(
                        widget.time,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),

            // 3. Action Buttons (Edit, Delete)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue[700]),
                  onPressed: widget.onEdit,
                  tooltip: 'Edit Task',
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red[600]),
                  onPressed: widget.onDelete,
                  tooltip: 'Delete Task',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListHeading extends StatelessWidget {
  const TaskListHeading({super.key, required this.dataLength,required this.taskCompleted});

  final int dataLength;
  final int taskCompleted;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: taskCompleted / dataLength,
          color: Colors.tealAccent,
          backgroundColor: Colors.grey[700],
        ),
        SizedBox(width: 20),
        Text(
          "Tasks",
          style: TextStyle(
            color: Colors.tealAccent,
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
