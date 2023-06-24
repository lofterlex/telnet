package com.nju.topology.entity;

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
    private int id;
    private String name;
    private String ip;
    private int port;
    private int type;
    private String command;
    private int topologyId;
}
