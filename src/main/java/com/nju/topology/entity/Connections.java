package com.nju.topology.entity;

import lombok.Data;

/**
 * ClassName: Connections
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:22
 * @Description:
 */
@Data
public class Connections {
    private int id;
    private int topologyId;
    private int node1Id;
    private int node2Id;
}
