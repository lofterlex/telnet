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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    // 学工号
    private int studentId;
    // 姓名
    private String name;
    // 密码
    private String password;

    public User(int studentId, String name, String password, int type) {
        this.studentId = studentId;
        this.name = name;
        this.password = password;
        this.type = type;
    }

    // 0-管理员；1-普通用户
    private int type;
}
