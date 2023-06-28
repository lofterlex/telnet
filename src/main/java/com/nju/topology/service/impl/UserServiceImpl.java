package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.mapper.UserMapper;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.List;

/**
 * ClassName: UserServiceImpl
 *
 * @Author: jiahz
 * @Date: 2023/6/24 11:03
 * @Description:
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Result<String> addUser(User user) {
        int res = userMapper.insertUser(user);
        if (res > 0) return Result.success("新增用户成功");
        else return Result.error("新增用户失败");
    }

    @Override
    public Result<List<User>> getUserList() {
        List<User> res = userMapper.getUserList();
        return Result.success(res);
    }

    @Override
    public Result<String> updateUser(User user) {
        int res = userMapper.updateUser(user);
        if (res > 0) return Result.success("修改用户成功");
        else return Result.error("修改用户失败");
    }

    @Override
    public Result<String> deleteUser(int id) {
        int res = userMapper.deleteUserById(id);
        if (res > 0) return Result.success("删除用户成功");
        else return Result.error("删除用户失败");
    }

    @Override
    public Result<User> login(int studentId, String password) {
        User user = userMapper.getUserByStudentId(studentId);
        if (user == null) {
            return Result.error("用户名或密码错误，登陆失败");
        }
        if (!user.getPassword().equals(password)) {
            return Result.error("用户名或密码错误，登陆失败");
        }
        return Result.success(user);
    }
}
