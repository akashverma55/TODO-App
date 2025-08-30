import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addtask extends StatefulWidget {
  final bool? isEdit;
  final String? title;
  final String? description;
  final String? date;
  final String? time;

  const Addtask({
    super.key, 
    this.isEdit, 
    this.title, 
    this.description, 
    this.date, 
    this.time
  });

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {

  @override
  Widget build(BuildContext context) {
    TextEditingController taskCtrl = TextEditingController(text: widget.title?? "");
    TextEditingController descCtrl = TextEditingController(text: widget.description?? "");
    DateTime? selectedDate; 
    TimeOfDay? selectedTime;
    bool isEdit = widget.isEdit?? false;
    String btnName= isEdit? "Update":"Add";
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 80),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 4, indent: 20,color: Colors.tealAccent,endIndent: 10,)),
                  Text(isEdit? "Update Task":"Add Task", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),
                  Expanded(child: Divider(thickness: 4, indent: 10,color: Colors.tealAccent,endIndent: 20,)),
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
                child: TimeDateWidget(selectedDate: selectedDate,isDate: true),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async{
                  final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if(picked!=null && picked!= selectedTime){
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: TimeDateWidget(selectedTime: selectedTime,isDate: false),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomButton(isCancel:false, btnName:btnName),
                  BottomButton(isCancel:true)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.isCancel,
    this.btnName
  });

  final bool isCancel;
  final String? btnName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){}, 
      style: ElevatedButton.styleFrom(
        backgroundColor: isCancel? Colors.black: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        side: BorderSide(width: 2,color: Colors.white),
        minimumSize: Size(120, 60)
      ),
      child: Text(isCancel?"Cancel": btnName!,style: TextStyle(fontSize: 18),)
    );
  }
}

class TimeDateWidget extends StatelessWidget {
  const TimeDateWidget({
    super.key,
    this.selectedDate,
    this.selectedTime,
    required this.isDate
  });

  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final bool isDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color: Colors.tealAccent)
      ),
      child: Row(
        children: [
          Icon(isDate? Icons.calendar_month: Icons.access_time,color: Colors.tealAccent),
          const SizedBox(width: 10,),
          isDate? Text(
            selectedDate==null? "Select Date":DateFormat("dd MMMM, yyyy").format(selectedDate!),
          ):
          Text(
            selectedTime==null? "Select Time":MaterialLocalizations.of(context).formatTimeOfDay(selectedTime!),
          )
        ],
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
