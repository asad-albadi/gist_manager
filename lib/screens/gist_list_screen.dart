// gist_list_screen.dart

import 'package:flutter/rendering.dart';
import 'package:gist_manager/main.dart';
import 'package:gist_manager/providers/gist_provider.dart';
import 'package:gist_manager/providers/hover_change_image.dart';
import 'package:gist_manager/providers/user_provider.dart';
import 'package:gist_manager/screens/credentials_dialog.dart';
import 'package:gist_manager/screens/gist_detail_screen.dart';
import 'package:gist_manager/screens/settings_screen.dart';
import 'package:gist_manager/widgets/custom_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  List<Widget> tagList(String filename, String content) {
    List<Widget> tags = [];
    List<Map<String, dynamic>> tagCriteria = [
      {
        'name': 'Containerization',
        'color': Colors.blueAccent,
        'keywords': ['docker', 'k8s', 'kubernetes', 'container']
      },
      {
        'name': 'Game Development',
        'color': Colors.lightGreen,
        'keywords': [
          'godot',
          'unity3d',
          'game development',
        ]
      },
      {
        'name': 'Operating Systems',
        'color': Colors.amber,
        'keywords': [
          'linux',
          'windows',
          'macos',
          'ubuntu',
          'fedora',
          'debian',
          'pop!_os',
          'archlinux',
          'arch linux'
        ]
      },
      {
        'name': 'Cloud Computing',
        'color': Colors.lightBlueAccent,
        'keywords': [
          'cloud',
          'aws',
          'azure',
          'gcp',
          'google cloud',
          'amazon web services'
        ]
      },
      /*   {
        'name': 'Programming Languages',
        'color': Colors.green,
        'keywords': [
          'python',
          '.py',
          'java',
          '.java',
          'dart',
          'flutter',
          'rust',
          '.rs',
          'c++',
          '.cpp',
          'c#',
          '.cs'
        ]
      }, */
      {
        'name': 'Data Science',
        'color': Colors.deepOrange,
        'keywords': [
          'data science',
          'data analysis',
          'pandas',
          'numpy',
          'machine learning',
          'artificial intelligence'
        ]
      },
      {
        'name': 'DevOps',
        'color': Colors.blueAccent,
        'keywords': [
          'devops',
          'ci/cd',
          'continuous integration',
          'continuous deployment'
        ]
      },
      {
        'name': 'Security',
        'color': Colors.redAccent,
        'keywords': ['security', 'cybersecurity', 'infosec']
      },
      {
        'name': 'Networking',
        'color': Colors.deepPurpleAccent,
        'keywords': ['networking', 'network', 'tcp/ip', 'dns']
      },
      {
        'name': 'Homelab',
        'color': Colors.black,
        'keywords': ['homelab']
      },
      {
        'name': 'IoT',
        'color': Colors.blueAccent,
        'keywords': ['home assistant', 'mqtt']
      },
      {
        'name': 'Electronics',
        'color': Colors.blueAccent,
        'keywords': ['pcb', 'sensor', 'arduino', '3d print', 'microcontroller']
      }
    ];

    for (var tag in tagCriteria) {
      for (var keyword in tag['keywords']) {
        if (filename.toLowerCase().contains(keyword) ||
            content.toLowerCase().contains(keyword)) {
          tags.add(CustomTag(name: tag['name'], color: tag['color']));
          break; // Avoid adding the same tag multiple times
        }
      }
    }

    return tags;
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
                    leading: HoverChangeImage(
                        assetImageUrl: 'assets/logo.png',
                        networkImageUrl: userProvider.user!.avatarUrl),
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
                    /*   subtitle: GestureDetector(
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
                    ), */
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
            child: Row(
              children: [
                Expanded(
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
                                      GistDetailScreen(gist: gist)),
                            );
                          },
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(gist.filename.split('.md')[0]),
                                ),
                                IconButton(
                                  tooltip: "Click here to go to: ${gist.url}",
                                  icon: const Icon(Icons.link, size: 18.0),
                                  onPressed: () {
                                    launchURL(gist.url);
                                  },
                                ),
                                Text(gist.createdAt),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (gist.filename.split('.md')[0] !=
                                    gist.description.toString())
                                  Text(gist.description ?? ''),
                                /*   Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children:
                                      tagList(gist.filename, gist.content),
                                ), */
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
