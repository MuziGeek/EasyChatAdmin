package com.muzi.easychatadmin.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 黑名单
 * </p>
 *
 * @author Muzi
 * @since 2024-12-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="Black对象", description="黑名单")
public class Black implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty(value = "拉黑目标类型 1.ip 2uid")
    private Integer type;

    @ApiModelProperty(value = "拉黑目标")
    private String target;

    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "修改时间")
    private LocalDateTime updateTime;


}
