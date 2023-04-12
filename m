Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B085671;
	Wed, 12 Apr 2023 13:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlSnSmc5PgqhbmOx+3QqSGMOJa7QIsknTMbFRTgwW9ixF0k5gy5kBZYn083OTV7HJfwsLGvPrypR9usIHj5iFT3PwwAmrnZnoDCFgxlx4nxtlLNYcQGKr/Hjdmy4GKPFpwjZsaVhm+uvvi1HfF2Zl5Pryr7uXIWafItb4OMWpjm+vw8lPcfP82byx7vwx4X4gz4p1S5fPGl4+gkzumKmbwT66NgKUmIdT4GdBwEraambPC2saWGMyWwe8GQyAITIMVIPIs435fucEVS+JLJM3WD/5xkE+2gK0osk9M5X9M3Uj2XBaZaiaNCEz1qZ0SuKo5gcLAViu0qWx+PhhS/nFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvPoy8Bk4c/VXsMxX5ob2BCx+2hY+lvR1ztLkZfqtBc=;
 b=i5mxM9DG8iWS5mJt4PmYjp5aqYzfkE+WklX3tnb+a0qHmtysJHlF8CSMrApNvLccbPKJ1ZsG3p6Z9WFV4sLb7U9vQJqvXoVTUIqLVWzw6D91DMSzOeCmr4pwuqEE+mYcddD1qfQFdjr8/K8lzh/NqbRrtWSm67wejEQxF7vqUrEIPhz0c70yt77FH6872QD3cEOPNZzMnQ++vqvr4CGGPMG/sE+bgxfMD6IbYQNjBoMe1dp7IhffT24UPXYIEo2eGk4u4mMDtnze4i3oUg7TltVuBa/O3Eq0L/bUILLsRe0mwglQELskTN8zRzkj6GmhsuvIX6UANxgNBrpPx5ByMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvPoy8Bk4c/VXsMxX5ob2BCx+2hY+lvR1ztLkZfqtBc=;
 b=O7ONBZ6dNYz0qIfgzwtVzQk4lCKu2USu6YOVne9rp4z4SIdfuYrg/j7cvKxwnhIypZjH331IttW/END0UP1ox150NuhmY8k+ib0moiewurK/Y0/6r0Jm4+BsSnLNDsFooj1VJ311wMdZ/5YuAsg4mtkleCE54OtoAnBz2gUHm6ed353KofwMjdzAoLMQG37J+xfHIigfaf0nEk7O1FLalZSK6zPhmyMiFFhZ3R/vO7PSfborAXwTBh6sUfTyYigWZHYRDek+orY/lO647s2lLQ6o3gOk4HjZjgiD2CH9wsWXr5DkKLNnLrXPW/zPGxra8l2G7vn3QCmiUOk0FJtgbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 13:51:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:49 +0000
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
Subject: [PATCH v4 16/17] iommu: Remove __iommu_group_for_each_dev()
Date: Wed, 12 Apr 2023 10:51:46 -0300
Message-Id: <16-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e8cecc-2d0d-4fc0-97e9-08db3b5d0f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cPDWXCzcepAVEPNHasdsuH8Kp2AtozvQUNB4BDLA7LJqTL9sYohKX193Ew9UKcbiGdHgarnPuuSFdJHQONm8iB/bSiFNitffKZuxJlo38t9qlQDUW5/33u0Ozz6ocF7lnXLd3b7Y02r/Ed5UprhneYE3Tu4M03Zj9XHvMXYIjStYFhgh0TZhslEufiw6Y5SimqQJgfnpOoeIRxwL3N01QZTr+CODkyx61HlBXZJOX7/nGBTkvp/SZc158ALMDQBBBz8VAdtm+KtG2TPusyhJBM1eIOt/EBarVlxrm3kQdCj7yb4OthCgVwbv4CKFQA43eEtTVrV9vPp3LMZTXszBckOzHQUPyJ6I0VvA5tA0Ip44QFyw+ai0MiisvdMJWifyouirXaQDP/JKN0Gzs5FdlGtwatGk8hhIeyp9GwmX7G6j1I9Y6ZBL858lQIj9RPi9AVlsmJK9NbVDQ6RZh+SNk+Q+6NQIlSztnFldhgYDyCjdivXY7xL/RjD3DHuS2px+nNCMCDi+ZT8vav4E8sMNyFU+G31qyiIEo4eKq1LgIfJnM7c3c5Wf7zRhYBSrXFQ/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(478600001)(110136005)(26005)(6506007)(186003)(5660300002)(54906003)(316002)(2906002)(66946007)(4326008)(107886003)(6666004)(66476007)(6486002)(8676002)(7416002)(41300700001)(8936002)(66556008)(83380400001)(6512007)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4svxx7KhPqwDZ7pjlWa4LI0nEIZCMNG1kSIj8oru4I84KG8wSKCInuptfIyN?=
 =?us-ascii?Q?cYZwufNpRtTQCk0+nJfVD7bS4qlF2Nkb5M9bt3vZJGtRBc9Tk8r6lBfJzB51?=
 =?us-ascii?Q?h1ytjp4CssUi34TxSfBExecxFnWOgoDJN7gJzz4UdXMXwlTI4dPpAxdTEH//?=
 =?us-ascii?Q?dWEV2k8A6308BidkCW/HGqIywTsktINKD0j039Ikyf4GZ6KU32+GHpWlZXkV?=
 =?us-ascii?Q?HGSIrb/zh5FA4o0s/REoCQfaSgCdb34IjoTHVknH32SvVxGMWbCS1zewlUnU?=
 =?us-ascii?Q?kGGrbSvajXW+B8QaaqBCINqmceqJk50jVHOu9mbr1dy0puoOjeGYgIKXpk5K?=
 =?us-ascii?Q?rw5Cd2FBwSF+RZz8rDJxJ5IQnOng/R4B2545gaZ76mVIX8OPu76LR4HN5POK?=
 =?us-ascii?Q?49r2a4JXyXAef2aC7momiil4pRx+6hAY2apHAi3/TfTKmQraxL9HlpcCFoAP?=
 =?us-ascii?Q?Bz3+xCuQoqZ8qOkQqFD5MX4SSfJ31nOY2kSCz78d5es3W03gblYAZiaSGkuw?=
 =?us-ascii?Q?KGBzJtgAvrochPN7p16FUeMvaLVVCL2WgluqZSHgBJwaWDJzl8yqLQmR31LO?=
 =?us-ascii?Q?am0/69AZml2f/g2Av+81plCdoDujfB6il+uxnfJDpFE1sseo4hgi4bn7KlYE?=
 =?us-ascii?Q?R+oW/n2xGBt+cjcsL1x2UjH+Ld2JrgOd/iVHrxhOqFn67zyNn25toj5UElSl?=
 =?us-ascii?Q?5zUSCc18xG4QjJdWnZhdzZixxKQ5cQVkq6Qggbj+n8+cRgc/MHPRwNSkJEyH?=
 =?us-ascii?Q?5m9H8OCNIA06412Pj51L5+ujm5Y5/iSuMiDQUImYDP+mWCaHL5HMVmZ97ggb?=
 =?us-ascii?Q?i8uSKO1ycyodYBqhKU48l7kMuVcumAsOfxlLj9qPCs61OTDzHPZfByYUlisE?=
 =?us-ascii?Q?LVZhRCLuIH6wk95cNvCkYwV1IP/fakF7TozVj5BVW2aLc/UGFs/j7nmcM6j/?=
 =?us-ascii?Q?romFV040DbbcPOrcMZsQgXKREltASYAFVkGuITL4dvgDV2vA/XpK4AJ2m8HY?=
 =?us-ascii?Q?jr8xbDFJCpIYvmP5qFinD3GPE8F/onwkLBO9y72KcQCwcDxTTNMvgJ2CSCvk?=
 =?us-ascii?Q?RtfgJQgR5J4BeYAgxPsDSvDb9t3QxUMbbrfGhS8AlMeTsiLfWTLlDFmRs9B2?=
 =?us-ascii?Q?dRBW1nOjK8iHDaGvL7Bq7XAQH0RCbmeAcKYADFPYFIp8defVbajnit7uG/HB?=
 =?us-ascii?Q?sm+gV+gYPH6qShZKOGPLjLdjT0KH7OAqz6BNNQvdbHBotPCGfvfOXY5EOOy1?=
 =?us-ascii?Q?E3Z1I00QjJft2tCLahkIvBUcE8Q08dSEzLCi1Hm0dqrlC+NBGLssLbfqlWFq?=
 =?us-ascii?Q?EU2UU1sSTH852IyBokPFxvpV8x5hrZSWrWnI2U9oQC4RU3lK1h1tNyv3OFqs?=
 =?us-ascii?Q?jRF7Iz3itiPKmLp3BfDDO0F0by75FPM0jlSXkU/s2BAHuoFJFsA+ijERd95a?=
 =?us-ascii?Q?GDA9HcYQyPfzs+jkmVY4bRD3S+LS2JHxQlqk5KAn2Vanvnmz1Aou9YJl9jyA?=
 =?us-ascii?Q?ZCaAG9FP2xULQnmpyUUcFL67RsQea6SYoEEiYmFAnEM8FAsisUfxCKPoX2hK?=
 =?us-ascii?Q?M/5sYPZMyHNUNNvSwKYG2NqvhsinJDoPrS6dE1OM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8cecc-2d0d-4fc0-97e9-08db3b5d0f64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gji+uWYtJKIA1FCzVks559lb173JtYz+duhU3FJcznFCfxsJU/DgoKQHrqB+Xof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

The last two users of it are quite trivial, just open code the one line
loop.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4c0908402f0139..85b1faac641267 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1134,20 +1134,6 @@ void iommu_group_remove_device(struct device *dev)
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
@@ -1162,10 +1148,15 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
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
@@ -1815,20 +1806,12 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
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
 
 int bus_iommu_probe(struct bus_type *bus)
@@ -1847,6 +1830,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		return ret;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
+		struct group_device *gdev;
+
 		mutex_lock(&group->mutex);
 
 		/* Remove item from the list */
@@ -1858,7 +1843,15 @@ int bus_iommu_probe(struct bus_type *bus)
 			return ret;
 		}
 		mutex_unlock(&group->mutex);
-		__iommu_group_dma_finalize(group);
+
+		/*
+		 * Mis-locked because the ops->probe_finalize() call-back of
+		 * some IOMMU drivers calls arm_iommu_attach_device() which
+		 * in-turn might call back into IOMMU core code, where it tries
+		 * to take group->mutex, resulting in a deadlock.
+		 */
+		for_each_group_device(group, gdev)
+			iommu_group_do_probe_finalize(gdev->dev);
 	}
 
 	return 0;
@@ -2999,8 +2992,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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
2.40.0

