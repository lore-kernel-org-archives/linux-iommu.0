Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71045C38BFA
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 22:31:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2D52176D
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 22:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2D52176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F134787590;
	Mon, 24 Feb 2020 22:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l6v5bbanSbwQ; Mon, 24 Feb 2020 22:31:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B7018763E;
	Mon, 24 Feb 2020 22:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F01CC18DA;
	Mon, 24 Feb 2020 22:31:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF3BC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 75412860B2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h5GcrOpSfzK9 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 22:31:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B52FB86055
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:31:31 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id c16so10599229oic.3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 14:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X0o0qn30+2qhaLvp/K43OKgrKlefJ1YZwBIeqT8fip8=;
 b=C2uYCEtnKgvpuV1vMBMj9at6ZHjO3GKdhYvhbwJ7lY97/HLHsii3uKpycBoN3lTS0R
 jSbvqs89yg7rh5XXYc2eqh7yfABYs1CadjFtYpRuXRHbdPNqPdzjcTQhS5FgHixXFZ//
 R/c1yLAkilAFYjKOo25M70D3uUzRcn4q6x8DeAr5qJMFvoLmsQjQ1iRIvt7UqfbZOC2s
 uMa+1JQNDm1+ax3VPdlzMT5ByjpB2VnAmFY5A15nwYQ/bl6ojO9txpFy0tlhZ2aMEa0B
 UYefngW6b658aDmr67U27j7+cUYO/4+Ws/zpfUr68Uw+kxBbSqGRP/ah/5MN4h2ih00C
 3+nw==
X-Gm-Message-State: APjAAAUea4fu3Mo/qVWWgn1ewOFu3K4ER4RfnMteOVMSuLgoaBuQAsbU
 7FrIaOVQ0Es/cTxk3LDABTcak7c=
X-Google-Smtp-Source: APXvYqwImtfpO7cq3d/nvmBua0GvNcIRNfGXYiR6EwkjeEy39WQ9UqgEnv7VmFgw94cPHGoiaIPUdA==
X-Received: by 2002:aca:54cc:: with SMTP id i195mr1048848oib.126.1582583490642; 
 Mon, 24 Feb 2020 14:31:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id w201sm4523757oif.29.2020.02.24.14.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:31:30 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
Date: Mon, 24 Feb 2020 16:31:29 -0600
Message-Id: <20200224223129.1068-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Arm SMMUv3.2 adds support for TLB range invalidate operations.
Support for range invalidate is determined by the RIL bit in the IDR3
register.

The range invalidate is in units of the leaf page size and operates on
1-32 chunks of a power of 2 multiple pages. First, we determine from the
size what power of 2 multiple we can use. Then we calculate how many
chunks (1-31) of the power of 2 size for the range on the iteration. On
each iteration, we move up in size by at least 5 bits.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Use inv_range local instead of modifying granule
- Simplify the TG calculation
- Use shift instead of divide by power of 2.
---
 drivers/iommu/arm-smmu-v3.c | 69 +++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index aa3ac2a03807..d8697f959ac0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -69,6 +69,9 @@
 #define IDR1_SSIDSIZE			GENMASK(10, 6)
 #define IDR1_SIDSIZE			GENMASK(5, 0)
 
+#define ARM_SMMU_IDR3			0xc
+#define IDR3_RIL			(1 << 10)
+
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
 #define IDR5_GRAN64K			(1 << 6)
@@ -346,9 +349,14 @@
 #define CMDQ_CFGI_1_LEAF		(1UL << 0)
 #define CMDQ_CFGI_1_RANGE		GENMASK_ULL(4, 0)
 
+#define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
+#define CMDQ_TLBI_RANGE_NUM_MAX		31
+#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
 #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
 #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
+#define CMDQ_TLBI_1_TTL			GENMASK_ULL(9, 8)
+#define CMDQ_TLBI_1_TG			GENMASK_ULL(11, 10)
 #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
 #define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
 
@@ -473,9 +481,13 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_S2_IPA	0x2a
 		#define CMDQ_OP_TLBI_NSNH_ALL	0x30
 		struct {
+			u8			num;
+			u8			scale;
 			u16			asid;
 			u16			vmid;
 			bool			leaf;
+			u8			ttl;
+			u8			tg;
 			u64			addr;
 		} tlbi;
 
@@ -627,6 +639,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
+#define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -895,14 +908,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
+		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
+		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
 		break;
 	case CMDQ_OP_TLBI_S2_IPA:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
+		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
+		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
 		break;
 	case CMDQ_OP_TLBI_NH_ASID:
@@ -2220,7 +2241,8 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 {
 	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long start = iova, end = iova + size;
+	unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
+	size_t inv_range = granule;
 	int i = 0;
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
@@ -2239,15 +2261,53 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
 
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+		/* Get the leaf page size */
+		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
+		cmd.tlbi.tg = (tg - 10) / 2;
+
+		/* Determine what level the granule is at */
+		cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+
+		num_pages = size >> tg;
+	}
+
 	while (iova < end) {
 		if (i == CMDQ_BATCH_ENTRIES) {
 			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
 			i = 0;
 		}
 
+		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+			/*
+			 * On each iteration of the loop, the range is 5 bits
+			 * worth of the aligned size remaining.
+			 * The range in pages is:
+			 *
+			 * range = (num_pages & (0x1f << __ffs(num_pages)))
+			 */
+			unsigned long scale, num;
+
+			/* Determine the power of 2 multiple number of pages */
+			scale = __ffs(num_pages);
+			cmd.tlbi.scale = scale;
+
+			/* Determine how many chunks of 2^scale size we have */
+			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
+			cmd.tlbi.num = num - 1;
+
+			/* range is num * 2^scale * pgsize */
+			inv_range = num << (scale + tg);
+
+			/* Clear out the lower order bits for the next iteration */
+			num_pages -= num << scale;
+		}
+
 		cmd.tlbi.addr = iova;
 		arm_smmu_cmdq_build_cmd(&cmds[i * CMDQ_ENT_DWORDS], &cmd);
-		iova += granule;
+		iova += inv_range;
 		i++;
 	}
 
@@ -3700,6 +3760,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (smmu->sid_bits <= STRTAB_SPLIT)
 		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
 
+	/* IDR3 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
+	if (FIELD_GET(IDR3_RIL, reg))
+		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
+
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
