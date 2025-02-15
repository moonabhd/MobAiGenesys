import 'dart:convert';

import 'package:fantasy_football/models/matchmob.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'match.dart';  // Ensure the model is imported
import 'package:http/http.dart' as http;

class MatchResults extends StatelessWidget {

  // This function fetches match data from the API
  Future<List<Match_model>> fetchMatchResults() async {
    final url = 'https://your-api-url.com/match-results';  // Replace with your actual API URL

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((matchData) => Match_model.fromJson(matchData)).toList();
    } else {
      throw Exception('Failed to load match results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 32, 34, 1),
      appBar: AppBar(
        title: Text('Match Results'),
        backgroundColor: Color.fromRGBO(61, 147, 19, 100),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<Match_model>>(
          future: fetchMatchResults(), // Fetch the match results
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No match results available'));
            } else {
              final matches = snapshot.data!;
              return ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTeamColumn(match.homeTeam, match.homeScore, true),
                          _buildScoreColumn(match.homeScore, match.awayScore),
                          _buildTeamColumn(match.awayTeam, match.awayScore, false),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTeamColumn(String team, int score, bool isHome) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: isHome ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            team,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Score: $score',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isHome ? Color.fromRGBO(206, 24, 23, 100) : Color.fromRGBO(206, 24, 23, 100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreColumn(int homeScore, int awayScore) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$homeScore - $awayScore',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(61, 147, 19, 100),
            ),
          ),
        ],
      ),
    );
  }
}
