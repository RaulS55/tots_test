import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';
import 'package:tots_test/src/ui/common/util/assets.dart';
import 'package:tots_test/src/ui/common/util/responsive.dart';
import 'package:tots_test/src/ui/common/widgets/custom_button.dart';
import 'package:tots_test/src/ui/views/home/contact_controller.dart';
import 'package:tots_test/src/ui/views/home/models/client.dart';

class NewEditClient extends StatefulWidget {
  const NewEditClient({super.key, required this.controller, this.client});
  final ClientController controller;
  final Client? client;
  @override
  State<NewEditClient> createState() => _NewEditClientState();
}

class _NewEditClientState extends State<NewEditClient> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  File? file;

  @override
  void initState() {
    if (widget.client != null) {
      final client = widget.client!;
      _nameController.text = client.firstname;
      _lastNameController.text = client.lastname;
      _emailController.text = client.email;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return ChangeNotifierProvider.value(
      value: widget.controller,
      builder: (context, child) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        behavior: HitTestBehavior.translucent,
        child: Form(
          key: _formKey,
          child: Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              height: responsive.hp(58),
              width: responsive.wp(90),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title
                        const Text(
                          'Add new client',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.black3,
                          ),
                        ),

                        //Image
                        SizedBox(height: responsive.hp(3)),
                        Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                onTap: _pickImage,
                                child: file == null
                                    ? SvgPicture.asset(AppAssets.uploadImage)
                                    : CircleAvatar(
                                        maxRadius: 55,
                                        foregroundImage: FileImage(file!),
                                      ))),

                        //Forms
                        SizedBox(height: responsive.hp(2)),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value?.isNotEmpty ?? false) return null;
                            return 'complete this field';
                          },
                          decoration: InputDecoration(
                            label: Text(
                              'First name*',
                              style: textStyle,
                            ),
                            enabledBorder: border,
                          ),
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          validator: (value) {
                            if (value?.isNotEmpty ?? false) return null;
                            return 'complete this field';
                          },
                          decoration: InputDecoration(
                            label: Text(
                              'Last name*',
                              style: textStyle,
                            ),
                            enabledBorder: border,
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }

                            if (!value.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text(
                              'Email address*',
                              style: textStyle,
                            ),
                            enabledBorder: border,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.black.withOpacity(0.38),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      Selector<ClientController, bool>(
                        selector: (p0, c) => c.isLoading,
                        builder: (context, isLoading, child) => CustomButton(
                          width: 170,
                          onTap: isLoading ? null : _save,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  'SAVE',
                                  style: TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pickImage() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pick == null) return;
      file = File(pick.path);

      setState(() {});
    } catch (e) {
      log('Pick image error $e');
    }
  }

  _save() {
    if (!_formKey.currentState!.validate()) return;
    final newClient = Client(
        id: widget.client?.id ?? 0,
        firstname: _nameController.text,
        lastname: _lastNameController.text,
        email: _emailController.text,
        photo: file?.path);
    if (widget.client == null) {
      widget.controller
          .add(client: newClient)
          .whenComplete(Navigator.of(context).pop);
    } else {
      widget.controller
          .edit(client: newClient)
          .whenComplete(Navigator.of(context).pop);
    }
  }

  final textStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.black3,
    fontSize: 16,
  );

  final border = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.gray2));
}
