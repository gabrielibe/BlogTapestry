import 'package:flutter/material.dart';




class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final filterOptions = [
      FilterOption(title: 'Chest'),
      FilterOption(title: 'Back'),
      FilterOption(title: 'Shoulders'),
      FilterOption(title: 'Arms'),
      FilterOption(title: 'Legs'),
      FilterOption(title: 'Abs'),
      FilterOption(title: 'Core'),
      FilterOption(title: 'Glutes'),
      FilterOption(title: 'Full Body'),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Workout App'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: 'Enter muscle group',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 8.0, // Horizontal spacing between items
              mainAxisSpacing: 8.0, // Vertical spacing between items
              padding: const EdgeInsets.all(16.0), // Padding around the grid
              children: filterOptions, // The list of FilterOption widgets
            ),
          ),
          // Filter options
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Arms
                FilterOption(title: 'Arms'),
                // Chest
                FilterOption(title: 'Chest'),
                // Legs
                FilterOption(title: 'Legs'),
                // Back
                FilterOption(title: 'Back'),
                // Shoulders
                FilterOption(title: 'Shoulders'),
                // Abs
                FilterOption(title: 'Abs'),
                // Full Body
                FilterOption(title: 'Full Body'),
                // Strength Training
                FilterOption(title: 'Strength Training'),
                // Yoga
                FilterOption(title: 'Yoga'),
                // Cardio
                FilterOption(title: 'Cardio'),
                // HIIT
                FilterOption(title: 'HIIT'),
                // Filter by Difficulty
                FilterOption(title: 'Filter by Difficulty'),
                // Filter by Workout Duration
                FilterOption(title: 'Filter by Workout Duration'),
                // Filter by Equipment
                FilterOption(title: 'Filter by Equipment'),
              ],
            ),
          ),
          // Show Results button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))),
              onPressed: () {
                // TODO: Implement the logic to show the results based on the selected filters
              },
              child:
                  Text('Show Results', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// A custom widget for each filter option
class FilterOption extends StatelessWidget {
  final String title;

  const FilterOption({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child:
          Container(
        decoration:
            BoxDecoration(color:
            Colors.pink, borderRadius:
            BorderRadius.circular(32.0)),
        child:
            Padding(
          padding:
              const EdgeInsets.symmetric(horizontal:
              16.0, vertical:
              8.0),
          child:
              Text(title, style:
              TextStyle(color:
              Colors.white)),
        ),
      ),
    );
  }
}
