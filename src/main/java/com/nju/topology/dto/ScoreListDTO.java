package com.nju.topology.dto;

import lombok.Data;

/**
 * ClassName: ScoreListDTO
 *
 * @Author: jiahz
 * @Date: 2023/6/28 23:43
 * @Description:
 */
@Data
public class ScoreListDTO {
    private int topologyId;
    private int studentId;
    private String name;
    private int score;
}
