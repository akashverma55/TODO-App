import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {

  TextEditingController taskCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  DateTime? selectedDate; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 80),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 2, indent: 20,color: Colors.tealAccent,endIndent: 10,)),
                  Text("Add Task", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                  Expanded(child: Divider(thickness: 2, indent: 10,color: Colors.tealAccent,endIndent: 20,)),
                ],
              ),
              SizedBox(height: 80),
              TextFieldWidget(ctrl: taskCtrl, isTask: true),
              SizedBox(height: 20),
              TextFieldWidget(ctrl: descCtrl, isTask: false),
              SizedBox(height: 50),
              InkWell(
                onTap: () async{
                  final DateTime? picked = await showDatePicker(
                    context: context, 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime(2100)
                  );
                  if(picked!=null && picked!= selectedDate){
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: Colors.tealAccent)
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month,color: Colors.tealAccent),
                      const SizedBox(width: 10,),
                      Text(
                        selectedDate==null? "Select Date":DateFormat("dd MMMM, yyyy").format(selectedDate!),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.ctrl,
    required this.isTask,
  });

  final TextEditingController ctrl;
  final bool isTask;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      maxLines: isTask? 1:4,
      decoration: InputDecoration(
        prefixIcon: Icon(color: Colors.tealAccent, isTask? Icons.task:Icons.description),
        labelText:isTask? "Task":"Description",
        hintText: isTask? "Enter the Task": "Enter the Description",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5,color: Colors.tealAccent)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5,color: Colors.white)
        )   
      ),
    );
  }
}
