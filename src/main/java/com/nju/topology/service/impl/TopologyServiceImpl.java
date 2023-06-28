package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Topology;
import com.nju.topology.mapper.TopologyMapper;
import com.nju.topology.service.TopologyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public Result<String> updateScore(int id, int score) {
        Topology topology = new Topology();
        topology.setScore(score);
        topology.setId(id);
        int res = topologyMapper.updateById(topology);
        if (res > 0) return Result.success("修改分数成功");
        else return Result.error("修改分数失败");
    }
}
