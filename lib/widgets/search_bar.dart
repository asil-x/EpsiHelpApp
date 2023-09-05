import 'package:epsihelp_app/controllers/convsersationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../layout_utils.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late ConversationsController convCont;
  @override
  void initState() {
    convCont = Get.find<ConversationsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onChanged: (value) {
        convCont.filterConvos();
      },
      controller: convCont.filterSearchCont,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search,
          size: 25,
          color: kGrey,
        ),
        isDense: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.only(
          left: 12,
        ),
        enabledBorder: roundPurpleBorder(15),
        focusedBorder: roundPurpleBorder(15),
        hintText: "Recherchez",
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
