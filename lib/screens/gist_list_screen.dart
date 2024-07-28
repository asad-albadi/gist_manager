import 'package:_mobile_app_to_lookup_and_search_gists/gist_provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/screens/gist_detail_screen.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GistListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GistProvider>(context, listen: false).fetchGists();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Gists'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<GistProvider>(context, listen: false).fetchGists();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<GistProvider>(
        builder: (context, gistProvider, _) {
          if (gistProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (gistProvider.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${gistProvider.errorMessage}'));
          } else if (gistProvider.gists.isEmpty) {
            return Center(child: Text('No gists found.'));
          } else {
            return ListView.builder(
              itemCount: gistProvider.gists.length,
              itemBuilder: (context, index) {
                final gist = gistProvider.gists[index];
                return ListTile(
                  title: Text(gist.filename),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(gist.description ?? 'No description'),
                      Text('Created at: ${gist.createdAt}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GistDetailScreen(gist: gist),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
