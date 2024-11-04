import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';
import 'package:tots_test/src/ui/common/util/assets.dart';
import 'package:tots_test/src/ui/common/util/spaces.dart';
import 'package:tots_test/src/ui/common/widgets/custom_button.dart';
import 'package:tots_test/src/ui/views/home/contact_controller.dart';
import 'package:tots_test/src/ui/views/home/widgets/new_edit_client.dart';

class ActionsBar extends StatelessWidget {
  const ActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(68),
        borderSide: const BorderSide(color: AppColors.gray3));
    final controller = Provider.of<ClientController>(context, listen: false);
    return Row(
      children: [
        Expanded(
            child: TextField(
          onChanged: (value) => controller.search(value),
          decoration: InputDecoration(
              enabledBorder: border,
              border: border,
              errorBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border,
              isDense: true,
              hintText: 'Search...',
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.62)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 40, maxWidth: 40),
              prefixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(AppAssets.search))),
        )),
        Spaces.horizontal8,
        CustomButton(
          text: 'ADD NEW',
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 4),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return NewEditClient(
                  controller: controller,
                );
              },
            );
          },
        )
      ],
    );
  }
}
