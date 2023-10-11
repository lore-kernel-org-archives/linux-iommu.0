Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C29CA68
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNpBU54T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc07lMeszphUe5WTW+Ni0xIv8gFz7asY/nlHz69TWNvEx41oMWyC2H4cbLhUYIaxQ4xZa5Nm5J/6svdJ7dUlmNijN4nC8/kCLy20FMW+6VjEGC907DB5GQhy4j6X7nsTmPRdxMehz6OQTYQAZ5zRMYuvmRakRcXxyFVbBlRVozOiWCuPyzHOM+KR26ciVRd4U5DhnrmGauP62jlwd8kJdh8I02RNI036uGnW95YW6S5wp6a9iCVR1BpYX87VD69ktYPoTZW9+nRV1ldc2RDbd5b9mIrwJRaw8GW8zjAHXzm7ZoaqPWY94upyArNeYRiGMI+ix9GirLFbkm191cn3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp8FVvZKSXYfhl5wczCdMR+4fmPeIChmQiUiL5g5Nno=;
 b=jgLx3NLPtr52d1dZBK2qkg1U2seBwJOIUVgK+UyvxUEHFAnh/nxkon9vNRRye3m44Fhe9FBunFZ2DZ/8YsniibkFJTgfowrZVw+BdjcNxke/tm8Oj9Xdjlox42uI8QXx3DWBHvGiYYaG6FJlhQ/pqz85SsIDrPMVBTRscFoO+G2Zgdmd+qh7LT0hEuBZzhYvyFSp99xErL6zNP1U9rq/jLx2oHWskMFHMaqJOlsetVMx3shVZ+IIMP4pDy7Hshoz5dkvbCYOY1kr71V/s9t+8Ae9b+6CGFnWhByAydrDuMCtf0rBD1lJn6kakBfWjE/2f5kaWa84BbTrnLeBwUWILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp8FVvZKSXYfhl5wczCdMR+4fmPeIChmQiUiL5g5Nno=;
 b=MNpBU54TpiWMr9lHIOk/NE+DK+GMT8nMr7tesFutHE54UsM9MoaO5l43CizAR2BT6xV65b/qY/6s0RvxHBXC1ZHZ/80Is8nRO2rWQGmf+qhxwbqjOMJ9suCQZVeoSa2w1dw97Iwt+6UYa4QH3ELqr6EjVpol3C1948LWPTFvga0DJ2d1NPPe+9+qWQxHji2xnYVBOoRCF+tbfXoXwl4bT/UyLA93OLrCr4JN3hdZ1BXYwdKhfuyxcWJ3Rg3UoVZwZdoGVT4atM+dTNqxDlGEiASaoiqSxCaGgLz/fKHbZwZzffFtN5GKi+96qkpfabxy9igcxggKMtDkZ61haQaa4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 10/27] iommu/arm-smmu-v3: Move the CD generation for SVA into a function
Date: Wed, 11 Oct 2023 20:25:46 -0300
Message-ID: <10-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b4aa7f-a78d-463b-8610-08dbcab170d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8gA/Qs9JdIWNYGulwckf3oYVlxXCiFsOEY7zZnSt91IzmBEQgHKIAvmZaTIjBixqUops6QkCfI60RNn8lK9xfxKCPU1VRWv8ZfVhOC5EeMtRYJC19ffRWzYGcUGmHXGrpsYP9bYX6/jOALoTmrWzCLI90CgBFDv1O/5ZHdMeYtHqjqn9jSh3H8CQ0Ri8H0r2Z3xdqZupzSi/uufivGRWTffTKyOKRRipV2n/jYMP7PvvjkIz5psd/Gq6/7Zuh+9JxTtgEDYUw7OMBI0JeqV+yg40PzllfasVas3Ep0YHGH8nh1A2kkUiZQ0SEs5kqKnp5mYv5Olw9eb7yyWlwkeUMuTGY0U/MgC3sCmFnIAdWVLeT868y54/n/y59tPUaNiNlMskuq9QGiDyh+ly3QrB/s9vhuwl+nyW3xvjenpr7B7bYFPJd2WWQNkGIMeZVHsP901FHCGKbkKGYjTclqZKeTgXb+K+seuUdJ6RDkQ1wPQ0cg4MbN+QOwzRIjN0BnIPAvyeG15BgoEUQLTA/FwlB0NKTDC+RKCHbVU2cerdFx+0Anuhu14/CG0ulcoSMlvacbS7ZAfCx/V90/xhM5q4WP4NU3C4H5dGPGvQamrZvCOV/wNGa4nqRj2LorPnuJzRkYVRCXJg/Oeipv0y7rnUFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(30864003)(83380400001)(478600001)(86362001)(6506007)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TQwrJIZFeQbWgN7uNsKfeetspNt8H4YZJBr2GsycGnkB8Uw0Y/7irq47bx1?=
 =?us-ascii?Q?ce4+NlVrz8rjyka5rd+c7NeJtCZICpRm22d2G54DKUuatJ5A0gsMaBfWIuA8?=
 =?us-ascii?Q?OGqle/MXpqiih63Fc0DdKceQ9jWSQVOgYVcvbEveMykgsAUrFzSvFXnSdAIX?=
 =?us-ascii?Q?CBTNNX4MMVMpYbAJ0fsUepslcD04x4msCLm55iyC04M2XNs4AGzfRa2fW0Ef?=
 =?us-ascii?Q?WzNZAtYV7mMdCrhDkdVmnY6eDPEdIYJsp8nrAjPG0YHwIpNpTvCDndjgCV9n?=
 =?us-ascii?Q?AYuANW8aFvAPr1Jtf+2yoSUO8u89e7wDmpnFl4fqvnWXRu/9NozT5rxeA1gV?=
 =?us-ascii?Q?Ld3ghlKhKeiTJXFDp1Jbuz37VnKo6BE6YTkB2bW3Niy7uqLgO5h+Ni1IYEoI?=
 =?us-ascii?Q?d89ddrtztoAezvUFUQXPZNr/zBf3zw7PpxwS0BKDIKOvleam0k6AbBH3ynGd?=
 =?us-ascii?Q?qfQ6xqRh09vrB3Qjzl6UP1MaMSr0lmFY9Bw1nUecryMTVi/5hOqRXbRDhdVo?=
 =?us-ascii?Q?47jKMbzujGgIgARQmqR3P6DYiMyM6HNTv/M1bZiKrBjrIGdx4a6fA5obZz2v?=
 =?us-ascii?Q?SBJWAVIuCmRbBSzMbBOoTJcitbiEYRJaEYe3uVYuAihwfdGzcQFjmt/oJBlt?=
 =?us-ascii?Q?9h7XJGW+/5taUJTHRtcPpHNQUxUfXu9p6aw8nYd59sIl7oDtOodjVqfGKAG9?=
 =?us-ascii?Q?6lobwtQqf50y0arU6WIvqsU8TS46YbK9g7bw48jSbcBq1hIu/xtgvuDEyuSx?=
 =?us-ascii?Q?0ZWAjm6l5ML1NWHpqxY7+cGzFvv2C/42wY6FiXCEFgzjO+5HIK+kq9u5ABX1?=
 =?us-ascii?Q?bY+tzkDxTwLOD/2IbVy0RNUDHa3iZ+S8RQRHRSBSX/C1rDg79ARJxllxTSrU?=
 =?us-ascii?Q?MkVYTK0m9c/Ap00yQDIvqAqZ6/GzL/Eh77dzGynYfsVzGkAa5vTQdwXRXETo?=
 =?us-ascii?Q?dHdMrKYI08w3kOzEbAPXs4mGWxWV/woFxpCz6idWGdQ+2hpn79krziHUnASE?=
 =?us-ascii?Q?/FAp9aBmzLJ8gd6tEMia+ZwRsMaxZ+xCRjHtmT4vmQvUuExP44oKz9nJknZ+?=
 =?us-ascii?Q?s3JwG+xV3bZph165HAOSJg1LhGHAbWVoF+ASagmzbYkBwXFTNe/MF1fpJzdv?=
 =?us-ascii?Q?AGdiOg0dBK2nPAJdhx883oDY8Jee4WBvI9dDVo/3Y7QdIq8ViVwaeOQef5vC?=
 =?us-ascii?Q?z/3AG8MfcSi8TPXVoephNBtS+ilRYGSi7C9tx//EKQSeIpway+fdsTR1csD6?=
 =?us-ascii?Q?AgW7O0BlRUSnIcdbuhL1nxE/gHzoWXRHpudMmCtGVQzT0P+vBp5hV9o2NBms?=
 =?us-ascii?Q?kXVXxG1twSdbmqfIT4XWCHeBE7O9WfLRKI8gXPFjornYlDXq9Px9cNcsqkx5?=
 =?us-ascii?Q?RDtAzhOOysa/x63STWPg7kUhEB85QvQnB4RA6Gt29Yqpa9HWA4NjZB4jIwp6?=
 =?us-ascii?Q?vAHL6Npgrs/paKnxXED6LrE5VaVU7p97hmjFMVXiZ3az6f8bx/2hDgqTuR5O?=
 =?us-ascii?Q?lZkYb2Ha7xkBa3fDPJoj0KOkzVF9nxW3S3MyY9tAVyRKWwrjkq4NFuZNU4tk?=
 =?us-ascii?Q?AJq7pL2f+4z/7LqS0gC5+1u8HcRlUbiVR0nfCrZl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b4aa7f-a78d-463b-8610-08dbcab170d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chsy++5wSSm4bWYQjamzNQkONGpum5ix1xo87TQOBqfM9AbnzmjoAHNM2brDvMQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Pull all the calculations for building the CD table entry for a mmu_struct
into arm_smmu_make_sva_cd().

Call it in the two places installing the SVA CD table entry.

Open code the last caller of arm_smmu_update_ctx_desc_devices() and remove
the function.

Remove arm_smmu_write_ctx_desc() since all callers are gone.

Remove quiet_cd since all users are gone, arm_smmu_make_sva_cd() creates
the same value.

The behavior of quiet_cd changes slightly, the old implementation edited
the CD in place to set CTXDESC_CD_0_TCR_EPD0 assuming it was a SVA CD
entry. This version generates a full CD entry with a 0 TTB0 and relies on
arm_smmu_write_cd_entry() to install it hitlessly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 145 +++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  77 +---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 -
 3 files changed, 93 insertions(+), 134 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 03a8e7b73bc004..73fe2919cc5f69 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -37,25 +37,6 @@ struct arm_smmu_bond {
 
 static DEFINE_MUTEX(sva_lock);
 
-/*
- * Write the CD to the CD tables for all masters that this domain is attached
- * to. Note that this is only used to update existing CD entries in the target
- * CD table, for which it's assumed that arm_smmu_write_ctx_desc can't fail.
- */
-static void arm_smmu_update_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
-					   int ssid,
-					   struct arm_smmu_ctx_desc *cd)
-{
-	struct arm_smmu_master *master;
-	unsigned long flags;
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		arm_smmu_write_ctx_desc(master, ssid, cd);
-	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-}
-
 static void
 arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 {
@@ -131,11 +112,76 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	return NULL;
 }
 
+static u64 page_size_to_cd(void)
+{
+	static_assert(PAGE_SIZE == SZ_4K || PAGE_SIZE == SZ_16K ||
+		      PAGE_SIZE == SZ_64K);
+	if (PAGE_SIZE == SZ_64K)
+		return ARM_LPAE_TCR_TG0_64K;
+	if (PAGE_SIZE == SZ_16K)
+		return ARM_LPAE_TCR_TG0_16K;
+	return ARM_LPAE_TCR_TG0_4K;
+}
+
+static void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
+				 struct arm_smmu_master *master,
+				 struct mm_struct *mm, u16 asid)
+{
+	u64 par;
+
+	memset(target, 0, sizeof(*target));
+
+	par = cpuid_feature_extract_unsigned_field(
+		read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1),
+		ID_AA64MMFR0_EL1_PARANGE_SHIFT);
+
+	target->data[0] = cpu_to_le64(
+		CTXDESC_CD_0_TCR_EPD1 |
+#ifdef __BIG_ENDIAN
+		CTXDESC_CD_0_ENDI |
+#endif
+		CTXDESC_CD_0_V |
+		FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par) |
+		CTXDESC_CD_0_AA64 |
+		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
+		CTXDESC_CD_0_R |
+		CTXDESC_CD_0_A |
+		CTXDESC_CD_0_ASET |
+		FIELD_PREP(CTXDESC_CD_0_ASID, asid));
+
+	/*
+	 * If no MM is passed then this creates a SVA entry that faults
+	 * everything. arm_smmu_write_cd_entry() can hitlessly go between these
+	 * two entries types since TTB0 is ignored by HW when EPD0 is set.
+	 */
+	if (mm) {
+		target->data[0] |= cpu_to_le64(
+			FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ,
+				   64ULL - vabits_actual) |
+			FIELD_PREP(CTXDESC_CD_0_TCR_TG0, page_size_to_cd()) |
+			FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0,
+				   ARM_LPAE_TCR_RGN_WBWA) |
+			FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0,
+				   ARM_LPAE_TCR_RGN_WBWA) |
+			FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS));
+
+		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
+					      CTXDESC_CD_1_TTB0_MASK);
+	} else {
+		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
+	}
+
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	target->data[3] = cpu_to_le64(read_sysreg(mair_el1));
+}
+
 static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 {
 	u16 asid;
 	int err = 0;
-	u64 tcr, par, reg;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_ctx_desc *ret = NULL;
 
@@ -169,39 +215,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	if (err)
 		goto out_free_asid;
 
-	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - vabits_actual) |
-	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
-	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
-	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
-	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-
-	switch (PAGE_SIZE) {
-	case SZ_4K:
-		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
-		break;
-	case SZ_16K:
-		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
-		break;
-	case SZ_64K:
-		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
-		break;
-	default:
-		WARN_ON(1);
-		err = -EINVAL;
-		goto out_free_asid;
-	}
-
-	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
-	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
-
-	cd->ttbr = virt_to_phys(mm->pgd);
-	cd->tcr = tcr;
-	/*
-	 * MAIR value is pretty much constant and global, so we can just get it
-	 * from the current CPU register
-	 */
-	cd->mair = read_sysreg(mair_el1);
 	cd->asid = asid;
 	cd->mm = mm;
 
@@ -278,6 +291,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	mutex_lock(&sva_lock);
 	if (smmu_mn->cleared) {
@@ -289,7 +304,18 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		struct arm_smmu_cd target;
+		struct arm_smmu_cd *cdptr;
+
+		cdptr = arm_smmu_get_cd_ptr(master, mm->pasid);
+		if (WARN_ON(!cdptr))
+			continue;
+		arm_smmu_make_sva_cd(&target, master, NULL, smmu_mn->cd->asid);
+		arm_smmu_write_cd_entry(master, mm->pasid, cdptr, &target);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
@@ -350,12 +376,19 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
-		if (ret) {
+		struct arm_smmu_cd target;
+		struct arm_smmu_cd *cdptr;
+
+		cdptr = arm_smmu_get_cd_ptr(master, mm->pasid);
+		if (!cdptr) {
+			ret = -ENOMEM;
 			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
 				arm_smmu_clear_cd(master, mm->pasid);
 			break;
 		}
+
+		arm_smmu_make_sva_cd(&target, master, mm, cd->asid);
+		arm_smmu_write_cd_entry(master, mm->pasid, cdptr, &target);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 	if (ret)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e83fe8a1f8eef2..822df7f9309b25 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -74,12 +74,6 @@ struct arm_smmu_option_prop {
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
-/*
- * Special value used by SVA when a process dies, to quiesce a CD without
- * disabling it.
- */
-struct arm_smmu_ctx_desc quiet_cd = { 0 };
-
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -1160,8 +1154,12 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     const struct arm_smmu_cd *target)
 {
 	struct arm_smmu_cd target_used;
+	int i;
 
 	arm_smmu_get_cd_used(target, &target_used);
+	/* Masks in arm_smmu_get_cd_used() are up to date */
+	for (i = 0; i != ARRAY_SIZE(target->data); i++)
+		WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
 	while (true) {
 		if (arm_smmu_write_cd_step(cdptr, target, &target_used))
 			break;
@@ -1208,72 +1206,6 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
-			    struct arm_smmu_ctx_desc *cd)
-{
-	/*
-	 * This function handles the following cases:
-	 *
-	 * (1) Install primary CD, for normal DMA traffic (SSID = IOMMU_NO_PASID = 0).
-	 * (2) Install a secondary CD, for SID+SSID traffic.
-	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
-	 *     CD, then invalidate the old entry and mappings.
-	 * (4) Quiesce the context without clearing the valid bit. Disable
-	 *     translation, and ignore any translation fault.
-	 * (5) Remove a secondary CD.
-	 */
-	u64 val;
-	bool cd_live;
-	struct arm_smmu_cd target;
-	struct arm_smmu_cd *cdptr = &target;
-	struct arm_smmu_cd *cd_table_entry;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
-
-	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
-		return -E2BIG;
-
-	cd_table_entry = arm_smmu_get_cd_ptr(master, ssid);
-	if (!cd_table_entry)
-		return -ENOMEM;
-
-	target = *cd_table_entry;
-	val = le64_to_cpu(cdptr->data[0]);
-	cd_live = !!(val & CTXDESC_CD_0_V);
-
-	if (!cd) { /* (5) */
-		val = 0;
-	} else if (cd == &quiet_cd) { /* (4) */
-		val |= CTXDESC_CD_0_TCR_EPD0;
-	} else if (cd_live) { /* (3) */
-		val &= ~CTXDESC_CD_0_ASID;
-		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
-		/*
-		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
-		 * this substream's traffic
-		 */
-	} else { /* (1) and (2) */
-		cdptr->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
-		cdptr->data[2] = 0;
-		cdptr->data[3] = cpu_to_le64(cd->mair);
-
-		val = cd->tcr |
-#ifdef __BIG_ENDIAN
-			CTXDESC_CD_0_ENDI |
-#endif
-			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
-			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
-			CTXDESC_CD_0_AA64 |
-			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
-			CTXDESC_CD_0_V;
-
-		if (cd_table->stall_enabled)
-			val |= CTXDESC_CD_0_S;
-	}
-	cdptr->data[0] = cpu_to_le64(val);
-	arm_smmu_write_cd_entry(master, ssid, cd_table_entry, &target);
-	return 0;
-}
-
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 {
 	int ret;
@@ -1282,7 +1214,6 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	cd_table->stall_enabled = master->stall_enabled;
 	cd_table->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cd_table->s1cdmax;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 950f5a08acda6d..6ed7645938a686 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -608,8 +608,6 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
-	/* Whether CD entries in this table have the stall bit set. */
-	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -761,7 +759,6 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
-extern struct arm_smmu_ctx_desc quiet_cd;
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
@@ -773,8 +770,6 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     struct arm_smmu_cd *cdptr,
 			     const struct arm_smmu_cd *target);
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
-			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.42.0

