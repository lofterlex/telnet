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
    public Result<Integer> addNode(Node node) {
        nodeMapper.insert(node);
        return Result.success(node.getId());
    }

    @Override
    public Result<String> updateNode(Node node) {
        int res = nodeMapper.updateNode(node);
        if (res > 0) return Result.success("更新节点成功");
        else return Result.error("更新节点失败");
    }

    @Override
    public Result<String> deleteNode(int id) {
        int res = nodeMapper.deleteUserById(id);
        if (res > 0) return Result.success("删除用户成功");
        else return Result.error("删除用户失败");
    }


}
