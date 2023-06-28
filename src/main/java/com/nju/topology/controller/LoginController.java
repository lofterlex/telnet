package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * ClassName: LoginController
 *
 * @Author: jiahz
 * @Date: 2023/6/25 23:41
 * @Description:
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result<User> login(@RequestBody User user, HttpServletRequest request) {
        Result<User> result = userService.login(user.getStudentId(), user.getPassword());
        if (result.getData() != null) {
            request.getSession().setAttribute("user", result.getData().getId());
        }
        ModelAndView mv = new ModelAndView();
        return result;
    }
}
