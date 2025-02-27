package com.nju.topology.controller;

import com.alibaba.fastjson.JSON;
import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.dto.ScoreListDTO;
import com.nju.topology.entity.Task;
import com.nju.topology.entity.TopoData;
import com.nju.topology.entity.Topology;
import com.nju.topology.entity.User;
import com.nju.topology.service.TaskService;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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

    // 主页面（历史记录）：获取历史记录
    @GetMapping("/history")
    public ResponseEntity<List<HistoryRecordDTO>> getHistoryList(@RequestParam int id) {
        Result<List<HistoryRecordDTO>> result = taskService.getHistoryList(id);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    // 主页面（历史记录）：查看配置
    @GetMapping("/getConfig")
    @ResponseBody
    public Map<String, Object> getConfig(@RequestParam int id) throws Exception {
        Result<Topology> result = taskService.getTopologyById(id);
        List<Map<String, Object>> nodeList = taskService.getNodes(id);
        Map<String, Object> map = new HashMap<>();
        String config = result.getData().getConfiguration();
        String nodes = JSON.toJSONString(nodeList);
        map.put("nodes", nodes);
        map.put("config", config);
        return map;
    }

    @GetMapping("/toExamine")
    public ModelAndView examine(@RequestParam int topologyId) throws Exception {
        Result<Topology> result = taskService.getTopologyById(topologyId);
        List<Map<String, Object>> nodeList = taskService.getNodes(topologyId);
        String config = result.getData().getConfiguration();
        String nodes = JSON.toJSONString(nodeList);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("examine");
        mv.addObject("nodes", nodes);
        mv.addObject("config", config);
        return mv;
    }


    // 任务管理页面：新增任务
    @PostMapping("/addTask")
    public ResponseEntity<String> addTask(@RequestParam String name,
                                          @RequestParam String description) {
        Result<String> result = taskService.addTask(name, description);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    // 任务管理页面：删除任务
    @PostMapping("/deleteTask")
    public ResponseEntity<String> addTask(@RequestParam int id) {
        Result<String> result = taskService.deleteTask(id);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    // 任务管理页面：获取任务列表
    @GetMapping("/toTask")
    public ModelAndView getTaskList() {
        Result<List<Task>> result = taskService.getTaskList();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin");
        mv.addObject("taskList", result.getData());
        return mv;
    }

    @GetMapping("/toUserTask")
    public ModelAndView getUserTaskList() {
        Result<List<Task>> result = taskService.getTaskList();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("task");
        mv.addObject("taskList", result.getData());
        return mv;
    }

    // 成绩管理页面：获取成绩列表
    @GetMapping("/toScore")
    public ModelAndView getScoreList(@RequestParam int id) {
        // 入参为task_id
        Result<List<ScoreListDTO>> result = taskService.getScoreList(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userManage");
        mv.addObject("scoreList", result.getData());
        int[] score_count = new int[5];
        for (ScoreListDTO dto : result.getData()) {
            int score = dto.getScore();
            if (score < 60) {
                score_count[0]++;
            } else if (score < 70) {
                score_count[1]++;
            } else if (score < 80) {
                score_count[2]++;
            } else if (score < 90) {
                score_count[3]++;
            } else {
                score_count[4]++;
            }
        }
        ArrayList<Integer> scoreCount = new ArrayList<>();
        for (int i : score_count) {
            scoreCount.add(i);
        }
        mv.addObject("scoreCount", scoreCount);
        return mv;
    }

    // 主页面：作业说明
    @GetMapping("/getTask")
    public ResponseEntity<Task> getTaskById(@RequestParam int id) {
        Result<Task> result = taskService.getTaskById(id);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }
}
