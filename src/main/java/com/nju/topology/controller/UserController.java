package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * ClassName: UserController
 *
 * @Author: jiahz
 * @Date: 2023/6/23 23:01
 * @Description:
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/toUser")
    public ModelAndView getUserList() {
        Result<List<User>> result = userService.getUserList();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user");
        mv.addObject("userList", result.getData());
        return mv;
    }

    @PostMapping("/addUser")
    public ResponseEntity<String> addUser(
                                          @RequestParam int studentId,
                                          @RequestParam String name,
                                          @RequestParam String password,
                                          @RequestParam int type) {
        Result<String> result = userService.addUser(new User(studentId, name, password, type));
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    @PostMapping("/updateUser")
    public ResponseEntity<String> updateUser(@RequestParam int id,
                                     @RequestParam int studentId,
                                     @RequestParam String name,
                                     @RequestParam String password,
                                     @RequestParam int type) {
        User user = new User(studentId, name, password, type);
        user.setId(id);
        Result<String> result = userService.updateUser(user);
        if (result.getCode() == 1)
            return ResponseEntity.ok(result.getData());
        else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result.getData());
    }

    @PostMapping("/deleteUser")
    public ResponseEntity<String> deleteUser(@RequestParam int id) {
        Result<String> result = userService.deleteUser(id);
        if (result.getCode() == 1) {
            return ResponseEntity.ok(result.getData());
        } else {
            String errorMessage = result.getData();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
        }
    }
}
