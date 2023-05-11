Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A611E51F;
	Thu, 11 May 2023 04:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgWWeSmuPGl71r5HyJSt9WZPWF2gSMR5btbbiKsqGCxnmrbIZ2NR50t/Uw++tlcRxapZQaA2ikbvQL0/bCkzuAV/ANyQfB1Gz9QWd7JhvZ9+LHwkF5dBFuhkJR/fJnhBQ4xjoBjqfkAbILFpWKFxWpBzFnCupkWhu8CUy1OMOIl6PkR7OEt6l6Iif0bSwN6VqgSBYl0HofHvOZ1wBpcV5CtN4et4zaU4qHvus1fyvb9Ro2sWbQr5iduIqVhvTBAMK1fHwm2Y4FZCr4hNPQaWotuI2dxS22j8TLYu8AIOMZkExCuIQcUpHou5ziihCn2LF8iiA6to+YMe5d5tbsYwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LxQqojU/KywifOnEcEtrdW/i7Wxzx75ZSFZKz6Smvs=;
 b=gOPqwFvbD3jbsKtMHRAACuxK6UjMsgQZduCkJ/dSlaM/As5Jg9aIfpPfqMgGFpxPQwx1Vi8ha6gbdtWPdSnQPK8lM8N5Pb5QiSCjb4a/oKlgY8C+pRDQtHUstTG9ERTwuktM5hqGrJfRs4FrW77LNajUrB0RDzGbIcE+dKbfzi+ifmF9q9+hsUAl+nWpwuml1rAzWwEWhXeV7sy0u1jbQq45TMRUppMCzlwB6/UGuvwR+IRr23YI7kKtTLz/NN4LkZdo7rRz7mCfgr9ELt2BZkoDnCd0cwIJHPXoC9dgzjdEzCfDrmJX8/X5oWa1rvJ49k56KFdy2UwElCU6CCLgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LxQqojU/KywifOnEcEtrdW/i7Wxzx75ZSFZKz6Smvs=;
 b=Yt9wsGEITwh+TnCHoVp3KxNGkpank3WGEFkuFS4PxW96+1AQgja9iOelkdeu1cH2zuBYB+llR//UOreQpTy/IhzzKHtWUFlmMueaI9LQjy8KklnHgJ9+ttopeB7MCfH+bDdemi1z/zWmj8S9UKvx0MDpJGdxQsqXoYDOkDFrW6MoIyQ86YSoFzKv4a0/dC/bSkCNXQmV/jxQIh+FVBOitDeEwqtFPQjO/JjR0DemA0lNipPzaF3tsFnmq1Tb3dsZIqu6HBTc1Aa/J/CL90EvToi5ix2Ogyt5hjFp1K9VgnVnDoUoIgiSHBfHZ9u76kwja/t/Wz+zMIopI9up0cRUqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:20 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 16/17] iommu: Remove __iommu_group_for_each_dev()
Date: Thu, 11 May 2023 01:42:14 -0300
Message-Id: <16-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: b2137d76-e5a1-47d4-ee0b-08db51da19c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MIS/zA9/Kkskb9xprRjseo/Y9hm/Vu2VbKQfUQmOv4nxgwOO9APs0F8XI5zdoCETVYR7VMF12tR/uxie8v5fuI4OC1mjGWJgPs+3YXfemag1qa50aoGL+VNHVC24WxMahb0Ezu+v6GL1ezSWyjJLQK3uEnx1k/Rj21PYnrrWPTB0+A9G2I+j/J75t21BvUpIv+ZX+nMpty4FgsaXrnxtsXMbXkBG7h33djilryaZgxAmpyKUMKwOmJ//nGUk6EHEftb67exQe+K0P4PVWsuXBaRGv4Qqy+NEid93kXCFRvRpmUr0OqL4s6BAz1tziFGjZ+j/1Jil/WZ+q7dLVFT9dudxbylFCEES74WSuLmnSvK4X0bYhLu9ZjogveDqIOyLqWmQPv67Wa8lV7jZ30Ol4tBl/5t45Lxp8l/SlNwcXmKqwZOGU5/sWnMFerI5paAzvJ1JcMkY68bDW2pWNMiqUKibEemc6w5F3HTM9/ZnVGG5fvmURRAFTofdh2MN2rS3uIpN9CbmkQKhL/Ofx67TjJNP+nBQpFHgjfH9nc0BOf2tMjICflNcjK7vmMuS/kQc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgwPiBnRsLd8ZrgSZWVE/agC9ZT/uBeNuxI8OwA1lSXfxFE8yoS3lsPjH4t+?=
 =?us-ascii?Q?6uiEE6U0Px4dsM7E8eKysiNn1P+bmhDf/chcafhHyQUhzstowluorOsRdUy1?=
 =?us-ascii?Q?LApuKYysNrmj+tX4brFmgBKVVGS5ct8CZOGELq8m86wL4HtxByYNcIy0F8J0?=
 =?us-ascii?Q?vdViMqgWMGepEQs9jwj7AcKyKGBWR09AkhE5zKCuaVS+kROExs4BOevkP9XA?=
 =?us-ascii?Q?JEGFtyYC4/6hyADQ7zkBmn8j3++3285Y1tGI1asnnJH7ZwhBrjBY5q+MlJpW?=
 =?us-ascii?Q?yLrQ1bR7aOdxSFt8LmNbI24tIfw8hEWjehmXMPBRHb3sIpIn6F3WQgGj2iWq?=
 =?us-ascii?Q?9v473Mqx5IeYZrJLOq/YW+ZD76lv/2hVQn7IhM6S5/Ln2UWgoKQ5WsOUy60O?=
 =?us-ascii?Q?WkLP6b95+fC5WEj0sCuWei/bcrgTvwGVbb9z3sOC1RcTou2vXTO4yrMfNMP7?=
 =?us-ascii?Q?l3dxB3Qy/NxPAuC54ov/ASFkfyOf11a2jkVv8hvkYo23m8DpwXQBmC8R/A6v?=
 =?us-ascii?Q?/A6Ktx396vcjGMM/XvhSyJtJUjQSf37BSpo2LIqY9x7rT4rhlg+edwcVMcYu?=
 =?us-ascii?Q?7/qnsXCACJtyy+kH9FRSPRiHlE1TCVY4VdEwES/6dgZvLpSTRCbFYjXcxopP?=
 =?us-ascii?Q?ACUVvMDg1/tW4sCqCi4ouzDL4FzrbMvqs0gyzr0n2GdpvWEL8Ckss1iRKWpt?=
 =?us-ascii?Q?OMe3pgRyLsoZu/5/0XHqNvlOtIjciiRBxVL0O4o6dIDyMzotfj4Bv7+Rlcsb?=
 =?us-ascii?Q?Dk/riywpsHw5h1W+6yARfh56HugPu96YTlbmUrr9dh/pZFq7qjHH3DMoVm30?=
 =?us-ascii?Q?wrEYOTTYCZcKWFR6g+GaM60g8iv2sIEW+l0FqvQtb9hH05vWBtSfLF3OYX78?=
 =?us-ascii?Q?Iqr0ZQnSTlQxFWN/12RASC1IGUYxy5CyeyR84nOBTfexKfzBVhUKZ589wCG5?=
 =?us-ascii?Q?WjHvU9Han8ODPWdkPk3puJmuc/qWqxh2+CDJHEzUx3NZBa6SKKvbAe/1Qzng?=
 =?us-ascii?Q?JoxAoJj9IbCPxLH8WOODshNkUQqTsr9KfpeFMQgZRk1ZlAgP8YBTUUepgsY1?=
 =?us-ascii?Q?6QDj3zotZ3sAXlHsSseh5JXc1cU7OmqujfcbwKnCoV2XKvFILoDHD4exgAjr?=
 =?us-ascii?Q?Sua7mryBumvPPRiq5ng92BHeG5W71f4e5nvbV6sCKu8j/9UNxdzufjJoEZ2j?=
 =?us-ascii?Q?0JQDAhhAvYLmYh5Cx54yH81vThfqbM0OwxpAE01c/ZrgggchnO5rIRbunwfi?=
 =?us-ascii?Q?mKPy3PJEfPYDt6yQOxdOn8l+H334KAbf5E+PTzdArOFxigRK1HdhPt0DiMxs?=
 =?us-ascii?Q?5cSHXHmYXoZ4OOby/JElKM8o1Sh9Q97KzD9g/5sY6wRh2h5U0E/H8g5JB3Co?=
 =?us-ascii?Q?EeEBZbj4NfhudIlBcjiivBbxsdK1Qq1Eud0HGxAfjoVCy8stqOPv/EowmTMk?=
 =?us-ascii?Q?qaHdu2Kvkt/2bv5TXvmYUbZ0OaphY2nGtZumHRQdW6ILK/HvCz3Ksz45gVUJ?=
 =?us-ascii?Q?/r/f3SPjdCfjumKNsmhQESaDYK9RpNr/Gl2dD8Qa4/EwNJ75S+yNh5heKrEq?=
 =?us-ascii?Q?MSldoTstR8beub1/Nb04bPPwzluZSSaEl48L7SwF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2137d76-e5a1-47d4-ee0b-08db51da19c1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWJASaqmVPEMtjkGz12McOMEue21xuMIBhvyeWjCFFuvK3825mn3Suk3ozdge1uQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

The last two users of it are quite trivial, just open code the one line
loop.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a710e3b5d1e6ba..7d2fdd2a11cca1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1110,20 +1110,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
-				      int (*fn)(struct device *, void *))
-{
-	struct group_device *device;
-	int ret = 0;
-
-	for_each_group_device(group, device) {
-		ret = fn(device->dev, data);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-
 /**
  * iommu_group_for_each_dev - iterate over each device in the group
  * @group: the group
@@ -1138,10 +1124,15 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 			     int (*fn)(struct device *, void *))
 {
-	int ret;
+	struct group_device *device;
+	int ret = 0;
 
 	mutex_lock(&group->mutex);
-	ret = __iommu_group_for_each_dev(group, data, fn);
+	for_each_group_device(group, device) {
+		ret = fn(device->dev, data);
+		if (ret)
+			break;
+	}
 	mutex_unlock(&group->mutex);
 
 	return ret;
@@ -1791,20 +1782,12 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 	return best_type;
 }
 
-static int iommu_group_do_probe_finalize(struct device *dev, void *data)
+static void iommu_group_do_probe_finalize(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
-
-	return 0;
-}
-
-static void __iommu_group_dma_finalize(struct iommu_group *group)
-{
-	__iommu_group_for_each_dev(group, group->default_domain,
-				   iommu_group_do_probe_finalize);
 }
 
 int bus_iommu_probe(const struct bus_type *bus)
@@ -1823,6 +1806,8 @@ int bus_iommu_probe(const struct bus_type *bus)
 		return ret;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
+		struct group_device *gdev;
+
 		mutex_lock(&group->mutex);
 
 		/* Remove item from the list */
@@ -1834,7 +1819,15 @@ int bus_iommu_probe(const struct bus_type *bus)
 			return ret;
 		}
 		mutex_unlock(&group->mutex);
-		__iommu_group_dma_finalize(group);
+
+		/*
+		 * FIXME: Mis-locked because the ops->probe_finalize() call-back
+		 * of some IOMMU drivers calls arm_iommu_attach_device() which
+		 * in-turn might call back into IOMMU core code, where it tries
+		 * to take group->mutex, resulting in a deadlock.
+		 */
+		for_each_group_device(group, gdev)
+			iommu_group_do_probe_finalize(gdev->dev);
 	}
 
 	return 0;
@@ -2994,8 +2987,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	if (!ret)
-		__iommu_group_dma_finalize(group);
+	if (!ret) {
+		struct group_device *gdev;
+
+		for_each_group_device(group, gdev)
+			iommu_group_do_probe_finalize(gdev->dev);
+	}
 
 	return ret ?: count;
 }
-- 
2.40.1

