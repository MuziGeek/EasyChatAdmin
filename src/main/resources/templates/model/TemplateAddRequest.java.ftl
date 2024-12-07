package ${cfg.packageName}.model.dto.${cfg.dataKey};

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 创建${cfg.dataName}请求
 *
 * @author <a href="https://github.com/MuziGeek">Muzi</a
 *
 */
@Data
public class ${cfg.upperDataKey}AddRequest implements Serializable {

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * 标签列表
     */
    private List<String> tags;

    private static final long serialVersionUID = 1L;
}