Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68241C6BF
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYEL34oR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqYrNoTdByrS2aS2UhYeoXzx+xsrbt1pcDmirUdbIpaNAmKWJ/AbB5fYVuxZC9wZi1FYBrGhKoZzmhrmk+H3NsIqH206c20boE3DfCJG7FVgdyQxLog6Sg7XqdhHr9u88quCwJnJ1W3/uD7TbUmaj77lnbvHR4mKq1s5y3QYFEf2LIEFKjm2mY/i9niluVYG9Vb6ipoDPLFwFXoTGmRy3c9/mV6ZA1JwBm8hL9xJYbAUDQwTqBZSn1Y4NkMYNYbAPVIOPuwDk9VsIyihLJ+FGGXBDBFMybDH4N2lxs8atLJ2kNrAvYWvGl0g8b5V3niI9YVTmoYE6Io9ElizLrSrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VULoKtsWLd7QUp6F6ejtKW0CvfQbcOavuVCT/vzNU70=;
 b=av7+z1pI3uPrfWIkAQTGo2ho4viDRpfNEC1wWPxBT6wotIpP99TS0Gax2Dh3NqdRnti/2w/d93nR6f/+2mcMz2F//k/qlBlmSZ4hEAGOtKiGSw4h5iZCxZ5fAMGUwYkqr+EHqUg2SGbgO3KadXf7ERFKcsiwLdnh4TZXru99OrdCjqe/6rlyxKhEjxMwlQHBxhyKIrt78bwL2mKygh8kEzCFfGDjgIrhtrevZm4LiCv5Ou90aYCeVVjDKiM+ekE9h0YRgP8/RgbF3we5Ji2cxVJeexdcsuedNZOuV20x7YcGfIQ+l55eXNsRBj158GZBdn4xaK2tIQKBT2iAQGr3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VULoKtsWLd7QUp6F6ejtKW0CvfQbcOavuVCT/vzNU70=;
 b=uYEL34oRVLzyg5/ym5Pi4XM1MFqJmV/rI/Sy8jqmlG5eiHHZmUS/+cVVvy3M3/vrAI6VjUSd3mxFSlX8OzQWqX5SfOljkgIm89V4j3hlZb5Ym77m31yo1AdtvLIEUsknSXbhy+R77MrAS75o3J8ZF8Kw6tQJKjP05ftxeRoEZBncTogkkuSEhc0wCoiskI+YyHfXIYP2CVMu5r1eJYT1GhHb+kmjTUVAFajvpVJF79w3O6+KcbR7LFRH/NTyeWioP7DhkqYjsUZLT6mp4jFZIAe9xnGZXQ1Vlez+wzPaIHBoBpBP6vpCcFrHOTI2PXzRVNH6zT+4bKz4xHMfr89Iew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 23/27] iommu/arm-smmu-v3: Move the arm_smmu_asid_xa to per-smmu like vmid
Date: Wed,  1 Nov 2023 20:36:41 -0300
Message-ID: <23-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cd7725-1245-4284-3ec2-08dbdb336a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	22WbIdhz676RCA4C8JErwwCYFa7FpdxykWX0t6vU/QZA+On/8dZCiRkIpy1AwJvw8NDooVtqS6BfHVXn3wl1sb1PVvO8VtfH9hBnfTJ2fHDsW01I1o1MLlpWuq2QzXvSWyJXjK4F4x1jwnr3iyeZHLf3d+4oRt4MQDAxfleBit9fgNLaq9A9AMbPqVONo8gAqSKPfj53XxfgqIzygZtijppmMrde6TYvgtnChBarBCeGs+8E0o9Wytw0lNbckJUfMgttWqwX6fTZLuXW9ULySH4M16AF/kn8Aeiji666yPrX7M9c5UzmOgzlHP4iQUnqLTUO/Vdw96MRqDEhDgypBwdfCwE3yvZ6RTcSrilnzM25d74Dxq58vNVmTHyRstYmPSWJgyqIKQYvl69s5SQVs6os2r9v3yuTwIklkWgZkH7eXdhFzcuj2gRo8WEjY6egxIy1vWopfywtZc8YrvJVfq5QtG6yIMBVYnITP4OexGi+igmGBLU2elGBM8L1W21BslLy46LuMjZ+wMQhLkU/ViJn4RiM3CHqpgoenyu5uKk9n0SVcEoySyQHulKajasd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTJEDVrXk9jnH92IdiCmG9oCJlifbtB8tnC3XIIrPE6mEIzeB5HMrnpe6GXY?=
 =?us-ascii?Q?WYdxifKNrNYh8djlWPSr/gsMkhwu43lkSWwJvPk4ZI1fgofMStbjQ10DBSMg?=
 =?us-ascii?Q?dG3ZcEzm/mK2FtlO+bcqgwFjVxmqoiDxemtlPO4nXjBEUZWzIDefmU+wHW6n?=
 =?us-ascii?Q?KgT8HHOtDSzmW5ZgEGqP71e1bBKU/pEa6fg4IzjJUrZeS3pINgX25nrYpSGo?=
 =?us-ascii?Q?Gca2abTrS2f/ZeXy9gwJU+LXPTd8VagWSKoQGj0TZTAfqmie7FxB8SmXQvAc?=
 =?us-ascii?Q?drr4r2AYNaSDlJkGIKPXkNzCaaanVIiW2aSSAUCagBtB8nD40S/G7aVNpess?=
 =?us-ascii?Q?CLK/tU8GbkvVDBvf3+oFC/pfDzkHpE3Ul8umGnFQ0JbbdIP0ZwfZmO1SEaaV?=
 =?us-ascii?Q?zwSieM31W6LHaAQU9s7NiYGIr/1xVRLaY/BDBdiKVH/OmgR0wizCck37Dmad?=
 =?us-ascii?Q?xXJ8ENlUyvURZg3VlAijSB/A++Q5jWFMk5fjkltDzuNbY2iSUl+kbuSmi/YD?=
 =?us-ascii?Q?ipLXpMR5zbmio6hRcXUpvxkuKoXmk9+cEPZCGDY+62N2gXoRph0EC48/jrnz?=
 =?us-ascii?Q?FM72iSaBXUPkFUGASyDFVmnj27NyyUlL7/V5E00B7uSRD3LHW+yn/c9lNFEj?=
 =?us-ascii?Q?DB/CICRK82Sijf8hSMlaqCeLntT0bNdxepp8edOLXuk7IsDt6VM6CIH4QTRO?=
 =?us-ascii?Q?yHU5jdAA3CvEyc34TsTOo4GA2zb6YC9N04vN1TZ5PxAAQXFs8omq0qAQzT/b?=
 =?us-ascii?Q?XAN5kTxnNOWRrj3MTgyrt7iw0EqypppuaAR7uc+59z3Wds4T9KsA9IanLVU6?=
 =?us-ascii?Q?yUkra646EzUKlsLOp9MZBY18URoSjw7LpVfFFLS+W4d7PRCGSZW5eG3s0G38?=
 =?us-ascii?Q?HhwRs1zVoIToGEay7JwOFZsJTlT3hjkPgNXxjBmPgFHoyyJgugnLHBWaldAL?=
 =?us-ascii?Q?27FMfGzI/nuPt/+NkHYxIx4eWnr3w2W0Y6EtudyjnnNO1I5UNzApKjES45s5?=
 =?us-ascii?Q?T7R0GqbMKf9JT6ZmoueTAPe7srNhR8jWv2JiHH/a0lvtqaSNYjWyGM+5hjhn?=
 =?us-ascii?Q?cBkhKLysmGU/o9xqSeRjJiPBDpkXuLmVDxmbOMXWawTLI4hoEsxJlHlaw6bz?=
 =?us-ascii?Q?G5zo9Egl4hEk9Redo3u4qpI7RhS3DHwaZTCOoMHJq/SRnMh6UsAASr4xJk5M?=
 =?us-ascii?Q?y1UdbdKEi8mmXvlP0MJOPTfthxsEAKSmFiQ99yLf0nh7QWV4j3YOI5YKN/zb?=
 =?us-ascii?Q?5bAUnmbF9xhGVziuwgNMuXK/kRJCpBF/2PcUc1Z3glOZKTdplDnMy0/wsoY6?=
 =?us-ascii?Q?e77un7aBW1FaTnw5b7Ea188zoulx0XvDUVuCPkkpg3FkJPWzhQTUqsbp1yFJ?=
 =?us-ascii?Q?+diaa5IPNqPcPUMcPvUjFaQnbA9halk5KJLuWiZw5QxU9kx341Nr+VIij7pr?=
 =?us-ascii?Q?t9BOepTTE4km6VAXwdgVz66OsDqjOl9TIu2LAykk1KsJnFGo9kCaKtHlwW9Z?=
 =?us-ascii?Q?yL1fJSnfjEzYcvMkFtVYIVtWhVKXXyoPS9W0xjY45po6lM4jPgv9U/kxZHRR?=
 =?us-ascii?Q?sTQ0Ffia2H2KDZbvLXxDkLGJpthRRe/bB0viLR25?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cd7725-1245-4284-3ec2-08dbdb336a2d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehmOn+4pltvYhnmJeMNK3H8z0eOnyBzPifLxbuC039LoA90ZuBsMy/UcCUMseD5C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

The SVA BTM and shared cd code was the only thing keeping this as a global
array. Now that is out of the way we can move it to per-smmu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 39 +++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 66de6cb62f9387..aa238d463cf808 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -407,7 +407,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
 	smmu_domain->smmu = smmu;
 
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
 		goto err_free;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7fd376a4e1752a..db5f2b92af17af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -71,9 +71,6 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
-DEFINE_MUTEX(arm_smmu_asid_lock);
-
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -2246,9 +2243,9 @@ void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain)
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 
 		/* Prevent SVA from touching the CD while we're freeing it */
-		mutex_lock(&arm_smmu_asid_lock);
-		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
-		mutex_unlock(&arm_smmu_asid_lock);
+		mutex_lock(&smmu->asid_lock);
+		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
+		mutex_unlock(&smmu->asid_lock);
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 &&
 		   smmu_domain->s2_cfg.vmid) {
 		struct arm_smmu_cmdq_ent cmd = {
@@ -2278,11 +2275,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
-	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	mutex_lock(&smmu->asid_lock);
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	cd->asid	= (u16)asid;
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&smmu->asid_lock);
 	return ret;
 }
 
@@ -2545,7 +2542,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	 * arm_smmu_master_domain contents otherwise it could randomly write one
 	 * or the other to the CD.
 	 */
-	lockdep_assert_held(&arm_smmu_asid_lock);
+	lockdep_assert_held(&master->smmu->asid_lock);
 
 	master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 	if (!master_domain)
@@ -2584,7 +2581,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 static void arm_smmu_attach_commit(struct arm_smmu_master *master,
 				   ioasid_t ssid, struct attach_state *state)
 {
-	lockdep_assert_held(&arm_smmu_asid_lock);
+	lockdep_assert_held(&master->smmu->asid_lock);
 
 	if (!state->want_ats) {
 		WARN_ON(master->ats_enabled);
@@ -2647,12 +2644,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * This allows the STE and the smmu_domain->devices list to
 	 * be inconsistent during this routine.
 	 */
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&smmu->asid_lock);
 
 	ret = arm_smmu_attach_prepare(master, smmu_domain, IOMMU_NO_PASID,
 				      &state);
 	if (ret) {
-		mutex_unlock(&arm_smmu_asid_lock);
+		mutex_unlock(&smmu->asid_lock);
 		return ret;
 	}
 
@@ -2677,7 +2674,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	arm_smmu_attach_commit(master, IOMMU_NO_PASID, &state);
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&smmu->asid_lock);
 	return 0;
 }
 
@@ -2701,7 +2698,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	if (!cdptr)
 		return -ENOMEM;
 
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&master->smmu->asid_lock);
 	ret = arm_smmu_attach_prepare(master, smmu_domain, pasid, &state);
 	if (ret)
 		goto out_unlock;
@@ -2711,7 +2708,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	arm_smmu_attach_commit(master, pasid, &state);
 
 out_unlock:
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&master->smmu->asid_lock);
 	return 0;
 }
 
@@ -2727,12 +2724,12 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	smmu_domain = to_smmu_domain(domain);
 
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&master->smmu->asid_lock);
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
 		arm_smmu_atc_inv_master(master, pasid);
 	arm_smmu_remove_master_domain(master, smmu_domain, pasid);
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&master->smmu->asid_lock);
 }
 
 static int arm_smmu_attach_dev_ste(struct device *dev,
@@ -2749,7 +2746,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * Do not allow any ASID to be changed while are working on the STE,
 	 * otherwise we could miss invalidations.
 	 */
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&master->smmu->asid_lock);
 
 	/*
 	 * The SMMU does not support enabling ATS with bypass/abort. When the
@@ -2778,7 +2775,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 
 	master->ats_enabled = false;
 
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&master->smmu->asid_lock);
 
 	/*
 	 * This has to be done after removing the master from the
@@ -3436,6 +3433,8 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	smmu->strtab_cfg.strtab_base = reg;
 
 	ida_init(&smmu->vmid_map);
+	xa_init_flags(&smmu->asid_map, XA_FLAGS_ALLOC1);
+	mutex_init(&smmu->asid_lock);
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c7c4f4fda31297..efc6bc11bbb838 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -675,6 +675,8 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
+	struct xarray			asid_map;
+	struct mutex			asid_lock;
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
@@ -768,9 +770,6 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 	return NULL;
 }
 
-extern struct xarray arm_smmu_asid_xa;
-extern struct mutex arm_smmu_asid_lock;
-
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
-- 
2.42.0

