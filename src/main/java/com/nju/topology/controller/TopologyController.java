package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Node;
import com.nju.topology.service.NodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * ClassName: TopologyController
 *
 * @Author: jiahz
 * @Date: 2023/6/25 17:22
 * @Description:
 */
@Controller
@RequestMapping("/topolpgy")
public class TopologyController {

    @Autowired
    private NodeService nodeService;
    @PostMapping("/insert")
     public Result<String> InsertNode(@RequestBody Node node){
            return nodeService.addNode(node);
     }
}
