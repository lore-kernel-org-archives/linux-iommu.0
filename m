Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EAE4EA;
	Wed, 29 Mar 2023 23:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7wjDRj5kG4nlgjTqcbzSTFvpsaG6P2DOjwMZKOFBovPo71eqqjSJIp0FH4KjR/9ixGLfe16lj4amuFt7Y+GNpwg2vJPbctFHepy9wx0CX345GFiizhodEB1MtG3NbQFU10usfvs85mSCvNEIYJbhpcR35qHj/BXecJEL2GPnhquua1fthOvDLq47vkQLhbEMcsWufd6/zxGLpVaq1oPGzVe1J+aG2KKGiNnHd/ClhF/5YmmT3bXzFWoyJE1/Nhp32grNLN7fW0IOoPr2zVmMY5HytFplGctAT3WKIR/bo2IKhpy36fseQEDsu/RfDgL8R7Cu1xGiIU8jnrSxQWEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/a4O1LkVglEDf4goBTeaM84PL+QB8NPZUazZUaHQSo=;
 b=C2cGaQbwyIrKBEuuMF6s9gBtJmdd3G3R65akKDdbdIgA3STG3De+hBBU0vr3hHQJTn5AZDPTwqI+JBEvY1H/VCwwAqXJCyLwYAMwn64QO2YxJFcjqavAuN2Cixv6zf7+j4qD0IeS0eD/M6pZTChX8sV9XIQtsQ2Te8YHZdDc2WdsUoIlAvJMbxT0t/3xzi/nwc4Ajg8aI1t4oy/x5REF65ski6bDqntBsiFn3bLai4DDbBzyutj6BLYSTgyubrRrtky4GBthfSYiya4VJ6Xsi2f7zctaU+5FiGMsps7+P6aSPTptrw8f0UIdCGFiyTxL0oUhc0c86b3y40ukLdQtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/a4O1LkVglEDf4goBTeaM84PL+QB8NPZUazZUaHQSo=;
 b=ovdtE0X69tA4NaMINGI81pTqrSQk11dEEAbj6Vcdr/sgwM4CDfpPUfNu6LzqvnIIZADF8Tl/BlXRxvzzhzYJKuLmXZ6UQBAFJNi/V0Q6TA+MmMXJezkKA17kZqMsNewM5H0uZ2JqSm+Lrw+sMeCRERwPOCmE+rMeQG1lVS4CRkMaTOIWAbSD+CJqU2BnKHjWjYprffKkiewEpXozvzL9izxUk2Tsg1mtax7di1L5NvHnUabdVmfBV+uQmp1M1HxwB/5Xx5D8jU4gZpkilSM1/3KNTfTVy1fILWsYkdnhDER5RRyr8LOXGdzdnoi2nH4WU2j+xa4XhVPqXuWby5LR2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 01/14] iommu: Replace iommu_group_device_count() with list_count_nodes()
Date: Wed, 29 Mar 2023 20:40:25 -0300
Message-Id: <1-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8cfed6-2fc3-4014-796e-08db30af00b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eAiGBqO3OQbALQpUDEydXIiN/eTfAlz3fdCAeaALo2CFdHhoGcicMqrq1/h/yB6qSNRMk8vdIashWp79vk6hbaYQtKZjsaBo3f6/+YAvs1rKbNvvJeF2vkmGby4AOY03GbSf6yfUaX910fPYvIL61SpxKjiY4uPiNfiIESja/IoEHS0St6ewGiCDQU8QEv0Y153i5aOCCYMeOpj52HPperREQUyH1omvsft3rGQWFuJ6Ejmq/a+R+GnMJLnkq69fS4S5IP5eIj06n6AIbh/zvB64HCmrYKtG4s6xbu0n5hfHeJsFUKv7k6L9TtRj02qLBKhrRCzrzfAYB1XMXCuborPG8Rha7Xjs1k7Aj8Ua8tpCliMKVPrd83EBnmBED+8OBifQkjByHiIvCxEJcc+q5CufVUrCAWVny+Ff4sqa++OvXD+BMyhofUz3mgu1wyN7uWvB7K0CnAyvaTH2fcbLLgBBdq3Ufz3whN8z5nm4SJ+R0CK6oyEnmihw1NcE5cWvfr4EM9eVvPlbdpeMIwwDHoDdT09hTtwUHdRJvnawdNcIFhEcB3teTb9NXz03q5oF/KoS9/TSHeqAa8m1t7jhq8RV3X5ftD5XOyvBZYYbhzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+I5ChJWDkvJi6TSqLDjkKD3pt6GeGqdmVaoA5Yv4Bf0ttIlUZtiyqlN1K83?=
 =?us-ascii?Q?MpW26375quvaK6mmIzEGbRSmI0/SAuZttK5l3wuVIxfE4XaVWC3Q26mODFp6?=
 =?us-ascii?Q?1bC/nnQnjYLKG5vTZUVpde/CDd/qLuToPnTMpZXZ0ilISqLA9svHAOsCAjus?=
 =?us-ascii?Q?O7wcXGZHbimMXBJAd4V+leWSCCIyh4wntSYiCAYnNi7NxsgHznKhAJB+iXqD?=
 =?us-ascii?Q?08nsSIg4LL+6oBgnzapeSGka1FglWsVZl6S5LkEJP5fiV7iByz1SIrYJ1+HN?=
 =?us-ascii?Q?JKPoOxARgIe+CCCUQkJCmjtLtha0Us/yqsg/rvRH8KdTG4jW1+eCWKe/IpBu?=
 =?us-ascii?Q?EiWjjCfYFH7Gc+u4gm4FnC9ZCRkagvTbcDdPiCnKHXjEM3eI37w9gmb10FgZ?=
 =?us-ascii?Q?bmkUZr+6McMiWVUajXMPa0zDEK6LF1bjadiPcN6Sxpj0WbPDbNI2mKLBExel?=
 =?us-ascii?Q?8VdWSfAUkGK6cogM24FzTq1AThhvukX8wH2P/vyoJhoT4tfJVscgtuC+Tz5y?=
 =?us-ascii?Q?R/o1X8x0JsXTVGeiPLzdQ+Md5LR0iGJjxa79XpbnGYhqvPIZE5z1J9ul42PU?=
 =?us-ascii?Q?9D2rsuTb8akwSPPcPklRiqpmZtL6Q6dUPaScqjRp8Fw1AHsgif8xdaGU0hmO?=
 =?us-ascii?Q?UFS/wxX+YtyhJ8/eHW18hmnWcu+inQyQNdMpgk5UhzpYZ+N+9CooCkp05raM?=
 =?us-ascii?Q?Gt8d5fYf8ARxdRds3urej3atXuJU0rWQINSau07XFD04F61lXGJ943WwstaE?=
 =?us-ascii?Q?9vgN2il8EFo1WOIhIclPW6kVa2t99ybXaOSkVujZKwZihaxKtNmm77+bg3bd?=
 =?us-ascii?Q?VbWWk4sW8ydN+e9k7i5C/1WS+zNLp6Eu79kaOEUJ6ocGu/7aE1b033pxjY3q?=
 =?us-ascii?Q?GyuyIrPjPzwzBgctIOg1EdBK0aUUcaQwWGLUdiuq7J3/Eu5r2tHkfK9kdLzB?=
 =?us-ascii?Q?n7+uPvA3DIDg75xCvn1h+vZvOhgzlV0FB63DfmcSVB4ZtnIMcicpVxECYh+T?=
 =?us-ascii?Q?UVErz2uoOols367i/2j0UtDKkbocwQVi3ijZ//iOhrNK9GusGnxZXmB2kOt8?=
 =?us-ascii?Q?sH18M4pcr+IvCqlquA5OEsX3HF+SpXb51Nf9L/MPEmcJSO+G/85s8m1fX2hD?=
 =?us-ascii?Q?9M+2R8k8Bq/IwSIRp3GI38/T+ERtfaa20Gb3WN28THEb1ptjs1E772akZZvb?=
 =?us-ascii?Q?TYtBAWoWXcTSVylDOIy1Q5hsYBwJb37xRVWBxQw+2nRqzb3wDb3Y3RiAuMcG?=
 =?us-ascii?Q?PabLjp9FEoTC9/on9X0BdQu/1aCqp4mW7uXK9KxWpTQEIybx5FU3WcUvYq00?=
 =?us-ascii?Q?rihqeR6vLYSo+QaKfBtcjG+SeG0nu/BWo+FBQz4o9eNwn7A9iiOEoMjuyFyU?=
 =?us-ascii?Q?1z5IYBLj9bNFjRTrz52SvrLjUotC0hntAd70uZOTWBO3JHupH548n30uRz1V?=
 =?us-ascii?Q?9j0k0kOzSlUAYuVJkEQFZe/mAcugkciOWyZUT1gQfl+fJzuxA886T1idJYMz?=
 =?us-ascii?Q?hRMvH/VloYjPtjWlglIIkLl3xeo4TXdjV3nMyYXBVu4ND3MHRxHnKNJXKOVM?=
 =?us-ascii?Q?v6/In3OzERuJThBUF8p6K0ulQG8pk8/pFcMUlX6T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8cfed6-2fc3-4014-796e-08db30af00b9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I06ZSPxthcdDEKuMZucN9GI7Yck89z8oLYDOHbfRkGLCJQHoQkE4xlhcwc62VmST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

No reason to wrapper a standard function, just call the library directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7abee83610b6c9..8cdf47279704c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1149,17 +1149,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
-{
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
-
-	return ret;
-}
-
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -2101,7 +2090,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (list_count_nodes(&group->devices) != 1)
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -2132,7 +2121,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (WARN_ON(domain != group->domain) ||
-	    WARN_ON(iommu_group_device_count(group) != 1))
+	    WARN_ON(list_count_nodes(&group->devices) != 1))
 		goto out_unlock;
 	__iommu_group_set_core_domain(group);
 
-- 
2.40.0

