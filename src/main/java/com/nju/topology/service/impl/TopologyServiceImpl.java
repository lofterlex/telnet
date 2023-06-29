package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Topology;
import com.nju.topology.mapper.NodeMapper;
import com.nju.topology.mapper.TopologyMapper;
import com.nju.topology.service.TopologyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * ClassName: TopologyServiceImpl
 *
 * @Author: jiahz
 * @Date: 2023/6/29 00:03
 * @Description:
 */
@Service
public class TopologyServiceImpl implements TopologyService {

    @Autowired
    private TopologyMapper topologyMapper;

    @Autowired
    private NodeMapper nodeMapper;

    @Override
    public Result<String> updateScore(int id, int score) {
        Topology topology = new Topology();
        topology.setScore(score);
        topology.setId(id);
        int res = topologyMapper.updateById(topology);
        if (res > 0) return Result.success("修改分数成功");
        else return Result.error("修改分数失败");
    }

    @Override
    public Result<Integer> addTopology(Topology topology) {
        topologyMapper.insert(topology);
        return Result.success(topology.getId());
    }

    @Override
    public Result<String> updateTopologyId(List<Integer> ids, int id) {
        int res = topologyMapper.updateTopologyId(ids, id);
        if (res > 0) return Result.success("修改拓扑id成功");
        else return Result.error("修改拓扑id失败");
    }

}
