package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.dto.ScoreListDTO;
import com.nju.topology.entity.Task;

import java.util.List;

/**
 * InterfaceName: TaskService
 *
 * @Author: jiahz
 * @Date: 2023/6/27 18:12
 * @Description:
 */
public interface TaskService {

    Result<List<HistoryRecordDTO>> getHistoryList(int userId);

    Result<String> getConfigurationMessage(int id);

    Result<String> addTask(String name, String desc);

    Result<List<Task>> getTaskList();

    Result<List<ScoreListDTO>> getScoreList(int id);

}
