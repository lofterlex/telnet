package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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
    public ResponseEntity<String> login(@RequestParam String studentId, @RequestParam String password, HttpServletRequest request) {
        if(studentId.equals("admin")) {
            if(password.equals("123")) {
                return ResponseEntity.ok("admin");
            }else {
                String errorMessage = "学号或密码不正确";
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
            }
        }
        if(studentId.equals("user")) {
            if(password.equals("123")) {
                return ResponseEntity.ok("user");
            }else {
                String errorMessage = "学号或密码不正确";
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
            }
        }
        Result<User> result = userService.login(Integer.parseInt(studentId), password);
        if (result.getCode() == 1) {
            User user = result.getData();
            request.getSession().setAttribute("userId", result.getData().getId());
            if(user.getType() == 0)
                return ResponseEntity.ok("admin");
            else return ResponseEntity.ok("user");
        } else {
            String errorMessage = "学号或密码不正确";
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
        }
    }
}
