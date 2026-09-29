import 'package:expense_tracker/screens/create_category_screen.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custome_text_field.dart';
import '../widgets/field_label.dart';

class CreatePartyScreen extends StatefulWidget {
  const CreatePartyScreen({super.key});

  @override
  State<CreatePartyScreen> createState() => _CreatePartyScreenState();
}

class _CreatePartyScreenState extends State<CreatePartyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String selectedKind = 'Vendor';

  final List<Map<String, String>> kindList = [
    {'code': 'Vendor', 'symbol': '🛍️'},
    {'code': 'Customer', 'symbol': '👤'},
    {'code': 'Client', 'symbol': '💼'},
    {'code': 'Other', 'symbol': '📁'},
  ];

  void createParty() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Party created successfully!'),
      ),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCategoryScreen()));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
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

                    const SizedBox(height: 60),

                    // TITLE & SUBTITLE
                    const Text(
                      'Create Party',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: BrandColor.brand1,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Add a person or business you deal with.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Gray_palette.gray7,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ROW 1: NAME & KIND
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(text: 'Name', isRequired: true),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: nameController,
                                hintText: 'Shree Laxman',
                                prefixIcon: Icons.wallet_outlined,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(text: 'Kind', isRequired: true),
                              const SizedBox(height: 8),
                              CustomDropdownField<String>(
                                value: selectedKind,
                                prefixWidget: Text(
                                  kindList.firstWhere(
                                        (k) => k['code'] == selectedKind,
                                    orElse: () =>
                                    {'code': 'Vendor', 'symbol': '🛍️'},
                                  )['symbol']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                items: kindList.map((kind) {
                                  return DropdownMenuItem<String>(
                                    value: kind['code'],
                                    child: Text(kind['code']!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedKind = value;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ROW 2: EMAIL & PHONE
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(
                                  text: 'Email', isRequired: false),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: emailController,
                                hintText: 'shree.laxman@exar',
                                prefixIcon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(
                                  text: 'Phone', isRequired: false),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: phoneController,
                                hintText: '123-456-7890',
                                prefixIcon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ADDRESS FIELD
                    const FieldLabel(text: 'Address', isRequired: false),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: addressController,
                      hintText: 'Rajkot, Gujarat, India - 360002',
                      prefixIcon: Icons.location_on_outlined,
                    ),

                    const SizedBox(height: 18),

                    // NOTES FIELD
                    const FieldLabel(text: 'Notes', isRequired: false),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: notesController,
                      hintText: 'Brothers',
                      prefixIcon: Icons.article_outlined,
                    ),

                    const SizedBox(height: 32),

                    // CREATE PARTY BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: createParty,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColor.brand1,
                          foregroundColor: Gray_palette.gray1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Create Party',
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