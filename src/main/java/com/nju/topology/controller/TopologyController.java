package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.entity.Node;
import com.nju.topology.entity.Task;
import com.nju.topology.entity.Topology;
import com.nju.topology.service.NodeService;
import com.nju.topology.service.TaskService;
import com.nju.topology.service.TopologyService;
import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PreDestroy;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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

    @PostMapping("/addNode")
    public ResponseEntity<Map<String, Object>> addNode(@RequestParam String name,
                                           @RequestParam String ip,
                                           @RequestParam int port,
                                           @RequestParam int key,
                                           @RequestBody Map<String, Object> config
    ) {
        int type = 0;
        List<Map<String, Object>> nodeDataArray = (List<Map<String, Object>>) config.get("nodeDataArray");
        for (Map<String, Object> map : nodeDataArray) {
            if ((int) map.get("key") == key) {
                // 确认当前节点的类别
                String category = (String) map.get("category");
                if (category.equals("router")) {
                    type = 0;
                } else if (category.equals("switch")) {
                    type = 1;
                } else {
                    type = 2;
                }
                // 修改json中的text字段
                map.put("text", name);
            }
        }

        // 添加节点到数据库
        Node node = new Node();
        node.setId(Math.abs(key));
        node.setName(name);
        node.setIp(ip);
        node.setPort(port);
        node.setType(type);
        nodeService.addNode(node);

        // 返回更新后的json配置
        return ResponseEntity.ok(config);
    }

    @PostMapping("/addTopology")
    public ResponseEntity<String> addTopology(@RequestParam int type,
                                              @RequestParam int userId,
                                              @RequestParam int taskId,
                                              @RequestBody Map<String, Object> config
    ) {
        Topology topology = new Topology();
        topology.setType(type);
        topology.setConfiguration(config.toString());
        topology.setUserId(userId);
        topology.setTaskId(taskId);
        int topologyId = topologyService.addTopology(topology).getData();

        //从json中获取ids（List）
        List<Integer> ids = new ArrayList<>();
        List<Map<String, Object>> nodeDataArray = (List<Map<String, Object>>) config.get("nodeDataArray");
        for (Map<String, Object> map : nodeDataArray) {
            int id = (int) map.get("key");
            ids.add(Math.abs(id));
        }
        topologyService.updateTopologyId(ids, topologyId);
        return ResponseEntity.ok("添加拓扑成功");
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
