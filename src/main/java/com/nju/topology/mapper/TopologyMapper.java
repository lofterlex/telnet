package com.nju.topology.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nju.topology.entity.Topology;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * InterfaceName: TopologyMapper
 *
 * @Author: jiahz
 * @Date: 2023/6/29 00:02
 * @Description:
 */
@Mapper
public interface TopologyMapper extends BaseMapper<Topology> {

    int updateTopologyId(@Param("ids") List<Integer> ids, @Param("id") int id);
}
