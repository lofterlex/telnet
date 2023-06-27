package com.nju.topology.mapper;

import com.nju.topology.dto.HistoryRecordDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * InterfaceName: TaskMapper
 *
 * @Author: jiahz
 * @Date: 2023/6/27 18:15
 * @Description:
 */
@Mapper
public interface TaskMapper {

    List<HistoryRecordDTO> getHistoryRecords(@Param("id") int id);
}
