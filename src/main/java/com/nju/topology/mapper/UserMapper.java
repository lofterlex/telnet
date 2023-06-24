package com.nju.topology.mapper;

import com.nju.topology.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    List<User> getUserList();

    int updateUser(User user);

    int deleteUserById(@Param("id") int id);

}
