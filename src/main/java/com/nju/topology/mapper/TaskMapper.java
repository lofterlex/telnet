package com.nju.topology.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.dto.ScoreListDTO;
import com.nju.topology.entity.Task;
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
public interface TaskMapper extends BaseMapper<Task> {

    List<HistoryRecordDTO> getHistoryRecords(@Param("id") int id);

    String getConfigurationMessage(@Param("id") int id);

    List<ScoreListDTO> getScoreList(@Param("id") int id);

}
