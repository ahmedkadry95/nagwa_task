import 'package:flutter/material.dart';
import 'package:nagwa_task/core/theme/colors.dart';

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  final Function(String) onSubmitted;
  final Function() onCancel;
  TextEditingController controller;

  SearchField({
    super.key,
    required this.onSubmitted,
    required this.onCancel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.white,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              return value.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.lightGreyBorder,
                    ),
                    onPressed: () {
                      controller.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      onCancel();
                    },
                  )
                  : const SizedBox.shrink();
            },
          ),

          filled: true,
          fillColor: AppColors.white,
          prefixIcon: const Icon(
            Icons.search,
            size: 30,
            color: AppColors.lightGreyBorder,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.lightGreyBorder,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.lightGreyBorder,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.greyBorder,
              width: 1.5,
            ),
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
