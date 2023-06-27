package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.entity.Topology;
import com.nju.topology.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * ClassName: TaskController
 *
 * @Author: jiahz
 * @Date: 2023/6/26 22:59
 * @Description:
 */
@RestController
@RequestMapping("/task")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @GetMapping("/history")
    public Result<List<HistoryRecordDTO>> getHistoryList(@RequestParam int id) {
        Result<List<HistoryRecordDTO>> historyList = taskService.getHistoryList(id);
        return historyList;
    }

    @GetMapping("/configmsg/{id}")
    public Result<String> getConfigMsg(@RequestParam int id) {
        Result<String> message = taskService.getConfigurationMessage(id);
        return message;
    }
}
