package com.nju.topology.mapper;

import com.nju.topology.entity.Node;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NodeMapper {
    int insertNode(Node node);
    int updateNode(Node node);
    int deleteUserById(@Param("id") int id);
}
