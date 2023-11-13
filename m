Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1275225CC
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OczEAv2s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzLLx+NwJoYtBKVxx/RGdUEAt0SHP60Lc7N5uhs21sYnnxJpwKwKhNbvMUCnNrf3NNua+LhJvTjcQP5ehGzv8VQtL2Xe2UOkHB04TNcWXSis5roqp6VUMdXjS9T4QhZMq5XzOE+craVlhDO2qJaHN7OAmfEn4IfMym2WK3qWdebCM8r/m23engHdBdVHhwTs3SW5MxtYJROrbLcJrQRMdXuJfE6teLBXIpnD/mEcmalvVdRC49Q6rMQSZkXPKo5QrtL2DRLm+kTv/tvWuOv9b5hA8xPquZFMWq4XkdsX3xQGGHn8AXKaWtiNbDN4CK1+4Jjnt8gm6KPmB1ZfPdqb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BveVXCPio5cejeu+gnNGMe2uG4zPA/l1WnMj0/qt1J8=;
 b=BRw7chAKTa5o19ocujMzWzMIzndAEfDMQp0un35JE80GJlI/tvl2qLm0+vP0lgG5KlvmXd3dgCFIqolLL0LUTRkNfMt8Sgr/Vgli+Gyhht3e9kg+qQNCDRzIuGqHakwLINb6MndK8E4m+DWOWJE5qZ0TVt6seUABxdoY32xx0DSSvWZ2m4DZjkcCoxN47Gien1xtOsL97YSgAkPhjeYKCuAZ8dGxOsX9T+Gibmnv+Sxzw/b1TMWpQFHT41PLRyawkKBfVFf2iJUGQVt79oRTwTFlH/rcn6M/z3KWuDB82ES08s3IpZSRkbwLXhrnIx97csm/7HZVxncBV5kemB7ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BveVXCPio5cejeu+gnNGMe2uG4zPA/l1WnMj0/qt1J8=;
 b=OczEAv2sovB4EfT4gaTFDld+HvffcRXEy3xVAQZpM63Z7ALD4KxdIAXpjkGFCfg/m13GAdwj6mdREtF6iWX2dKi/OO8XwNATA9ZOvlhUoHhthFbnn0PiVseZ5jCFVaYA98hayI1Sm3BuR4A3TMGuvfqyB/RiZPFz59aouBaLSHCt9ruAFpPsNuTY/b5R47WG3luoQnvvsqupHsUNbrQYnI5z/EPRmbtP6XsB0W1Hae8ePhurI1Bf9x+3swqVM5is1197/mO8HdRXZXnWT+Wg9AfV5vFuMrIbjPA4MLYr+//Jt9tLk4Hitxs/43Rpv7Z4W3YSTATojhqG5OTnLuK2Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:36 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
Date: Mon, 13 Nov 2023 13:53:08 -0400
Message-ID: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f8d554-26c4-4082-9f94-08dbe47170ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tk0N/tVokYAKc9SVxoVNKZrhUwm55rmlUNPRx+EkMUgjPpbJOmn8m9gnGOYxGB9N9DRfFVmA5pmlN/h19VV/TzT6dHKk4xJXMimiDIOerWrAPbXWd1MlK49lZibN8VNnbpnKb4pV4yNJGW6C1OnqBs86D1qfO9yNpXuOaP2TXvDtF2h6S3TBcvWD9syhVkEmZnq5S31qXxV6NY5XHcoE3LWFGlcI3zhwcpIqNgmc1/TOoR7j4X5ZTuZUsSYbkLTSE6yi5JWLi3p2MCm4gIRd5oqC+2kh5bvMDJkqQzhosrSw3GFPLpUa3WvNWVfY0HTK/+y6P8YDmIztU1b4fBgpRtBxV9+oscpC4FsLZ35hntfZxuM08mj4hesFe9/zcf9ChwnCV5hvJhaGcMsWO0ahNTa5Gb2wvpRozQhtN4UFE3/45Y7uFpR09VMnkl9P/9v9vyJs3WpGuTnYHAkU16x+P2v+69nkAyYwyLsbAcyMtTdyBtp8SAK58briauln97D9XWNOA1jqKHU5jr/mra0wXDDd+ptBTPZYrWaI3CGRzyZgPM/2R5bsx2s+m/FZCIVrxS7ntD3vQVYbk9ckVW/5alN89iBF7VZN6nlYYnIw4FQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cf7zOzrs5hd6gxnYl2AGY9wt7hYbOJFJ9Lt/v1s7ZOmmYQ5lLVn3jPZQWIDr?=
 =?us-ascii?Q?dacATP3HYrmDUhSofuRfhCEmCNBjU5MD9SM8fDaFcUkwpcSN4XPheCWd31RZ?=
 =?us-ascii?Q?cwaWJKRVux7flWe+aqRw6KhDzvtF/umDy8KbH3QU9J66ADNLVi+6Ty7RrsWP?=
 =?us-ascii?Q?PS16im7nvCdy0QqbBUjimT5vYezaP5fbX6HE6gRYToEJtm/8aEhDoQQ2Pcnd?=
 =?us-ascii?Q?XBiztQt6fa+ECny3oCvrqWjiST/LbYPYkqkivR2MKF4zuJlkTucKMsB/FY8Z?=
 =?us-ascii?Q?KM92RO4ZqNU3ppBdK32g0vsOxrJ12MB7EsRGdGYJ3duBePCAbviqIkjPmHLI?=
 =?us-ascii?Q?ZLkgIUzQzml9AQVH5CDC5q+Bpy8Z+vhZ8wIQhQGcah1ju2309sNzTew4ekVI?=
 =?us-ascii?Q?Ruo3qbcp31wFE6us55lav50ieSGqEXpYghyZqwheX745iKT3bpX1RU76A8o3?=
 =?us-ascii?Q?9lu8ZjMlKAf6MefS99Jwx/TNy/NObqBXBlJ9iDz5OqKmR3f/kykZpcOB5r2f?=
 =?us-ascii?Q?SH37UFDZWMQRa0tQ2kBSDru7/pWSErk2rFfTpa5h1Kg7cmmfKtiXu4faaW62?=
 =?us-ascii?Q?rrev0W047rmDQXuu3Hlkli7D/WWPe13gzLmrhkI94/m3bl+Moy9fJLWJ1pra?=
 =?us-ascii?Q?4anVPO60Gwj0lMVql1mdbnvu6wyywZgzP8Du6m6/mOFCXAcUTBr/ieYd9SD5?=
 =?us-ascii?Q?rUcypuF4fqX4mJHETO8yTwKYHmPAzmEKoIhlGpst5W989BNWufWOtUWrx9GM?=
 =?us-ascii?Q?Q28IaCUU4JdGLgagWlxg8EGV3rtQ1PDVFCePZ9E1QFG000+m1AFrhIwr95FH?=
 =?us-ascii?Q?Wzp+uLG+xoRb46v3tHbRf7CzXHXtULUuQyEpMnpzRhVMlYmoXecIU0o3EEwd?=
 =?us-ascii?Q?kACS9y7OHgjw+IOjTjmPdrYphoU9/4n0XVHOAl2OWqHsVCsoxZ4dNN4YIKY3?=
 =?us-ascii?Q?Z3YurusOXpldb4xNyenmYnFBAhnkX2LX56qiy0S9mENzKIAgkuMu2BTALoL0?=
 =?us-ascii?Q?ghus4yreieFuiti6Lxznb9BMPYea3Uiw0itcSRsfJhzDtsR2yDQCxkzDop4p?=
 =?us-ascii?Q?jTfBBynXaoKBLOV8Sb16Yr2oP6fy8/AvDecXP1YWTrxb8VkMMAhCX909ETFZ?=
 =?us-ascii?Q?jm2nAswUAKfM9zHpmXWCAI1J9qul5qVYP6nGt7uAw23WbWL8am/qBxLNZzTm?=
 =?us-ascii?Q?gEeOoG7NuqV+F0MoEzj2K6X/GvLy2dYspozOxUI2kq9An6n0P9TuzgwOoRjN?=
 =?us-ascii?Q?I2G9dVAKMtAT4qBwE24w6kJa++aBwLMnoxT7XkIBPPOgVNHEu+drq5/J9TlS?=
 =?us-ascii?Q?nl7KXgJMqsqs0OLomW2qGN+C5nQlgiHxhwN0aU6rPQmwJyahXeKoYleRfZGu?=
 =?us-ascii?Q?vLziaZBpOBGvz2PdqQ3I+LRmFgs0vVq5Wyw222aFJUb6fmw4ynsq+pSaD9VL?=
 =?us-ascii?Q?r6lcEPcouePN09xchDAPVOD9F2d3Cq1rB8/kNjVcXiKBXosYuBoG2TX+eHLu?=
 =?us-ascii?Q?WnKsUlo8wI6Rg+scIJHHfhDhbApQ3q6TCKxoBmCDTNXSrWqZlOzH5E/YjjyR?=
 =?us-ascii?Q?79dP4qEp3r8CesHoQP4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f8d554-26c4-4082-9f94-08dbe47170ab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnstzaAGGQBMlTb22UjuW3qhgmWftYqeJV2UxRjyLlT4GiS0vBMBKvRUTgK+IYGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

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

