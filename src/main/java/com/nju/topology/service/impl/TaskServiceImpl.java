package com.nju.topology.service.impl;

import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.mapper.TaskMapper;
import com.nju.topology.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ClassName: TaskServiceImpl
 *
 * @Author: jiahz
 * @Date: 2023/6/27 18:14
 * @Description:
 */
@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskMapper taskMapper;

    @Override
    public Result<List<HistoryRecordDTO>> getHistoryList(int userId) {
        List<HistoryRecordDTO> historyRecords = taskMapper.getHistoryRecords(userId);
        if (historyRecords == null) {
            return Result.error("查看历史记录失败");
        } else {
            return Result.success(historyRecords);
        }
    }
}
