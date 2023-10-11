Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B090818
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuxEBVqq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYxcq1zUTgGDV5t1Na+z4Zuwcq+OuXtx/oQtRKdeMjKq12Himtc7reJz9mNihdRjTk9EKgxnCNxsof0Kczkg6xQuNP6Iz1gr67APWc2Li7M9IVSwyeNkfGHzNNZkZtobBh+cG1cn/CY4ObQU5zLkvM+LWv46sLIc4PFF4NdEE1vrq0/x+l4ghiimbPLLDOREjvdv6bRdzEknIpwe8iwxaBtYItoR5wStOJ4lr+mMfUU3oyetuXFHYf91SoTDwYetHQKrBKi5tkiyWTSPbS8ZAoRmMShMz+/0gJVOwCt+L9yRvwIVrImqb/9podkrQ96CkIa1F6cTMbA0id5PCiiQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BveVXCPio5cejeu+gnNGMe2uG4zPA/l1WnMj0/qt1J8=;
 b=DgGg52yG5C1wrNUTo+z4H43wrCo5ojHtO/VxRN6jvFHkh3MjS1oOUzjyglp9OKwO+UGQBMAcH/7v4LZue68g+jYOP/giOWbQxeLNEAPTc/V5cCK12c/EfExJAyNAYRRacOyXVpXJWoB1nFsbV6YC/LoVqEEMllsQlgrGoAJ5jd+LLSLzJUjeCmJM5cQEQXLfqfoIGEFS9L+blXcv0mfOxFO4BG0nPNL9TLbE2M6mID0lY6pa3lIAEmsGu4LP7NsGVDhjiKYw+Hwu9OcfYC2Q7JfCeYRi8IC464BpLPZpyte8y1W5LXAq/4uZ1qe4M0V9tbTUZQnzUEhXWLF5zCs7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BveVXCPio5cejeu+gnNGMe2uG4zPA/l1WnMj0/qt1J8=;
 b=QuxEBVqqpPk6CrOhgJwfe6c0LAuV7qN5CGlaivbFR3ruMiKzToZ09cBNzmGycwLl9Q0eRjBCQJwurlTP1fqhgbQWNBgDSJVy3AdRaS/qaxUWDLKLS0Lgm5fj0buFCPOjOBB7vYM6qCcqUMm6S0OXp9AAdPb0k73f2A7EO5TCqOtL0B5u0lldIfB/2w1OBJp1NGkA19YVWWgaBojKgHAK4xGPo+/4hWcpfKh9lpRQF6+ZZIj/G1oWp+bby/ciyCykniwotflrkoVEu1KA2mFUXkXzZZCSRAlYucfwYIY128gWQL0X/49kUUqI8aLl/boeo3FxmVhrvhKJ8qiWAQKKvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 01/19] iommu/arm-smmu-v3: Add a type for the STE
Date: Tue, 10 Oct 2023 21:33:07 -0300
Message-ID: <1-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0418.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccfdc91-2ce0-4a9a-192e-08dbc9f1af9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZpwTutF5y1jsjZ8jnWXPtfIyc+T0T1D8fPQSj3Fa2jk/7vF+2o7igRD/H6mZIfADe0pPjE+7MYjYDNzlSnDMBkYStfTsSZyWpQX6Y3zWbI9rXOQWSHAWtXsw/GenCIKpKDqXNs3RhywdlTREeDtL0iu18kQjQFlhiLbg5nvcnGG4dNSH6aQU3msYBlh/diyOWut3i4b9+JK0bblbkZDKnYBsvw1zh3Sms4Ef9fziXj4xj9QzWRASasb8HCIbcv1d4ARa6uZ7kjAa8K8gijdMdRnrKXrlFukJTIIf/H+xQGF+8IdRyRoDX3N0jAYMNYdBkRCXc3Ei70CuLcCG4v6c8yVhnHbNveM/YiuiuD/gQhWIWTUWbluAhKiXHeOyqoZxHbMhOdzfH2x3xPzW70KsmW9Mbr4bcmY+CzQ2pbjlFMk/ZohVTKXlZY12kRAin84EDl5JUtEjtKXTFpm6xzw7S3uEIPyZxXPWRt4nnLL7yLZgAEvp8LJtlriUDjR8T+QH/Hkrh+WoICWaSF/EFySS8Qfg6E6cvjeFVsyq3xku8uArMWo0RMKkh9u5izi4fLcHLnK04B1uiq3tL0CVordruIsvI97toQxobs7Ljqrf3ko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rguaZJpEn86lbiYwHc9eiVF2SwUgk71n+00xrWGaKJqx0o6kD8bJnUShvtJL?=
 =?us-ascii?Q?lgsHyz/PzDczNyWGObtDl1sVQcs3Uelc9zQdK4OukXOuJl69k7ioKstFiuav?=
 =?us-ascii?Q?L4kikqiilrGYwJvzEelhef/XpruVCAC0trRAJRSLCKIrnXkKL/askT1ZWkNw?=
 =?us-ascii?Q?jk37epi9RgAg/3zJYHCWX/st3AneE7ema4/pYnNPWjB1cpBZFIMwp5weAy1d?=
 =?us-ascii?Q?DCv1/YhLVAL7l4ndEoY+sd45SMUyFfdGA5Fwknio4UDNY+dYsWL3y8zFcfdP?=
 =?us-ascii?Q?3WgZS+LyBrHuWA5Z4QKIAnhFR/bzhBO2wLOAT7PEVfRT++LnWCcyGs+oWPwv?=
 =?us-ascii?Q?doxXji12tzTeAmPG0D1VqfpBCcD7T61nPnZrsCmSeyC6Mzz0jA6wczIGaepj?=
 =?us-ascii?Q?CVwI+QBKQ0HloASbzpEPNEvLxZB5JWmpkpHLxcokXnwwzcTn5nJMCGh4cdgF?=
 =?us-ascii?Q?rI0UCNRe8JK6KDnAWSLKCtQgP2XlwFUVUq4zmJQSLOQxrBehR67lqA0qKicc?=
 =?us-ascii?Q?d4toabpgKjjcnyh3ssdSIyYl0V6Hl5IhuVSRh4gXK8S63S7hTj0UfVRykcam?=
 =?us-ascii?Q?RqD4r5dMdZ2w4ZNWyVCdVw5DNx+pyLpA+twCQBBqyb4eUon6crXiwxhtUbCc?=
 =?us-ascii?Q?NThGQiScJBT7S1N8O0vqg3J3cdNB4vewdTgRdS3NZmFPArB4aXzyWkw1cbPk?=
 =?us-ascii?Q?7B4hlY9vycoP2zjDPqRUWfk1HRoN8m1phtWxK1PqZzSkfKUnRjcyRJn5h2YR?=
 =?us-ascii?Q?TU5MVidUSijycsh7wSg/pr6Fkb3yp9jzvPs+SgR6sPVasdRh14z0QVkhT/tC?=
 =?us-ascii?Q?timzvO34C2+YXMrpJZKVTIB4CyPSjtznu2rQ/mwqDomDAOrWGsioBhuwlQo+?=
 =?us-ascii?Q?F3V4bBuhLZ0IGwexkkuwpA5I6cD8GZ3brlCjRMTkjfuuwgwGq0VGqApKyQ2f?=
 =?us-ascii?Q?CqZf9LzjXxlFMtPNvz7F7t6fW+Uedun8bxNXHH9zH06Pvz1m4r8myaTS4434?=
 =?us-ascii?Q?+W+AJXkuJFi80cbSiJ/xkbCjjJ8BFDwQmZnLa+4O99syUW8Gumq0Cm57D+oM?=
 =?us-ascii?Q?8mrXV+Og//hl4NxJmbce0k23zqSZdl9xxyR1fHNtYYMjhFiL1bmew0tOhZmV?=
 =?us-ascii?Q?l98c3dgNS184lm8iXN2Qt807jFOFb6WR+3jbtaGn0GqI1BsE1ROTsYAxd+4e?=
 =?us-ascii?Q?FE6R7VUqT/FY/w4dhRhyDjoO1wsA5xcO5e2dIA/BXT80+iWXkN57wryIzHyT?=
 =?us-ascii?Q?hZa77u2zYoy1I1n3G1FeU9UHXIk1vVI/C3RxnnpjwIWvmgM9KswyAu7UQOu5?=
 =?us-ascii?Q?OHQNqDwu7ESUb/JLwEMoFGBJ1MavkDmk1fm+pdrqvTZuTvCBmtk+YOm8Po6u?=
 =?us-ascii?Q?ApqzL2oeXGaZNI3o4MHYRwtlIKL5mMf0VYA4gXq+SIIelurBaNqCRoof9nyv?=
 =?us-ascii?Q?wG0uBxeX4+ojclf1nkVeWiSh4/pKTYVJmAHGeX88BPrmGg658eLs/dkNCbuF?=
 =?us-ascii?Q?oMdQiF0O3/+cuHyidcJFfuxkc4cxTZjGf2AMJNe3bRL267CYgxtaphGDcNqz?=
 =?us-ascii?Q?Mx5Ys0ejsG4w8FUVEvlnO0yY68as0TxR1H8i8xmj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccfdc91-2ce0-4a9a-192e-08dbc9f1af9e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oiWL+VOaCDLrVw4DZ+QQRhu3R7Cv5QcQVuJlGXYFvNR5YFAcff1u6R1+lg+K4DJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Instead of passing a naked __le16 * around to represent a STE wrap it in a
"struct arm_smmu_ste" with an array of the correct size. This makes it
much clearer which functions will comprise the "STE API".

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 ++++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++-
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7445454c2af244..519749d15fbda0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1249,7 +1249,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
-				      __le64 *dst)
+				      struct arm_smmu_ste *dst)
 {
 	/*
 	 * This is hideously complicated, but we only really care about
@@ -1267,7 +1267,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 * 2. Write everything apart from dword 0, sync, write dword 0, sync
 	 * 3. Update Config, sync
 	 */
-	u64 val = le64_to_cpu(dst[0]);
+	u64 val = le64_to_cpu(dst->data[0]);
 	bool ste_live = false;
 	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
@@ -1325,10 +1325,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
 
-		dst[0] = cpu_to_le64(val);
-		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
+		dst->data[0] = cpu_to_le64(val);
+		dst->data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
 						STRTAB_STE_1_SHCFG_INCOMING));
-		dst[2] = 0; /* Nuke the VMID */
+		dst->data[2] = 0; /* Nuke the VMID */
 		/*
 		 * The SMMU can perform negative caching, so we must sync
 		 * the STE regardless of whether the old value was live.
@@ -1343,7 +1343,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
 		BUG_ON(ste_live);
-		dst[1] = cpu_to_le64(
+		dst->data[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
@@ -1352,7 +1352,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
-			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
+			dst->data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
@@ -1362,7 +1362,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 	if (s2_cfg) {
 		BUG_ON(ste_live);
-		dst[2] = cpu_to_le64(
+		dst->data[2] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
 			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
 #ifdef __BIG_ENDIAN
@@ -1371,18 +1371,18 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
 			 STRTAB_STE_2_S2R);
 
-		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+		dst->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
 
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
 	}
 
 	if (master->ats_enabled)
-		dst[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
+		dst->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
 						 STRTAB_STE_1_EATS_TRANS));
 
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 	/* See comment in arm_smmu_write_ctx_desc() */
-	WRITE_ONCE(dst[0], cpu_to_le64(val));
+	WRITE_ONCE(dst->data[0], cpu_to_le64(val));
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 
 	/* It's likely that we'll want to use the new STE soon */
@@ -1390,7 +1390,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
 }
 
-static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent, bool force)
+static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
+				      unsigned int nent, bool force)
 {
 	unsigned int i;
 	u64 val = STRTAB_STE_0_V;
@@ -1401,11 +1402,11 @@ static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent, bool fo
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
 
 	for (i = 0; i < nent; ++i) {
-		strtab[0] = cpu_to_le64(val);
-		strtab[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
-						   STRTAB_STE_1_SHCFG_INCOMING));
-		strtab[2] = 0;
-		strtab += STRTAB_STE_DWORDS;
+		strtab->data[0] = cpu_to_le64(val);
+		strtab->data[1] = cpu_to_le64(FIELD_PREP(
+			STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
+		strtab->data[2] = 0;
+		strtab++;
 	}
 }
 
@@ -2209,26 +2210,22 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	return 0;
 }
 
-static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 {
-	__le64 *step;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		struct arm_smmu_strtab_l1_desc *l1_desc;
 		int idx;
 
 		/* Two-level walk */
 		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
-		l1_desc = &cfg->l1_desc[idx];
-		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
-		step = &l1_desc->l2ptr[idx];
+		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
 	} else {
 		/* Simple linear lookup */
-		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
+		return (struct arm_smmu_ste *)&cfg
+			       ->strtab[sid * STRTAB_STE_DWORDS];
 	}
-
-	return step;
 }
 
 static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
@@ -2238,7 +2235,8 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
-		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step =
+			arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -3769,7 +3767,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
 	list_for_each_entry(e, &rmr_list, list) {
-		__le64 *step;
+		struct arm_smmu_ste *step;
 		struct iommu_iort_rmr_data *rmr;
 		int ret, i;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 961205ba86d25d..03f9e526cbd92f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -206,6 +206,11 @@
 #define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)
 
 #define STRTAB_STE_DWORDS		8
+
+struct arm_smmu_ste {
+	__le64 data[STRTAB_STE_DWORDS];
+};
+
 #define STRTAB_STE_0_V			(1UL << 0)
 #define STRTAB_STE_0_CFG		GENMASK_ULL(3, 1)
 #define STRTAB_STE_0_CFG_ABORT		0
@@ -571,7 +576,7 @@ struct arm_smmu_priq {
 struct arm_smmu_strtab_l1_desc {
 	u8				span;
 
-	__le64				*l2ptr;
+	struct arm_smmu_ste		*l2ptr;
 	dma_addr_t			l2ptr_dma;
 };
 
-- 
2.42.0

