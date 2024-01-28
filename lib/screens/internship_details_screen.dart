import 'package:flutter/material.dart';
import 'package:internship_search_app/models/internship_model.dart';

class InternshipDetailsScreen extends StatelessWidget {
  final InternshipModel internshipData;

  const InternshipDetailsScreen(
      {super.key, required this.internshipData, required internship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              internshipData.internshipsMeta.keys.first,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Company: ${internshipData.internshipsMeta.values.first.companyName ?? "N/A"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${internshipData.internshipsMeta.values.first.locations.isNotEmpty ? internshipData.internshipsMeta.values.first.locations.first.locationName ?? "N/A" : "N/A"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Start Date: ${internshipData.internshipsMeta.values.first.startDate ?? "N/A"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              internshipData.internshipsMeta.values.first.title ?? "N/A",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Apply Now'),
            ),
          ],
        ),
      ),
    );
  }
}
