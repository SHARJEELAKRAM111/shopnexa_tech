class ProjectModel {
  final String title;
  final String description;
  final String imagePath;
  final List<String> tags;
  final String detailsUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tags,
    required this.detailsUrl,
  });
}
