Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC70C433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:08:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2EA20C01
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2EA20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 86C58CC4;
	Fri,  9 Aug 2019 17:08:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CE848D7C
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4DADC67F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA02D1684;
	Fri,  9 Aug 2019 10:08:15 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1FB63F575; 
	Fri,  9 Aug 2019 10:08:14 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 02/15] iommu/arm-smmu: Convert GR1 registers to bitfields
Date: Fri,  9 Aug 2019 18:07:39 +0100
Message-Id: <44c4cf251a9eb4fdadff949cd8ff524b9d062c86.1565369764.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565369764.git.robin.murphy@arm.com>
References: <cover.1565369764.git.robin.murphy@arm.com>
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

As for GR0, use the bitfield helpers to make GR1 usage a little cleaner,
and use it as an opportunity to audit and tidy the definitions. This
tweaks the handling of CBAR types to match what we did for S2CR a while
back, and fixes a couple of names which didn't quite match the latest
architecture spec (IHI0062D.c).

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-regs.h | 33 ++++++++++++++-------------------
 drivers/iommu/arm-smmu.c      | 18 +++++++++---------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index d189f025537a..671c2d98c9da 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -108,30 +108,25 @@ enum arm_smmu_s2cr_type {
 
 /* Context bank attribute registers */
 #define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))
-#define CBAR_VMID_SHIFT			0
-#define CBAR_VMID_MASK			0xff
-#define CBAR_S1_BPSHCFG_SHIFT		8
-#define CBAR_S1_BPSHCFG_MASK		3
-#define CBAR_S1_BPSHCFG_NSH		3
-#define CBAR_S1_MEMATTR_SHIFT		12
-#define CBAR_S1_MEMATTR_MASK		0xf
+#define CBAR_IRPTNDX			GENMASK(31, 24)
+#define CBAR_TYPE			GENMASK(17, 16)
+enum arm_smmu_cbar_type {
+	CBAR_TYPE_S2_TRANS,
+	CBAR_TYPE_S1_TRANS_S2_BYPASS,
+	CBAR_TYPE_S1_TRANS_S2_FAULT,
+	CBAR_TYPE_S1_TRANS_S2_TRANS,
+};
+#define CBAR_S1_MEMATTR			GENMASK(15, 12)
 #define CBAR_S1_MEMATTR_WB		0xf
-#define CBAR_TYPE_SHIFT			16
-#define CBAR_TYPE_MASK			0x3
-#define CBAR_TYPE_S2_TRANS		(0 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(1 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_FAULT	(2 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_TRANS	(3 << CBAR_TYPE_SHIFT)
-#define CBAR_IRPTNDX_SHIFT		24
-#define CBAR_IRPTNDX_MASK		0xff
+#define CBAR_S1_BPSHCFG			GENMASK(9, 8)
+#define CBAR_S1_BPSHCFG_NSH		3
+#define CBAR_VMID			GENMASK(7, 0)
 
 #define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
 
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
-#define CBA2R_RW64_32BIT		(0 << 0)
-#define CBA2R_RW64_64BIT		(1 << 0)
-#define CBA2R_VMID_SHIFT		16
-#define CBA2R_VMID_MASK			0xffff
+#define CBA2R_VMID16			GENMASK(31, 16)
+#define CBA2R_VA64			BIT(0)
 
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_CB_ACTLR		0x4
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 89eddc54e41c..515fb1ce39ed 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -237,7 +237,7 @@ struct arm_smmu_cfg {
 		u16			asid;
 		u16			vmid;
 	};
-	u32				cbar;
+	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
 };
 #define INVALID_IRPTNDX			0xff
@@ -692,31 +692,31 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	/* CBA2R */
 	if (smmu->version > ARM_SMMU_V1) {
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
-			reg = CBA2R_RW64_64BIT;
+			reg = CBA2R_VA64;
 		else
-			reg = CBA2R_RW64_32BIT;
+			reg = 0;
 		/* 16-bit VMIDs live in CBA2R */
 		if (smmu->features & ARM_SMMU_FEAT_VMID16)
-			reg |= cfg->vmid << CBA2R_VMID_SHIFT;
+			reg |= FIELD_PREP(CBA2R_VMID16, cfg->vmid);
 
 		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(idx));
 	}
 
 	/* CBAR */
-	reg = cfg->cbar;
+	reg = FIELD_PREP(CBAR_TYPE, cfg->cbar);
 	if (smmu->version < ARM_SMMU_V2)
-		reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
+		reg |= FIELD_PREP(CBAR_IRPTNDX, cfg->irptndx);
 
 	/*
 	 * Use the weakest shareability/memory types, so they are
 	 * overridden by the ttbcr/pte.
 	 */
 	if (stage1) {
-		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
-			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
+		reg |= FIELD_PREP(CBAR_S1_BPSHCFG, CBAR_S1_BPSHCFG_NSH) |
+			FIELD_PREP(CBAR_S1_MEMATTR, CBAR_S1_MEMATTR_WB);
 	} else if (!(smmu->features & ARM_SMMU_FEAT_VMID16)) {
 		/* 8-bit VMIDs live in CBAR */
-		reg |= cfg->vmid << CBAR_VMID_SHIFT;
+		reg |= FIELD_PREP(CBAR_VMID, cfg->vmid);
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(idx));
 
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
