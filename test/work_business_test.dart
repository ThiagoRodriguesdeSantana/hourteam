import 'package:flutter_test/flutter_test.dart';
import 'package:hourteam/business/work_business.dart';
import 'package:hourteam/locale_br.dart';
import 'package:hourteam/models/Work.dart';
import 'package:hourteam/repository/register_repo/register_repository_interface.dart';
import 'package:hourteam/repository/work_repo/work_repository_interface.dart';
import 'package:mockito/mockito.dart';

class IWorkRepositoryMock extends Mock implements IWorkRepository {}

class IRegisterRepositoryMock extends Mock implements IRegisterRepository {}

void main() {
  test("createNewWork - " + work_already_exists, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");

    when(workMock.findByName(workObj.name)).thenAnswer((_) async => workObj);

    var business = WorkBusiness(workMock, registerMock);

    expect(() => business.createNewWork(workObj), throwsException);
  });

  test("createNewWork - " + work_without_name, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("");

    when(workMock.findByName(workObj.name)).thenAnswer((_) async => null);

    var business = WorkBusiness(workMock, registerMock);

    expect(() => business.createNewWork(workObj), throwsException);
  });

  test("createNewWork - " + work_error_insert, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");

    when(workMock.findByName(workObj.name)).thenAnswer((_) async => null);

    when(workMock.addWork(workObj)).thenAnswer((_) async => false);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.createNewWork(workObj);

    expect(reposne.success, false);
  });
  test("createNewWork - " + success, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");

    when(workMock.findByName(workObj.name)).thenAnswer((_) async => null);

    when(workMock.addWork(workObj)).thenAnswer((_) async => true);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.createNewWork(workObj);

    expect(reposne.success, true);
  });

  test("alterWork - " + work_error_update, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");

    when(workMock.updateWork(workObj)).thenAnswer((_) async => false);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.alterWork(workObj);

    expect(reposne.mensage, work_error_update);
  });

  test("alterWork - " + success, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");

    when(workMock.updateWork(workObj)).thenAnswer((_) async => true);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.alterWork(workObj);

    expect(reposne.success, true);
  });

  test("alterWork - " + success, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");

    when(workMock.updateWork(workObj)).thenAnswer((_) async => true);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.alterWork(workObj);

    expect(reposne.success, true);
  });

  test("removeWork - " + register_error_remove, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");
    workObj.id = 1;

    when(registerMock.deleteAllRegister(workObj.id))
        .thenAnswer((_) async => false);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.removeWork(workObj);

    expect(reposne.mensage, register_error_remove);
  });

  test("removeWork - " + work_error_remove, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");
    workObj.id = 1;

    when(registerMock.deleteAllRegister(workObj.id))
        .thenAnswer((_) async => true);

    when(workMock.deleteWork(workObj)).thenAnswer((_) async => false);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.removeWork(workObj);

    expect(reposne.mensage, work_error_remove);
  });

  test("removeWork - " + success, () async {
    var workMock = IWorkRepositoryMock();
    var registerMock = IRegisterRepositoryMock();

    var workObj = Work("work test");
    workObj.id = 1;

    when(registerMock.deleteAllRegister(workObj.id))
        .thenAnswer((_) async => true);

    when(workMock.deleteWork(workObj)).thenAnswer((_) async => true);

    var business = WorkBusiness(workMock, registerMock);

    var reposne = await business.removeWork(workObj);

    expect(reposne.mensage, success);
  });
}
