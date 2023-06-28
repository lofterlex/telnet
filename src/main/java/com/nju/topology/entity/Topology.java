package com.nju.topology.entity;

import lombok.Data;

/**
 * ClassName: Topology
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:19
 * @Description:
 */
@Data
public class Topology {
    private int id;
    private int type;
    private String configuration;
    private int userId;
    private int taskId;
    private int score;
}
