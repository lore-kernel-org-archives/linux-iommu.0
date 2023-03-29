Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C945E4EB;
	Wed, 29 Mar 2023 23:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBfR3ckvLQn4qjZeLzB92cj5OF5h9gjMcu5pyqt4SGAc5fpTONNZraqIE3LbPbrJxu9a/hfvYYy0FtU7h6FAhWp8kQXes8oeq5hfi7RxYE3VzzatVWtKEqK86icc3mhu+ETzzhPXjXU1wk//dRvFyDAIRo6z/l3nW2wucgICFU0smUCwECq8bJheZGHesrTpduUYTdzxDDLtQG+sRkIGTXUyHM46cMcgOVnSjldHJE9a8accUU8Rjr825EpnDv7+G09Q5RNyS9JE7ntqLn4IOGdrXw4tvD4ZKstEI4WuOIdr1VshXGyMhECT4Hyjv5XV/nww0b/KTOPvuyBjNRzoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8iN0lm64mMItxL2Vxs0iers/cHU5oZrqLfUjORU+Uk=;
 b=dco1IUInWu4RaQ5B0yxQhA8YRos4AqtAne/Aq2aJXX1cXuTukxhbZSvYFUIH3mt3PGBxpQiaWPNIqk9xAO7BO8Wqt1t91MhIDkL5zzUe84C0E5yNvi/ZIflvcRWdcZCcJQVB2jlBsckBaMS1t8KE0CxuXVauMqAzDxq1HqSSpNgnvYdRCZAb131hLP3wmAnxdvEwLxcJf2vxsYexWrfU3/iDG9kw9YWbLOlDya3USfThlf5YT9u2TaiKd6Nh9HkUg+7g8SjvJkj6fiXnfqZYpIXyLSvQUdbFg7QTa3PQRNdGf2SYODsR7n03dHxBtaNVewUkPcuIES94HP2xJgDmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8iN0lm64mMItxL2Vxs0iers/cHU5oZrqLfUjORU+Uk=;
 b=UE/Ex3SI8BclS68QbBHUnThjfYXoiEslzdIyV+ZvUm/SNESP8RUUc6kwHiVYmEYqJxz67I+WYHQ3cIxF3GeaP2pW5tpFwhAf7gNn4FUfSeKUOIVJi/UDL7EiRmIZerHpbxEnhWTxXbmUEdU+bj1M+ti0PP/4cikd1cER9rh/LJq2XuW6CHOh5RjWKR2SMMnyqZK2MxoAwzPPeFnso4X8MkViV8SIVLXRyZF31R7UFbJADNQ3qTr1xb/Dfl98QiCYwPemGWexVx/9o7KOBODrr0POnUX1VltnM0SHZOs9GKAl6Yn26j3mbAi1KQhzfB09Acxx6+D6S6TQAysCKMUkMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:43 +0000
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
Subject: [PATCH v2 09/14] iommu: Fix iommu_probe_device() to attach the right domain
Date: Wed, 29 Mar 2023 20:40:33 -0300
Message-Id: <9-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:208:2be::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 833ef5f3-cbd3-4973-38f3-08db30af00dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3G3OL6byVyml0PQdz0J3EN43X/9KZ+lpCnP6NPv6YKKFU0/c6bRulSbRJGXlnPpJUTddX4VOPiXH7ifEW4mIN+/F/fK2FRWXam7NEkxGy9X4VyvFknmaAEGVUjtv7wJ+ceA2mmVovuZNqd7urqMeuBL3a78XsBPVoaEXUZGkFen8v/plmrtv7q9Ej8zxegjT6ut2+4cYl9LC3JxDxpZ3lN33EZL1I6zQb4CR2mYINWRNd+vwNfQQmJOlKgsjOCFhgcbC+UZZmk0k8I7tSlpad5ep6P5UCBbqeXOPNrmal3/wDEdq182sHzySFqFYGKEJLmOJe6n9Im6T1S9sDvqkawXse0c4ZiM3RlnooDNO1OlnoOcONrAISkCGqgNaF2qALyfnA1J+JZgCCFgrLiTDnP33+02jxjdCx7w3Xf1D4MO4w/E051Vn5Nzs2q97qWX4toYpdQESZ53bDDVDwZnZ/vXKLNF3gn0TAfii2yBjFw6Y6AYKgEGsVctiGzF9v9HvB8d6LB1rJgdKLc3aueWkg34blg9luB7b8Tq9IKhTFUHCwroQkzDwQM68CvWk//OuE0v9juLQYNihg+aFJ6Ulu597J820yVbm4mvXclktl44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PRH8CuClrGp1HzVzNEoDiz8AxEB/lVnXvY3KQnPsCE/KkaMcs+S6yrWwGPr?=
 =?us-ascii?Q?iiBC4WW8A64zLGm7kogHkD0VKZVgbrZ6hrdlBYpjfvDxhHY4uD6lzwbF3xH/?=
 =?us-ascii?Q?imiBHVL2T1eqJWxBd/FIh/fv+UIeoogIOZTEfhQurZkqWQHC67AfpNdkzFwk?=
 =?us-ascii?Q?AoXet4TOAtzec28EegLngrxMHy7wLtOsYoYPvp3pLjkv3R5tJOJeFzuis7mJ?=
 =?us-ascii?Q?M9HPi5STdtlJKmJJ2lNhbhhrl7ELCt5gfP1WFCDEHfvDwcteeh1Du2IikaTl?=
 =?us-ascii?Q?m4YI/+6/9IEu4XdSZ96CWcX1Iiqc/syXBWIh4HSUhBDr2hcy0MEhY0s1EuSp?=
 =?us-ascii?Q?CNOOddJC5cNwaxKgXWNnCHZExwQhuxvzLfRjvRAy/tJN9Hy5HppMp7C8GJtB?=
 =?us-ascii?Q?MAu0/aACdBYiuuchi6M46Py1GHwAg5rJVm3V/gyUWli/WkP0RUlzqDvhz1TZ?=
 =?us-ascii?Q?C6OKrh7Fllca9hoR4GcdrasXW4gue6M+ba+r5QUasPBdM/428RgXnuXWWhpR?=
 =?us-ascii?Q?GbjGOpmRladIXsoTnh/NMVVLiAlbVxg50Zx1ugE+/BXeedne5+jUFRjxOFMt?=
 =?us-ascii?Q?AXc475qXLLEwux4Cf01YwYtzz1LeCgd64vNrQiPnDEm0bz2l3+/LGQMeW7gF?=
 =?us-ascii?Q?hzVwXLw/5afI+5Wdb9tlp+8JzaDAHiISJajMZ2xwdq8QwWoB7cl0D4GN/vMf?=
 =?us-ascii?Q?6hViNxnU4Xpk0P5uMwTHCTvMBmHT6XwdiiNQ4+iHVQmS+yradpXuXnOLKAhb?=
 =?us-ascii?Q?VKyAvpa26OxPLCMtk2pCYgnfch17wt8Nbb3XMmwHOrblYMzMG7vrcXk43dgR?=
 =?us-ascii?Q?wKf4Y4diJwqmXEyMn2hmRGSrgfa+HLmkK1zaJkVPGjxV7KhKP++R5QY98B6b?=
 =?us-ascii?Q?5Lu97j/O59D3zZ46mvrCpZS+Gc5eCkmo5gcgH2wsqaLYjdO5Hejfp+2S+KYQ?=
 =?us-ascii?Q?tbP7/7lTQUleet2/z6rj6cePM+vC7SUxCuOIAsaPNNSREK4LmdRFvhK68GAB?=
 =?us-ascii?Q?NUg/WRyclFF/sljGH7/B75b/0t6aUmUzzrZyemePqD5NBANWtSCIFrU+HHWG?=
 =?us-ascii?Q?lnEH/aKh28lwKLL/Y9MHk5/iITBJr4B/Wthl8Bp2gbZaQZFNU8xovp5uzuj4?=
 =?us-ascii?Q?Ybrh/x21HKmJvY3KRCuY52AROFcqOQb7KF+7QUphk5WJ5cUJJUiEktJKKJG/?=
 =?us-ascii?Q?Nivxr91Ti1YBIo3QraQ6IsPEfaiRPKe7Mw6KaGunG61v3cWD1Q6FewtXp/R7?=
 =?us-ascii?Q?1RXoURUN8LKn9wcq1Z+1sZf9qXGgQf5AWYryHhCbe5dDd4JruMGiCCrRe0gq?=
 =?us-ascii?Q?rWNd/5nTS3o4B+RjYzfP/WCfVeR9eC5ln051p91lrl8mck/RGa9Co5L3hvt8?=
 =?us-ascii?Q?8FzvcX7ztF4/XtVRJtqeVVyb0wAK4/U/sC3TecFjf12N+wnyB8NhWXeSCUNE?=
 =?us-ascii?Q?oeHbcQQk/XfCEYsUZLKqrK4UMIibAJJfzTg3oIOBPH1lDnFsUr2QOuugXzsj?=
 =?us-ascii?Q?h/twKptB9BU5j2d461wyUIXpEbi+fEiIrfrPzvF+nWTJJpvECby8ipMB7PHl?=
 =?us-ascii?Q?deJHa8E+h4EdJe8p/T9YxSKHKb55PTGik3vjZ7Ni?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833ef5f3-cbd3-4973-38f3-08db30af00dd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgG1YhL4KrgDHyYv49yVI9lyARGgdpHDJEgAdcWKgT7rRXGxC/3ZryduDjC7ZriD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

The general invariant is that all devices in an iommu_group are attached
to group->domain. We missed some cases here where an owned group would not
get the device attached.

Rework this logic so it follows the default domain flow of the
bus_iommu_probe() - call iommu_alloc_default_domain(), then use
__iommu_group_set_domain_internal() to set up all the devices.

Finally always attach the device to the current domain if it is already
set.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6fe8bc78db2016..5bbd667f727605 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -432,27 +432,32 @@ int iommu_probe_device(struct device *dev)
 		goto err_release;
 	}
 
-	/*
-	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver. There are still some drivers which don't
-	 * support default domains, so the return value is not yet
-	 * checked.
-	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
 
-	/*
-	 * If device joined an existing group which has been claimed, don't
-	 * attach the default domain.
-	 */
-	if (group->default_domain && !group->owner) {
+	if (group->domain) {
 		ret = iommu_group_do_dma_first_attach(group, dev);
-		if (ret) {
-			mutex_unlock(&group->mutex);
-			iommu_group_put(group);
-			goto err_release;
-		}
+	} else if (!group->default_domain) {
+		/*
+		 * Try to allocate a default domain - needs support from the
+		 * IOMMU driver. There are still some drivers which don't
+		 * support default domains, so the return value is not yet
+		 * checked.
+		 */
+		iommu_alloc_default_domain(group, dev);
+		group->domain = NULL;
+		if (group->default_domain)
+			ret = __iommu_group_set_domain_internal(
+				group, group->default_domain,
+				IOMMU_SET_DOMAIN_WITH_DEFERRED);
+
+		/*
+		 * We assume that the iommu driver starts up the device in
+		 * 'set_platform_dma_ops' mode if it does not support default
+		 * domains.
+		 */
 	}
+	if (ret)
+		goto err_unlock;
 
 	iommu_create_device_direct_mappings(group, dev);
 
@@ -465,6 +470,9 @@ int iommu_probe_device(struct device *dev)
 
 	return 0;
 
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 err_release:
 	iommu_release_device(dev);
 
@@ -1717,9 +1725,6 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 {
 	unsigned int type;
 
-	if (group->default_domain)
-		return 0;
-
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
-- 
2.40.0

