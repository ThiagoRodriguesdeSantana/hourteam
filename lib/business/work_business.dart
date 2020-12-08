import 'dart:io';

import 'package:hourteam/locale_br.dart';
import 'package:hourteam/models/Work.dart';
import 'package:hourteam/models/validation_response.dart';
import 'package:hourteam/repository/register_repo/register_repository_interface.dart';
import 'package:hourteam/repository/work_repo/work_repository_interface.dart';

class WorkBusiness {
  final IWorkRepository workRepository;
  final IRegisterRepository registerRepository;

  WorkBusiness(this.workRepository, this.registerRepository);

  Future<ValidationResponse> createNewWork(Work work) async {
    var exists = await alreadyExiste(work);

    print(exists);
    if (exists) {
      throw new Exception(work_already_exists);
    }

    if (work.name.isEmpty) {
      throw new Exception(work_without_name);
    }

    var result = await this.workRepository.addWork(work);

    if (!result) {
      return ValidationResponse(false, success, 500);
    }

    return ValidationResponse(true, success, 200);
  }

  Future<bool> alreadyExiste(Work work) async {
    var result = await this.workRepository.findByName(work.name);

    return result != null;
  }

  Future<ValidationResponse> alterWork(Work work) async {
    if (work.name.isEmpty) {
      throw new Exception(work_without_name);
    }

    var response = await this.workRepository.updateWork(work);
    if (!response) {
      return ValidationResponse(false, work_error_update, 500);
    }

    return ValidationResponse(true, success, 200);
  }

  Future<ValidationResponse> removeWork(Work work) async {
    var resp = await this.registerRepository.deleteAllRegister(work.id);

    if (!resp) {
      return ValidationResponse(false, register_error_remove, 500);
    }

    var isRemovedWork = await this.workRepository.deleteWork(work);

    if (!isRemovedWork) {
      return ValidationResponse(false, work_error_remove, 500);
    }

    return ValidationResponse(true, success, 200);
  }

  Future<List<Work>> listWorks() async {
    var listFake = new List<Work>();

    listFake = await this.workRepository.getAllWorks();

    return listFake;
  }
}
