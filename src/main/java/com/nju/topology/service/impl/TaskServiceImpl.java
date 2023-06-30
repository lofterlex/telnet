package com.nju.topology.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.nju.topology.common.Result;
import com.nju.topology.dto.HistoryRecordDTO;
import com.nju.topology.dto.ScoreListDTO;
import com.nju.topology.entity.Node;
import com.nju.topology.entity.Task;
import com.nju.topology.entity.Topology;
import com.nju.topology.mapper.NodeMapper;
import com.nju.topology.mapper.TaskMapper;
import com.nju.topology.mapper.TopologyMapper;
import com.nju.topology.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Wrapper;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    private NodeMapper nodeMapper;

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private TopologyMapper topologyMapper;

    @Override
    public Result<List<HistoryRecordDTO>> getHistoryList(int userId) {
        List<HistoryRecordDTO> historyRecords = taskMapper.getHistoryRecords(userId);
        if (historyRecords == null) {
            return Result.error("查看历史记录失败");
        } else {
            return Result.success(historyRecords);
        }
    }

    @Override
    public Result<Topology> getTopologyById(int id) {
        Topology topology = topologyMapper.selectById(id);
        if (topology == null) {
            return Result.error("查找拓扑失败");
        } else {
            return Result.success(topology);
        }
    }

    @Override
    public List<Map<String, Object>> getNodes(int id) {
        QueryWrapper<Node> queryWrapper = new QueryWrapper();
        queryWrapper.eq("topology_id", id);
        List<Node> nodes = nodeMapper.selectList(queryWrapper);
        List<Map<String, Object>> nodeList = new ArrayList<>();
        for (Node node : nodes) {
            Map<String, Object> map = new HashMap<>();
            map.put("port", node.getPort());
            map.put("ip", node.getIp());
            map.put("name", node.getName());
            map.put("key", node.getId());
            nodeList.add(map);
        }
        return nodeList;
    }

    @Override
    public Result<String> addTask(String name, String desc) {
        Task task = new Task();
        task.setName(name);
        task.setDescription(desc);
        int res = taskMapper.insert(task);
        if (res > 0) {
            return Result.success("新增任务成功");
        } else {
            return Result.error("新增任务失败");
        }
    }

    @Override
    public Result<String> deleteTask(int id) {
        int res = taskMapper.deleteById(id);
        if (res > 0) {
            return Result.success("删除任务成功");
        } else {
            return Result.error("删除任务失败");
        }
    }

    @Override
    public Result<List<Task>> getTaskList() {
        List<Task> tasks = taskMapper.selectList(null);
        return Result.success(tasks);
    }

    @Override
    public Result<List<ScoreListDTO>> getScoreList(int id) {
        List<ScoreListDTO> scoreList = taskMapper.getScoreList(id);
        return Result.success(scoreList);
    }

    @Override
    public Result<Task> getTaskById(int id) {
        QueryWrapper<Task> wrapper = new QueryWrapper<>();
        wrapper.eq("id", id);
        Task task = taskMapper.selectOne(wrapper);
        if (task == null) {
            return Result.error("获取任务失败");
        } else {
            return Result.success(task);
        }
    }

}
