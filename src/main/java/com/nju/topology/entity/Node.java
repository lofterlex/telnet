package com.nju.topology.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.sun.org.apache.xpath.internal.operations.Or;
import lombok.Data;

import java.time.Period;

/**
 * ClassName: Node
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:20
 * @Description:
 */
@Data
public class Node {
    private Integer id;
    private String name;
    private String ip;
    private Integer port;
    private Integer type;
    private Integer topology_id;

    public Node(Integer id, String name, String ip, Integer port, Integer type, Integer topology_id) {
        this.id = id;
        this.name = name;
        this.ip = ip;
        this.port = port;
        this.type = type;
        this.topology_id = topology_id;
    }
}
