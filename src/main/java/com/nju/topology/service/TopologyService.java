package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Topology;

/**
 * InterfaceName: TopologyService
 *
 * @Author: jiahz
 * @Date: 2023/6/29 00:03
 * @Description:
 */

public interface TopologyService {
    Result<String> updateScore(int id, int score);

    Result<String> addTopology(Topology topology);
}
