import 'package:simons/cubit/page_cubit.dart';
import 'package:simons/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtomNavigation extends StatelessWidget {
  final String imageUrl;
  final int index;

  const CustomButtomNavigation(
      {Key? key, required this.imageUrl, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imageUrl,
            width: 32,
            height: 32,
            color: context.read<PageCubit>().state == index
                ? kGreenColor
                : kGreyColor,
          ),
          Container(
              width: 38,
              height: 2,
              decoration: BoxDecoration(
                  color: context.read<PageCubit>().state == index
                      ? kGreenColor
                      : kTransparentColor,
                  borderRadius: BorderRadius.circular(18))),
        ],
      ),
    );
  }
}
