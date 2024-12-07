package com.muzi.easychatadmin.generate;

import cn.hutool.core.io.FileUtil;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.builder.ConfigBuilder;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.FileType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.*;
import java.util.stream.Collectors;

public class MybatisCodeGenerator {

    // 模拟英文到中文的翻译映射，实际中可替换为更准确的获取翻译方式
    private static final Map<String, String> EN_TO_CN_MAP = new HashMap<>();

    public static void main(String[] args) {
        String tableNames = "black,contact,group_member,item_config,message,message_mark,role,room,room_friend,room_group,secure_invoke_record,sensitive_word,user,user_apply,user_backpack,user_emoji,user_friend,user_role,wx_msg";
        List<Map<String, String>> maps = processTableName(tableNames);
        for (Map<String, String> map : maps) {
            GeneratorClass(map.get("tableName"), map.get("dataName"), map.get("dataKey"), map.get("upperDataKey"));

        }
    }

    private static void GeneratorClass(String tableName, String dataName, String dataKey, String upperDataKey) {
        // 全局配置
        GlobalConfig globalConfig = new GlobalConfig();
        String projectPath = System.getProperty("user.dir");
        globalConfig.setOutputDir(projectPath + "/src/main/java") // 设置输出目录
                .setAuthor("Muzi") // 设置作者
                .setOpen(false) // 设置生成后是否自动打开目录
                .setFileOverride(true) // 设置文件存在时是否覆盖
                .setServiceName("%sService") // 设置Service接口名后缀
                .setIdType(IdType.AUTO) // 设置主键生成策略
                .setSwagger2(true); // 设置是否生成Swagger注解

        // 数据源配置
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setDbType(DbType.MYSQL) // 设置数据库类型
                .setUrl("jdbc:mysql://47.102.86.248:3306/EasyChat?useSSL=false&serverTimezone=UTC") // 数据库连接URL
                .setUsername("root") // 数据库用户名
                .setPassword("woshiliduo123") // 数据库密码
                .setDriverName("com.mysql.cj.jdbc.Driver"); // 数据库驱动类名

        // 策略配置
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig.setInclude(tableName) // 指定需要生成代码的表名
                .setNaming(NamingStrategy.underline_to_camel) // 设置表名转类名策略
                .setColumnNaming(NamingStrategy.underline_to_camel) // 设置列名转属性名策略
                .setEntityLombokModel(true) // 设置实体类使用Lombok模型
                .setRestControllerStyle(true) // 设置Controller使用REST风格
                .setControllerMappingHyphenStyle(true); // 驼峰转连字符


        // 包配置
        PackageConfig packageConfig = new PackageConfig();
        packageConfig.setParent("com.muzi.easychatadmin") // 设置父包名
                .setEntity("model.entity") // 设置实体类所在的子包名
                .setController("controller") // 设置Controller所在的子包名
                .setService("service") // 设置Service所在的子包名
                .setServiceImpl("service.impl") // 设置服务实现类所在的子包名
                .setMapper("mapper") // 设置Mapper接口所在的子包名
                .setXml("src\\main\\resources\\mapper"); // 设置Mapper XML文件所在的子包名


//        TemplateConfig templateConfig = new TemplateConfig();
//        templateConfig.setXml(null) // 不生成XML文件
//                .setController("templates/TemplateController.java") // 设置Controller模板路径
//                .setService("templates/TemplateService.java")
//                .setServiceImpl("templates/TemplateServiceImpl.java");
//
//        InjectionConfig injectionConfig = new InjectionConfig() {
//            //自定义属性注入:abc
//            //在.ftl(或者是.vm)模板中，通过${cfg.abc}获取属性
//            @Override
//            public void initMap() {
//                Map<String, Object> dataModel = new HashMap<>();
//                dataModel.put("packageName", packageConfig.getParent());
//                dataModel.put("dataName", dataName);
//                dataModel.put("dataKey", dataKey);
//                dataModel.put("upperDataKey", upperDataKey);
//                this.setMap(dataModel);
//            }
//        };
//        // 自定义输出配置
//        List<FileOutConfig> focList = new ArrayList<>();
//        // 自定义配置会被优先输出
//        String templatePath = "templates/model/TemplateAddRequest.java.ftl";
//        String typePath = "%s/src/main/java/com/muzi/easychatadmin/model/dto/"+dataKey+"/%sAddRequest.java";
//        CreateTmpRequest(projectPath, injectionConfig, focList, templatePath, typePath, upperDataKey);
//        templatePath = "templates/model/TemplateEditRequest.java.ftl";
//        typePath = "%s/src/main/java/com/muzi/easychatadmin/model/dto/"+dataKey+"/%sEditRequest.java";
//        CreateTmpRequest(projectPath, injectionConfig, focList, templatePath, typePath, upperDataKey);
//        templatePath = "templates/model/TemplateQueryRequest.java.ftl";
//        typePath = "%s/src/main/java/com/muzi/easychatadmin/model/dto/"+dataKey+"/%sQueryRequest.java";
//        CreateTmpRequest(projectPath, injectionConfig, focList, templatePath, typePath, upperDataKey);
//        templatePath = "templates/model/TemplateUpdateRequest.java.ftl";
//        typePath = "%s/src/main/java/com/muzi/easychatadmin/model/dto/"+dataKey+"/%sUpdateRequest.java";
//        CreateTmpRequest(projectPath, injectionConfig, focList, templatePath, typePath, upperDataKey);
//        templatePath = "templates/model/TemplateVO.java.ftl";
//        typePath = "%s/src/main/java/com/muzi/easychatadmin/model/vo/%sVO.java";
//        CreateTmpRequest(projectPath, injectionConfig, focList, templatePath, typePath, upperDataKey);
//
//
//        injectionConfig.setFileOutConfigList(focList);

        // 整合配置
        AutoGenerator autoGenerator = new AutoGenerator();
        autoGenerator.setGlobalConfig(globalConfig)
                .setDataSource(dataSourceConfig)
                .setStrategy(strategyConfig)
                .setPackageInfo(packageConfig)
//                .setTemplate(templateConfig)
                .setTemplateEngine(new FreemarkerTemplateEngine());
//                .setCfg(injectionConfig);
        //System.out.println(autoGenerator.getConfig().getTableInfoList().toString());

        // 执行生成
        autoGenerator.execute();
    }

    private static void CreateTmpRequest(String projectPath, InjectionConfig injectionConfig, List<FileOutConfig> focList, String templatePath, String typePath, String upperName) {
        if (!FileUtil.exist(String.format(typePath, projectPath, upperName))) {
            FileUtil.touch(String.format(typePath, projectPath, upperName));
        }
        focList.add(new FileOutConfig(templatePath) {
            @Override
            public String outputFile(TableInfo tableInfo) {
                String outputPath = String.format(typePath, projectPath, upperName);
                // 自定义输出文件名 ， 如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
                return outputPath;
            }
        });
        injectionConfig.setFileCreate(new IFileCreate() {
            @Override
            public boolean isCreate(ConfigBuilder configBuilder, FileType fileType, String filePath) {
                // 判断自定义文件夹是否需要创建
                checkDir(String.format(typePath, projectPath, upperName));
//                if (fileType == FileType.OTHER) {
//                    // 已经生成 mapper 文件判断存在，不想重新生成返回 false
//                    return !new File(filePath).exists();
//                }
                // 允许生成模板文件
                return true;
            }
        });
    }

    static {
        EN_TO_CN_MAP.put("black", "黑名单");
        EN_TO_CN_MAP.put("contact", "联系人");
        EN_TO_CN_MAP.put("group_member", "群成员");
        EN_TO_CN_MAP.put("item_config", "项目配置");
        EN_TO_CN_MAP.put("message", "消息");
        EN_TO_CN_MAP.put("message_mark", "消息标记");
        EN_TO_CN_MAP.put("role", "角色");
        EN_TO_CN_MAP.put("room", "房间");
        EN_TO_CN_MAP.put("room_friend", "房间好友");
        EN_TO_CN_MAP.put("room_group", "房间群组");
        EN_TO_CN_MAP.put("secure_invoke_record", "安全调用记录");
        EN_TO_CN_MAP.put("sensitive_word", "敏感词");
        EN_TO_CN_MAP.put("user", "用户");
        EN_TO_CN_MAP.put("user_apply", "用户申请");
        EN_TO_CN_MAP.put("user_backpack", "用户背包");
        EN_TO_CN_MAP.put("user_emoji", "用户表情");
        EN_TO_CN_MAP.put("user_friend", "用户好友");
        EN_TO_CN_MAP.put("user_role", "用户角色");
        EN_TO_CN_MAP.put("wx_msg", "微信消息");
    }

    private static List<Map<String, String>> processTableName(String tableNames) {
        List<String> originalList = Arrays.stream(tableNames.split(",")).collect(Collectors.toList());
        List<Map<String, String>> newList = new ArrayList<>();
        for (String str : originalList) {
            StringBuilder sb = new StringBuilder();
            String[] parts = str.split("_");
            HashMap<String, String> tableInfo = new HashMap<>();
            for (String part : parts) {
                if (part.length() > 0) {
                    // 将每个部分的首字母大写
                    String capitalizedPart = part.substring(0, 1).toUpperCase() + part.substring(1).toLowerCase();
                    sb.append(capitalizedPart);
                }
            }
            tableInfo.put("tableName", str);
            tableInfo.put("dataName", EN_TO_CN_MAP.get(str));
            tableInfo.put("dataKey", sb.toString().toLowerCase());
            tableInfo.put("upperDataKey", sb.toString());
            newList.add(tableInfo);
        }
        return newList;
    }

}

