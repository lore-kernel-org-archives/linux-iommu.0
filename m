Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2579EC3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5632083B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5632083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9426A10AB;
	Thu, 15 Aug 2019 18:37:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 43F3D107E
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6E551CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4141570;
	Thu, 15 Aug 2019 11:37:50 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF0813F694; 
	Thu, 15 Aug 2019 11:37:48 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 05/17] iommu/arm-smmu: Convert context bank registers to
	bitfields
Date: Thu, 15 Aug 2019 19:37:25 +0100
Message-Id: <30616d132784d6fb5a4f2ebefa3e55f004696332.1565892337.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565892337.git.robin.murphy@arm.com>
References: <cover.1565892337.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Finish the final part of the job, once again updating some names to
match the current spec.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-regs.h | 86 ++++++++++++++++++-----------------
 drivers/iommu/arm-smmu.c      | 16 +++----
 drivers/iommu/qcom_iommu.c    | 13 +++---
 3 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index 8522330ee624..a8e288192285 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -129,19 +129,59 @@ enum arm_smmu_cbar_type {
 #define CBA2R_VA64			BIT(0)
 
 #define ARM_SMMU_CB_SCTLR		0x0
+#define SCTLR_S1_ASIDPNE		BIT(12)
+#define SCTLR_CFCFG			BIT(7)
+#define SCTLR_CFIE			BIT(6)
+#define SCTLR_CFRE			BIT(5)
+#define SCTLR_E				BIT(4)
+#define SCTLR_AFE			BIT(2)
+#define SCTLR_TRE			BIT(1)
+#define SCTLR_M				BIT(0)
+
 #define ARM_SMMU_CB_ACTLR		0x4
+
 #define ARM_SMMU_CB_RESUME		0x8
-#define ARM_SMMU_CB_TTBCR2		0x10
+#define RESUME_TERMINATE		BIT(0)
+
+#define ARM_SMMU_CB_TCR2		0x10
+#define TCR2_SEP			GENMASK(17, 15)
+#define TCR2_SEP_UPSTREAM		0x7
+#define TCR2_AS				BIT(4)
+
 #define ARM_SMMU_CB_TTBR0		0x20
 #define ARM_SMMU_CB_TTBR1		0x28
-#define ARM_SMMU_CB_TTBCR		0x30
+#define TTBRn_ASID			GENMASK_ULL(63, 48)
+
+#define ARM_SMMU_CB_TCR			0x30
 #define ARM_SMMU_CB_CONTEXTIDR		0x34
 #define ARM_SMMU_CB_S1_MAIR0		0x38
 #define ARM_SMMU_CB_S1_MAIR1		0x3c
+
 #define ARM_SMMU_CB_PAR			0x50
+#define CB_PAR_F			BIT(0)
+
 #define ARM_SMMU_CB_FSR			0x58
+#define FSR_MULTI			BIT(31)
+#define FSR_SS				BIT(30)
+#define FSR_UUT				BIT(8)
+#define FSR_ASF				BIT(7)
+#define FSR_TLBLKF			BIT(6)
+#define FSR_TLBMCF			BIT(5)
+#define FSR_EF				BIT(4)
+#define FSR_PF				BIT(3)
+#define FSR_AFF				BIT(2)
+#define FSR_TF				BIT(1)
+
+#define FSR_IGN				(FSR_AFF | FSR_ASF | \
+					 FSR_TLBMCF | FSR_TLBLKF)
+#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT | \
+					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)
+
 #define ARM_SMMU_CB_FAR			0x60
+
 #define ARM_SMMU_CB_FSYNR0		0x68
+#define FSYNR0_WNR			BIT(4)
+
 #define ARM_SMMU_CB_S1_TLBIVA		0x600
 #define ARM_SMMU_CB_S1_TLBIASID		0x610
 #define ARM_SMMU_CB_S1_TLBIVAL		0x620
@@ -150,46 +190,8 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_TLBSYNC		0x7f0
 #define ARM_SMMU_CB_TLBSTATUS		0x7f4
 #define ARM_SMMU_CB_ATS1PR		0x800
+
 #define ARM_SMMU_CB_ATSR		0x8f0
-
-#define SCTLR_S1_ASIDPNE		(1 << 12)
-#define SCTLR_CFCFG			(1 << 7)
-#define SCTLR_CFIE			(1 << 6)
-#define SCTLR_CFRE			(1 << 5)
-#define SCTLR_E				(1 << 4)
-#define SCTLR_AFE			(1 << 2)
-#define SCTLR_TRE			(1 << 1)
-#define SCTLR_M				(1 << 0)
-
-#define CB_PAR_F			(1 << 0)
-
-#define ATSR_ACTIVE			(1 << 0)
-
-#define RESUME_RETRY			(0 << 0)
-#define RESUME_TERMINATE		(1 << 0)
-
-#define TTBCR2_SEP_SHIFT		15
-#define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
-#define TTBCR2_AS			(1 << 4)
-
-#define TTBRn_ASID_SHIFT		48
-
-#define FSR_MULTI			(1 << 31)
-#define FSR_SS				(1 << 30)
-#define FSR_UUT				(1 << 8)
-#define FSR_ASF				(1 << 7)
-#define FSR_TLBLKF			(1 << 6)
-#define FSR_TLBMCF			(1 << 5)
-#define FSR_EF				(1 << 4)
-#define FSR_PF				(1 << 3)
-#define FSR_AFF				(1 << 2)
-#define FSR_TF				(1 << 1)
-
-#define FSR_IGN				(FSR_AFF | FSR_ASF | \
-					 FSR_TLBMCF | FSR_TLBLKF)
-#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT | \
-					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)
-
-#define FSYNR0_WNR			(1 << 4)
+#define ATSR_ACTIVE			BIT(0)
 
 #endif /* _ARM_SMMU_REGS_H */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 293a95b0d682..a877de006d02 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -628,16 +628,16 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	cb->cfg = cfg;
 
-	/* TTBCR */
+	/* TCR */
 	if (stage1) {
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
 			cb->tcr[0] = pgtbl_cfg->arm_v7s_cfg.tcr;
 		} else {
 			cb->tcr[0] = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 			cb->tcr[1] = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
-			cb->tcr[1] |= TTBCR2_SEP_UPSTREAM;
+			cb->tcr[1] |= FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM);
 			if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
-				cb->tcr[1] |= TTBCR2_AS;
+				cb->tcr[1] |= TCR2_AS;
 		}
 	} else {
 		cb->tcr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
@@ -650,9 +650,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			cb->ttbr[1] = pgtbl_cfg->arm_v7s_cfg.ttbr[1];
 		} else {
 			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-			cb->ttbr[0] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
+			cb->ttbr[0] |= FIELD_PREP(TTBRn_ASID, cfg->asid);
 			cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
-			cb->ttbr[1] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
+			cb->ttbr[1] |= FIELD_PREP(TTBRn_ASID, cfg->asid);
 		}
 	} else {
 		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
@@ -721,13 +721,13 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(idx));
 
 	/*
-	 * TTBCR
+	 * TCR
 	 * We must write this before the TTBRs, since it determines the
 	 * access behaviour of some fields (in particular, ASID[15:8]).
 	 */
 	if (stage1 && smmu->version > ARM_SMMU_V1)
-		writel_relaxed(cb->tcr[1], cb_base + ARM_SMMU_CB_TTBCR2);
-	writel_relaxed(cb->tcr[0], cb_base + ARM_SMMU_CB_TTBCR);
+		writel_relaxed(cb->tcr[1], cb_base + ARM_SMMU_CB_TCR2);
+	writel_relaxed(cb->tcr[0], cb_base + ARM_SMMU_CB_TCR);
 
 	/* TTBRs */
 	if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index bed948c3058a..60a125dd7300 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
@@ -247,16 +248,16 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0] |
-				((u64)ctx->asid << TTBRn_ASID_SHIFT));
+				FIELD_PREP(TTBRn_ASID, ctx->asid));
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[1] |
-				((u64)ctx->asid << TTBRn_ASID_SHIFT));
+				FIELD_PREP(TTBRn_ASID, ctx->asid));
 
-		/* TTBCR */
-		iommu_writel(ctx, ARM_SMMU_CB_TTBCR2,
+		/* TCR */
+		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
 				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
-				TTBCR2_SEP_UPSTREAM);
-		iommu_writel(ctx, ARM_SMMU_CB_TTBCR,
+				FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM));
+		iommu_writel(ctx, ARM_SMMU_CB_TCR,
 				pgtbl_cfg.arm_lpae_s1_cfg.tcr);
 
 		/* MAIRs (stage-1 only) */
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
