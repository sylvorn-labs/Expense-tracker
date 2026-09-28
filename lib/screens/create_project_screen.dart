import 'package:expense_tracker/constants/color.dart';
import 'package:expense_tracker/screens/add_account_screen.dart';
import 'package:expense_tracker/widgets/field_label.dart';
import 'package:flutter/material.dart';

import '../widgets/custome_text_field.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  void createProject() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project created successfully!'),
      ),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAccountScreen()));
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP SPACING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // BACK BUTTON
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.chevron_left,
                            color: BrandColor.brand1,
                            size: 22,
                          ),
                          SizedBox(width: 2),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: BrandColor.brand1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 120),

                    // TITLE
                    const Text(
                      'Start Project',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: BrandColor.brand1,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // SUBTITLE
                    const Text(
                      'Organise your work and track progress.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Gray_palette.gray7,
                      ),
                    ),

                    const SizedBox(height: 75),

                    // BUSINESS NAME
                    FieldLabel(text: 'Name',isRequired: true,),

                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Voops',
                      prefixIcon: Icons.folder_copy_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter business name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),

                    //Description
                    FieldLabel(text: 'Description',isRequired: true,),
                    const SizedBox(height: 8,),

                    CustomTextField(
                      controller: descriptionController,
                      hintText: 'Simple application to control finances.',
                      prefixIcon: Icons.text_snippet_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 75),

                    // ADD BUSINESS BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: createProject,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColor.brand1,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Start Project',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // MOUNTAIN BANNER
            Image.asset(
              'assets/images/mountain_banner.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}