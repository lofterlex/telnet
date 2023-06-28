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
    private Integer id;
    private Integer type;
    private String configuration;
    private Integer userId;
    private Integer taskId;
    private Integer score;
}
