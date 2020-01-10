Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A61C282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6B620842
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYYD4y4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6B620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9CB286B91;
	Fri, 10 Jan 2020 15:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGwxYnJlZ7je; Fri, 10 Jan 2020 15:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57A6A86B96;
	Fri, 10 Jan 2020 15:29:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45AE3C1D7D;
	Fri, 10 Jan 2020 15:29:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 127C7C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F5A2840C2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYCcClDcFmje for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA12283791
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8E71D2082E;
 Fri, 10 Jan 2020 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578670148;
 bh=TBqXqhR2q3RIkkjnOjgVavEGiYRhxf5hDTYpOPNsHvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kYYD4y4P2kge43cL+a6ai6uTqJqxwHHHrSHxFy/N7adi+N3GhLplygGC+G+ie6hh8
 i6fUZediQuDwZuQdNeq9moiNaOlRFogHbHkcnLbadBAhTJKKQoKcsEj2cYyZAw95ln
 XTrCsF3rxyg+qUafA8qYOcFt94v36XeEsXFxYwUs=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 7/8] iommu/io-pgtable-arm: Rationalise VTCR handling
Date: Fri, 10 Jan 2020 15:28:51 +0000
Message-Id: <20200110152852.24259-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110152852.24259-1-will@kernel.org>
References: <20200110152852.24259-1-will@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Commit 05a648cd2dd7 ("iommu/io-pgtable-arm: Rationalise TCR handling")
reworked the way in which the TCR register value is returned from the
io-pgtable code when targetting the Arm long-descriptor format, in
preparation for allowing page-tables to target TTBR1.

As it turns out, the new interface is a lot nicer to use, so do the same
conversion for the VTCR register even though there is only a single base
register for stage-2 translation.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c    | 17 +++++++++-
 drivers/iommu/arm-smmu.c       |  2 +-
 drivers/iommu/arm-smmu.h       | 21 +++++++++++++
 drivers/iommu/io-pgtable-arm.c | 57 +++++++++++++---------------------
 include/linux/io-pgtable.h     | 10 +++++-
 5 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d127974afdb7..4443e1890077 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -250,6 +250,13 @@
 
 #define STRTAB_STE_2_S2VMID		GENMASK_ULL(15, 0)
 #define STRTAB_STE_2_VTCR		GENMASK_ULL(50, 32)
+#define STRTAB_STE_2_VTCR_S2T0SZ	GENMASK_ULL(5, 0)
+#define STRTAB_STE_2_VTCR_S2SL0		GENMASK_ULL(7, 6)
+#define STRTAB_STE_2_VTCR_S2IR0		GENMASK_ULL(9, 8)
+#define STRTAB_STE_2_VTCR_S2OR0		GENMASK_ULL(11, 10)
+#define STRTAB_STE_2_VTCR_S2SH0		GENMASK_ULL(13, 12)
+#define STRTAB_STE_2_VTCR_S2TG		GENMASK_ULL(15, 14)
+#define STRTAB_STE_2_VTCR_S2PS		GENMASK_ULL(18, 16)
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
@@ -2159,14 +2166,22 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	int vmid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
+	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
 	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);
 	if (vmid < 0)
 		return vmid;
 
+	vtcr = &pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
 	cfg->vmid	= (u16)vmid;
 	cfg->vttbr	= pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
-	cfg->vtcr	= pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
+	cfg->vtcr	= FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
+			  FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
+			  FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, vtcr->irgn) |
+			  FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, vtcr->orgn) |
+			  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
+			  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
+			  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 214be09f6ded..f067783ebd59 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -548,7 +548,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				cb->tcr[0] |= ARM_SMMU_TCR_EAE;
 		}
 	} else {
-		cb->tcr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
+		cb->tcr[0] = arm_smmu_lpae_vtcr(pgtbl_cfg);
 	}
 
 	/* TTBRs */
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 6501f38a5966..8d1cd54d82a6 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -174,6 +174,15 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_TCR_IRGN0		GENMASK(9, 8)
 #define ARM_SMMU_TCR_T0SZ		GENMASK(5, 0)
 
+#define ARM_SMMU_VTCR_RES1		BIT(31)
+#define ARM_SMMU_VTCR_PS		GENMASK(18, 16)
+#define ARM_SMMU_VTCR_TG0		ARM_SMMU_TCR_TG0
+#define ARM_SMMU_VTCR_SH0		ARM_SMMU_TCR_SH0
+#define ARM_SMMU_VTCR_ORGN0		ARM_SMMU_TCR_ORGN0
+#define ARM_SMMU_VTCR_IRGN0		ARM_SMMU_TCR_IRGN0
+#define ARM_SMMU_VTCR_SL0		GENMASK(7, 6)
+#define ARM_SMMU_VTCR_T0SZ		ARM_SMMU_TCR_T0SZ
+
 #define ARM_SMMU_CB_CONTEXTIDR		0x34
 #define ARM_SMMU_CB_S1_MAIR0		0x38
 #define ARM_SMMU_CB_S1_MAIR1		0x3c
@@ -352,6 +361,18 @@ static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
 	       FIELD_PREP(ARM_SMMU_TCR2_SEP, ARM_SMMU_TCR2_SEP_UPSTREAM);
 }
 
+static inline u32 arm_smmu_lpae_vtcr(struct io_pgtable_cfg *cfg)
+{
+	return ARM_SMMU_VTCR_RES1 |
+	       FIELD_PREP(ARM_SMMU_VTCR_PS, cfg->arm_lpae_s2_cfg.vtcr.ps) |
+	       FIELD_PREP(ARM_SMMU_VTCR_TG0, cfg->arm_lpae_s2_cfg.vtcr.tg) |
+	       FIELD_PREP(ARM_SMMU_VTCR_SH0, cfg->arm_lpae_s2_cfg.vtcr.sh) |
+	       FIELD_PREP(ARM_SMMU_VTCR_ORGN0, cfg->arm_lpae_s2_cfg.vtcr.orgn) |
+	       FIELD_PREP(ARM_SMMU_VTCR_IRGN0, cfg->arm_lpae_s2_cfg.vtcr.irgn) |
+	       FIELD_PREP(ARM_SMMU_VTCR_SL0, cfg->arm_lpae_s2_cfg.vtcr.sl) |
+	       FIELD_PREP(ARM_SMMU_VTCR_T0SZ, cfg->arm_lpae_s2_cfg.vtcr.tsz);
+}
+
 /* Implementation details, yay! */
 struct arm_smmu_impl {
 	u32 (*read_reg)(struct arm_smmu_device *smmu, int page, int offset);
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 78ec0ee5c59c..846963c87e0f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -100,26 +100,19 @@
 #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
 
 /* Register bits */
-#define ARM_64_LPAE_VTCR_RES1		(1U << 31)
-
-#define ARM_LPAE_VTCR_TG0_SHIFT		14
 #define ARM_LPAE_TCR_TG0_4K		0
 #define ARM_LPAE_TCR_TG0_64K		1
 #define ARM_LPAE_TCR_TG0_16K		2
 
-#define ARM_LPAE_TCR_SH0_SHIFT		12
 #define ARM_LPAE_TCR_SH_NS		0
 #define ARM_LPAE_TCR_SH_OS		2
 #define ARM_LPAE_TCR_SH_IS		3
 
-#define ARM_LPAE_TCR_ORGN0_SHIFT	10
-#define ARM_LPAE_TCR_IRGN0_SHIFT	8
 #define ARM_LPAE_TCR_RGN_NC		0
 #define ARM_LPAE_TCR_RGN_WBWA		1
 #define ARM_LPAE_TCR_RGN_WT		2
 #define ARM_LPAE_TCR_RGN_WB		3
 
-#define ARM_LPAE_VTCR_SL0_SHIFT		6
 #define ARM_LPAE_VTCR_SL0_MASK		0x3
 
 #define ARM_LPAE_TCR_T0SZ_SHIFT		0
@@ -877,8 +870,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 static struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 {
-	u64 reg, sl;
+	u64 sl;
 	struct arm_lpae_io_pgtable *data;
+	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
 	/* The NS quirk doesn't apply at stage 2 */
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NON_STRICT))
@@ -903,61 +897,59 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	}
 
 	/* VTCR */
-	reg = ARM_64_LPAE_VTCR_RES1;
 	if (cfg->coherent_walk) {
-		reg |= (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-		       (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-		       (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+		vtcr->sh = ARM_LPAE_TCR_SH_IS;
+		vtcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
+		vtcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
 	} else {
-		reg |= (ARM_LPAE_TCR_SH_OS << ARM_LPAE_TCR_SH0_SHIFT) |
-		       (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT) |
-		       (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT);
+		vtcr->sh = ARM_LPAE_TCR_SH_OS;
+		vtcr->irgn = ARM_LPAE_TCR_RGN_NC;
+		vtcr->orgn = ARM_LPAE_TCR_RGN_NC;
 	}
 
 	sl = data->start_level;
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
-		reg |= (ARM_LPAE_TCR_TG0_4K << ARM_LPAE_VTCR_TG0_SHIFT);
+		vtcr->tg = ARM_LPAE_TCR_TG0_4K;
 		sl++; /* SL0 format is different for 4K granule size */
 		break;
 	case SZ_16K:
-		reg |= (ARM_LPAE_TCR_TG0_16K << ARM_LPAE_VTCR_TG0_SHIFT);
+		vtcr->tg = ARM_LPAE_TCR_TG0_16K;
 		break;
 	case SZ_64K:
-		reg |= (ARM_LPAE_TCR_TG0_64K << ARM_LPAE_VTCR_TG0_SHIFT);
+		vtcr->tg = ARM_LPAE_TCR_TG0_64K;
 		break;
 	}
 
 	switch (cfg->oas) {
 	case 32:
-		reg |= (ARM_LPAE_TCR_PS_32_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_32_BIT;
 		break;
 	case 36:
-		reg |= (ARM_LPAE_TCR_PS_36_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_36_BIT;
 		break;
 	case 40:
-		reg |= (ARM_LPAE_TCR_PS_40_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_40_BIT;
 		break;
 	case 42:
-		reg |= (ARM_LPAE_TCR_PS_42_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_42_BIT;
 		break;
 	case 44:
-		reg |= (ARM_LPAE_TCR_PS_44_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_44_BIT;
 		break;
 	case 48:
-		reg |= (ARM_LPAE_TCR_PS_48_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_48_BIT;
 		break;
 	case 52:
-		reg |= (ARM_LPAE_TCR_PS_52_BIT << ARM_LPAE_VTCR_PS_SHIFT);
+		vtcr->ps = ARM_LPAE_TCR_PS_52_BIT;
 		break;
 	default:
 		goto out_free_data;
 	}
 
-	reg |= (64ULL - cfg->ias) << ARM_LPAE_TCR_T0SZ_SHIFT;
-	reg |= (~sl & ARM_LPAE_VTCR_SL0_MASK) << ARM_LPAE_VTCR_SL0_SHIFT;
-	cfg->arm_lpae_s2_cfg.vtcr = reg;
+	vtcr->tsz = 64ULL - cfg->ias;
+	vtcr->sl = ~sl & ARM_LPAE_VTCR_SL0_MASK;
 
 	/* Allocate pgd pages */
 	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
@@ -984,24 +976,17 @@ arm_32_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
-
 	return arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
 }
 
 static struct io_pgtable *
 arm_32_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 {
-	struct io_pgtable *iop;
-
 	if (cfg->ias > 40 || cfg->oas > 40)
 		return NULL;
 
 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
-	iop = arm_64_lpae_alloc_pgtable_s2(cfg, cookie);
-	if (iop)
-		cfg->arm_lpae_s2_cfg.vtcr &= 0xffffffff;
-
-	return iop;
+	return arm_64_lpae_alloc_pgtable_s2(cfg, cookie);
 }
 
 static struct io_pgtable *
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 6ae104cedfd7..40c1b7745fb6 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -114,7 +114,15 @@ struct io_pgtable_cfg {
 
 		struct {
 			u64	vttbr;
-			u64	vtcr;
+			struct {
+				u32	ps:3;
+				u32	tg:2;
+				u32	sh:2;
+				u32	orgn:2;
+				u32	irgn:2;
+				u32	sl:2;
+				u32	tsz:6;
+			}	vtcr;
 		} arm_lpae_s2_cfg;
 
 		struct {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
