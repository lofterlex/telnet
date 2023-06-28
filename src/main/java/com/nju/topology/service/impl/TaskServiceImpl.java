package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.dto.ScoreListDTO;
import com.nju.topology.entity.Task;
import com.nju.topology.mapper.TaskMapper;
import com.nju.topology.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ClassName: TaskServiceImpl
 *
 * @Author: jiahz
 * @Date: 2023/6/27 18:14
 * @Description:
 */
@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskMapper taskMapper;

    @Override
    public Result<List<HistoryRecordDTO>> getHistoryList(int userId) {
        List<HistoryRecordDTO> historyRecords = taskMapper.getHistoryRecords(userId);
        if (historyRecords == null) {
            return Result.error("查看历史记录失败");
        } else {
            return Result.success(historyRecords);
        }
    }

    @Override
    public Result<String> getConfigurationMessage(int id) {
        String message = taskMapper.getConfigurationMessage(id);
        if ("".equals(message)) {
            return Result.error("配置信息为空，请重新配置");
        } else {
            return Result.success(message);
        }
    }

    @Override
    public Result<String> addTask(String name, String desc) {
        Task task = new Task();
        task.setName(name);
        task.setDescription(desc);
        int res = taskMapper.insert(task);
        if (res > 0) {
            return Result.success("新增任务成功");
        } else {
            return Result.error("新增任务失败");
        }
    }

    @Override
    public Result<List<Task>> getTaskList() {
        List<Task> tasks = taskMapper.selectList(null);
        return Result.success(tasks);
    }

    @Override
    public Result<List<ScoreListDTO>> getScoreList(int id) {
        List<ScoreListDTO> scoreList = taskMapper.getScoreList(id);
        return Result.success(scoreList);
    }

}
