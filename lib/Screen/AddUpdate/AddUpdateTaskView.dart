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
  late TextEditingController _taskCtrl;
  late TextEditingController _descCtrl;
  DateTime? selectedDateTime;

  @override
  void initState(){
    super.initState();
    _taskCtrl = TextEditingController(text: widget.title??"");
    _descCtrl = TextEditingController(text: widget.description??"");
    print("${widget.date} in the Edit" );

    if(widget.isEdit==true && widget.date!=null && widget.time!=null){
      final date = DateFormat("MMM d, yyyy").parse(widget.date!);
      final time = DateFormat("h:mm a").parse(widget.time!);

      selectedDateTime = DateTime(date.year,date.month,date.day,time.hour,time.minute);
    }
  }


  @override
  Widget build(BuildContext context) {
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
              TextFieldWidget(ctrl: _taskCtrl, isTask: true),
              SizedBox(height: 20),
              TextFieldWidget(ctrl: _descCtrl, isTask: false),
              SizedBox(height: 50),
              InkWell(
                onTap: () async{
                  final DateTime? picked = await showDatePicker(
                    context: context, 
                    initialDate: selectedDateTime?? DateTime.now(),
                    firstDate: DateTime(2000), 
                    lastDate: DateTime(2100)
                  );
                  if(picked!=null){
                    setState(() {
                      final time = selectedDateTime?? DateTime.now();
                      selectedDateTime=DateTime(
                        picked.year,
                        picked.month,
                        picked.day,
                        time.hour,
                        time.minute
                      );
                    });
                  }
                },
                child: TimeDateWidget(selectedDateTime: selectedDateTime,isDate: true),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async{
                  final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(selectedDateTime??DateTime.now()));
                  if(picked!=null){
                    setState(() {
                      final date = selectedDateTime?? DateTime.now();
                      selectedDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        picked.hour,
                        picked.minute
                      );
                    });
                  }
                },
                child: TimeDateWidget(selectedDateTime: selectedDateTime,isDate: false),
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
      onPressed: (){
        isCancel? Navigator.pop(context):print("Add");
      }, 
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
    this.selectedDateTime,
    required this.isDate
  });

  final DateTime? selectedDateTime;
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
            selectedDateTime==null? "Select Date":DateFormat("dd MMMM, yyyy").format(selectedDateTime!),
          ):
          Text(
            selectedDateTime==null? "Select Time":DateFormat("h:mm a").format(selectedDateTime!)
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
