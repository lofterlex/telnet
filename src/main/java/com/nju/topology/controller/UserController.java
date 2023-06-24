package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping
    public String test() {
        return "test";
    }

    @PostMapping("/add")
    public Result<String> addUser(@RequestBody User user) {
        Result<String> result = userService.addUser(user);
        return result;
    }
}
