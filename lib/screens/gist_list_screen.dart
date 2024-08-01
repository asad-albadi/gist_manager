// gist_list_screen.dart

import 'package:_mobile_app_to_lookup_and_search_gists/main.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/providers/gist_provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/providers/user_provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/screens/gist_detail_screen.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GistListScreen extends StatefulWidget {
  const GistListScreen({super.key});

  @override
  _GistListScreenState createState() => _GistListScreenState();
}

class _GistListScreenState extends State<GistListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GistProvider>(context, listen: false).fetchGists();
      Provider.of<UserProvider>(context, listen: false)
          .fetchUserProfile(); // Fetch user profile
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: const SettingsDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                if (userProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userProvider.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${userProvider.errorMessage}'));
                } else if (userProvider.user != null) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(userProvider.user!.avatarUrl),
                    ),
                    title: Text(userProvider.user!.login),
                    subtitle: GestureDetector(
                      onTap: () async {
                        if (await canLaunch(userProvider.user!.htmlUrl)) {
                          await launch(userProvider.user!.htmlUrl);
                        } else {
                          throw 'Could not launch ${userProvider.user!.htmlUrl}';
                        }
                      },
                      child: Text(
                        userProvider.user!.htmlUrl,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<GistProvider>(context, listen: false).fetchGists();
              Provider.of<UserProvider>(context, listen: false)
                  .fetchUserProfile(); // Fetch user profile
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
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
                          title: Row(
                            children: [
                              Text(gist.filename.split('.md')[0]),
                              IconButton(
                                tooltip: "Click here to go to: ${gist.url}",
                                icon: const Icon(Icons.link, size: 18.0),
                                onPressed: () {
                                  launchURL(gist.url);
                                },
                              )
                            ],
                          ),
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
                                      GistDetailScreen(gist: gist)),
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
