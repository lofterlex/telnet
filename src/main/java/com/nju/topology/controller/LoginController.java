package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * ClassName: LoginController
 *
 * @Author: jiahz
 * @Date: 2023/6/25 23:41
 * @Description:
 */
@RestController
public class LoginController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result<User> login(@RequestBody User user) {
        Result<User> result = userService.login(user.getStudentId(), user.getPassword());
//        if (result.getData() != null) {
//            request.getSession().setAttribute("user", result.getData().getId());
//        }
        return result;
    }
}
