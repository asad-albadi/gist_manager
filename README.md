# Gist Manager

Gist Manager is a Flutter application that allows you to manage your GitHub gists. It provides a convenient interface for viewing, searching, and sorting your gists. The app also includes a light and dark theme based on the Dracula color palette.

## Features

- **View Gists**: Fetch and display a list of your GitHub gists.
- **Search Gists**: Search through your gists by filename, description, or content.
- **Sort Gists**: Sort gists by filename or date in ascending or descending order.
- **Gist Details**: View the content of a gist in detail, with Markdown support.
- **User Profile**: Display GitHub user profile information.
- **Dark Mode**: Switch between light and dark themes.

## Screenshots

### Light Theme
![image](https://github.com/user-attachments/assets/4e50d8cd-5494-49f6-ac49-c3949215b9c9)


### Dark Theme
![image](https://github.com/user-attachments/assets/855b132e-41f8-4e35-baea-448868c15462)


## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/gist_manager.git
    cd gist_manager
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the app**:
    ```bash
    flutter run
    ```

## Usage

1. **Enter your GitHub credentials**: When prompted, enter your GitHub username and personal access token.
2. **View your gists**: The app will fetch and display your gists.
3. **Search and sort**: Use the search bar to find specific gists and the sort buttons to order them as desired.
4. **View details**: Tap on a gist to view its content in detail.

## Development

### Project Structure

- `lib/`: Contains the main source code.
  - `models/`: Data models for gists and user.
  - `providers/`: State management using `ChangeNotifier`.
  - `screens/`: UI screens for listing gists, displaying details, and settings.
  - `services/`: API service for fetching data from GitHub.
  - `widgets/`: Reusable UI components like tags.

### Adding New Features

1. **Create a new branch**:
    ```bash
    git checkout -b feature/your-feature
    ```

2. **Make your changes** and commit them:
    ```bash
    git add .
    git commit -m "Add your feature"
    ```

3. **Push to your branch**:
    ```bash
    git push origin feature/your-feature
    ```

4. **Create a pull request**: Submit your changes for review.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/feature-name`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/feature-name`).
5. Open a pull request.

## Acknowledgements

- [Dracula Theme](https://draculatheme.com/) for the beautiful color palette.
- [Flutter](https://flutter.dev/) for the awesome framework.
- [GitHub API](https://developer.github.com/v3/gists/) for the backend support.

## Contact

For any issues or inquiries, please contact [your-email@example.com].
