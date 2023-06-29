package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.entity.Node;

public interface NodeService {
    Result<Integer> addNode(Node node);

    Result<String> updateNode(Node node);

    Result<String> deleteNode(int id);

}
