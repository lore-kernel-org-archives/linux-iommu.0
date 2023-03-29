Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D98C2C9;
	Wed, 29 Mar 2023 23:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSOq287AASIYEHbIUpSnpSKv+VU78krvcBpKzAmqswUhBj//TTSvH4FNuuWmNxE4Rogr+7qVrJvIFz8NP7ZrBo09t2X2LhEwVGNxs2jYDULyn3UHjDV1BQM4/rjug+pKMLDWmsxX8vGVWg5xb2RmKLx5ysyQsF1gE9jzNBcAhV3P3vekf7aI/yUA0zzorL+aYzXmDbJL5rtUIu40EKQec8peCTf/MGjgv5CmZrRD17zJ9DJohSeMi98QPfve4aq8tiIzpCZcS9xlekx9U6rd+rd9Lh0UPw1ckfmKss2G/gKe8N/hMmQatoQveocMFF69p34PqO/jaxS74NLlQGPL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G8FrTX+PAk7wnzuuqlY4urwxBBFDKFIBajgT7N5N9g=;
 b=EtuzOKY03ZCC0Nih9+QKK2P7O72m2XzHWYuw5X44HpjyXcY+FA8oDMpAM7kRnzx2ZyivLftU8O32TZ0M8UPdd5gUc6Jzc7D4EU4+DO6/wtUNkz2cYRVU+KcFmmKrbGAAVSYkcRkn0QIsLb2/tVNrFigg5pM98taZZheCXbD5UjF8SDPluhntfrWMWXMBtCklh76l8Ksm27Telm9ICkpd9VPjU1nxYPOrquZcfAnEkgUgOUykiJVTXrlrqZWauNeC4+o/0DKOoyqlgkB6dj4Sd5ZO4ej+3e1JklgZNg1AwuSmO6lAyXK+uiAKfL82PDFvlLW4kzAZOkN2+efOvjJuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G8FrTX+PAk7wnzuuqlY4urwxBBFDKFIBajgT7N5N9g=;
 b=ZXRIHZpFYiAr+6t2L53jBWGBWUj7Wqq44Y7vduEoF3eJECFhdU2Y8SsYORRlFwtXhPHC7YYH2GEWZuX5LxHWaCTf4nQbYqJGe12lKcfliJNJg+O4a4drWGoMZ9EtkCSB/ulVU/XC5UEg6V6pOYP4lfxi3DlJWM9JnCWafEIFv1134p/nBVIUfYk1tQIbucPc4v0kA3b0cY7lbaKxxZ47gdy2jH8Ww145ybyei7N4rlPGhdvByh/HgcbweanqW1CqRjNxergpHLIsrCiEf1RVHiv0rROC6WGe7kuY6EWFrOdmADNsZXTPz9u2qmaiwKKkH2Po1QXgTTLR3EDyok6gaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:46 +0000
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
Subject: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to one function
Date: Wed, 29 Mar 2023 20:40:36 -0300
Message-Id: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db4ef3a-0aeb-4b85-b424-08db30af0148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jqXzIl6QXTVIDQ2QKnm14O6uRbB1pOy8aUAvC9lbfnUVP8envDPykFuMesmnw1PEjDANcH0aS61lGiEuGyPu8ayRpOkimz7aZTiuvW4MZi4dGtc9vPV1eWxGm2yXqR9QnDUVacVBA8SVBOj2c7gWIAtQ1pc6VelUK3moe6ZxZKDMIClfsb/r/gZQTro6SJCth/zCduRzUqHwElKHRaVvvU20dZJ7ELb18sgfqKdlkaLrJTnTW8wmxeRoYWsjAeMdQwNumXGLw1n2i3KVNja80Cb7uxXvo21A45wF3Zg5oR1M3B6v97m2H60bqyn9YVMXUN29acezjTSvqZnW0oUbrfIdZJSyAt81FTo+2AtL26Hb7fm/xNqMn+D064GZtk7FLFHSnPIhP/lCzE3uN3uHfb69Hsr8XUcclpITC3MJW23DN20TnJVKY3OOw76Y8CMiUnSXT1FejhSrmQFdCgCSqX4ugiXfVsEkPkg6iUuKJBLp0CuXqeKOV5EyBuI7TIkU66L6d1tVQ6+drEsjQ0MBN5RjozQecO2nmooMem0rgmnMmcpUKiRgm4XkOv8qA3Lh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(30864003)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAE1wPuLINZ3EbbAnoQydSoCblAcmOCRfBrx97HJ7xZIxDD+DPaw0omnGV1k?=
 =?us-ascii?Q?9vaSJ7N+klmPG4OfLGQwrcDFV/PjizR9sUMZ49xpLMmCcELGYmYkAuxdPTk5?=
 =?us-ascii?Q?dfYT9FArAXb0QFODp3dKAOiJQvaedRBjtui3Ft8oa7grGLQ8tbAlsKpdZJCW?=
 =?us-ascii?Q?vWbbfZmpmf0pTEmzWyFJH6c0l3broxI9MFObRaYNIcep+FAU9c93RnUIbzft?=
 =?us-ascii?Q?KFT5NBy1PSvfIOZkVEFQ2PF+ZKkITmfZ2fPxpasHjiY/itZWh8FHjv5WykKw?=
 =?us-ascii?Q?lTLLd1xWbCE1ugihqT1tF2qs3tvQ3S+158CPS1/One/NKbhcfy2xdRRmsqCh?=
 =?us-ascii?Q?P4Mje7oqc2KKsKOROk2pL/rwfEpPE71GqYO/NCxSVp8yeUrXFRXHGtBWWlaZ?=
 =?us-ascii?Q?ZXpcGRFvkxbGghx1aE1P8U3qloF21ssgxdfPS3UGAXVnGtsPp1gsCQtbVxRj?=
 =?us-ascii?Q?jm9PJUZRcZS6JZM6nhap1kUMekwGCA7VWbJYr4M9Fx3eqf/Mk7TB1YXEBuIZ?=
 =?us-ascii?Q?JRIPp7g1HrsAvkAEFUpIqbh9cNERXZ4Ybf/95WMcBAP/u+0nYp5gSbcWwVeF?=
 =?us-ascii?Q?M4k2c7g1GQ+/Lp+lqq4lftb5duZ4FeIFVOYkdoaws9jSe6VcwN+PsadOaXNB?=
 =?us-ascii?Q?VPGESe4X69PdQyTMvPZFexR4OKdtAxna0aFgf6l8mie7rxYajf3nuM+2bE1l?=
 =?us-ascii?Q?uhJ0TYzfDEhG5IP55DdQRC1SXSGSIu18KY6pAszzDmjMVLBkm0UtDeC+gRbg?=
 =?us-ascii?Q?w8XQJ9nuLQtcfLoJgVBSiXRMc93rq5tAFm3bJ42NTqYn6sj4kSRYed1gPg16?=
 =?us-ascii?Q?goO6M4ZKUN0LtZGQy2o9j4jIer/K+kpaneCOATmAJ8scumM7PRSqVZ5/8B2U?=
 =?us-ascii?Q?nIdfZz8ua2W2lo9KSjO84kK4675UPllrs10EPuWs/3jT7aDsGxsjmd7TYKtA?=
 =?us-ascii?Q?U4gLFAwzsJKhpscBl2c7HnuGglkSrUdfMjxh3z58pKr0qeZEtJxrMBC+11ST?=
 =?us-ascii?Q?DLljRmCYCqaIYTxRERsUchZXcgghs/JLvEcGZB83cz2yUp3Lpe8qIT4q68f7?=
 =?us-ascii?Q?pOTgKAT0E0io04X0UYIc5JdVXSKoc0yO2GMdYmwm1vsLOal4CGspqG4zCnqp?=
 =?us-ascii?Q?qZdB/f1M2NxPOZQKCu7ByHSALFgcSq/s4FNJ9tJgbLFMySMcYLnfaQ1YgHq6?=
 =?us-ascii?Q?h3JbCV2DgpN43y9bCYqfQ9dod6bLTaI/u75GBDZAIzuNDGGj5cvo8Jun7FlC?=
 =?us-ascii?Q?GJR2KISq2S7rU/vtaHFPpWCGAmBEQuE47In/T+2vE6VMsuTFtzhi32cP0uiG?=
 =?us-ascii?Q?R5e1j2P1szeESelI3fJPd3LrbNI7bHUFo2AxptonOxqXhj9NNMqG8ui+TZBC?=
 =?us-ascii?Q?ZovheNjGncR3qQLyJkYWohjzdvCU3O/EDlSwtb2/ptBHcodqZSt593GubMFc?=
 =?us-ascii?Q?qSKYE4On4Q3LBORvRQ1t0ObPKZhixl+2uSzoJSlRWU2JolPIHOKWe+rmznyK?=
 =?us-ascii?Q?22UgOZ1gxypDZYgIxzvurebRxgs0X9puYAI8EfJpq4GKwmel5ycasp8Ou5Rs?=
 =?us-ascii?Q?Y+t2oE9Gkcn3sttAiC5kEQOczrdNw2ZYne2kL/Jz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db4ef3a-0aeb-4b85-b424-08db30af0148
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oys+Tga7knW+j+rBQOI57PGO2BrbwPbEcDnWiK6RP0jbyg2JeRYNm86Ylf1VRa6v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

The default_domain setup flow requires
 - Determining the default type
 - Allocating a default_domain
 - Attaching it to devices
 - Doing iommu_create_device_direct_mappings()

This is sprinkled around three places written in two different ways. Make
it all the same in one function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 256 ++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 160 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 79e3fa80d0f6cc..26129423fa7b95 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -91,8 +91,6 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -124,7 +122,9 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
-static int iommu_create_device_direct_mappings(struct iommu_group *group,
+static int iommu_setup_default_domain(struct iommu_group *group,
+				      int target_type);
+static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -436,29 +436,14 @@ int iommu_probe_device(struct device *dev)
 
 	if (group->domain) {
 		ret = iommu_group_do_dma_first_attach(group, dev);
+		if (ret)
+			goto err_unlock;
+		iommu_create_device_direct_mappings(group->domain, dev);
 	} else if (!group->default_domain) {
-		/*
-		 * Try to allocate a default domain - needs support from the
-		 * IOMMU driver. There are still some drivers which don't
-		 * support default domains, so the return value is not yet
-		 * checked.
-		 */
-		iommu_alloc_default_domain(group, dev);
-		if (group->default_domain)
-			ret = __iommu_group_set_domain_internal(
-				group, group->default_domain,
-				IOMMU_SET_DOMAIN_WITH_DEFERRED);
-
-		/*
-		 * We assume that the iommu driver starts up the device in
-		 * 'set_platform_dma_ops' mode if it does not support default
-		 * domains.
-		 */
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
+			goto err_unlock;
 	}
-	if (ret)
-		goto err_unlock;
-
-	iommu_create_device_direct_mappings(group, dev);
 
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
@@ -1004,16 +989,15 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
 }
 EXPORT_SYMBOL_GPL(iommu_group_set_name);
 
-static int iommu_create_device_direct_mappings(struct iommu_group *group,
+static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev)
 {
-	struct iommu_domain *domain = group->default_domain;
 	struct iommu_resv_region *entry;
 	struct list_head mappings;
 	unsigned long pg_size;
 	int ret = 0;
 
-	if (!domain || !iommu_is_dma_domain(domain))
+	if (!iommu_is_dma_domain(domain))
 		return 0;
 
 	BUG_ON(!domain->pgsize_bitmap);
@@ -1696,37 +1680,6 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static int iommu_group_alloc_default_domain(struct bus_type *bus,
-					    struct iommu_group *group,
-					    unsigned int type)
-{
-	struct iommu_domain *dom;
-
-	dom = __iommu_domain_alloc(bus, type);
-	if (!dom && type != IOMMU_DOMAIN_DMA) {
-		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
-		if (dom)
-			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
-				type, group->name);
-	}
-
-	if (!dom)
-		return -ENOMEM;
-
-	group->default_domain = dom;
-	return 0;
-}
-
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev)
-{
-	unsigned int type;
-
-	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
-
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
-}
-
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1848,6 +1801,84 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 	return best_type;
 }
 
+/**
+ * iommu_setup_default_domain - Set the default_domain for the group
+ * @group: Group to change
+ * @target_type: Domain type to set as the default_domain
+ *
+ * Allocate a default domain and set it as the current domain on the group. If
+ * the group already has a default domain it will be changed to the target_type.
+ * When target_type is 0 the default domain is selected based on driver and
+ * system preferences.
+ */
+static int iommu_setup_default_domain(struct iommu_group *group,
+				      int target_type)
+{
+	struct group_device *gdev;
+	struct iommu_domain *dom;
+	struct bus_type *bus =
+		list_first_entry(&group->devices, struct group_device, list)
+			->dev->bus;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+
+	target_type = iommu_get_default_domain_type(group, target_type);
+	if (target_type < 0)
+		return -EINVAL;
+
+	if (group->default_domain && group->default_domain->type == target_type)
+		return 0;
+
+	dom = __iommu_domain_alloc(bus, target_type);
+	if (!dom && target_type != IOMMU_DOMAIN_DMA) {
+		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+		if (dom)
+			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
+				target_type, group->name);
+	}
+
+	/*
+	 * There are still some drivers which don't support default domains, so
+	 * we ignore the failure and leave group->default_domain NULL.
+	 *
+	 * We assume that the iommu driver starts up the device in
+	 * 'set_platform_dma_ops' mode if it does not support default domains.
+	 */
+	if (!dom) {
+		ret = 0;
+		goto out_set;
+	}
+
+	ret = __iommu_group_set_domain_internal(group, dom,
+						IOMMU_SET_DOMAIN_WITH_DEFERRED);
+	if (ret) {
+		/*
+		 * An attach_dev failure may result in some devices being left
+		 * attached to dom. This is not cleaned up until release_device
+		 * is called. Thus we can't always free dom on failure, we have
+		 * no choice but to stick the broken domain into
+		 * group->default_domain to defer the free and try to continue.
+		 */
+		if (list_count_nodes(&group->devices) > 1)
+			goto out_set;
+
+		iommu_domain_free(dom);
+		dom = NULL;
+		goto out_set;
+	}
+
+	/* The domain must be attached before we can establish any mappings */
+	for_each_group_device(group, gdev)
+		iommu_create_device_direct_mappings(dom, gdev->dev);
+
+out_set:
+	if (group->default_domain)
+		iommu_domain_free(group->default_domain);
+	group->default_domain = dom;
+	return ret;
+}
+
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -1864,21 +1895,6 @@ static void __iommu_group_dma_finalize(struct iommu_group *group)
 				   iommu_group_do_probe_finalize);
 }
 
-static int iommu_do_create_direct_mappings(struct device *dev, void *data)
-{
-	struct iommu_group *group = data;
-
-	iommu_create_device_direct_mappings(group, dev);
-
-	return 0;
-}
-
-static int iommu_group_create_direct_mappings(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group,
-					  iommu_do_create_direct_mappings);
-}
-
 int bus_iommu_probe(struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
@@ -1900,30 +1916,18 @@ int bus_iommu_probe(struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
-		/* Try to allocate default domain */
-		iommu_group_alloc_default_domain(
-			bus, group, iommu_get_default_domain_type(group, 0));
-
 		if (!group->default_domain) {
-			mutex_unlock(&group->mutex);
-			continue;
+			ret = iommu_setup_default_domain(group, 0);
+			if (ret) {
+				mutex_unlock(&group->mutex);
+				return ret;
+			}
 		}
-
-		iommu_group_create_direct_mappings(group);
-
-		ret = __iommu_group_set_domain_internal(
-			group, group->default_domain,
-			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-
 		mutex_unlock(&group->mutex);
-
-		if (ret)
-			break;
-
 		__iommu_group_dma_finalize(group);
 	}
 
-	return ret;
+	return 0;
 }
 
 bool iommu_present(struct bus_type *bus)
@@ -2905,69 +2909,6 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
-/*
- * Changes the default domain of an iommu group
- *
- * @group: The group for which the default domain should be changed
- * @dev: The first device in the group
- * @type: The type of the new default domain that gets associated with the group
- *
- * Returns 0 on success and error code on failure
- *
- * Note:
- * 1. Presently, this function is called only when user requests to change the
- *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
- *    Please take a closer look if intended to use for other purposes.
- */
-static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *dev, int type)
-{
-	struct iommu_domain *prev_dom;
-	int ret;
-
-	lockdep_assert_held(&group->mutex);
-
-	prev_dom = group->default_domain;
-	type = iommu_get_default_domain_type(group, type);
-	if (type < 0)
-		return -EINVAL;
-
-	/*
-	 * Switch to a new domain only if the requested domain type is different
-	 * from the existing default domain type
-	 */
-	if (prev_dom->type == type)
-		return 0;
-
-	group->default_domain = NULL;
-	group->domain = NULL;
-
-	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
-	if (ret)
-		goto restore_old_domain;
-
-	group->domain = prev_dom;
-	ret = iommu_create_device_direct_mappings(group, dev);
-	if (ret)
-		goto free_new_domain;
-
-	ret = __iommu_group_set_domain(group, group->default_domain);
-	if (ret)
-		goto free_new_domain;
-
-	iommu_domain_free(prev_dom);
-
-	return 0;
-
-free_new_domain:
-	iommu_domain_free(group->default_domain);
-restore_old_domain:
-	group->default_domain = prev_dom;
-
-	return ret;
-}
-
 /*
  * Changing the default domain through sysfs requires the users to unbind the
  * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
@@ -2980,8 +2921,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
-	struct device *dev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -3019,10 +2958,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		return -EPERM;
 	}
 
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
-
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
+	ret = iommu_setup_default_domain(group, req_type);
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
-- 
2.40.0

