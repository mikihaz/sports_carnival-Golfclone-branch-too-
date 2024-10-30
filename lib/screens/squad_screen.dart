import 'package:flutter/material.dart';
import 'package:rpgl/bases/themes.dart';

class SquadScreen extends StatelessWidget {
  final int fieldCount; // Number of fields passed from the other screen

  SquadScreen({required this.fieldCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Flat app bar for a clean look
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Squad Form',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black), // Back icon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SquadForm(fieldCount: fieldCount),
      ),
    );
  }
}

class SquadForm extends StatefulWidget {
  final int fieldCount; // Receive the field count from SquadScreen

  SquadForm({required this.fieldCount});

  @override
  _SquadFormState createState() => _SquadFormState();
}

class _SquadFormState extends State<SquadForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers = [];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeControllers(); // Initialize with the number of input fields passed

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController
        .forward(); // Start the animation when the screen is displayed
  }

  void _initializeControllers() {
    for (int i = 0; i < widget.fieldCount; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title
            Text(
              'Enter Squad Details',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppThemes.getBackground(),
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic input fields with avatars and animated transitions
            ...List.generate(_controllers.length, (index) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(index * 0.2, 1.0, curve: Curves.easeIn),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppThemes.getBackground().withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Player avatar placeholder
                      CircleAvatar(
                        backgroundColor:
                            AppThemes.getBackground().withOpacity(0.2),
                        radius: 25,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: AppThemes.getBackground(),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Player name input field
                      Expanded(
                        child: TextFormField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            labelText: 'Player ${index + 1}',
                            labelStyle: TextStyle(
                              color: AppThemes.getBackground(),
                              fontWeight: FontWeight.w500,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppThemes.getBackground(), width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a player name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Save Button
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: AppThemes.getBackground(),
                  elevation: 8,
                  shadowColor: AppThemes.getBackground().withOpacity(0.4),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Squad Data')),
                    );
                  }
                },
                child: Text(
                  'Save Squad',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose(); // Dispose of all controllers
    }
    _animationController.dispose();
    super.dispose();
  }
}
