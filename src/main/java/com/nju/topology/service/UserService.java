package com.nju.topology.service;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * InterfaceName: UserService
 *
 * @Author: jiahz
 * @Date: 2023/6/24 11:01
 * @Description:
 */

public interface UserService {


    Result<String> addUser(User user);

    Result<List<User>> getUserList();

    Result<String> updateUser(User user);

    Result<String> deleteUser(int id);


}
