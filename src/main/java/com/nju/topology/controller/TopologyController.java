package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Node;
import com.nju.topology.service.NodeService;
import com.nju.topology.service.TopologyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/addNode")
     public Result<String> InsertNode(@RequestBody Node node){
            return nodeService.addNode(node);
     }

     @PostMapping("/updateScore")
    public ResponseEntity<String> updateScore(@RequestParam int id, @RequestParam int score) {
        Result<String> result = topologyService.updateScore(id, score);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }
}
