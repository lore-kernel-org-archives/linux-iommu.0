Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CDFD52A
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy7WgswjVQYlfDW2Yie9HspNbrPEufV2wBjJLy4sDwJMkN6S7oyNmHwCpideI64Yw0ksnFkS2HHMEmZYM66C/71EdpS8g0laQICj13PIM+B0ZZtr1+quUlHJg7XMXKBoSmJhpDcsMpmxhHJu7qo2SYqoVMyvpHu4QdS04iE62P59+rtVuneFWBQmCkqNYFOmi99dBbtx1vNfuhlVqyjuS+Wi0GRLoVp9Fdxkj+4JxqqAXTvHx+3hs7LPFf84p0WUtdCrte5lodTylqXTh9b8wk3MRUaMrmepyRH1gnHewxl8CUwM1qUpj4ZJKJI5iih8kKQRKFIhvwS96jYe4U59+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNun7lGBw/LPIqSsoScPKknJqDLno8b307mRQQ8Vb/w=;
 b=APvt+WBEoWVR1L0W7xXrCZTrRhAC3fp78+V+hR80tG8kGiECiLc0OJc8jSDT1Z2oBqXc0L6ghAAM4dlkvsfUGYllhLB7dEzwwduiiV8OmKD/XAuruM/DkVi3k6hgISAKk8Lri5aCRK2LtbZmZDBCuAQfArSMKMYdOPigWX3a7I3+/alLwKjCFObFcuQpi6t1M9wtnc7Q0X0l9mZiucU2QSvy3fd2Q5p0u7EDqpv3BeIVyNL5SbK3p/6ALziYNPN3cQMSItN8fPE3F5NK+09eFI7gQpBkTB4A0g6VfA+x+szBaM52bkHV6FHou65FaXPS7/c1oCIAidn2vyvi/nOVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNun7lGBw/LPIqSsoScPKknJqDLno8b307mRQQ8Vb/w=;
 b=h+f3ytcAB7JclRugDuVPqWxx1QRVqZsjCV4C94QvNqQidZ2ncga4vnp3i/aiHNrGj8Kl7VIv/rlwsCDE05EeTsXEYsp9F8rWvYwoOFAQ6xEJv9FARh7z0GZxhcYcJ+sjdprsichbksAJBPE4cAI73qczAcYPSL7TwkEwqU3996T56EpyJXweIxuVB533kRmyY68VyIdGdTqQCg7x6tXu7+p27XJHwgx9LU3XpgSJzjhZDlAIzUs2IVFqvnJNLdraG5yKITXhgZUQrQZBwPX/K8zibrG1fYFW1XqH131OBbwCpsuj1AwF2Ft2WWFIT+5IWkM1uQmo2iKd1eRoTJcNjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 5/9] iommu: Make iommu_group_do_dma_first_attach() simpler
Date: Tue, 21 Mar 2023 16:53:17 -0300
Message-Id: <5-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 400794fd-92cb-47db-5b14-08db2a45edbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CAOyhffx9tSxF6nIDVIl0s9hJQnrm+gr5JxSH1aV0TgLYJwc0wA+E5sKOYqlkscQAUdFVQvkn3FljC/Hi1k+uop6fdPp4I6RV2AExekabEHWZb+NSxXeDY1HEYrJ+Uswmu3scQNc+bJMPOPkCKEI8V6qEP274GNj36NnXw+o8271hPm7HenvYmZ4CGa6kOg3PCpqCa6OHWSV7W+KXyRlPPbX4TE+sLS1nfW6pxHu0GNgL+crBr8piuBSoROeVOEqBuazF8Bq1xeXChIN8Qqi73rjHnwwTNFiwTjmaOnTGtEph5XyPRg9hrnwPoci7nRw9XX1W5dUL1WalyTofbtFpO2xKAf4J4p+XG5I9aWPWx2y00bZgXq0XX9gISZoJEItcWzV8THvhlQji/e61j9pF69qx50COD04JgCpwmLiJsbUomgJD6/9bWqdEgPLEeA3X7jXw1mXQuxkTUGeoGieBNDojnzu7sY7eQlWVJHyFAthMKXhDIzKjWSwGC7bWzWNyPR4sfF7+Io0gfUECkX1QAhpr5rP5TcI/F3vdtLmSM6C/Sz251ASorUj2S6rsmTkKnambl7RUiLm+5AuaSh3JFkWDvPdTAigJPilujxfRzg1VWrIkLbqDQwIwH8hbzN51CZSaPGoqLcZU5hOVxjCuu1I+mjyKOUCv+ydbmQpd2yMWAU6MZilmnY79fWK9ACu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvyoE+CCqcsFmYOUs/uz23w0iLgM8WlShkqlJCWkP8TTsTI+CcrhxD08GWUj?=
 =?us-ascii?Q?G7GN4IlcrZBJZJ697fIkqxZ95LgmtpvT5RnZbe9OTzqnm7yU/1l6I8a3dHNZ?=
 =?us-ascii?Q?0V3Ph+U3Unb0L5Y38r42TXXYVZQ+bmdoBit8ZVKcneGlc5ln+CFJZ13oFO+m?=
 =?us-ascii?Q?U3pvm5rrHALgNu+F709FoOjkQenzfFPcG4nd3NtI9aDQBbewLLDF/H/WZW/P?=
 =?us-ascii?Q?wd1mpTevNJQpWEKpQ8AKGL2SU4VpVqd4A/+ZKqova8yuA8/DWOa3MfgbsRtg?=
 =?us-ascii?Q?Z5M55gi//fVD9wM1X5uyJIHhbulU/wZ23bXfsuYsEXCWaXgTna3J91Egyg6i?=
 =?us-ascii?Q?kpZsVa64GXVz25124gJ2EfigaV5f7mXzINJETSla0nNuWu8Z4kKF5Ery3Y05?=
 =?us-ascii?Q?vZDqHR6hVl6TsGmVldsQjn04S5SWK9KNLHYlk44W8zfvB7kzg93RhHzr/r9B?=
 =?us-ascii?Q?7H8XKLTsPNrbi4Wge9Xb1yCP+M/O2qv/H0Av11+iq5DiozsqZTrHdWPNzYPh?=
 =?us-ascii?Q?9dgZAvM4TbQTf6+6OvwGeTsvWPNUm+cvkKHQpTjgiJiwry3gu9i8o3cShIF1?=
 =?us-ascii?Q?Fne6HRjqJOU3C3RgbCRl6p6IW0xkKu0AqUeVqx4vdcc4JIMyGEo91idVRL51?=
 =?us-ascii?Q?2vmiwFea5pVwDnmIEIxFJDGahK6U/M5aTXiJM9DMzJArRT6b3R/s3vO5jdtN?=
 =?us-ascii?Q?CdCdGKpOdIafda5Vf74XgZlYRiZB3uymzN/dlv9iK/5nlZhlV9Tu76LfqcFZ?=
 =?us-ascii?Q?kPVvl0dMLaN+cdsmgeHSeeZd8xJvIwUW1KvDe9Y22IvbeF3yFDCQrgbWsgHa?=
 =?us-ascii?Q?9FFsU/OraSR/I1t1zVSlS++6py+4+buHVyHmSAvbxhgeweQHWg+zgqbOFqMV?=
 =?us-ascii?Q?K/9S2MAxyo/j7/6EQu1NIz59c4KzD5z0ykxejr718lxK316/VL1WBc5i5Smy?=
 =?us-ascii?Q?S5FF+PnMyBf4IGnkj3ldX1QQavu54dUT+WeF/fJxYkxXKV6ofCBpUbyGkKdQ?=
 =?us-ascii?Q?mnyJ4VZGJHSH3iErzyYBF/ffC1vLTSOM7kyL22LiFSh+s9WPsX2HWPozRd3M?=
 =?us-ascii?Q?/sngxaezxD5PJZhK4g48rGz6j+ZQbnFRex4h7/xrRgVQgUOj1sHUmodHrBQX?=
 =?us-ascii?Q?wW80H047v9cChR3x3ztlavhPSN4tMCJS2LuLuzqeH++/gxSQaYV81KAyZYjg?=
 =?us-ascii?Q?++oHow4UEaKOmrrPjI8oJVkfcpmtbF0+4GyI08js9Y6nuSxhF59od7xT1RWF?=
 =?us-ascii?Q?K5bQ3FoesnngQ7V8KrDmCmWkJbJwZjDeBvvSUGkNZdS51Djhg7PEjkkcg6Dy?=
 =?us-ascii?Q?P5s3o3hraVSF8VzGHy38hFz1QFJVsAO77ebKNdOJjT4qWvdkLcGnF5tn1gcX?=
 =?us-ascii?Q?MWz/ozTJeAIFMOsk3QACh1Oq3IT4WUQeabKhyEvHsyDFUBBwdEzY44y3iYfJ?=
 =?us-ascii?Q?Jpwq9uk5RQBjoBmsUrCTrxZM/E+06HEXQS8QWdjJV1ggvHFPCic8hwoMDLlP?=
 =?us-ascii?Q?dlkrleZmqY9U09Om07AIpXGsdGvJda8U+/bFZAZ2IsjgsVHoUoVTmqgKT5xL?=
 =?us-ascii?Q?2RKgiTXTvj7mhAqiRsqY8fFaW/GVMSqzqKOZZLcP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400794fd-92cb-47db-5b14-08db2a45edbd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j+XGnBu748q0a5LheRw0b+VvaMwHPE5jNODA87fLx7oZuPmtW8rNYiA6uhMjG7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

It should always attach to the current group->domain, so don't take in a
domain parameter. Use the __iommu_device_set_domain() common code to
handle the attach.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e4f9ab89d38ec..ea7700bbcf3399 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -102,6 +102,10 @@ enum {
 	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
+static int __iommu_device_set_domain(struct iommu_group *group,
+				     struct device *dev,
+				     struct iommu_domain *new_domain,
+				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
 					     unsigned int flags);
@@ -402,18 +406,11 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
-static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
+static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
 {
-	struct iommu_domain *domain = data;
-
-	lockdep_assert_held(&dev->iommu_group->mutex);
-
-	if (iommu_is_attach_deferred(dev)) {
-		dev->iommu->attach_deferred = 1;
-		return 0;
-	}
-
-	return __iommu_attach_device(domain, dev);
+	return __iommu_device_set_domain(
+		group, dev, group->domain,
+		group->owner ? 0 : IOMMU_SET_DOMAIN_WITH_DEFERRED);
 }
 
 int iommu_probe_device(struct device *dev)
@@ -446,7 +443,7 @@ int iommu_probe_device(struct device *dev)
 	 * attach the default domain.
 	 */
 	if (group->default_domain && !group->owner) {
-		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
+		ret = iommu_group_do_dma_first_attach(group, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
@@ -1049,7 +1046,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
-		ret = iommu_group_do_dma_first_attach(dev, group->domain);
+		ret = iommu_group_do_dma_first_attach(group, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
-- 
2.40.0

