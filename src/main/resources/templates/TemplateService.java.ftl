package ${cfg.packageName}.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import ${cfg.packageName}.model.dto.${cfg.dataKey}.${cfg.upperDataKey}QueryRequest;
import ${cfg.packageName}.model.entity.${cfg.upperDataKey};
import ${cfg.packageName}.model.vo.${cfg.upperDataKey}VO;

import javax.servlet.http.HttpServletRequest;

/**
 * ${cfg.dataName}服务
 *
 * @author <a href="https://github.com/MuziGeek">Muzi</a
 *
 */
public interface ${cfg.upperDataKey}Service extends IService<${cfg.upperDataKey}> {

    /**
     * 校验数据
     *
     * @param ${cfg.dataKey}
     * @param add 对创建的数据进行校验
     */
    void valid${cfg.upperDataKey}(${cfg.upperDataKey} ${cfg.dataKey}, boolean add);

    /**
     * 获取查询条件
     *
     * @param ${cfg.dataKey}QueryRequest
     * @return
     */
    QueryWrapper<${cfg.upperDataKey}> getQueryWrapper(${cfg.upperDataKey}QueryRequest ${cfg.dataKey}QueryRequest);
    
    /**
     * 获取${cfg.dataName}封装
     *
     * @param ${cfg.dataKey}
     * @param request
     * @return
     */
    ${cfg.upperDataKey}VO get${cfg.upperDataKey}VO(${cfg.upperDataKey} ${cfg.dataKey}, HttpServletRequest request);

    /**
     * 分页获取${cfg.dataName}封装
     *
     * @param ${cfg.dataKey}Page
     * @param request
     * @return
     */
    Page<${cfg.upperDataKey}VO> get${cfg.upperDataKey}VOPage(Page<${cfg.upperDataKey}> ${cfg.dataKey}Page, HttpServletRequest request);
}
