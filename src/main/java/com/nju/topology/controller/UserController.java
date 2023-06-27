package com.nju.topology.controller;

import com.nju.topology.common.Result;
import com.nju.topology.entity.User;
import com.nju.topology.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * ClassName: UserController
 *
 * @Author: jiahz
 * @Date: 2023/6/23 23:01
 * @Description:
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;


    @GetMapping("/list")
    public String getUserList(Model model) {
        Result<List<User>> userList = userService.getUserList();
        model.addAttribute("map", userList.getMap());
        return "user";
    }


    @PostMapping("/add")
    public Result<String> addUser(@RequestBody User user, Model model) {
        Result<String> result = userService.addUser(user);
        model.addAttribute("map", result.getMap());
        return result;
    }

    @PostMapping("/update")
    public Result<String> updateUser(@RequestBody User user, Model model) {
        Result<String> result = userService.updateUser(user);
        model.addAttribute("map", result.getMap());
        return result;
    }

    @PostMapping("/delete")
    public Result<String> deleteUser(@RequestParam int id, Model model) {
        Result<String> result = userService.deleteUser(id);
        model.addAttribute("map", result.getMap());
        return result;
    }

}
