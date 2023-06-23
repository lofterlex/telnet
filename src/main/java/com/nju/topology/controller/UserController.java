package com.nju.topology.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @GetMapping
    public String test() {
        return "test";
    }
}
