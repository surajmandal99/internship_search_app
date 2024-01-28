import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_search_app/models/internship_model.dart';
import 'dart:convert';

import 'package:internship_search_app/screens/internship_details_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internship Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> internships = [];
  List<dynamic> filteredInternships = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final Uri url = Uri.parse('https://internshala.com/flutter_hiring/search');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('internships_meta')) {
        final Map<String, dynamic> internshipsMeta =
            responseData['internships_meta'];
        final List<dynamic> internshipsData = internshipsMeta.values.toList();

        setState(() {
          internships = internshipsData;
          filteredInternships = internshipsData;
        });
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterInternships(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredInternships = internships;
      });
    } else {
      List<dynamic> filteredList = internships.where((internship) {
        final String title = internship['title'].toString().toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredInternships = filteredList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterInternships,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Search Internships',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredInternships.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InternshipDetailsScreen(
                                  internshipData: InternshipModel.fromJson({
                                    "internships_meta": {
                                      "internships": {
                                        "id": internships[index]['id'],
                                        "company_name": internships[index]
                                            ['company_name'],
                                        "locations": [
                                          {
                                            "locationName": "City, Country",
                                          }
                                        ],
                                        "start_date": "2024-02-01",
                                        "title": "Software Developer Intern",
                                      }
                                    },
                                  }),
                                  internship: internships,
                                ))),
                    title: Text(filteredInternships[index]['title']),
                    subtitle: Text(filteredInternships[index]['company_name'] ??
                        'No Company'),
                    // Add more details here
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
