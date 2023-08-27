import 'package:flutter/material.dart';

import 'constants.dart';

Widget button(
    {required context,
    required String text,
    required Color? color,
    required double minWidth,
    required double height,
      double sizeOfText = 20 ,
    required Function() function}) {
  return Container(
    decoration: BoxDecoration(
        color:backgroundColor,
        borderRadius: BorderRadius.circular(25)
    ) , 
    child: MaterialButton(
      height: height,
      minWidth: minWidth,
      onPressed: function,
      color: color,
      child: Text(
        text,
        textAlign: TextAlign.center
        ,
        style: TextStyle(
            color: Colors.white, fontSize: sizeOfText),
      ),
    ),
  );
}

Widget textField(
  context, {
  required String text,
  required IconData prefixIcon,
  required TextEditingController controller,
  bool isPass = false,
  required TextInputType type,
  IconData? suffixIcon,
  Function()? function,
  double radius = 25,
  int maxLines = 1,
}) {
  return Container(
    color:backgroundColor,
    child: TextFormField(
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return "$text can't be empty";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      controller: controller,
      obscureText: isPass,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: function,
                icon: Icon(
                  suffixIcon,
                  color: Colors.white,
                ))
            : null,
        label: Text(
          text,
          style: const TextStyle(color: Colors.white , fontSize: 20,fontWeight: FontWeight.w900),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    ),
  );
}

List<PopupMenuItem> menuItem = [
  const PopupMenuItem(
    value: 0,
    child: Row(
      children: [
        Icon(
          Icons.logout,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Logout ")
      ],
    ),
  )
];

Widget backgroundImage(context, {required String image}) {
  return Image(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,

    image: AssetImage(image),
    fit: BoxFit.cover,
  );
}

Widget radioButton(
    context,
    {required String text,
    required String value,
    required String groupValue,
    required Function(String?) function}) {
  return Expanded(
    // width: MediaQuery.of(context).size.width/5,
    child: ListTile(

      title: Text(text,style: const TextStyle(color: Colors.white ),),
      leading: Radio(

    value: value,
    fillColor: MaterialStateColor.resolveWith((states) {
      return Colors.white;
    }),
    groupValue: groupValue,
    onChanged: function,
      ),
    ),
  );
}

Widget checkBoxItem(
    context,
    {required Function(bool?) function,
    required String text,
    required bool value}) {
  return Row(
    children: [
      Theme(
        data: Theme.of(context).copyWith(
    unselectedWidgetColor: Colors.white,
  ),
        child: Checkbox(
          // focusColor: Colors.blue,
          // activeColor: Colors.blue,

          value: value,
          onChanged: function,
        ),
      ),
      Text(text),
    ],
  );
}

Widget dropDownMenu(
    {required List<String> food,
    required String text,
    required Function(String?) function}) {
  return Container(
    color:Colors.black.withOpacity(0.6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 3),
          child: Text(
            "اختار الاكل اللي بتحبه(اكتر من واحد )",
            style: TextStyle(fontSize: 20, color: Colors.grey[400]),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        DropdownButton<String>(
          dropdownColor:Colors.black.withOpacity(0.8),
          alignment: AlignmentDirectional.centerEnd,
            isExpanded: true,
            hint: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            items: food.map((String value) {
              return DropdownMenuItem<String>(

                alignment: AlignmentDirectional.centerEnd,
                value: value,
                child: Text(value,style: const TextStyle(color: Colors.white,fontSize: 20,),),
              );
            }).toList(),
            onChanged: function),
      ],
    ),
  );
}
