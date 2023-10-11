Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B03FB2B
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ksP7HHZ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGKHqMKEUitdzb7xM8jS/XP2C8yMXwZBHdGIRLKCtC1m+UTDS1kiu2jM1KO/VMjbpFdOSPes5lrttPSlh4BQN3Wz2H5ji+H9LlNbWReffERBivAn58VbFzthaRiP4+U+s6EiOhH3hEVETVY2NWnElvOmLdWHSIcWBJyCUmInRbxIl65WMTasskoW56iNFP8PZTlaqRKnRyctGBz1z7pQ9zg7DF96Xm03+bgmahsMgb0iM5YYND2i6kAq7ZfYGJqtj5l8G5LNRoL5lvrM5LVXA8bqPZ40mGyWnF25RU17+B2jzq3MD6IsEsR30SmZEeKggUTvxXW0ZifLNlyDB8tBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXY8cYB6r1pguAdARgFbTYspPWqf2jO88B1GajOppsw=;
 b=fxRCvogeqroAdo4b6GidqHIR1Kg+XmPAp/b+79W+K5DoQhQpTWrV9+VjNUAGa84ClKDqHbGeisSxOhb6DiYGXF9bUYtEbP1vagVEnSE1tKZkvUpCkkpWYVYF+N4RmlUH7DcSPrncOOrCJW1djWMSYt2+/S2yw7UL0yzsXLonVJumR/hzYQ5UMHhr2NoBAPPW8vPEv5LFve4gILVWM94cIXuFw+1E6s19l2G2PftE4FYzmPebJqC7uTRTm8qfk18zmRtYLJAXJIbs7zIbux02U5kOoIo2VSOUL5MYO/K8AqHMQrHI4KgTkEh0hqnCCUjvs++5IXjJVo2s8i1U6oLvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXY8cYB6r1pguAdARgFbTYspPWqf2jO88B1GajOppsw=;
 b=ksP7HHZ8CSGJ9m+75BDc0oiLcxMK85caPAvCkGLl2dOUBoX5bOIdDKrvdWW1gasWboL5zL/C7bV/z/YcbKjcd/0BQsibnoNMQG+vU84mwvtVoPFht6u4chpBJrU1DT+FDkTOQWycEtluwVZZSckURYptR8KC7yMdL9fzBCk7F0HA1YSsHTrwV4dT/IRVAlJGkm/YnD29ZeYCcyuI/R04t8yBj8Ni2JP4DL+X30AVVf/hH99mcXQydXdu9RE8c4K0OnlRJG8qP6KYsfCdL5WSNs1E88LKPI0boljsJ6BQqzSJlmwOkVhCM8gw24p/Ne5G0FdUOPjshYQvqBvqGFsQhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:07 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 12/27] iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()
Date: Wed, 11 Oct 2023 20:25:48 -0300
Message-ID: <12-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9b5633-9dfa-4e06-e220-08dbcab1704b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+1NmTsISRUkaNE0zzQy9MzIzDc4FMd2KOWbEC9fYAgb+gwZfnS99dV8toZ2AA5Q8OpXbveEvn/J8zdZkqxIo37r0xgMYFIWPhJAYmthMGMdrg9vi+8KJ5eWMyLYI+weqc6tyY4IecWFgbgMDvUNDlJsKFQjLbFixqPtmAe4hBPanJf2yol7U3nWg+LFzmcSh1LetGMyzMr1S6MWrMU4CtYD7CXH9ZoDxFh8iMQfKX35tOuOIs7+VrAsKjbnWY1ezkyNHBhg1cAhTs2fqJhRTe5xchIjlJCifE5XhUbwEmq6VeklLM8eP2x+V0ldmU6rqB+tAR9pRBkEthq54xXy8m0j2OJgEhEabsJ/sk6x51zjw45uqsX+Ox/KsIiad0kbyQKzCkf8ylA0XepP0ZjxxcMSBU6QquQiK2fC+mb1e1VvWV7WyrQoBfcjs22cSx3ktdNsN5Ni1cORNe2x4QgXVdOY865Kz3o4R6fw73z/5pE6Cqdixbcad+xZWnNu6MAoVcH4i8YDNFgGCrdTqDJKszdvP+TwEAgrK2sg6LTz8jZlxDUswjJwbjCVCozaF12G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeAEiEbg7fhfgq3I8+QWjokdEcJxnYSLEmrdyT1RxgHxmWLTR7LnoRiol2r/?=
 =?us-ascii?Q?fffTqemvTlcfNFwPOOlA1yUFZrVlw6DWe+xT1GOd3aqq1CK0l77gnNo1eqtX?=
 =?us-ascii?Q?YDq3mwQzEfy8FExUZjY5KQq3+GXXBwkDseJdq4wYTew1exFRwn8oZlUdmjqD?=
 =?us-ascii?Q?s5aVlh6WI7HoHD6qofk2dh96RBuebJ2ywfSg6oYGpYctg8cW9nakHCpaMx4B?=
 =?us-ascii?Q?OqS7zGOsKi1d+30/iu6Lc7BrZwdLKvm43yuIRMQgbVX0FjBvOpSJ83lbv4bu?=
 =?us-ascii?Q?PC4/QiYkPzsCYHhw2oBzcjYah2yGHjfa+U24OWtb98ODJHnhNVa+Z+NIVGZw?=
 =?us-ascii?Q?7wglSTBWn/X41mZFdFFrttVNZLsoEluq0ZfLmQLl3/0dZDLw7r0U2g3bZJBn?=
 =?us-ascii?Q?5M4zuzRlOEfALmQLSjjHQAhqg/liwj911bYootC0xxL4oon4dpWDcucG77Zc?=
 =?us-ascii?Q?zUG2lAz+y2JhqFBIHli3FrUF6bp9LLs29SMq7/7wJ83m3MsLaZZiOZit2n+8?=
 =?us-ascii?Q?Pj/Y7Sx1UzbMRo/YVVCqUUw337UaOh2Cc4NrPpVQ/jpd9uWV33TmWjJbv2V7?=
 =?us-ascii?Q?b0xxtdoeE3VikxksIAnZtQRdPwAYNJDNaw433ELbPBqLESJl3OTwpXn1eW6O?=
 =?us-ascii?Q?sv48dyGN1quqGq/KFdj4e9ZFelLJgeFiAtqV+OkRAfz4fGmrLVfzIC+ier3y?=
 =?us-ascii?Q?nP0HeyBvXGDKL2gCpheQaqkO/Mp8qIB5jTtX6KE4pZyVa8d7KB1MfErcMprp?=
 =?us-ascii?Q?1/VV46JwIXF9IVkkMDNJMqaO+yl37WvkBriNQWpL3typXTmwkQF6paNs0WP5?=
 =?us-ascii?Q?wfQqwqS0P6X9oPQCFB3p81G+7x75nwM3PaPmBdoxnO7x45lSeQ1s0Qv3ld7v?=
 =?us-ascii?Q?4wqjJuLgQ11XWJZmVjQSXQ9L1YqqFFzwrV5Qlhf2zhe9V7C7QleNjEKDYH63?=
 =?us-ascii?Q?/mBoCbkYLcpn7yU1SH492wKVyQW2ItVCtLqq85QGHTM3l2ZTKZ2o5I5HARKI?=
 =?us-ascii?Q?J/etAjJOnAF3gT8jrgQ/GyidCGv7uzKe0D/qada93Z/Iaix+VfvVIQiN+H+n?=
 =?us-ascii?Q?OGbdh3DCwGbczQKHUmKLhXvgTqbNEXLKjR3LaO8ZdH8GKlQerku6dqB/sRhD?=
 =?us-ascii?Q?SxDSaNkFWvYT2yJpkfw/O6BMUz4C9ioh9rAwGnXJK7uRchBKHpcpabUm4uSU?=
 =?us-ascii?Q?/aKyeHkiBVmAYCzYs4pYl9noL+3Wly6nhoiU41AhFoLFO8f7VumrGLKuB6pg?=
 =?us-ascii?Q?Ii8E8+sEKE+UrhaZDLUGLxH+HJkqYQrWEJJhoTiDrYLOeST1lfBqpq/ID8DC?=
 =?us-ascii?Q?gWUKFYIQ9Pn63wSii9cjrXcsEuwuwffyg8idCSYOOxB/+QS/aehLinI6SXM8?=
 =?us-ascii?Q?GSg0fk705rImBZUdbLPUwUd8VPLfjPKjslVGeNJtnfLEGXwXLOrljKDGMDxq?=
 =?us-ascii?Q?BgsR+107O/3T+MlCF7YovqaQsYi4y9BL3il0NahYq6ObolHKgzMTr4Ao/xz8?=
 =?us-ascii?Q?hqkhp0yZ2trL57G5JSPs28ZiYb8LM5Us+MfqFABroi3ovPw4GecEwOW0utAF?=
 =?us-ascii?Q?2vg/S/yj8rjenVZm3FiNuGVUWtU0OP489yEVBc97?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9b5633-9dfa-4e06-e220-08dbcab1704b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLn26Bbdz9/rCcG+eCqmRYXbt0DDohi0uiRghFnNmPobX3/wZYw33Hjjzgc+uI0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

Half the code was living in arm_smmu_domain_finalise_s1(), just move it
here and take the values directly from the pgtbl_ops instead of storing
copies.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 ++++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88aa40e7517cd6..894add54013fe9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1172,15 +1172,25 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
+	const struct io_pgtable_cfg *pgtbl_cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
+	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
+		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
-		cd->tcr |
+		FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
+		CTXDESC_CD_0_TCR_EPD1 |
 #ifdef __BIG_ENDIAN
 		CTXDESC_CD_0_ENDI |
 #endif
 		CTXDESC_CD_0_V |
+		FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
 		CTXDESC_CD_0_AA64 |
 		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
 		CTXDESC_CD_0_R |
@@ -1188,9 +1198,9 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 		CTXDESC_CD_0_ASET |
 		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
 		);
-
-	target->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
-	target->data[3] = cpu_to_le64(cd->mair);
+	target->data[1] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
+				      CTXDESC_CD_1_TTB0_MASK);
+	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.mair);
 }
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
@@ -2216,13 +2226,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
-				       struct arm_smmu_domain *smmu_domain,
-				       struct io_pgtable_cfg *pgtbl_cfg)
+				       struct arm_smmu_domain *smmu_domain)
 {
 	int ret;
 	u32 asid;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
-	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
 	refcount_set(&cd->refs, 1);
 
@@ -2230,31 +2238,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	if (ret)
-		goto out_unlock;
-
 	cd->asid	= (u16)asid;
-	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
-	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
-			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
-
-	mutex_unlock(&arm_smmu_asid_lock);
-	return 0;
-
-out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
-				       struct arm_smmu_domain *smmu_domain,
-				       struct io_pgtable_cfg *pgtbl_cfg)
+				       struct arm_smmu_domain *smmu_domain)
 {
 	int vmid;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2278,8 +2268,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
-				 struct arm_smmu_domain *smmu_domain,
-				 struct io_pgtable_cfg *pgtbl_cfg);
+				 struct arm_smmu_domain *smmu_domain);
 
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
@@ -2322,7 +2311,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	smmu_domain->domain.geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu, smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu, smmu_domain);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e41c83623ff2f2..6d22a9f4c33a0b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -587,9 +587,6 @@ struct arm_smmu_strtab_l1_desc {
 
 struct arm_smmu_ctx_desc {
 	u16				asid;
-	u64				ttbr;
-	u64				tcr;
-	u64				mair;
 
 	refcount_t			refs;
 	struct mm_struct		*mm;
-- 
2.42.0

