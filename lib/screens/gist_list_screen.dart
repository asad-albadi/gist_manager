// gist_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/gist_provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/screens/gist_detail_screen.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/screens/settings_screen.dart';

class GistListScreen extends StatefulWidget {
  @override
  _GistListScreenState createState() => _GistListScreenState();
}

class _GistListScreenState extends State<GistListScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GistProvider>(context, listen: false).fetchGists();
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<GistProvider>(context, listen: false).fetchGists();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                Provider.of<GistProvider>(context, listen: false)
                    .searchGists(query);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<GistProvider>(context, listen: false)
                      .sortGistsByFilename(_sortAscending);
                  _toggleSortOrder();
                },
                child: Text(_sortAscending
                    ? 'Sort by Filename Asc'
                    : 'Sort by Filename Desc'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<GistProvider>(context, listen: false)
                      .sortGistsByDate(_sortAscending);
                  _toggleSortOrder();
                },
                child: Text(
                    _sortAscending ? 'Sort by Date Asc' : 'Sort by Date Desc'),
              ),
            ],
          ),
          Expanded(
            child: Consumer<GistProvider>(
              builder: (context, gistProvider, _) {
                if (gistProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (gistProvider.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${gistProvider.errorMessage}'));
                } else if (gistProvider.gists.isEmpty) {
                  return const Center(child: Text('No gists found.'));
                } else {
                  return ListView.builder(
                    itemCount: gistProvider.gists.length,
                    itemBuilder: (context, index) {
                      final gist = gistProvider.gists[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(gist.filename.split('.md')[0]),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              gist.filename.split('.md')[0] ==
                                      gist.description.toString()
                                  ? const Text('')
                                  : Text(gist.description ?? ''),
                              Text(gist.createdAt),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GistDetailScreen(gist: gist),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
