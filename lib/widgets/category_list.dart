import 'package:flutter/material.dart';

import 'package:transaction_app/utils/icons_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.onChanged});
  final ValueChanged<String?> onChanged;
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String currentCategory = '';
  List<Map<String, dynamic>> categoryList = [];

  final scrollController = ScrollController();
  var appIcons = AppIcons();

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryList = appIcons.homeExpenseCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
          controller: scrollController,
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = categoryList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentCategory = data['name'];
                  widget.onChanged(data['name']);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: currentCategory == data['name']
                      ? Colors.blue.shade900
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Row(
                  children: [
                    Icon(
                      data['icon'],
                      size: 15,
                      color: currentCategory == data['name']
                          ? Colors.white
                          : Colors.blue.shade900,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      data['name'],
                      style: TextStyle(
                        color: currentCategory == data['name']
                            ? Colors.white
                            : Colors.blue.shade900,
                      ),
                    ),
                  ],
                )),
              ),
            );
          }),
    );
  }
}
