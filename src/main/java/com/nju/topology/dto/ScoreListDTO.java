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
    private int id;
    private int studentId;
    private String name;
    private int score;

    public int getScore() {
        return score;
    }
}
