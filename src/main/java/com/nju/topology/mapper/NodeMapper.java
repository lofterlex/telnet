package com.nju.topology.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nju.topology.entity.Node;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NodeMapper extends BaseMapper<Node> {
    int insertNode(Node node);
    int updateNode(Node node);
    int deleteUserById(@Param("id") int id);
}
