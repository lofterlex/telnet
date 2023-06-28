package com.nju.topology.common;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/**
 * ClassName: Result
 *
 * @Author: jiahz
 * @Date: 2023/6/24 10:56
 * @Description: 统一返回格式
 */
@Data
public class Result<T> {

    private Map<String, Object> map = new HashMap<>();

//    private Integer code; //编码：1成功，0失败
//
//    private String msg; //信息
//
//    private T data; //数据


    public static <T> Result<T> success(T object) {
        Result<T> r = new Result<T>();
        r.map.put("code", 1);
        r.map.put("data", object);
        return r;
    }

    public static <T> Result<T> error(String msg) {
        Result r = new Result();
        r.map.put("msg", msg);
        r.map.put("code", 0);
        return r;
    }

    public T getData() {
        return data;
    }
}

