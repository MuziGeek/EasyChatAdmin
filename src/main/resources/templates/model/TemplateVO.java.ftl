package ${cfg.packageName}.model.vo;

import cn.hutool.json.JSONUtil;
import ${cfg.packageName}.model.entity.${cfg.upperDataKey};
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * ${cfg.dataName}视图
 *
 * @author <a href="https://github.com/MuziGeek">Muzi</a
 *
 */
@Data
public class ${cfg.upperDataKey}VO implements Serializable {

    /**
     * id
     */
    private Long id;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * 创建用户 id
     */
    private Long userId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 标签列表
     */
    private List<String> tagList;

    /**
     * 创建用户信息
     */
    private UserVO user;

    /**
     * 封装类转对象
     *
     * @param ${cfg.dataKey}VO
     * @return
     */
    public static ${cfg.upperDataKey} voToObj(${cfg.upperDataKey}VO ${cfg.dataKey}VO) {
        if (${cfg.dataKey}VO == null) {
            return null;
        }
        ${cfg.upperDataKey} ${cfg.dataKey} = new ${cfg.upperDataKey}();
        BeanUtils.copyProperties(${cfg.dataKey}VO, ${cfg.dataKey});
        List<String> tagList = ${cfg.dataKey}VO.getTagList();
        ${cfg.dataKey}.setTags(JSONUtil.toJsonStr(tagList));
        return ${cfg.dataKey};
    }

    /**
     * 对象转封装类
     *
     * @param ${cfg.dataKey}
     * @return
     */
    public static ${cfg.upperDataKey}VO objToVo(${cfg.upperDataKey} ${cfg.dataKey}) {
        if (${cfg.dataKey} == null) {
            return null;
        }
        ${cfg.upperDataKey}VO ${cfg.dataKey}VO = new ${cfg.upperDataKey}VO();
        BeanUtils.copyProperties(${cfg.dataKey}, ${cfg.dataKey}VO);
        ${cfg.dataKey}VO.setTagList(JSONUtil.toList(${cfg.dataKey}.getTags(), String.class));
        return ${cfg.dataKey}VO;
    }
}
