import 'package:flutter/material.dart';
import 'package:transaction_app/utils/icons_list.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({
    super.key,
    required this.onChanged,
    this.cattype,
  });

  final ValueChanged<String?> onChanged;
  final String? cattype;

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.cattype,
      isExpanded: true,
      hint: const Text("Select Category"),
      items: appIcons.homeExpenseCategories
          .map((e) => DropdownMenuItem<String>(
                value: e['name'],
                child: Row(
                  children: [
                    Icon(
                      e['icon'],
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      e['name'],
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ))
          .toList(),
      onChanged: widget.onChanged,
    );
  }
}
