import 'package:flutter/material.dart';
import 'package:gist_manager/main.dart';
import 'package:gist_manager/models/colors.dart';
import 'package:gist_manager/providers/gist_provider.dart';
import 'package:gist_manager/providers/user_provider.dart';
import 'package:gist_manager/screens/credentials_dialog.dart';
import 'package:gist_manager/widgets/filter_popup.dart';
import 'package:gist_manager/screens/gist_detail_screen.dart';
import 'package:gist_manager/screens/settings_screen.dart';
import 'package:gist_manager/widgets/custom_tag.dart';
import 'package:provider/provider.dart';

class GistListScreen extends StatefulWidget {
  const GistListScreen({super.key});

  @override
  _GistListScreenState createState() => _GistListScreenState();
}

class _GistListScreenState extends State<GistListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _sortAscending = true;
  String _currentFilter = 'All'; // Add a state variable for the current filter
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GistProvider>(context, listen: false).fetchGists();
      Provider.of<UserProvider>(context, listen: false)
          .fetchUserProfile(); // Fetch user profile
    });

    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
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

  void _showFilterPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterPopup(
          currentFilter: _currentFilter,
          onFilterChanged: (filter) {
            setState(() {
              _currentFilter = filter;
              Provider.of<GistProvider>(context, listen: false)
                  .filterGists(filter);
            });
          },
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
                  return Center(child: Text(userProvider.errorMessage));
                } else if (userProvider.user != null) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(userProvider.user!.avatarUrl),
                    ),
                    title: Row(
                      children: [
                        Text(userProvider.user!.login),
                        IconButton(
                          tooltip:
                              "Click here to go to: ${userProvider.user!.htmlUrl}",
                          icon: const Icon(Icons.link, size: 18.0),
                          onPressed: () {
                            launchURL(userProvider.user!.htmlUrl);
                          },
                        ),
                      ],
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
                  .fetchUserProfile();
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
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
                if (!_isSearchFocused) ...[
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<GistProvider>(context, listen: false)
                            .sortGistsByFilename(_sortAscending);
                        _toggleSortOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.text_format),
                          Icon(_sortAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<GistProvider>(context, listen: false)
                            .sortGistsByDate(_sortAscending);
                        _toggleSortOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          Icon(_sortAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _showFilterPopup,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list),
                          Text(_currentFilter.toString())
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: Consumer<GistProvider>(
              builder: (context, gistProvider, _) {
                if (gistProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (gistProvider.errorMessage.isNotEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text(gistProvider.errorMessage),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const CredentialsDialog(),
                            );
                          },
                          child: const Text('Update Credentials'),
                        ),
                      ],
                    ),
                  );
                } else if (gistProvider.gists.isEmpty) {
                  return const Center(child: Text('No gists found.'));
                } else {
                  return ListView.builder(
                    itemCount: gistProvider.gists.length,
                    itemBuilder: (context, index) {
                      final gist = gistProvider.gists[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GistDetailScreen(gist: gist),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Icon(
                                    gist.isPublic ? Icons.public : Icons.lock,
                                    color: gist.isPublic
                                        ? DraculaPalette.green
                                        : DraculaPalette.red,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    gist.filename.split('.md')[0],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  tooltip: "Click here to go to: ${gist.url}",
                                  icon: const Icon(Icons.link, size: 18.0),
                                  onPressed: () {
                                    launchURL(gist.url);
                                  },
                                ),
                              ],
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (gist.filename.split('.md')[0] !=
                                    gist.description.toString())
                                  Expanded(
                                    child: Text(
                                      gist.description ?? '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                const Spacer(),
                                Text(gist.createdAt),
                              ],
                            ),
                          ),
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
