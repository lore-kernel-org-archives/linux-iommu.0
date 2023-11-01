Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34311CA96
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uRb+rTx2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2z+9F/0fFpazGcRFSCPK3y22gXdwbGfWk5mUcz9cYLqqcKfJuqqLIygIVoOTuVk3y9YRSTH1kNAvlqpzSfaMfAaH3mlLpB5YguR6VjnbxJzIobC66fDqzhYcU+11niQy7TM2CPaOTdKCFcAr/CIoS1Iyxw3ImxwVL5mZqU4s5AC7aT8uyhNP9IHqp+j3oV8QUHvBIaetvBp9vDalhTJ0djHLW+sRRs8LgrGEhhN8C3NUSSBD6mt0w0YsTM2BZ1gFfR4GqmOxqHEn0HhsoBiewL1a/NUb+nzngzOGlyaEXucNqFOgoh6n3VDMMOeKkJeg5dFGUUStlLXv0EnfNm0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4rURhKAwbTVOUaKwLxWefbMSxB6FAqr6mou4/Mqf1M=;
 b=NtwmVExJY30oI+j7u1Jjnxwf1Haxvx+0nTezjP3FMZ+mM+3LrEf85gu6BOCx5sSmMWjyqvrXcSkIyE2YRQtY4P53iAKg/qWP2rBK7Ib2KsUZ9Olt5V+0Y7e40W/RWdjfAmsXCd2tsPEG3/x4SrrYWwGo6StUTXbIIUHk4dxlD3rM65jyE+HDzV6XeWdD14apABG5PskFS2CGpSIJaS7kx/RjVfa1j4d6EtEvLk6ZNq5d2MBN32zrjxC0bZNeQn219givIVdQJimCEdgvsetKtfgmN/A2oqfWkFaIbf2/Bq+dDlvIoA30Vxm14ihlWTZ6I59BqZnZyYfIJr9X/5b7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4rURhKAwbTVOUaKwLxWefbMSxB6FAqr6mou4/Mqf1M=;
 b=uRb+rTx2HZ5450Qs76Im14xxTo1ehf0CPDLFxgldq5FybTpmv4/qkbheyQUMdTqWac4Ir61vnKM9BfNuerP9pFIi65IRswbMhXx9fJ0hf7NQuyHCIugnKkNBeg32QIWDqFVb5PBkT5U2D7YVxNcOhCjNmWIIcwkRZm8WAJxqpl0c0yygfeW+2EJtygQasZIPf6CiyT/HxL1dzne72lg59nP+Km9+k4akFzVjBJFN3EEP214BIsjkV6TQ+/CIXQ4vofW0GHFY7xU6bcUTV8h1jKyah4mwQ8YP1PLGZlc3ZFZ3YeSjCfNL7jg/YYHQOS//AmSxvMs0gcorvl8476Z3kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 18/27] iommu/arm-smmu-v3: Make SVA allocate a normal arm_smmu_domain
Date: Wed,  1 Nov 2023 20:36:36 -0300
Message-ID: <18-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 10de8ff1-40fe-47a3-9cf6-08dbdb336a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tl8Kuh8WvAuG2nnCn9rMjnaLs+rOxcBpnw6VkRcRcrRJ1i7sG7dffIWi03GlIMDDOwnh0fw7zilBsEr3M2svyAJZ9vtCFoAVIKDUjYbrh9iwycfql9ZRSSUjnWjZ/iNzGN0mR/2V0E7OvdXY1XjIp1wdJBEqaSxpoxD/BXrHL0+C1CLcIm27lXxeXXSyk8TaUf1hBB7xBuB3ZoTmGns0S63ntfXwK035ro3jSzOsYW73DTy1vH6nK0IeOU2UqtdmBBn/4BuK8B9ylSSFwNT8dAhxz7FyAlyQXqeQU6FOYFuH09apZu0pUcLAoZ1a7Og4ynZSoSTxikjwEX3eCoKfHvmxcLDtsBlURcyei0AgS4wAwNalehkVYTfqi0G5vWpBC10tUi4WSYdI45NUrqbnp1O2ijQtSN6IQWtmxvrL+ZL7FuQrlHa0Kqgtf/Mk1SOr0hOgw33CCEc9JvKLZx7c9wTSqRH73QRLaVzfsGV+U/ncn7bXCdpn1zBp8gAhSLmrk7YmR9QBEb5BAEZtMzkEGxEE27zvanzFs0N7ajhEp9cDzif0aJ+tkQnrSUYPQ4Hz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkmkQnQiJinwl6vvcQLui+Zfdh1ykhDRGLapewysIDnRdN26gS/vwiI3J0Vh?=
 =?us-ascii?Q?1M6cnlTJDmz1TCgV7qclea2SazPKBLk8/Xg7Bw1MHARQpMppx4eP2penbB/N?=
 =?us-ascii?Q?lJpJCoB3ngiq7zGRm7N4PLtFLiT9hivzpeZTxz777fJWDOfgCG5n+ZITiiqf?=
 =?us-ascii?Q?6+S1NNpKCs4mLwNEhZl9pz4qC+GKpSLGLBd/bsWAuJrAg7MrVlcfUuJvSFn9?=
 =?us-ascii?Q?aub/9F0efEDd8AInUCBjXwC16fYyEa0Pvtz1Np+aKmz2NPi6wDLcX3MiQelZ?=
 =?us-ascii?Q?QLvtmcQup2dZSf6RzdUlcOmuCM7DUwOfCIiTKG2KAQ5y/JHmNGeXyzkWoM0r?=
 =?us-ascii?Q?gqsSnXxCxSqM8WzrgZyCTE2CxZ5jp4C2TBk8mY/Jaxjdw5ScHOECdSFDoNUx?=
 =?us-ascii?Q?GCvxkPwrGiSnMRRQbkOAUwM2TSOtPwUOJb2nQfIdASfwxX2kSkkvciJdOrQz?=
 =?us-ascii?Q?Wo/FVks4/WMEsQQFUbB9CRwANHcBlTucRuOnIKFsmYvWNIk9wjEhfgBXJIaB?=
 =?us-ascii?Q?WNkov/cLCiy68KORTAAm/+4cshxp22JlBZnoy01lMgi4ynrnAUbqbDMtiOzF?=
 =?us-ascii?Q?mPtzVLU7N7Y8X5qS/pKfRhvrEdZpyPYGzQnSGJJSgWgp7DwYys6acPzp+R0v?=
 =?us-ascii?Q?IsHEZvnNk+LLnXqU4POKuBrtMtgmdOvfDuKaIlp6cn/ydXh0jCW1mS49pgg3?=
 =?us-ascii?Q?uTXisHnxRHs95z8lJPAC9jy0fljapUfbi/paHFv2HhHJ22uR+OY7lkrxI4QC?=
 =?us-ascii?Q?At8bOh5DD67gmZXcd+rhshMeyOOXVknSsLXQ49RUOiLfZHTj6Q5D1Fz0QYkI?=
 =?us-ascii?Q?SawP+E7jbrhRgRI/IhSJYzhh71JDR0OdOG8l8IPmIO7R8Ix8oyZc78vTozFL?=
 =?us-ascii?Q?RwD+BYBXcJNLZkoOzOcRx/Ot+ngbxfYXuQa795ECER80De26Hkzar3xq7s0i?=
 =?us-ascii?Q?eCNYitnH9jBewwHz3fQmykAI+AKCXMNPRYcK2DFYkucVK94b8PUKvyx4Nxjm?=
 =?us-ascii?Q?3eUCAt69N4PQyiTzJWu24pOnLIrF2hb4+u05ZOMFcDhtqmoEBoLlq8KkQ8eX?=
 =?us-ascii?Q?jXvUd8L21r7IcL+IJpWv1/Y0Ep0QBO5sE8H2a1tLBbeWFWsMGuSoFQ6bdiB/?=
 =?us-ascii?Q?dEHaMKwFG13szTALe/RLsougXmb9yge05bKBC8QHlajqm5ZDMbE0vaar4Wgt?=
 =?us-ascii?Q?01dohR+dGP84Hn52FJsvjjOfQ0i41Dld2qJiX3jNvgOc6K50VVglVZbkAo5E?=
 =?us-ascii?Q?RABC0BTK95zNLdRqNv6bwLdsj6EQjRNYIHNJemiyD69jO0/IfmKA5Jb00XTe?=
 =?us-ascii?Q?803bLRwlrw9OH2RtWzuojluYeQan1nHRGPrT5penCSyrC3BMXm5fRabEKgLY?=
 =?us-ascii?Q?UplNQ1iIhEVrbgd60Hz6kMo+eQBEenjOcJax+MCmnvCSF7Z7EVQkj56KbuD4?=
 =?us-ascii?Q?yOUruli1yB5VD+DxcgQ2i0xeExxH0u+mJsU7K1eHFvZM5zTEOm81GXl3DWrZ?=
 =?us-ascii?Q?jBLWSbB7dxnTv5/74c1oCbwjgC6e147l/GsYfV3NvX2ijpFyK1tJlvuhBD+t?=
 =?us-ascii?Q?nLUuf2ZB+bQIdvi7EbXLG3FgSuuLRJJywTeeCcHL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10de8ff1-40fe-47a3-9cf6-08dbdb336a8c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:48.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVQCInor/WrmlX0hG9ffybpgNNDxcMNAhH4oOoNC0rpa6Y4IgJMAnXkDUG5b1mSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

Currently the SVA domain is a naked struct iommu_domain, allocate a struct
arm_smmu_domain instead.

This is necessary to be able to use the struct arm_master_domain
mechanism.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 +++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 34 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 ++--
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 2f818b24d931c2..5894785aa901e8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -646,14 +646,14 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 	.free			= arm_smmu_sva_domain_free
 };
 
-struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned type)
 {
-	struct iommu_domain *domain;
+	struct arm_smmu_domain *smmu_domain;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
+	smmu_domain = arm_smmu_domain_alloc();
+	if (!smmu_domain)
 		return NULL;
-	domain->ops = &arm_smmu_sva_domain_ops;
+	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
 
-	return domain;
+	return &smmu_domain->domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d9174d609659d2..326c82fad90b8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2229,23 +2229,10 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
-{
-
-	if (type == IOMMU_DOMAIN_SVA)
-		return arm_smmu_sva_domain_alloc();
-	return NULL;
-}
-
-static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	/*
-	 * Allocate the domain and initialise some of its data structures.
-	 * We can't really do anything meaningful until we've added a
-	 * master.
-	 */
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
 		return NULL;
@@ -2255,6 +2242,23 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	spin_lock_init(&smmu_domain->devices_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
+	return smmu_domain;
+}
+
+static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain;
+
+	smmu_domain = arm_smmu_domain_alloc();
+	if (!smmu_domain)
+		return NULL;
+
+	/*
+	 * Allocate the domain and initialise some of its data structures.
+	 * We can't really do anything meaningful until we've added a
+	 * master.
+	 */
+
 	if (dev) {
 		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
@@ -3207,7 +3211,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc		= arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f72aebaf95f981..c1181e456b7d5f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -765,7 +765,8 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 {
 	if (!domain)
 		return NULL;
-	if (domain->type & __IOMMU_DOMAIN_PAGING)
+	if (domain->type & __IOMMU_DOMAIN_PAGING ||
+	    domain->type == IOMMU_DOMAIN_SVA)
 		return to_smmu_domain(domain);
 	return NULL;
 }
@@ -773,6 +774,8 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
+struct arm_smmu_domain *arm_smmu_domain_alloc(void);
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
@@ -805,7 +808,7 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
-struct iommu_domain *arm_smmu_sva_domain_alloc(void);
+struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned int type);
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
-- 
2.42.0

