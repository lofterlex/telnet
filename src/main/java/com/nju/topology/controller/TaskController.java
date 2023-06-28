package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.entity.Topology;
import com.nju.topology.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * ClassName: TaskController
 *
 * @Author: jiahz
 * @Date: 2023/6/26 22:59
 * @Description:
 */
@Controller
@RequestMapping("/task")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @GetMapping("/history")
    public Result<List<HistoryRecordDTO>> getHistoryList(@RequestParam int id, Model model) {
        Result<List<HistoryRecordDTO>> historyList = taskService.getHistoryList(id);
        model.addAttribute("map", historyList.getMap());
        return historyList;
    }

    @GetMapping("/config")
    public Result<String> getConfigMsg(@RequestParam int id, Model model) {
        Result<String> message = taskService.getConfigurationMessage(id);
        model.addAttribute("map", message.getMap());
        return message;
    }
}
