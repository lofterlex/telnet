package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Node;
import com.nju.topology.mapper.NodeMapper;
import com.nju.topology.service.NodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NodeServiceImpl implements NodeService {

    @Autowired
    private NodeMapper nodeMapper;
    @Override
    public Result<String> addNode(Node node) {
        int res = nodeMapper.insertNode(node);
        if (res > 0) return Result.success("新增节点成功");
        else return Result.error("新增节点失败");
    }

}
