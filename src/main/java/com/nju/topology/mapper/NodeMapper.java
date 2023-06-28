package com.nju.topology.mapper;

import com.nju.topology.entity.Node;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NodeMapper {
    int insertNode(Node node);
    int updateNode(Node node);
}
