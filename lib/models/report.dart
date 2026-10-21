enum ReportStatus { draft, sent, responded }

class Report {
  final String id;
  final String title;
  final ReportStatus status;

  const Report({
    required this.id,
    required this.title,
    this.status = ReportStatus.draft,
  });
  Report copyWith({ReportStatus? status}) {
    return Report(id: id, title: title, status: status ?? this.status);
  }
}
