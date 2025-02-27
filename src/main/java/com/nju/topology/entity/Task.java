package com.nju.topology.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * ClassName: Task
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:20
 * @Description:
 */
@Data
public class Task {
    private Integer id;
    private String name;
    private String description;

}
