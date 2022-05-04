Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2B9C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 00:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 732AC83EBD;
	Wed,  4 May 2022 00:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3g_L21Ei1jq; Wed,  4 May 2022 00:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0153D83EBC;
	Wed,  4 May 2022 00:11:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA273C0032;
	Wed,  4 May 2022 00:11:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AADC8C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 00:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BA8F83EBF
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 00:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B7bX678lVrZR for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 00:11:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::626])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 724E983EBC
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 00:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7nyvjXie7t7Yrd0RjyuIrTvPf+v6nxeaXik+M4J1U1fS0haHEXoiZJVeVZAzqP3of4LaQmigm3LS9yabx96EK0f658e++xTPP4oiNi3bjXXY1QiLR9nAt2eWq3BRkruMG8fOLEf7NFFzf+/ZkYGBYPUUN1rg0hEowXCnyEcJn2Xhr2KJuTtCc1gkGj6DuwFBu9cR+X8DinEKrnhmFBZyFrtpSRcjbaA3cHIfP/XxZ4aBaVqYZX9yeZD+AFTHOjOqgZt15yKnJ2I0Fk3co6fN/+rOgvGVCk+mOK6p5FpHiWzjs5dbpQ5l6HptKTtRTRJJhiPOa3Cz75iTs+lxm9N2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5O2iPGOqgF9jKsTPMr/e5uvmfp4zflSPe0Sn+YOHKA=;
 b=D4C7PxREroEOV4jljQaeI1n7NNMhBw0gVfVcYfQDvyExle/L2JhjiujQqbik0d6Wqvo0xhgbmALaG2ZmI0BQkLcNi/q6C2tD+VX3ITmA9LNCnVZhvNtnDJjhkr72N0b7GvgmUQ1P8W2uqhaa6QpacaJ8xVthoqBWP1Gy+bQwczQHYuysapFldCzei080UC7D4zpKafAkT00nixEcMiEOLApj98GHjMH69HVRtgqgcRCtRVpCXiP0P9eI7mzFmZaH3GX6BLub1/7m4251x4QUzi0oRjdoBAH89T1hbEsudVtC2QwobRmlEt0gh1lvQy7gZUT2vgKR+l2PuFyszren/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5O2iPGOqgF9jKsTPMr/e5uvmfp4zflSPe0Sn+YOHKA=;
 b=lWJ1u3PSx4BOCQTih+w3SbJ1aq4EOWJoovBjDbUIoDfzh1fGSuB6yrtFJMGdAPAK9K+CjBwYavr/QNE/esMrQRz5V8WwdrQWhbyxpet4O8aBJI/1Owo5UGzfo0NR4UmALgj49+TyJC/RoIpGU9yJ9yxl+R3c4z9EMPLKkJoDzDSSrBxVxZTGFs58mughOTGhot64HmsQPD0SmKCEV/FWQkLVPOC3rzkrMWHIjk8Ol247dnUO4vtyFKX2R7mZZjwT2Z7DR/2ArBfsppZlJ7WgL2sDA+IsP3xNweCxC9IBfctRmxDk8UyYwkTf7xIcPoOXYtt4hZpxI3nIgmX6chLKLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 00:11:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:11:03 +0000
To: iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Date: Tue,  3 May 2022 21:11:02 -0300
Message-Id: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:208:237::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b1907e3-ed02-49ac-e9da-08da2d62937d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17253DC43205C99C0DBAF73CC2C39@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xjXyjf5IIXw8a4tfb3L1Ej2YtuE4bLkC4vvklkwsws9Heh/j5EIcFJS+JbB0o/0ufeP7VSW8JMYTMvhojez3KSN39KkS3+ux6pYI+eeqWlGDR3NlvF0VR0uyhjYynyZAzBMiF8WAcH2V1y7NcaLmuAXGsDVXVED4wSy1TpVrYLV0aekbxeSP4uWgAGy5uBeKUAnTpLC0O+FendZ3ITGs1DLphYjDepI7e+K/FCED0lFm8OTTCTGKfdnatJ7NYySCTduMr4+S6s8KDGKustZ3NWC40EC9TUmJ+JLjMTarppIj/LI8Dv/o4X5+XNAkO/8BrzrMBSg5j/cjlOSqfV9k0oy5KywCvCZrDl9PBIKIfFXBnVvADb1bUIG4WPv6Z3xP/k537CBIBWKcWhvGan/Xc4/Q+G6xdkuvlHUMG3HwUTFdZppMgsxfiNf1SvV4zs2F0Ikw23eUvU8alWbdBzwOleU5ZROSBKAo/HCGfX1vFGPu04lqlx/trETvG2I3ty3bhSbJxbi1JVjO4y4qtQt6ALCBobkZHlZpRHlmpkqxBli9URuTKFje4ESV9RrzZQgV2ioaq7D78Y05e74U83a20S7G51LlI+/YwB+5ugpWwHacZj1wAstaxAvP27u6RPSUbzqxZonQ4He1Lpc/3XVZxYmHbyNaIgilaQOQlj6TLwnh4C3dp8YAtQYA1ZEpHm50DqI/pH4qSdq6tltn4fmT9jfBC5N6dlsExgVg4OllgDcUKSfbs66bp0Et2mvDndnRWEkWjgRxyHCBVABPMMzxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8936002)(36756003)(5660300002)(966005)(6486002)(8676002)(54906003)(66476007)(2906002)(508600001)(66556008)(110136005)(66946007)(6512007)(26005)(38100700002)(83380400001)(6506007)(186003)(86362001)(316002)(2616005)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nwistjnMLpIWSBx2BxvnxiNeZTePC3HAqa1c/T2J9VE7sHJM7fhC+zEBs1M?=
 =?us-ascii?Q?esyHJipt9CHC9nK5xmxTNFMHVF4uYThXXrShmjU0A14sj2HcxthCQhl7RrtH?=
 =?us-ascii?Q?DFIPhfB7J2cQ8HGIJAGdFWmuS5VkpG51RJrLb/vo5UoZbJTUZyc+2n+Xj4qQ?=
 =?us-ascii?Q?IOHNrti5LKcWKW2Cb+nMA46fL/vHwSRoyaAfmy5tB+i1Kr6AXpKvL02m1zxU?=
 =?us-ascii?Q?c6jmHC4PLSJ8fet6pC+St54cFnl0hg8kY7KVjHUVnAu/BaOEX5PJxhxhy772?=
 =?us-ascii?Q?bfaV/yaDQmf1vHRKOdjRXS3LIkeb9IqsANb+43BCLCJwT39TlXeGJ2WnXVv1?=
 =?us-ascii?Q?rf+hIUAC/iICUvldzB96XeTvFn1IBrq89TU08SK1c2Gr3X65X1EemUPc/qws?=
 =?us-ascii?Q?Ks6wzC3m4xQktdlL0R/BZn+eIqlEWEHQf83f+GoyPHH5CT5MbsKI2SKLrVPp?=
 =?us-ascii?Q?350VthVi4LWMQxuJWiAs7NryWGivNTDmGSDyP5KhzJ5hZMc9vtmmebzgU96k?=
 =?us-ascii?Q?HmVe63yjaPQA+9KxAhKHY5u6lJb2BKF25psU8JP/nz4sg6P2kZxydJyTAcpz?=
 =?us-ascii?Q?nEQZgE4VXfOE3W+SrMNCAsft8995V8W81KhYs6x1vNoYRV3Zi+LzyLERIM0V?=
 =?us-ascii?Q?BbdwjwF1iK+4JOKvuZ665BdlxyaHBb3FsMPWETUxQ63W3vtbjhknpmfISgd/?=
 =?us-ascii?Q?5CPj/QQFBK9arYQTbUCNvkV3KhWxxq+9MWOCJJPJGdcPfImb9kOcxgd7hEV2?=
 =?us-ascii?Q?87OuXFYeLmJSLLXtZMt999jnoxWPO0fQGo8lRoGap2FDQTCSNwMFEimJABD8?=
 =?us-ascii?Q?eYIueQS3VAikUH3BhECqfJXutN13d4FgR30x15Z07z+KOgBJ9kK1+zh965cF?=
 =?us-ascii?Q?EEgqxBfBsNTfqa45V0nDeTjkPg++oIA2qwd7dbJu87fV+B1kl5HHw0lk7F8x?=
 =?us-ascii?Q?6cnqWZ3y2malNiJ1UflofIpCyC+oawI8V1UJbZqWUavk5deoD1lOBz2s+FFD?=
 =?us-ascii?Q?1PQ3375fcL2wHQA0s4/Hpjqx159PVPpixXncLuaQNZ0u9nN+ddrQXTShJZx3?=
 =?us-ascii?Q?kxb0vPLxZHW1SD3TZPqOka5YhKW0w2pEbHgcvIZFBcUhkurxNVx8G87bw/u7?=
 =?us-ascii?Q?ko0XsZvT1YAT/O3cMZr/FKnZl3+F+0J6j7eQ8fojjJV9ITJDYd+qwtFN9u1V?=
 =?us-ascii?Q?TlIWWEGGB6oeJJW1CzYnLIVg9JKgof08+Bbwqf0ZTdwqvQcVvOnkbfSmJew4?=
 =?us-ascii?Q?ZkFlFPkQxEo8CXnaHgloKelSJ97qE+0F+Wyr20TupF2PgU8kbplDa0q/ACNo?=
 =?us-ascii?Q?K/7EzhVTZvVPJb/zqJoVnBQ7Z7/F/rJ+u2oNtEIih0cM3Rsh8zdXgRr01y99?=
 =?us-ascii?Q?ZEPs4pOC+pwl5hxFFR1434cUvrUnDRyiVCscbA6HNPMz4IJA8DpON4ExRlkU?=
 =?us-ascii?Q?BlrNSP5yeBfVv9tk/CGTsCfPOS//0/NwAsjSAv47MepvcPYVZHXBf9yo+BJe?=
 =?us-ascii?Q?66Te2ACYIuH98QEEZjd/dfOzktveRR4YZkVBOegMksjNCZ8q/CTWShotPGng?=
 =?us-ascii?Q?QuN0WqVTmScK3dvXBr1U+S6a9yvAmIl83olb4+p0Z4msuqPcxoHNLBmjdpru?=
 =?us-ascii?Q?2Fz1ExY7MXQsYeytD0SBGiYrDl53IZIDZah8vhzef8EkR0Uk+cZ+OoI8XKT9?=
 =?us-ascii?Q?lO+M16K1abChvTgxZbSgM0PZ2wg9bHhhHsSUU++/bX1H/gdilEb49OvWdOI0?=
 =?us-ascii?Q?JCULILo/fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1907e3-ed02-49ac-e9da-08da2d62937d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 00:11:03.3393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zykEgAf6Djj4EIr2xXu65zEOo+TZRMUHjkubyk2NP8kdPP6sgghJSvk3TCQTmnqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Once the group enters 'owned' mode it can never be assigned back to the
default_domain or to a NULL domain. It must always be actively assigned to
a current domain. If the caller hasn't provided a domain then the core
must provide an explicit DMA blocking domain that has no DMA map.

Lazily create a group-global blocking DMA domain when
iommu_group_claim_dma_owner is first called and immediately assign the
group to it. This ensures that DMA is immediately fully isolated on all
IOMMU drivers.

If the user attaches/detaches while owned then detach will set the group
back to the blocking domain.

Slightly reorganize the call chains so that
__iommu_group_attach_core_domain() is the function that removes any caller
configured domain and sets the domains back a core owned domain with an
appropriate lifetime.

__iommu_group_attach_domain() is the worker function that can change the
domain assigned to a group to any target domain, including NULL.

Add comments clarifying how the NULL vs detach_dev vs default_domain works
based on Robin's remarks.

This fixes an oops with VFIO and SMMUv3 because VFIO will call
iommu_detach_group() and then immediately iommu_domain_free(), but
SMMUv3 has no way to know that the domain it is holding a pointer to
has been freed. Now the iommu_detach_group() will assign the blocking
domain and SMMUv3 will no longer hold a stale domain reference.

Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management interfaces")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 112 +++++++++++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 30 deletions(-)

This is based on Robins draft here:

https://lore.kernel.org/linux-iommu/18831161-473f-e04f-4a81-1c7062ad192d@arm.com/

With some rework. I re-organized the call chains instead of introducing
iommu_group_user_attached(), fixed a recursive locking for
iommu_group_get_purgatory(), and made a proper commit message.

Still only compile tested, so RFCish.

Nicolin/Lu? What do you think, can you check it?

Jason

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece2585406..94d99768023c94 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -44,6 +44,7 @@ struct iommu_group {
 	char *name;
 	int id;
 	struct iommu_domain *default_domain;
+	struct iommu_domain *blocking_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
 	unsigned int owner_cnt;
@@ -82,8 +83,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group);
+static void __iommu_group_attach_core_domain(struct iommu_group *group);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -596,6 +596,8 @@ static void iommu_group_release(struct kobject *kobj)
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
+	if (group->blocking_domain)
+		iommu_domain_free(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -1979,12 +1981,10 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
-		WARN_ON(1);
+	if (WARN_ON(domain != group->domain) ||
+	    WARN_ON(iommu_group_device_count(group) != 1))
 		goto out_unlock;
-	}
-
-	__iommu_detach_group(domain, group);
+	__iommu_group_attach_core_domain(group);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2072,38 +2072,66 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 	return 0;
 }
 
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group)
+static int __iommu_group_attach_domain(struct iommu_group *group,
+				       struct iommu_domain *new_domain)
 {
 	int ret;
 
+	if (group->domain == new_domain)
+		return 0;
+
 	/*
-	 * If the group has been claimed already, do not re-attach the default
-	 * domain.
+	 * A NULL domain means to call the detach_dev() op. New drivers should
+	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain
+	 * and detatch_dev().
 	 */
-	if (!group->default_domain || group->owner) {
-		__iommu_group_for_each_dev(group, domain,
+	if (!new_domain) {
+		WARN_ON(!group->domain->ops->detach_dev);
+		__iommu_group_for_each_dev(group, group->domain,
 					   iommu_group_do_detach_device);
 		group->domain = NULL;
-		return;
+		return 0;
 	}
 
-	if (group->domain == group->default_domain)
-		return;
-
-	/* Detach by re-attaching to the default domain */
+	/*
+	 * New drivers do not implement detach_dev, so changing the domain is
+	 * done by calling attach on the new domain. Drivers should implement
+	 * this so that DMA is always translated by either the new, old, or a
+	 * blocking domain. DMA should never become untranslated.
+	 *
+	 * Note that this is called in error unwind paths, attaching to a
+	 * domain that has already been attached cannot fail.
+	 */
 	ret = __iommu_group_for_each_dev(group, group->default_domain,
 					 iommu_group_do_attach_device);
-	if (ret != 0)
-		WARN_ON(1);
+	if (ret)
+		return ret;
+	group->domain = new_domain;
+	return 0;
+}
+
+/*
+ * Put the group's domain back to the appropriate core-owned domain - either the
+ * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
+ */
+static void __iommu_group_attach_core_domain(struct iommu_group *group)
+{
+	struct iommu_domain *new_domain;
+	int ret;
+
+	if (group->owner)
+		new_domain = group->blocking_domain;
 	else
-		group->domain = group->default_domain;
+		new_domain = group->default_domain;
+
+	ret = __iommu_group_attach_domain(group, new_domain);
+	WARN(ret, "iommu driver failed to attach the default/blocking domain");
 }
 
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
-	__iommu_detach_group(domain, group);
+	__iommu_group_attach_core_domain(group);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
@@ -3088,6 +3116,29 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	iommu_group_put(group);
 }
 
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
+{
+	struct group_device *dev =
+		list_first_entry(&group->devices, struct group_device, list);
+
+	if (group->blocking_domain)
+		return 0;
+
+	group->blocking_domain =
+		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
+	if (!group->blocking_domain) {
+		/*
+		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
+		 * create an empty domain instead.
+		 */
+		group->blocking_domain = __iommu_domain_alloc(
+			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		if (!group->blocking_domain)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 /**
  * iommu_group_claim_dma_owner() - Set DMA ownership of a group
  * @group: The group.
@@ -3111,9 +3162,15 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 			goto unlock_out;
 		}
 
+		ret = __iommu_group_alloc_blocking_domain(group);
+		if (ret)
+			goto unlock_out;
+
+		ret = __iommu_group_attach_domain(group,
+						  group->blocking_domain);
+		if (ret)
+			goto unlock_out;
 		group->owner = owner;
-		if (group->domain)
-			__iommu_detach_group(group->domain, group);
 	}
 
 	group->owner_cnt++;
@@ -3137,13 +3194,8 @@ void iommu_group_release_dma_owner(struct iommu_group *group)
 		goto unlock_out;
 
 	group->owner_cnt = 0;
-	/*
-	 * The UNMANAGED domain should be detached before all USER
-	 * owners have been released.
-	 */
-	if (!WARN_ON(group->domain) && group->default_domain)
-		__iommu_attach_group(group->default_domain, group);
 	group->owner = NULL;
+	__iommu_group_attach_core_domain(group);
 unlock_out:
 	mutex_unlock(&group->mutex);
 }

base-commit: dc7afe17339c2f5de8c377aaa0b976139a19e158
-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
