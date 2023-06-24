package com.nju.topology.mapper;

import com.nju.topology.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * ClassName: UserMapper
 *
 * @Author: jiahz
 * @Date: 2023/6/24 11:05
 * @Description:
 */
@Mapper
public interface UserMapper {
    int insertUser(User user);
}
