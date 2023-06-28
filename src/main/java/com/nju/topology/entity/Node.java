package com.nju.topology.entity;

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
    private String command;
    private Integer topology_id;
}
