package com.nju.topology.entity;

import lombok.Data;

/**
 * ClassName: Task
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:20
 * @Description:
 */
@Data
public class Task {
    private int id;
    private int userId;
    private int topologyId;
    private int score;
}
