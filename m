Return-Path: <SRS0=W82T=3C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A35EC33CAD
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 14:39:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFE420678
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 14:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFE420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A50238169A;
	Mon, 13 Jan 2020 14:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mXpf2dbKzsc; Mon, 13 Jan 2020 14:39:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF7BB8442D;
	Mon, 13 Jan 2020 14:39:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C726FC18DD;
	Mon, 13 Jan 2020 14:39:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD136C077D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9876B20417
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TZ7n8vG5Av4E for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jan 2020 14:39:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by silver.osuosl.org (Postfix) with ESMTPS id A68CD20411
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:39:26 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id 13so8381746oij.13
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 06:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=81zWfeXhBaixkcEUs8f4gK08iAzMzzHoyfXswbOOolg=;
 b=Qt6demzEoqBSl3MHW/uHxw7/IHZ5Sb1S9qt+oG8nuSlI7JnwV/6KNh7aEPrp1kpino
 xw52hrPbmJYcSUWkk4MEJPDefLoOLrTMsv05r4bdFWoVDiXTfKFcrCUfoO+nLyWT+m3T
 jKEsQLJyHG14AfnlmVCKi2V3zXYJQ22qhpxc+zABe/jO5osfoj7jUVooe9PbTgV06MeA
 T2q6jHiinMluG8qZuOXkngSfhWQMMO6qduhTRQY3h69WdLMUZ4GJwXlUwU5NalssQsAA
 zCg7SYHaLa05ZSmY7SO6ddL/MPlv3msgj3CVB45ciXqg5N7U//mVHOXFZU7IHmcpGQ4I
 68dA==
X-Gm-Message-State: APjAAAVQmXMEBba0NtdwCMwoSzQS6GzPgsUZSWk7jFRHrx+poQRjrYvl
 zoZIGhyJKjPxccWvLEqFKvirnaU=
X-Google-Smtp-Source: APXvYqwZal0CQqyNCpa063ctZkqNNitnuhA40bOLoRHYGv6idil39oKfY/8szsTcvMNL/RHpu5rmwA==
X-Received: by 2002:aca:ed57:: with SMTP id l84mr13263125oih.8.1578926365612; 
 Mon, 13 Jan 2020 06:39:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c7sm4219269otm.63.2020.01.13.06.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:39:25 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
Date: Mon, 13 Jan 2020 08:39:24 -0600
Message-Id: <20200113143924.11576-1-robh@kernel.org>
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
1-32 chunks of a power of 2 multiple pages. First we determine from the
size what power of 2 multiple we can use and then adjust the granule to
32x that size.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e91b4a098215..8b6b3e2aa383 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -70,6 +70,9 @@
 #define IDR1_SSIDSIZE			GENMASK(10, 6)
 #define IDR1_SIDSIZE			GENMASK(5, 0)
 
+#define ARM_SMMU_IDR3			0xc
+#define IDR3_RIL			(1 << 10)
+
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
 #define IDR5_GRAN64K			(1 << 6)
@@ -327,9 +330,14 @@
 #define CMDQ_CFGI_1_LEAF		(1UL << 0)
 #define CMDQ_CFGI_1_RANGE		GENMASK_ULL(4, 0)
 
+#define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
+#define CMDQ_TLBI_RANGE_NUM_MAX		32
+#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
 #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
 #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
+#define CMDQ_TLBI_1_TTL			GENMASK_ULL(9, 8)
+#define CMDQ_TLBI_1_TG			GENMASK_ULL(11, 10)
 #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
 #define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
 
@@ -455,9 +463,13 @@ struct arm_smmu_cmdq_ent {
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
 
@@ -595,6 +607,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
+#define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -856,13 +869,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
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
@@ -2022,12 +2043,39 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
 
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+		unsigned long tg, scale;
+
+		/* Get the leaf page size */
+		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+		/* Determine the power of 2 multiple number of pages */
+		scale = __ffs(size / (1UL << tg));
+		cmd.tlbi.scale = scale;
+
+		cmd.tlbi.num = CMDQ_TLBI_RANGE_NUM_MAX - 1;
+
+		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
+		cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
+
+		/* Determine what level the granule is at */
+		cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+
+		/* Adjust granule to the maximum range */
+		granule = CMDQ_TLBI_RANGE_NUM_MAX * (1 << scale) * (1UL << tg);
+	}
+
 	while (iova < end) {
 		if (i == CMDQ_BATCH_ENTRIES) {
 			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
 			i = 0;
 		}
 
+		/* Only possible for range invalidate */
+		if (granule > (end - iova))
+			cmd.tlbi.num = ((end - iova) /
+					(granule / CMDQ_TLBI_RANGE_NUM_MAX)) - 1;
+
 		cmd.tlbi.addr = iova;
 		arm_smmu_cmdq_build_cmd(&cmds[i * CMDQ_ENT_DWORDS], &cmd);
 		iova += granule;
@@ -3449,6 +3497,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
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
