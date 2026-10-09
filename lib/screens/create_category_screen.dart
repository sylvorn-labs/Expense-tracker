import 'package:expense_tracker/screens/record_transaction_screen.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custome_text_field.dart';
import '../widgets/field_label.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController();

  // Default selected option
  String selectedKind = 'Expense';
  Color selectedColor = const Color(0xFFFF3B30);

  // Separate dropdown items for Expense and Income
  final List<Map<String, String>> kindList = const [
    {'code': 'Expense', 'label': 'Expense', 'symbol': '₹'},
    {'code': 'Income', 'label': 'Income', 'symbol': '₹'},
  ];

  final List<Color> colorPalette = const [
    Color(0xFFFF3B30),
    Color(0xFFFF9500),
    Color(0xFFFFCC00),
    Color(0xFF34C759),
    Color(0xFF00C7BE),
    Color(0xFF30B0C7),
    Color(0xFF007AFF),
    Color(0xFF5856D6),
    Color(0xFFAF52DE),
    Color(0xFFFF2D55),
    Color(0xFFA2845E),
  ];

  void createCategory() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Category created as $selectedKind!'),
      ),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordTransactionScreen()));
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // Helper method to safely retrieve data from kindList without null-check runtime errors
  Map<String, String> _getSelectedKindData() {
    return kindList.firstWhere(
          (k) => k['code'] == selectedKind,
      orElse: () => {'code': 'Expense', 'label': 'Expense', 'symbol': '₹'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedKindData = _getSelectedKindData();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // FIXED FORM CONTENT
            Expanded(
              child: Padding(
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

                      const Spacer(flex: 2),

                      // TITLE
                      const Text(
                        'Create Category',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: BrandColor.brand1,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // SUBTITLE
                      const Text(
                        'organise your transactions with categories.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Gray_palette.gray7,
                        ),
                      ),

                      const Spacer(flex: 3),

                      // NAME FIELD
                      const FieldLabel(text: 'Name', isRequired: true),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Marketing',
                        prefixIcon: Icons.category_outlined,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter category name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // KIND DROPDOWN
                      const FieldLabel(text: 'Kind', isRequired: true),
                      const SizedBox(height: 6),
                      CustomDropdownField<String>(
                        value: selectedKind,
                        prefixWidget: Text(
                          selectedKindData['symbol'] ?? '₹',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: BrandColor.brand1,
                          ),
                        ),
                        items: kindList.map((kind) {
                          return DropdownMenuItem<String>(
                            value: kind['code'],
                            child: Text(
                              kind['label'] ?? kind['code'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: BrandColor.brand1,
                              ),
                            ),
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

                      const SizedBox(height: 16),

                      // COLOURS PICKER
                      const FieldLabel(text: 'Colours', isRequired: true),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 28,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: colorPalette.length,
                          separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final color = colorPalette[index];
                            final isSelected = selectedColor == color;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = color;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(
                                    color: BrandColor.brand1,
                                    width: 2,
                                  )
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const Spacer(flex: 4),

                      // CREATE CATEGORY BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: createCategory,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BrandColor.brand1,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Create Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),

            // BOTTOM MOUNTAIN BANNER
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