package ${cfg.packageName}.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${cfg.packageName}.annotation.AuthCheck;
import ${cfg.packageName}.common.BaseResponse;
import ${cfg.packageName}.common.DeleteRequest;
import ${cfg.packageName}.common.ErrorCode;
import ${cfg.packageName}.common.ResultUtils;
import ${cfg.packageName}.constant.UserConstant;
import ${cfg.packageName}.exception.BusinessException;
import ${cfg.packageName}.exception.ThrowUtils;
import ${cfg.packageName}.model.dto.${cfg.dataKey}.${cfg.upperDataKey}AddRequest;
import ${cfg.packageName}.model.dto.${cfg.dataKey}.${cfg.upperDataKey}EditRequest;
import ${cfg.packageName}.model.dto.${cfg.dataKey}.${cfg.upperDataKey}QueryRequest;
import ${cfg.packageName}.model.dto.${cfg.dataKey}.${cfg.upperDataKey}UpdateRequest;
import ${cfg.packageName}.model.entity.${cfg.upperDataKey};
import ${cfg.packageName}.model.entity.User;
import ${cfg.packageName}.model.vo.${cfg.upperDataKey}VO;
import ${cfg.packageName}.service.${cfg.upperDataKey}Service;
import ${cfg.packageName}.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * ${cfg.dataName}接口
 *
 * @author <a href="https://github.com/MuziGeek">Muzi</a
 *
 */
@RestController
@RequestMapping("/${cfg.dataKey}")
@Slf4j
public class ${cfg.upperDataKey}Controller {

    @Resource
    private ${cfg.upperDataKey}Service ${cfg.dataKey}Service;

    @Resource
    private UserService userService;

    // region 增删改查

    /**
     * 创建${cfg.dataName}
     *
     * @param ${cfg.dataKey}AddRequest
     * @param request
     * @return
     */
    @PostMapping("/add")
    public BaseResponse<Long> add${cfg.upperDataKey}(@RequestBody ${cfg.upperDataKey}AddRequest ${cfg.dataKey}AddRequest, HttpServletRequest request) {
        ThrowUtils.throwIf(${cfg.dataKey}AddRequest == null, ErrorCode.PARAMS_ERROR);
        // todo 在此处将实体类和 DTO 进行转换
        ${cfg.upperDataKey} ${cfg.dataKey} = new ${cfg.upperDataKey}();
        BeanUtils.copyProperties(${cfg.dataKey}AddRequest, ${cfg.dataKey});
        // 数据校验
        ${cfg.dataKey}Service.valid${cfg.upperDataKey}(${cfg.dataKey}, true);
        // todo 填充默认值
        User loginUser = userService.getLoginUser(request);
        ${cfg.dataKey}.setUserId(loginUser.getId());
        // 写入数据库
        boolean result = ${cfg.dataKey}Service.save(${cfg.dataKey});
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        // 返回新写入的数据 id
        long new${cfg.upperDataKey}Id = ${cfg.dataKey}.getId();
        return ResultUtils.success(new${cfg.upperDataKey}Id);
    }

    /**
     * 删除${cfg.dataName}
     *
     * @param deleteRequest
     * @param request
     * @return
     */
    @PostMapping("/delete")
    public BaseResponse<Boolean> delete${cfg.upperDataKey}(@RequestBody DeleteRequest deleteRequest, HttpServletRequest request) {
        if (deleteRequest == null || deleteRequest.getId() <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        User user = userService.getLoginUser(request);
        long id = deleteRequest.getId();
        // 判断是否存在
        ${cfg.upperDataKey} old${cfg.upperDataKey} = ${cfg.dataKey}Service.getById(id);
        ThrowUtils.throwIf(old${cfg.upperDataKey} == null, ErrorCode.NOT_FOUND_ERROR);
        // 仅本人或管理员可删除
        if (!old${cfg.upperDataKey}.getUserId().equals(user.getId()) && !userService.isAdmin(request)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
        }
        // 操作数据库
        boolean result = ${cfg.dataKey}Service.removeById(id);
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        return ResultUtils.success(true);
    }

    /**
     * 更新${cfg.dataName}（仅管理员可用）
     *
     * @param ${cfg.dataKey}UpdateRequest
     * @return
     */
    @PostMapping("/update")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public BaseResponse<Boolean> update${cfg.upperDataKey}(@RequestBody ${cfg.upperDataKey}UpdateRequest ${cfg.dataKey}UpdateRequest) {
        if (${cfg.dataKey}UpdateRequest == null || ${cfg.dataKey}UpdateRequest.getId() <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // todo 在此处将实体类和 DTO 进行转换
        ${cfg.upperDataKey} ${cfg.dataKey} = new ${cfg.upperDataKey}();
        BeanUtils.copyProperties(${cfg.dataKey}UpdateRequest, ${cfg.dataKey});
        // 数据校验
        ${cfg.dataKey}Service.valid${cfg.upperDataKey}(${cfg.dataKey}, false);
        // 判断是否存在
        long id = ${cfg.dataKey}UpdateRequest.getId();
        ${cfg.upperDataKey} old${cfg.upperDataKey} = ${cfg.dataKey}Service.getById(id);
        ThrowUtils.throwIf(old${cfg.upperDataKey} == null, ErrorCode.NOT_FOUND_ERROR);
        // 操作数据库
        boolean result = ${cfg.dataKey}Service.updateById(${cfg.dataKey});
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        return ResultUtils.success(true);
    }

    /**
     * 根据 id 获取${cfg.dataName}（封装类）
     *
     * @param id
     * @return
     */
    @GetMapping("/get/vo")
    public BaseResponse<${cfg.upperDataKey}VO> get${cfg.upperDataKey}VOById(long id, HttpServletRequest request) {
        ThrowUtils.throwIf(id <= 0, ErrorCode.PARAMS_ERROR);
        // 查询数据库
        ${cfg.upperDataKey} ${cfg.dataKey} = ${cfg.dataKey}Service.getById(id);
        ThrowUtils.throwIf(${cfg.dataKey} == null, ErrorCode.NOT_FOUND_ERROR);
        // 获取封装类
        return ResultUtils.success(${cfg.dataKey}Service.get${cfg.upperDataKey}VO(${cfg.dataKey}, request));
    }

    /**
     * 分页获取${cfg.dataName}列表（仅管理员可用）
     *
     * @param ${cfg.dataKey}QueryRequest
     * @return
     */
    @PostMapping("/list/page")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public BaseResponse<Page<${cfg.upperDataKey}>> list${cfg.upperDataKey}ByPage(@RequestBody ${cfg.upperDataKey}QueryRequest ${cfg.dataKey}QueryRequest) {
        long current = ${cfg.dataKey}QueryRequest.getCurrent();
        long size = ${cfg.dataKey}QueryRequest.getPageSize();
        // 查询数据库
        Page<${cfg.upperDataKey}> ${cfg.dataKey}Page = ${cfg.dataKey}Service.page(new Page<>(current, size),
                ${cfg.dataKey}Service.getQueryWrapper(${cfg.dataKey}QueryRequest));
        return ResultUtils.success(${cfg.dataKey}Page);
    }

    /**
     * 分页获取${cfg.dataName}列表（封装类）
     *
     * @param ${cfg.dataKey}QueryRequest
     * @param request
     * @return
     */
    @PostMapping("/list/page/vo")
    public BaseResponse<Page<${cfg.upperDataKey}VO>> list${cfg.upperDataKey}VOByPage(@RequestBody ${cfg.upperDataKey}QueryRequest ${cfg.dataKey}QueryRequest,
                                                               HttpServletRequest request) {
        long current = ${cfg.dataKey}QueryRequest.getCurrent();
        long size = ${cfg.dataKey}QueryRequest.getPageSize();
        // 限制爬虫
        ThrowUtils.throwIf(size > 20, ErrorCode.PARAMS_ERROR);
        // 查询数据库
        Page<${cfg.upperDataKey}> ${cfg.dataKey}Page = ${cfg.dataKey}Service.page(new Page<>(current, size),
                ${cfg.dataKey}Service.getQueryWrapper(${cfg.dataKey}QueryRequest));
        // 获取封装类
        return ResultUtils.success(${cfg.dataKey}Service.get${cfg.upperDataKey}VOPage(${cfg.dataKey}Page, request));
    }

    /**
     * 分页获取当前登录用户创建的${cfg.dataName}列表
     *
     * @param ${cfg.dataKey}QueryRequest
     * @param request
     * @return
     */
    @PostMapping("/my/list/page/vo")
    public BaseResponse<Page<${cfg.upperDataKey}VO>> listMy${cfg.upperDataKey}VOByPage(@RequestBody ${cfg.upperDataKey}QueryRequest ${cfg.dataKey}QueryRequest,
                                                                 HttpServletRequest request) {
        ThrowUtils.throwIf(${cfg.dataKey}QueryRequest == null, ErrorCode.PARAMS_ERROR);
        // 补充查询条件，只查询当前登录用户的数据
        User loginUser = userService.getLoginUser(request);
        ${cfg.dataKey}QueryRequest.setUserId(loginUser.getId());
        long current = ${cfg.dataKey}QueryRequest.getCurrent();
        long size = ${cfg.dataKey}QueryRequest.getPageSize();
        // 限制爬虫
        ThrowUtils.throwIf(size > 20, ErrorCode.PARAMS_ERROR);
        // 查询数据库
        Page<${cfg.upperDataKey}> ${cfg.dataKey}Page = ${cfg.dataKey}Service.page(new Page<>(current, size),
                ${cfg.dataKey}Service.getQueryWrapper(${cfg.dataKey}QueryRequest));
        // 获取封装类
        return ResultUtils.success(${cfg.dataKey}Service.get${cfg.upperDataKey}VOPage(${cfg.dataKey}Page, request));
    }

    /**
     * 编辑${cfg.dataName}（给用户使用）
     *
     * @param ${cfg.dataKey}EditRequest
     * @param request
     * @return
     */
    @PostMapping("/edit")
    public BaseResponse<Boolean> edit${cfg.upperDataKey}(@RequestBody ${cfg.upperDataKey}EditRequest ${cfg.dataKey}EditRequest, HttpServletRequest request) {
        if (${cfg.dataKey}EditRequest == null || ${cfg.dataKey}EditRequest.getId() <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // todo 在此处将实体类和 DTO 进行转换
        ${cfg.upperDataKey} ${cfg.dataKey} = new ${cfg.upperDataKey}();
        BeanUtils.copyProperties(${cfg.dataKey}EditRequest, ${cfg.dataKey});
        // 数据校验
        ${cfg.dataKey}Service.valid${cfg.upperDataKey}(${cfg.dataKey}, false);
        User loginUser = userService.getLoginUser(request);
        // 判断是否存在
        long id = ${cfg.dataKey}EditRequest.getId();
        ${cfg.upperDataKey} old${cfg.upperDataKey} = ${cfg.dataKey}Service.getById(id);
        ThrowUtils.throwIf(old${cfg.upperDataKey} == null, ErrorCode.NOT_FOUND_ERROR);
        // 仅本人或管理员可编辑
        if (!old${cfg.upperDataKey}.getUserId().equals(loginUser.getId()) && !userService.isAdmin(loginUser)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
        }
        // 操作数据库
        boolean result = ${cfg.dataKey}Service.updateById(${cfg.dataKey});
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        return ResultUtils.success(true);
    }

    // endregion
}
