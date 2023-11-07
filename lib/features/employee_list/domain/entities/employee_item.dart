enum EmployeeRole {
  productDesigner("Product Designer"),
  flutterDeveloper("Flutter Developer"),
  qaTester("QA Tester"),
  productOwner("Product Owner");

  const EmployeeRole(this.roleDisplayName);
  final String roleDisplayName;
}

class EmployeeItemEntity {
  final int id;
  final String name;
  final EmployeeRole role;
  final DateTime startDate;
  final DateTime? endDate;

  EmployeeItemEntity(
      {required this.id,
      required this.name,
      required this.role,
      required this.startDate,
      this.endDate});
}
