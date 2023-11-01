Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3891C694
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maOVsj/m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqblf8sU47+JGvAaGztPRC6ce+5qhhg3Jkt4ZEobD4OuCyQW/OSs7nD3tLCCGBVKUrIkY1bz+r4GFiZViC8pkT1vxYmCPcTnLNEEbPivhHZGI/67Nr0ajF8FfIrxcZNJLKRmg96hlJBoUzIjrViYjtweYXKac+1SZ78TPHLjt3R4ymuf9GlSQGZ6VGSJG19pTvnLPGIOHTm5Q/GVOahfNtZxlb6fjKKMY7WyWXm5CjoxTAlgCnhJWUhHGtFUsjy1JPeYn8R83LphFb/+6Y7gsg3OpQ60TaFJFuUI5VQfQWhRqnvpniwRELyQbzF7Bcotw8mDgyRZITS5J2bCR1XQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebdqfe9hHI80d66WoIdCKN+fhJlczA2bMUAoKvEZgpY=;
 b=esyzznktGcrFQmAq3eQJk7X+GP2EnN8EYuLwCKp4xp4ETkxH6gJx9Q6y4ndh+wxwRcG5tEUrDHarptw2iAn3IoJGNf8XGCkqb2ON1ODzsKHqZeMwlkTHl2xZB6yU8WJRGOfqNTX6wX+m/t7+SyvTT25mXlJhATjQ5GHeMKLjqPpNHLOmWjytvwHLuYsJv7DF35hsG8Bv66n05qXI7a4QLHwRgZJv7NF5B9V462b6l+oA656Dtu7fFKGQV+8695lNyVaF9eR9d0Pc1nk27cG8pAVX6EBWVyZMKEoGjYlBh8zjk5VC/LrL49rwBMbA+mRZDN4AtxyoK6LO4owwskEUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebdqfe9hHI80d66WoIdCKN+fhJlczA2bMUAoKvEZgpY=;
 b=maOVsj/mnPc7rIqixuG1d+Bfn4hjtMyFrUc5nlOUwCA1H7vlNYk0GT/13pUQMH8pfz71D78HJ6gUcLbhDzYxHbhCbF2XAMbl1Rk19wuYSBrV/AxPLPZv8GVa+IC3F2dg9L1TdHZ9eBwNiTRrGi1fZvWNqMn0PWz0FA4y4mM0xs5TwbpxerQj6QPFszazTf2Il51w8j9vR927hXUdFB+J0MwJNva42sUMWol72Tbv0bwM7R+l2GLr5noMdtPXjA1gzNb5g6lgiv/ffs6N4YZNdGDncgw4r5wrZtyUWlizstCAVIqerYeBUf0/Sl0KeJHmFNNdg6xCFVoEbnuWCjigFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 10/27] iommu/arm-smmu-v3: Move the CD generation for SVA into a function
Date: Wed,  1 Nov 2023 20:36:28 -0300
Message-ID: <10-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae677b0-4098-4393-93c5-08dbdb3369a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jntti+7pZopojPGjqECMuwXru/5ROHuDla5y/pZD1tKaZ17NLI3hJ+o0VkGXB1GMjAkzifBufqJYqAO8fCeyw5gRGnWU7Qlikbv5QarWJVDGRXfP06iYL9zY1HOcdndSIGgLhI85Zt1YO+2FzqBKyUJ0Sm5zdnMN/4htFGzF5qcz7hvP9Fr+qg7O+GKP5vKLJoeohN+eyON5WeShFWAL5XxhIuJnCDGmBUYOnbG7U9L3MQtRxDrg78BviHOeaMzL3u73jgzeoHXzwGXHpM6DX/2jJapKGyrpvwr8eBE/+rHXb0yfM26YouiWUe4SbMrylUa6VHYZKNcVp9Or1CVOtGLNKgM76l28ZWD3duDdjJEF1qU6C4g742bBecllOyiJjHkRQanxSBw7WXiH1qPo0uNe//dbHB3CZSfGNR4ft346QmOL3Xvb1JTAN+Yd//p05B4u1qNkcRa+hMi/Xvexk9FMPPO3uCLqluiwj2S/ZxGPqLwH6gAAY0fKGmQkDd1bTDJ4kZkn0jsDotu26z9yjJGYHFdYw+T8J+leTBMV4nPGAO6HqE/HSnegv9UH4tooNzoRbThaS9uljTSzYgak+NDOJCO0Hs/D9+8vHeHgVkyabhTxVLn4H2Gj/00Ec2i3EdC12pjnArNgw5UcAvqwxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(30864003)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENTGVIWAMd4M4MxHICXcNIoj2M6UHzOIjb4Z74bJM8D4RDw2/tMCfRX67sTo?=
 =?us-ascii?Q?uLkkCLv5jM7HRHWa1Ak5tcTGotRJJbDPnSdhmiKsVX8ewhjRynBrqvlb0n5g?=
 =?us-ascii?Q?6UG2vbOwNQoYcI4pWNq2t1Y1mFxhmXXnmoM1HyabTqdB6nHWpKI2f5IjAFHk?=
 =?us-ascii?Q?uB9jXGm4Nay509ioHvCJ+YrWgFaPNtHIfyKmQgwdkHmpzemT46aQlo9FdSK2?=
 =?us-ascii?Q?aGHB0DxmLyh0tslkdNkO1tYHUYzyVn7R11iKr56DLPBNdczOXw1Lq95WhFsV?=
 =?us-ascii?Q?m9bA62Hsp40oR0mW0Jgg3d7lrPrgmexbQi1qL1FXNgUdGBGwwbXKPTkiX6k8?=
 =?us-ascii?Q?BwvxUB0X1jmbMBhM/WR2hFkdoxpTCQ1d5l59SMFNz7neV4QFqirnqJ/iVDJK?=
 =?us-ascii?Q?QyIknXXN+Xa+k1eFxdZb/qj6IyZzptCqREJAxmKOctu1lyA0rjwE4vsJy9m0?=
 =?us-ascii?Q?5sNmkUMPEsZ2pu+0hOGfl03/psJms+TptxjwuSnex1FNMuhlwOFSf+C9M7Kl?=
 =?us-ascii?Q?byYCDs3waDVQQA2yc1QQT/T0DC4u+CzEKfJmixr5R864t+ydmH+RJXpHcsZn?=
 =?us-ascii?Q?RIg5gw9QRyhhPLRVX+0uqUfaOAoQM6sH48SlSO6ZbMZnY/xzFRtdiDC1KSgy?=
 =?us-ascii?Q?5QkfUNwN9Y38QUy3syMWjrp7jhih8GH5r+q63mRWUkQAuPmdvKQ6DB8/zgq8?=
 =?us-ascii?Q?iQTUVw/2ccdI6dp20bVg3ah1IDQ15i0FMKCUn5mxeWrb+ylB4+RQOUhc9JeG?=
 =?us-ascii?Q?suMRbQ6OLm2eEc09s/VQFuuW+llKOrXdVGsJyJKmqgdQr/FlOD3loCjE8rCv?=
 =?us-ascii?Q?o8c1paddj9NbUV9vvYE3yeXjAIfWaHtNYm7d9EPET72EtV7gHE7/FoqQUumB?=
 =?us-ascii?Q?ZqkrA8RqiOEv1oeM93uwR4SEHLwJ6wBaNXE3YWSpashCadiEQTYwvLD9P1zx?=
 =?us-ascii?Q?GBBvMmHvvMylDAWyc244u2aGTJPj2Eht1ycX16Pr2EEJpCWyhPCzCuoRv8+Z?=
 =?us-ascii?Q?tJrkwLDhKSmvAnRcjeKIwp5Lqyk9Pm2yFCxmCkqK4AbcgdFbzYygzhNWZ/xt?=
 =?us-ascii?Q?p/qsR8AhjfC/GW/K14rua/W+YkTIYIPRmvnzo0BHf3mf6xSQJ1oT09/ndTri?=
 =?us-ascii?Q?YD5wex/ZcjH04+JvKcklvj+FUDN26kJf5WdFoeDuauModOb6BjGpuLk1R9WF?=
 =?us-ascii?Q?Ak5FUxzEPbvWIOmAiquXync+v8zkzGGcr5KLIbGUU5JGd4zbtrGwhc+r1anC?=
 =?us-ascii?Q?j5SnjwyWVmldpK2bbG7umDm3+OUyIbANKrTpgSAaiEwIjPXp7C6D+lLwGnpB?=
 =?us-ascii?Q?WWd3cBW3gf5+Xky/qUgTMD6eo91vGPCD8r5Wqr4J3NLFuDW4wo9h5UXnRo3B?=
 =?us-ascii?Q?xgECOW92DSQUDFQemjqLyQrDHSmwb6S3IA0vjDZArgOcjAj/Kcv4/EEoXO1C?=
 =?us-ascii?Q?i0tuhcK+hZqIYt3dZqoHYSTC8LrBmB51byJdWNLBpJZc52vc9AGbc19JurPU?=
 =?us-ascii?Q?tkvqnsVkyzSNkp+DlF/V6+PxDSra1jxt25qSksyikawtC+7hJ3I1RScDKdPG?=
 =?us-ascii?Q?Qy+TzKY/E8AgOBRkRk4LCPy94A5+PnJ6RRrDW7cm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae677b0-4098-4393-93c5-08dbdb3369a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y/S9bzOZS6sTjnpl4gegOjyWVBG0VFFSN29XWsZdptzxF5cmLXA7ikOxgdyMbyf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

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
index 04a807774402b2..1f0940b497f3c6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -35,25 +35,6 @@ struct arm_smmu_bond {
 
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
@@ -129,11 +110,76 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
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
 
@@ -167,39 +213,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
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
 
@@ -276,6 +289,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	mutex_lock(&sva_lock);
 	if (smmu_mn->cleared) {
@@ -287,7 +302,18 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
@@ -348,12 +374,19 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
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
index 67544a92a7714c..4ac32bb91ebf27 100644
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
@@ -1192,8 +1186,12 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
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
@@ -1240,72 +1238,6 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
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
@@ -1314,7 +1246,6 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
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

