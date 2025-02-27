package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Topology;

import java.util.List;
import java.util.Map;

/**
 * InterfaceName: TopologyService
 *
 * @Author: jiahz
 * @Date: 2023/6/29 00:03
 * @Description:
 */

public interface TopologyService {
    Result<String> updateScore(int id, int score);

    Result<Integer> addTopology(Topology topology);

    Result<String> updateTopologyId(List<Integer> ids, int id);

}
