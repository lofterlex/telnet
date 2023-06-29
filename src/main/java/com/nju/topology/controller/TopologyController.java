package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.entity.Node;
import com.nju.topology.entity.Task;
import com.nju.topology.entity.Topology;
import com.nju.topology.service.NodeService;
import com.nju.topology.service.TaskService;
import com.nju.topology.service.TopologyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PreDestroy;
import java.util.List;

/**
 * ClassName: TopologyController
 *
 * @Author: jiahz
 * @Date: 2023/6/25 17:22
 * @Description:
 */
@Controller
public class TopologyController {

    @Autowired
    private NodeService nodeService;
    @Autowired
    private TopologyService topologyService;
    @Autowired
    private TaskService taskService;

    // 跳转至主页面
    @GetMapping("/toMain")
    public ModelAndView toMain(@RequestParam int userId, @RequestParam int taskId) {
        ModelAndView mv = new ModelAndView();
        Result<List<HistoryRecordDTO>> historyRecords = taskService.getHistoryList(userId);
        Result<Task> taskDesc = taskService.getTaskById(taskId);

        mv.setViewName("main");
        mv.addObject("historyList", historyRecords.getData());
        mv.addObject("taskDesc", taskDesc.getData());
        return mv;
    }

    // 该方法返回值为添加的节点id，可以在前端将id绑定到key
    @PostMapping("/addNode")
    public ResponseEntity<Integer> addNode(@RequestParam String name,
                                           @RequestParam String ip,
                                           @RequestParam int port,
                                           @RequestParam int type) {
        Node node = new Node();
        node.setName(name);
        node.setIp(ip);
        node.setPort(port);
        node.setType(type);
        Result<Integer> result = nodeService.addNode(node);
        return ResponseEntity.ok(result.getData());
    }

    @PostMapping("/addTopology")
    public ResponseEntity<String> addTopology(@RequestParam int type,
                                              @RequestParam String configuration,
                                              @RequestParam int userId,
                                              @RequestParam int taskId
    ) {
        Topology topology = new Topology();
        topology.setType(type);
        topology.setConfiguration(configuration);
        topology.setUserId(userId);
        topology.setTaskId(taskId);
        Result<String> result = topologyService.addTopology(topology);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    @PostMapping("/updateNode")
    public Result<String> updateNode(@RequestBody Node node) {
        return nodeService.updateNode(node);
    }

    @PostMapping("/deleteNode")
    public Result<String> deleteNode(@RequestParam int id) {
        return nodeService.deleteNode(id);
    }

    @PostMapping("/updateScore")
    public ResponseEntity<String> updateScore(@RequestParam int id, @RequestParam int score) {
        Result<String> result = topologyService.updateScore(id, score);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }


}
