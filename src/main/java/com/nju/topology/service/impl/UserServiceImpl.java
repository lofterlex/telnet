package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.mapper.UserMapper;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
