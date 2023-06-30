package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.dto.ScoreListDTO;
import com.nju.topology.entity.Task;
import com.nju.topology.entity.Topology;

import java.util.List;
import java.util.Map;

/**
 * InterfaceName: TaskService
 *
 * @Author: jiahz
 * @Date: 2023/6/27 18:12
 * @Description:
 */
public interface TaskService {

    Result<List<HistoryRecordDTO>> getHistoryList(int userId);

    Result<Topology> getTopologyById(int id);

    List<Map<String, Object>> getNodes(int id);

    Result<String> addTask(String name, String desc);

    Result<String> deleteTask(int id);

    Result<List<Task>> getTaskList();

    Result<List<ScoreListDTO>> getScoreList(int id);

    Result<Task> getTaskById(int id);

}
