package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * ClassName: UserController
 *
 * @Author: jiahz
 * @Date: 2023/6/23 23:01
 * @Description:
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/list")
    public Result<List<User>> getUserList() {
        Result<List<User>> result = userService.getUserList();
        return result;
    }

    @PostMapping("/add")
    public Result<String> addUser(@RequestBody User user) {
        Result<String> result = userService.addUser(user);
        return result;
    }

    @PostMapping("/update")
    public Result<String> updateUser(@RequestBody User user) {
        Result<String> result = userService.updateUser(user);
        return result;
    }

    @PostMapping("/delete")
    public Result<String> deleteUser(@RequestParam int id) {
        Result<String> result = userService.deleteUser(id);
        return result;
    }

}
