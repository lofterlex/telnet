package com.nju.topology.entity;

import lombok.Data;

/**
 * ClassName: User
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:17
 * @Description:
 */
@Data
public class User {
    private int id;
    private int studentId;
    private String name;
    private String password;
    private int type;
}
