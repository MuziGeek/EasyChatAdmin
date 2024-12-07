package ${cfg.packageName}.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${cfg.packageName}.common.ErrorCode;
import ${cfg.packageName}.constant.CommonConstant;
import ${cfg.packageName}.exception.ThrowUtils;
import ${cfg.packageName}.mapper.${cfg.upperDataKey}Mapper;
import ${cfg.packageName}.model.dto.${cfg.dataKey}.${cfg.upperDataKey}QueryRequest;
import ${cfg.packageName}.model.entity.${cfg.upperDataKey};
import ${cfg.packageName}.model.entity.${cfg.upperDataKey}Favour;
import ${cfg.packageName}.model.entity.${cfg.upperDataKey}Thumb;
import ${cfg.packageName}.model.entity.User;
import ${cfg.packageName}.model.vo.${cfg.upperDataKey}VO;
import ${cfg.packageName}.model.vo.UserVO;
import ${cfg.packageName}.service.${cfg.upperDataKey}Service;
import ${cfg.packageName}.service.UserService;
import ${cfg.packageName}.utils.SqlUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * ${cfg.dataName}服务实现
 *
 * @author <a href="https://github.com/MuziGeek">Muzi</a
 *
 */
@Service
@Slf4j
public class ${cfg.upperDataKey}ServiceImpl extends ServiceImpl<${cfg.upperDataKey}Mapper, ${cfg.upperDataKey}> implements ${cfg.upperDataKey}Service {

    @Resource
    private UserService userService;

    /**
     * 校验数据
     *
     * @param ${cfg.dataKey}
     * @param add      对创建的数据进行校验
     */
    @Override
    public void valid${cfg.upperDataKey}(${cfg.upperDataKey} ${cfg.dataKey}, boolean add) {
        ThrowUtils.throwIf(${cfg.dataKey} == null, ErrorCode.PARAMS_ERROR);
        // todo 从对象中取值
        String title = ${cfg.dataKey}.getTitle();
        // 创建数据时，参数不能为空
        if (add) {
            // todo 补充校验规则
            ThrowUtils.throwIf(StringUtils.isBlank(title), ErrorCode.PARAMS_ERROR);
        }
        // 修改数据时，有参数则校验
        // todo 补充校验规则
        if (StringUtils.isNotBlank(title)) {
            ThrowUtils.throwIf(title.length() > 80, ErrorCode.PARAMS_ERROR, "标题过长");
        }
    }

    /**
     * 获取查询条件
     *
     * @param ${cfg.dataKey}QueryRequest
     * @return
     */
    @Override
    public QueryWrapper<${cfg.upperDataKey}> getQueryWrapper(${cfg.upperDataKey}QueryRequest ${cfg.dataKey}QueryRequest) {
        QueryWrapper<${cfg.upperDataKey}> queryWrapper = new QueryWrapper<>();
        if (${cfg.dataKey}QueryRequest == null) {
            return queryWrapper;
        }
        // todo 从对象中取值
        Long id = ${cfg.dataKey}QueryRequest.getId();
        Long notId = ${cfg.dataKey}QueryRequest.getNotId();
        String title = ${cfg.dataKey}QueryRequest.getTitle();
        String content = ${cfg.dataKey}QueryRequest.getContent();
        String searchText = ${cfg.dataKey}QueryRequest.getSearchText();
        String sortField = ${cfg.dataKey}QueryRequest.getSortField();
        String sortOrder = ${cfg.dataKey}QueryRequest.getSortOrder();
        List<String> tagList = ${cfg.dataKey}QueryRequest.getTags();
        Long userId = ${cfg.dataKey}QueryRequest.getUserId();
        // todo 补充需要的查询条件
        // 从多字段中搜索
        if (StringUtils.isNotBlank(searchText)) {
            // 需要拼接查询条件
            queryWrapper.and(qw -> qw.like("title", searchText).or().like("content", searchText));
        }
        // 模糊查询
        queryWrapper.like(StringUtils.isNotBlank(title), "title", title);
        queryWrapper.like(StringUtils.isNotBlank(content), "content", content);
        // JSON 数组查询
        if (CollUtil.isNotEmpty(tagList)) {
            for (String tag : tagList) {
                queryWrapper.like("tags", "\"" + tag + "\"");
            }
        }
        // 精确查询
        queryWrapper.ne(ObjectUtils.isNotEmpty(notId), "id", notId);
        queryWrapper.eq(ObjectUtils.isNotEmpty(id), "id", id);
        queryWrapper.eq(ObjectUtils.isNotEmpty(userId), "userId", userId);
        // 排序规则
        queryWrapper.orderBy(SqlUtils.validSortField(sortField),
                sortOrder.equals(CommonConstant.SORT_ORDER_ASC),
                sortField);
        return queryWrapper;
    }

    /**
     * 获取${cfg.dataName}封装
     *
     * @param ${cfg.dataKey}
     * @param request
     * @return
     */
    @Override
    public ${cfg.upperDataKey}VO get${cfg.upperDataKey}VO(${cfg.upperDataKey} ${cfg.dataKey}, HttpServletRequest request) {
        // 对象转封装类
        ${cfg.upperDataKey}VO ${cfg.dataKey}VO = ${cfg.upperDataKey}VO.objToVo(${cfg.dataKey});

        // todo 可以根据需要为封装对象补充值，不需要的内容可以删除
        // region 可选
        // 1. 关联查询用户信息
        Long userId = ${cfg.dataKey}.getUserId();
        User user = null;
        if (userId != null && userId > 0) {
            user = userService.getById(userId);
        }
        UserVO userVO = userService.getUserVO(user);
        ${cfg.dataKey}VO.setUser(userVO);
        // 2. 已登录，获取用户点赞、收藏状态
        long ${cfg.dataKey}Id = ${cfg.dataKey}.getId();
        User loginUser = userService.getLoginUserPermitNull(request);
        if (loginUser != null) {
            // 获取点赞
            QueryWrapper<${cfg.upperDataKey}Thumb> ${cfg.dataKey}ThumbQueryWrapper = new QueryWrapper<>();
            ${cfg.dataKey}ThumbQueryWrapper.in("${cfg.dataKey}Id", ${cfg.dataKey}Id);
            ${cfg.dataKey}ThumbQueryWrapper.eq("userId", loginUser.getId());
            ${cfg.upperDataKey}Thumb ${cfg.dataKey}Thumb = ${cfg.dataKey}ThumbMapper.selectOne(${cfg.dataKey}ThumbQueryWrapper);
            ${cfg.dataKey}VO.setHasThumb(${cfg.dataKey}Thumb != null);
            // 获取收藏
            QueryWrapper<${cfg.upperDataKey}Favour> ${cfg.dataKey}FavourQueryWrapper = new QueryWrapper<>();
            ${cfg.dataKey}FavourQueryWrapper.in("${cfg.dataKey}Id", ${cfg.dataKey}Id);
            ${cfg.dataKey}FavourQueryWrapper.eq("userId", loginUser.getId());
            ${cfg.upperDataKey}Favour ${cfg.dataKey}Favour = ${cfg.dataKey}FavourMapper.selectOne(${cfg.dataKey}FavourQueryWrapper);
            ${cfg.dataKey}VO.setHasFavour(${cfg.dataKey}Favour != null);
        }
        // endregion

        return ${cfg.dataKey}VO;
    }

    /**
     * 分页获取${cfg.dataName}封装
     *
     * @param ${cfg.dataKey}Page
     * @param request
     * @return
     */
    @Override
    public Page<${cfg.upperDataKey}VO> get${cfg.upperDataKey}VOPage(Page<${cfg.upperDataKey}> ${cfg.dataKey}Page, HttpServletRequest request) {
        List<${cfg.upperDataKey}> ${cfg.dataKey}List = ${cfg.dataKey}Page.getRecords();
        Page<${cfg.upperDataKey}VO> ${cfg.dataKey}VOPage = new Page<>(${cfg.dataKey}Page.getCurrent(), ${cfg.dataKey}Page.getSize(), ${cfg.dataKey}Page.getTotal());
        if (CollUtil.isEmpty(${cfg.dataKey}List)) {
            return ${cfg.dataKey}VOPage;
        }
        // 对象列表 => 封装对象列表
        List<${cfg.upperDataKey}VO> ${cfg.dataKey}VOList = ${cfg.dataKey}List.stream().map(${cfg.dataKey} -> {
            return ${cfg.upperDataKey}VO.objToVo(${cfg.dataKey});
        }).collect(Collectors.toList());

        // todo 可以根据需要为封装对象补充值，不需要的内容可以删除
        // region 可选
        // 1. 关联查询用户信息
        Set<Long> userIdSet = ${cfg.dataKey}List.stream().map(${cfg.upperDataKey}::getUserId).collect(Collectors.toSet());
        Map<Long, List<User>> userIdUserListMap = userService.listByIds(userIdSet).stream()
                .collect(Collectors.groupingBy(User::getId));
        // 2. 已登录，获取用户点赞、收藏状态
        Map<Long, Boolean> ${cfg.dataKey}IdHasThumbMap = new HashMap<>();
        Map<Long, Boolean> ${cfg.dataKey}IdHasFavourMap = new HashMap<>();
        User loginUser = userService.getLoginUserPermitNull(request);
        if (loginUser != null) {
            Set<Long> ${cfg.dataKey}IdSet = ${cfg.dataKey}List.stream().map(${cfg.upperDataKey}::getId).collect(Collectors.toSet());
            loginUser = userService.getLoginUser(request);
            // 获取点赞
            QueryWrapper<${cfg.upperDataKey}Thumb> ${cfg.dataKey}ThumbQueryWrapper = new QueryWrapper<>();
            ${cfg.dataKey}ThumbQueryWrapper.in("${cfg.dataKey}Id", ${cfg.dataKey}IdSet);
            ${cfg.dataKey}ThumbQueryWrapper.eq("userId", loginUser.getId());
            List<${cfg.upperDataKey}Thumb> ${cfg.dataKey}${cfg.upperDataKey}ThumbList = ${cfg.dataKey}ThumbMapper.selectList(${cfg.dataKey}ThumbQueryWrapper);
            ${cfg.dataKey}${cfg.upperDataKey}ThumbList.forEach(${cfg.dataKey}${cfg.upperDataKey}Thumb -> ${cfg.dataKey}IdHasThumbMap.put(${cfg.dataKey}${cfg.upperDataKey}Thumb.get${cfg.upperDataKey}Id(), true));
            // 获取收藏
            QueryWrapper<${cfg.upperDataKey}Favour> ${cfg.dataKey}FavourQueryWrapper = new QueryWrapper<>();
            ${cfg.dataKey}FavourQueryWrapper.in("${cfg.dataKey}Id", ${cfg.dataKey}IdSet);
            ${cfg.dataKey}FavourQueryWrapper.eq("userId", loginUser.getId());
            List<${cfg.upperDataKey}Favour> ${cfg.dataKey}FavourList = ${cfg.dataKey}FavourMapper.selectList(${cfg.dataKey}FavourQueryWrapper);
            ${cfg.dataKey}FavourList.forEach(${cfg.dataKey}Favour -> ${cfg.dataKey}IdHasFavourMap.put(${cfg.dataKey}Favour.get${cfg.upperDataKey}Id(), true));
        }
        // 填充信息
        ${cfg.dataKey}VOList.forEach(${cfg.dataKey}VO -> {
            Long userId = ${cfg.dataKey}VO.getUserId();
            User user = null;
            if (userIdUserListMap.containsKey(userId)) {
                user = userIdUserListMap.get(userId).get(0);
            }
            ${cfg.dataKey}VO.setUser(userService.getUserVO(user));
            ${cfg.dataKey}VO.setHasThumb(${cfg.dataKey}IdHasThumbMap.getOrDefault(${cfg.dataKey}VO.getId(), false));
            ${cfg.dataKey}VO.setHasFavour(${cfg.dataKey}IdHasFavourMap.getOrDefault(${cfg.dataKey}VO.getId(), false));
        });
        // endregion

        ${cfg.dataKey}VOPage.setRecords(${cfg.dataKey}VOList);
        return ${cfg.dataKey}VOPage;
    }

}
