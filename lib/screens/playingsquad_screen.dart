import 'package:flutter/material.dart';
import 'package:rpgl/bases/themes.dart';

class PlayingsquadScreen extends StatelessWidget {
  final int fieldCount; // Number of fields passed from the other screen

  PlayingsquadScreen({required this.fieldCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Flat app bar for a clean look
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Darts',
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

// class _SquadFormState extends State<SquadForm>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   List<TextEditingController> _controllers = [];
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers(); // Initialize with the number of input fields passed

//     // Initialize Animation Controller
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//     _animationController
//         .forward(); // Start the animation when the screen is displayed
//   }

//   void _initializeControllers() {
//     for (int i = 0; i < widget.fieldCount; i++) {
//       _controllers.add(TextEditingController());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // Title
//               Text(
//                 'Enter Squad Details',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: AppThemes.getBackground(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // List of Sports Categories with player fields
//               _buildSportCategory('Junior Doubles', 2),
//               _buildSportCategory('Men\'s Double', 2),
//               _buildSportCategory('Women\'s Single', 1),
//               _buildSportCategory('Veteran Doubles', 2),

//               // Save Button
//               const SizedBox(height: 30),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     backgroundColor: AppThemes.getBackground(),
//                     elevation: 8,
//                     shadowColor: AppThemes.getBackground().withOpacity(0.4),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Processing Squad Data')),
//                       );
//                     }
//                   },
//                   child: Text(
//                     'Save Squad',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build each sport category with corresponding fields
//   Widget _buildSportCategory(String sportName, int playerCount) {
//     return FadeTransition(
//       opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//           parent: _animationController,
//           curve: Curves.easeIn,
//         ),
//       ),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 20),
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: AppThemes.getBackground().withOpacity(0.1),
//               blurRadius: 10,
//               spreadRadius: 5,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Sport Name
//             Text(
//               sportName,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: AppThemes.getBackground(),
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Player Input Fields
//             Row(
//               children: List.generate(playerCount, (index) {
//                 return Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: TextFormField(
//                       controller: _controllers.length > index
//                           ? _controllers[index]
//                           : TextEditingController(),
//                       decoration: InputDecoration(
//                         labelText: 'Player ${index + 1}',
//                         labelStyle: TextStyle(
//                           color: AppThemes.getBackground(),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey.shade100,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(
//                               color: AppThemes.getBackground(), width: 2),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a player name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Expanded widget to ensure all sections fit within the screen
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBoardSection("Open Singles", 1),
                    _buildBoardSection("Mixed Doubles", 2),
                    _buildBoardSection("Open Doubles\n(Above 40 Years)", 2),
                    _buildBoardSection("Open Doubles", 2),
                    _buildBoardSection("Open Triples", 3),
                    // _buildBoardSection("Table 5", 1),
                    // _buildBoardSection("Table 6", 1),
                  ],
                ),
              ),
              // Save Button
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
      ),
    );
  }

  // Helper method to build each board section with corresponding fields
  Widget _buildBoardSection(String boardName, int playerCount) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeIn,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Board Name
            Text(
              boardName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppThemes.getBackground(),
              ),
            ),

            // Player Input Fields in a Column layout
            Column(
              children: List.generate(playerCount, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0), // Reduced vertical spacing
                  child: TextFormField(
                    controller: _controllers.length > index
                        ? _controllers[index]
                        : TextEditingController(),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey.shade300),
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

// class _SquadFormState extends State<SquadForm>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   List<TextEditingController> _controllers = [];
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();

//     // Initialize Animation Controller
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//     _animationController.forward();
//   }

//   void _initializeControllers() {
//     // Initialize controllers for all input fields
//     for (int i = 0; i < 6; i++) {
//       _controllers.add(TextEditingController());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // Title
//               Text(
//                 'Enter Squad Details',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: AppThemes.getBackground(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Headers: Events | Order of Play | Player Name
//               Row(
//                 children: [
//                   Expanded(flex: 3, child: _buildHeaderText('Events')),
//                   Expanded(flex: 1, child: _buildHeaderText('Order')),
//                   Expanded(flex: 3, child: _buildHeaderText('Player Name')),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Event Rows
//               _buildEventRow('Open Singles', '1', 0),
//               _buildEventRow('Mixed Doubles', '1.', 1, secondPlayerIndex: 2),
//               _buildEventRow('Open Doubles\n(Above 40 Years)', '1.', 3,
//                   secondPlayerIndex: 4),
//               _buildEventRow('', '2.', 5), // Extra row for Open Doubles player

//               // Save Button
//               const SizedBox(height: 30),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     backgroundColor: AppThemes.getBackground(),
//                     elevation: 8,
//                     shadowColor: AppThemes.getBackground().withOpacity(0.4),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Processing Squad Data')),
//                       );
//                     }
//                   },
//                   child: Text(
//                     'Save Squad',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build each event row
//   Widget _buildEventRow(String eventName, String order, int playerIndex,
//       {int? secondPlayerIndex}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Event Name Column
//           Expanded(
//             flex: 3,
//             child: Text(
//               eventName,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppThemes.getBackground(),
//               ),
//             ),
//           ),

//           // Order of Play Column
//           Expanded(
//             flex: 1,
//             child: Text(
//               order,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppThemes.getBackground(),
//               ),
//             ),
//           ),

//           // Player Name Input Fields Column
//           Expanded(
//             flex: 3,
//             child: Column(
//               children: [
//                 _buildPlayerInput(playerIndex),
//                 if (secondPlayerIndex != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: _buildPlayerInput(secondPlayerIndex),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method to build input fields for player names
//   Widget _buildPlayerInput(int index) {
//     return TextFormField(
//       controller: _controllers[index],
//       decoration: InputDecoration(
//         hintText: 'Player ${index + 1}',
//         hintStyle: TextStyle(
//           color: AppThemes.getBackground().withOpacity(0.5),
//         ),
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: BorderSide(color: AppThemes.getBackground(), width: 2),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter a player name';
//         }
//         return null;
//       },
//     );
//   }

//   // Helper method to build header text
//   Widget _buildHeaderText(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: AppThemes.getBackground(),
//       ),
//       textAlign: TextAlign.center,
//     );
//   }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose(); // Dispose of all controllers
    }
    _animationController.dispose();
    super.dispose();
  }
}
