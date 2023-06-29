package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Node;
import com.nju.topology.service.NodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * ClassName: TelnetController
 *
 * @Author: jiahz
 * @Date: 2023/6/25 17:22
 * @Description:
 */
@RestController
@RequestMapping("/telnet")
public class TelnetController {

    @Autowired
    private NodeService nodeService;
    @PostMapping("/insert")
     public Result<String> InsertNode(@RequestBody Node node){
            return nodeService.addNode(node);
     }

     @PostMapping("/update")
    public Result<String> updateNode(@RequestBody Node node){return nodeService.updateNode(node);}

    @PostMapping("/delete")
    public Result<String> deleteNode(@RequestParam int id){
        return nodeService.deleteNode(id);
    }

}
