Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32567D52A
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI1sADXdXe1zdelICwI21fbfSz9jrS7dA143IWcDr+0ybSK9GN9IhqQHl+9UlgdD771SkU2AAU6Ms+DDkPcX2ASGIqm8to5VZm9YVLOjfD3l5Oob9+x/iEbwmYyopF/ADz/DcHTSRgktuq8Z5SiWijDrUGkgY3bxClrWkgmbmu5kZC97XvkKaCx3K+Dqb+yXGX680TQiiVTdiYbYpsx+IoIfKjT6bSuPjF5OQSzbsaYhp+5HsMpr0tdQQ2i6Je3Oj6finvb1iPY1gvwYSX4gDacatgin2dD9HJ4gqfdZa6P3yD267Y4AOecmI2F0C5tJRgzBAfZXEsTLseZEaDaC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIpbCZnNsE92o5FREdyu1FqLSuZUZmnRZIe1lMvADao=;
 b=RuhQtOXH4SnHShvR2c7m5GARHLNW2DRSl6G8XL0nu8Ds2qac4lJaZNpddpzuW0SsBLiGSxZ0vVlCxFfBhJqGEWFM7gxfNflgbx7md42XVAsaQn8OvBZPVRidkKDXounhg09R610ScCaYLetpMU+GXFHTHGLqQ4ktKkrQVeNlzpEg1Rj2saJBzNQWsyMtVK3JEgoswkCjGkRXDKS+JhpYWY4byOHrlQVOelBEpj0kIV/WuAa8wLrK8Va2Lyld3VhE+5tlb4eS1vDPnkzFV1TpHDYs2o2sig12oUpPXtYYOjgm0Ycn+PcZiZEchxBFL0Q+kxvJlZmW6Vxz6ftQQqybSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIpbCZnNsE92o5FREdyu1FqLSuZUZmnRZIe1lMvADao=;
 b=dyloxXlLIpkYk3EtOB4F0sA1oztSM/vUjYGaetC1dVCby6LE+J0cZJvlzE1fGbeAoSCXVBrUlDF7w96kUrhVRNyH/iEJZuHUoZ93AXibiJnsE7A7jXEGXnkKRw4shQzdOz2nEVEOQ6Ge5g5Szet7cDVtd5SDYpq6ImkUppBVtyURPfdsrRJscQ9KA7ycQeiIkPn7kuiPDMV+ZxOvBLxASWS1F8Tf1yNHQvz+RxB9DHmaGGWA/Ygbm2AOfzfZoa+rYk5eU+8vzhpRMBfrlBYcof3iu02IWD0cGwVJoHIKzfJTq/ogyO/4U1ooH3dDm/nIkd+5x9bAJoZua1QND168Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 2/9] iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
Date: Tue, 21 Mar 2023 16:53:14 -0300
Message-Id: <2-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DF6.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:a) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: c29e5360-b494-4b07-2a13-08db2a45ed76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	blQENceeWxCfFnEkJuzbjNbsAwE1EmZOzUMqEquWkJEE5nTimvkJSvZSb2rthLzgZXqfMsofoiSk4LXFQ+S092maqIvFPajTZdz8roMtfHuDqj3VkPg7ECl9KCt+wsB5W1InwZEXmn+Q1vhRQiMmbKVvFo1u1oHIbB6d2jT8ljYfD9dvJPL298xBeHuT9aoai0yfj6ALk/5ZZ8xXVLfDEAF4roj01nuuRHeQSUX64vIVeNFXbqDmFdneru8c4Dn0WeStEQN7BZMCs7/JwjaegF/ke4/A1lraHzfaKF+NCmKSgQNd8tQDsu6OF+tO5s0H/gyrFL+W3RFRQMXFwZZJDkGvVB1YbyV7/CLgRzo+DQGdCfnV3zk+jsi1EqMJSvAk5TPgZAzliH2A+NyGCE4vJiIwJQlRcKtDzYNDY36GfF6pKNsCWzSGm/v9UVqvBQNWriN80bMWuiJG783zur32v6Qb/BrCZSvFfZlKq+vEMHNWUUYhe/lnpdIBVN86Mzo7v4nGh2mF6Ybeyiz9l4XEEcF7RWzeT7pLVqTWIS07zP+DRm5A0KNXjFbRofo+gY2DtzY1X3HHmeJzVDcY1DDjtUdf0rF+tLnwl6SNiVM1R0vschewtIiDrrIYDinHTGPVtSmVqyRzUFTtgn16DwKn/v7hmsc2UyTI+v9K4QkfiLFxic+OL539A+llYCE9fQ4v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(66899018)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e26DvMiOAnJkTXDKBODVLuTuJBY3e4+0LYBcaXsRdKvBKfoVMYm+4I+A26YR?=
 =?us-ascii?Q?KsC9QGphFM4LUQFoiZMjQlKKq8srFRqLH5h9lESDDIkbhIbrb5p71qVV4DA3?=
 =?us-ascii?Q?tvJlBRUqucIrqaZ0V3N2Ee5SzJfUXz8AV5DV3IHPvii62U5gGyizoMHYRqok?=
 =?us-ascii?Q?X5A+jjoXCjSEIyKYnWewRe3dUUjI41NFL6wt8dQZlwhyD+FJA7GBDioximJv?=
 =?us-ascii?Q?iP9uuBgijJcu+D+fU1CYHE/RYAS0gBfpiC9Ow99twP8fD4ryFl6LEOt6lQZZ?=
 =?us-ascii?Q?kW0Wp6GCrZSfbSXSm0nCUk3R6hyts7bjqHCgzBmUZ3gWIQ97iGuzbSx7Qs94?=
 =?us-ascii?Q?I/tn9MIMfz/11X2X5sleqwWKw0XC70/iQ9Ihfg7mj1SLPEmIWgUmEhPB64PR?=
 =?us-ascii?Q?vzTtcNHqWtXHTptFMGgT4awQjEUyIRZcxdqvzM6db4EMBUYZfjkdrRYEiqBE?=
 =?us-ascii?Q?8eIRzwQSwmWQ4tg7ncF3s0Aj0hMYOLpbv/+a+hRUzCZGT0GKNiCESUpOpEmG?=
 =?us-ascii?Q?6MBOTTxV1LsT85oRXtsiY+bvKfR/I0NzyFSRSjUsjWRTpnD2gVUDZax32p+0?=
 =?us-ascii?Q?uTskNy2mJkrJRfop7j0nh/UAafiMgRTX1rsTcGP9xCavCUAO1/KcORs7qjea?=
 =?us-ascii?Q?hpQPLrBjr5PMAv4vOD2+V6JDkG9geG+IZs79WJRrFWUV83wc9Z3pFRLZD8Tc?=
 =?us-ascii?Q?18ibgr6aNPcFFXbrcXFAdBrXDCskOWj6IFEmuu7arFmuIG0kTDBMsmEHutjZ?=
 =?us-ascii?Q?IJIp3TWiAmiR3TqXGdDAU7PHH80eNBWlVQFk7vcw2Lkx0aaP3GqcQO+7920g?=
 =?us-ascii?Q?LmBRCEiuK+YYGCW20R8/s+iaLGV7HvrrhA/ETPjfatdYTEOQw4ahgf3PVbcN?=
 =?us-ascii?Q?eS2ZntTtlIH/Tmchx9Dwg2vK/wRuGPvIXC6T5u88cnEV0HjBttF7KXxhd9Uk?=
 =?us-ascii?Q?iEYEmptZVSNo6uHDYT+2lIoQLXuXcU6ucy2rfvTIqjB89sIKoyBmvRTCJxHI?=
 =?us-ascii?Q?rz0bAiWDPGJ6WrvPY/BCiRFaDJ2vuu2s578yam6BVyMrmJq3qR/mD6Xk/I2F?=
 =?us-ascii?Q?DAN8GkYs1BQSa6iWXCMcsv0UldRf3En58lL7dPHOD43gvNXkZ5WaBtU1zbg9?=
 =?us-ascii?Q?ZELvAxvUzLiIpIPwYylOspK/iV1lcLYRo7OWbx9x4TlMkISISglSnORA+IDT?=
 =?us-ascii?Q?/CLawuBLVlH4TQIaLbM9vlWKxHfaG7Q3n59/7mTRDaoW5W7wh9EwXqRTOsfj?=
 =?us-ascii?Q?Vjpyr1ym8ALYYnIJgD219ZGm7pNhfuF9MKXhMiwyiwE1PqcwkZuIcuEpjI6l?=
 =?us-ascii?Q?PLiYMj0Pd7eV0I5fJmLifQeGWBYC3R6Uoxp0Q15GEEnKl5s5NjXyRE3/uUPN?=
 =?us-ascii?Q?LDJzweBGhR/xO/wIWSeCB61m7M7e/QMHTpzMkUnEp4a7twUm0XLaUkeTkyHD?=
 =?us-ascii?Q?sQbQ6JMruAHhWGqxm3gbE/4vvzJ48xNQOdLwPAmdNGAZ+MOjTVGQQzMwKmrI?=
 =?us-ascii?Q?qMd+f4kA+mywGMiP6cA5h4kZVI7ax+yLGhtSrQRVHH1eOgHaFOS8YAo3knyy?=
 =?us-ascii?Q?cDr2PY9ZZRHjtUzKVpFQVuhr8CmFZa6PiaYhhVNv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e5360-b494-4b07-2a13-08db2a45ed76
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:22.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8xF6dNn+8CNteJu+kkKj0AxH5xo65KdkyyX5MKPvbtBaZJWkBSgvwhbobCFkFFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

The error recovery here matches the recovery inside
__iommu_group_set_domain(), so just use it directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6f52df534decc0..96323c8cff0168 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2136,52 +2136,14 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
-/*
- * IOMMU groups are really the natural working unit of the IOMMU, but
- * the IOMMU API works on domains and devices.  Bridge that gap by
- * iterating over the devices in a group.  Ideally we'd have a single
- * device which represents the requestor ID of the group, but we also
- * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
- * wish to group them at a higher level (ex. untrusted multi-function
- * PCI devices).  Thus we attach each device.
- */
-static int iommu_group_do_attach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	return __iommu_attach_device(domain, dev);
-}
-
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
-	int ret;
-
 	if (group->domain && group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0) {
-		group->domain = domain;
-	} else {
-		/*
-		 * To recover from the case when certain device within the
-		 * group fails to attach to the new domain, we need force
-		 * attaching all devices back to the old domain. The old
-		 * domain is compatible for all devices in the group,
-		 * hence the iommu driver should always return success.
-		 */
-		struct iommu_domain *old_domain = group->domain;
-
-		group->domain = NULL;
-		WARN(__iommu_group_set_domain(group, old_domain),
-		     "iommu driver failed to attach a compatible domain");
-	}
-
-	return ret;
+	return __iommu_group_set_domain(group, domain);
 }
 
 /**
-- 
2.40.0

