package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Node;

public interface NodeService {
    public Result<String> addNode(Node node);
}
