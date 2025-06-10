class Redacao {
  final String aluno;
  final String tema;
  final DateTime dataEnvio;
  final String status;
  final int? nota;

  Redacao({
    required this.aluno,
    required this.tema,
    required this.dataEnvio,
    required this.status,
    this.nota,
  });
}