package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.entity.Task;
import com.nju.topology.entity.Topology;
import com.nju.topology.entity.User;
import com.nju.topology.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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
public class TaskController {

    @Autowired
    private TaskService taskService;

    @GetMapping("/history")
    public ResponseEntity<List<HistoryRecordDTO>> getHistoryList(@RequestParam int id) {
        Result<List<HistoryRecordDTO>> result = taskService.getHistoryList(id);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    @GetMapping("/config")
    public ResponseEntity<String> getConfigMsg(@RequestParam int id) {
        Result<String> result = taskService.getConfigurationMessage(id);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    @PostMapping("/addTask")
    public ResponseEntity<String> addTask(@RequestParam String name,
                                          @RequestParam String desc) {
        Result<String> result = taskService.addTask(name, desc);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    @GetMapping("/toTask")
    public ModelAndView getTaskList() {
        Result<List<Task>> result = taskService.getTaskList();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin");
        mv.addObject("taskList", result.getData());
        return mv;
    }

//    @GetMapping("/toScore")
//    public ModelAndView getScoreList(@RequestParam int id) {
//
//    }


}
