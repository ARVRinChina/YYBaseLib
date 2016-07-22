//
//  EnumModel.h
//  xlzx
//
//  Created by tony on 16/2/1.
//  Copyright © 2016年 tony. All rights reserved.
//

#ifndef EnumModel_h
#define EnumModel_h

/**
 首页广告类型
 */
typedef NS_ENUM(NSInteger, Type) {
    empty,
    activity //活动
};
/**
 *  性别
 */
typedef NS_ENUM(NSInteger , Sex) {
    /**
     *  保密
     */
    SexUnknown,
    /**
     *  男
     */
    SexMale,
    /**
     *  女
     */
    SexFamale
};

/**
 *  婚姻情况
 */
typedef NS_ENUM(NSUInteger , Marriage) {
    /**
     *  保密
     */
    MarriageUnknown,
    /**
     *  已婚
     */
    MarriageMarried,
    /**
     *  未婚
     */
    MarriageUnmarried,
    /**
     *  离异
     */
    MArriageDivorce,
    /**
     *  单身
     */
    MarriageSingle,
    /**
     *  恋爱中
     */
    MarriageInlove
};

/**
 *  用户类型
 */
typedef NS_ENUM(NSUInteger , UserType) {
    /**
     *  普通用户
     */
    UserTypeNormal,
    /**
     *  咨询师用户
     */
    UserTypeConsult,
    /**
     *  机构管理员
     */
    UserTypeOrganization
};

/**
 *  星座
 */
typedef NS_ENUM(NSUInteger, Constellation) {
    /**
     *  未选择
     */
    ConstellationNoSelect,
    /**
     *  白羊座
     */
    ConstellationAries,
    /**
     *  金牛座
     */
    ConstellationTaurus,
    /**
     *  双子座
     */
    ConstellationGemini,
    /**
     *  巨蟹座
     */
    ConstellationCancer,
    /**
     *  狮子座
     */
    ConstellationLeo,
    /**
     *  处女座
     */
    ConstellationVirgo,
    /**
     *  天秤座
     */
    ConstellationLibra,
    /**
     *  天蝎座
     */
    ConstellationScorpio,
    /**
     *  射手座
     */
    ConstellationSagittarius,
    /**
     *  摩羯座
     */
    ConstellationCapricorn,
    /**
     *  水瓶座
     */
    ConstellationAquarius,
    /**
     *  双鱼座
     */
    ConstellationPisces,
};

/**
 *  血型
 */
typedef NS_ENUM(NSUInteger ,BloodType) {
    /**
     *  未选择
     */
    BloodTypeNoSelect,
    /**
     *  A型
     */
    BloodTypeA,
    /**
     *  B型
     */
    BloodTypeB,
    /**
     *  O型
     */
    BloodTypeO,
    /**
     *  AB型
     */
    BloodTypeAB,
};

/**
 *  学历
 */
typedef NS_ENUM(NSUInteger ,Education) {
    /**
     *  未选择
     */
    EducationNoSelect,
    /**
     *  初中及以下
     */
    EducationBelowJunior,
    /**
     *  高中
     */
    EducationHigh,
    /**
     *  中技
     */
    EducationPolytechnic,
    /**
     *  中专
     */
    EducationSecondarySpecialized,
    /**
     *  大专
     */
    EducationJuniorCollege,
    /**
     *  本科
     */
    EducationUndergraduate,
    /**
     *  硕士
     */
    EducationMaster,
    /**
     *  MBA
     */
    EducationMBA,
    /**
     *  博士
     */
    EducationDoctor
};

/**
 *  职业
 */
typedef NS_ENUM(NSUInteger ,Profession) {
    /**
     *  未选择
     */
    ProfessionNoSelect,
    /**
     *  计算机
     */
    ProfessionComputer,
    /**
     *  销售
     */
    ProfessionSales,
    /**
     *  会计
     */
    ProfessionAccounting,
    /**
     *  生产
     */
    ProfessionProduction,
    /**
     *  生物
     */
    ProfessionBiological,
    /**
     *  广告
     */
    ProfessionAdvertising,
    /**
     *  建筑
     */
    ProfessionArchitecture,
    /**
     *  人事
     */
    ProfessionPersonnel,
    /**
     *  咨询
     */
    ProfessionConsultation,
    /**
     *  服务业
     */
    ProfessionServiceIndustry,
    /**
     *  公务员
     */
    ProfessionCivilServants
};

/**
 *  年收入
 */
typedef NS_ENUM(NSUInteger ,AnnualIncome) {
    /**
     *  未选择
     */
    AnnualIncomeNoSelect,
    /**
     *  五万以下
     */
    AnnualIncome50ThousandBelow,
    /**
     *  五至八万
     */
    AnnualIncome50To80Thousand,
    /**
     *  八至十二万
     */
    AnnualIncome80To120Thousand,
    /**
     *  十二万至十五万
     */
    AnnualIncome120To150Thousand,
    /**
     *  十五万以上
     */
    AnnualIncome150ThousandAbove
};

/**
 *  用户状态
 */
typedef NS_ENUM(NSUInteger , UserStatus) {
    /**
     *  空闲
     */
    UserStatusFree,
    /**
     *  离开
     */
    UserStatusLeave,
    /**
     *  咨询中
     */
    UserStatusConsult,
    /**
     *  离线
     */
    UserStatusOffLine
};

/**
 *  订单类型
 */
typedef NS_ENUM(NSUInteger , OrdersType) {
    /**
     *  图文语音
     */
    OrdersTypeGraphic,
    /**
     *  网络电话
     */
    OrdersTypeVoIP,
    /**
     *  线下预约
     */
    OrdersTypeMakeAnAppointment
};

/**
 *  订单状态
 */
typedef NS_ENUM(NSUInteger ,OrderStatus) {
    /**
     *  待确认
     */
    OrderStatusWaitingConfirm,
    /**
     *  未支付
     */
    OrderStatusUnpaid,
    /**
     *  已支付
     */
    OrderStatusPaid,
    /**
     *  已完成
     */
    OrderStatusCompleted,
    /**
     *  已评论
     */
    OrderStatusHaveComments,
    /**
     *  已拒绝
     */
    OrderStatusRejected,
    /**
     *  取消
     */
    OrderStatusCancel,
    /**
     *  异常
     */
    OrderStatusException
};

/**
 *  银行
 */
typedef NS_ENUM(NSUInteger,Bank) {
    /**
     *  中国人民银行
     */
    BankPBC,
    /**
     *  中国工商银行
     */
    BankICBC,
    /**
     *  中国建设银行
     */
    BankCBC,
    /**
     *  中国银行
     */
    BankBC,
    /**
     *  中国农业银行
     */
    BankABC,
    /**
     *  中国交通银行
     */
    BankBCM,
    /**
     *  中国招商银行
     */
    BankCMB,
    /**
     *  中国邮政储蓄银行
     */
    BankPSBC,
    /**
     *  中信银行
     */
    BankCCB,
    /**
     *  光大银行
     */
    BankCEB,
    /**
     *  民生银行
     */
    BankCMBC
};

/**
 *  文章类型
 */
typedef NS_ENUM(NSUInteger , ArticleType) {
    /**
     *  文章
     */
    ArticleTypeDefault,
    /**
     *  视频
     */
    ArticleTypeVedio,
    /**
     *  短句
     */
    ArticleTypeShortSententce
    
};

/**
 *  支付类型
 */
typedef NS_ENUM(NSInteger,PayType) {
    /**
     *  支付宝
     */
    PayTypeAlipay,
    /**
     *  微信
     */
    PayTypeWechat,
    /**
     *  余额
     */
    PayTypeBalance
};

/**
 *  拍卖状态
 */
typedef NS_ENUM(NSInteger,AuctionStatus) {
    /**
     *  正常
     */
    AuctionStatusNormal,
    /**
     *  已流拍
     */
    AuctionStatusUnsold,
    /**
     *  已结束
     */
    AuctionStatusEnd
};

/**
 *  地图搜索的类型
 */
typedef NS_ENUM(NSInteger , MapSearchType) {
    /**
     *  机构
     */
    MapSearchTypeOrganization    = 1,
    /**
     *  活动
     */
    MapSearchTypeActivity        = 1 << 1,
    /**
     *  咨询师
     */
    MapSearchTypeConsultant      = 1 << 2,
    /**
     *  普通用户
     */
    MapSearchTypeNormalUser      = 1 << 3,
};

#endif /* EnumModel_h */
