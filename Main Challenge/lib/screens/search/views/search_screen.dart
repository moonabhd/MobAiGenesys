import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/route/route_constants.dart';
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shop/models/product_model.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final List<String> recentSearches = [
  'Harry Potter',
  'Hopeless',
  'Fifty Shades of grey',
  'It start with us',
  'It ends with us',
];

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  List<BookModel> searchResults = demoPopularBooks;
  List<BookModel> filteredResults = [];
  List<String> recentSearches = [];
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecentSearches = 10;

  @override
  void initState() {
    super.initState();
    filteredResults = searchResults;
    _loadRecentSearches();
  }

  // Load recent searches from SharedPreferences
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList(_recentSearchesKey) ?? [];
    });
  }

  // Save recent searches to SharedPreferences
  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, recentSearches);
  }

  // Add a search term to recent searches
  void _addToRecentSearches(String searchTerm) {
    if (searchTerm.isEmpty) return;

    setState(() {
      // Remove the search term if it already exists
      recentSearches.remove(searchTerm);
      // Add the search term to the beginning of the list
      recentSearches.insert(0, searchTerm);
      // Keep only the most recent searches
      if (recentSearches.length > _maxRecentSearches) {
        recentSearches = recentSearches.sublist(0, _maxRecentSearches);
      }
    });
    _saveRecentSearches();
  }

  // Remove a search term from history
  void _removeFromHistory(String searchTerm) {
    setState(() {
      recentSearches.remove(searchTerm);
    });
    _saveRecentSearches();
  }

  // Clear all search history
  void _clearSearchHistory() {
    setState(() {
      recentSearches.clear();
    });
    _saveRecentSearches();
  }

  Future<void> _filterProducts(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredResults = searchResults;
      });
      return;
    }

    _addToRecentSearches(query); // Add to recent searches

    const apiUrl = 'http://127.0.0.1:5000/recommend';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List recommendations = data['recommendations'];

        setState(() {
          filteredResults = recommendations
              .map((item) => BookModel.fromJson(item))
              .toList();
              recentSearchdemo=filteredResults;
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  /// **Handles Speech-to-Text for Vocal Search**
  // Update these functions in your _SearchScreenState class

Future<void> _startListening() async {
  try {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print('Speech status: $status');
        if (status == 'done') {
          setState(() => _isListening = false);
        }
      },
      onError: (errorNotification) {
        print('Speech error: $errorNotification');
        setState(() => _isListening = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $errorNotification')),
        );
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        // Clear the previous text when starting new listening session
        _searchController.clear();
      });

      await _speech.listen(
        onResult: (result) {
          setState(() {
            _searchController.text = result.recognizedWords;
            // If we have a final result, stop listening and perform search
            if (result.finalResult) {
              _stopListening();
            }
          });
        },
        listenFor: Duration(seconds: 30), // Maximum listening duration
        pauseFor: Duration(seconds: 3),   // Auto-stop after silence
        partialResults: true,             // Get interim results
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available')),
      );
    }
  } catch (e) {
    print('Error initializing speech recognition: $e');
    setState(() => _isListening = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

Future<void> _stopListening() async {
  try {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });

    final recognizedText = _searchController.text.trim();
    print('Recognized Text: $recognizedText');

    if (recognizedText.isNotEmpty) {
      // Add to recent searches and perform the search
      _addToRecentSearches(recognizedText);
      await _filterProducts(recognizedText);
    }
  } catch (e) {
    print('Error stopping speech recognition: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error stopping recognition: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booki',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      await _filterProducts(_searchController.text);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                    onPressed: () {
                      _isListening ? _stopListening() : _startListening();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildRecentSearches()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildRecentSearches() {
    if (recentSearches.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No recent searches',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              'Your search history will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (recentSearches.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Clear Search History'),
                        content: const Text(
                          'Are you sure you want to clear your search history?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _clearSearchHistory();
                              Navigator.pop(context);
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear All'),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              final searchTerm = recentSearches[index];
              return Dismissible(
                key: Key(searchTerm),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _removeFromHistory(searchTerm);
                },
                child: ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(searchTerm),
                  trailing: const Icon(Icons.north_west, size: 16),
                  onTap: () {
                    setState(() {
                      _searchController.text = searchTerm;
                    });
                    _filterProducts(searchTerm);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Search result (${filteredResults.length} items)',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: filteredResults.map((product) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      productDetailsScreenRoute,
                      arguments: product, // Passing the selected book
                    );
                  },
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.author,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(product.category, style: TextStyle(color: Colors.grey)),
                      Text(product.isbn.toString(),
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}