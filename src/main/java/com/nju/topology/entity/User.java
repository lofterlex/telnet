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
    // 用户id
    private int id;
    // 学工号
    private int studentId;
    // 姓名
    private String name;
    // 密码
    private String password;
    // 0-管理员；1-普通用户
    private int type;
}
