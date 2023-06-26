package com.nju.topology.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * ClassName: HomeController
 *
 * @Author: jiahz
 * @Date: 2023/6/25 16:50
 * @Description:
 */
@Controller
public class HomeController {

    @GetMapping("/")
    public String getIndexPage() {
        return "main";
    }
    @GetMapping("/login")
    public String getLoginPage() {
        return "login";
    }

    @GetMapping("/manage")
    public String getManagePage() {
        return "userManage";
    }

    @GetMapping("/admin")
    public String getAdminPage() {
        return "admin";
    }

    @GetMapping("/user")
    public String getUserPage() {
        return "user";
    }

}
