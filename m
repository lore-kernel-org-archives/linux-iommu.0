Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0116C433E0
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:22:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B63320760
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="NsMNCLtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B63320760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5A04088CE9;
	Thu,  2 Jul 2020 20:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bz+knfVvDGD9; Thu,  2 Jul 2020 20:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ABDD788CE2;
	Thu,  2 Jul 2020 20:22:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 987C2C0890;
	Thu,  2 Jul 2020 20:22:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 040F2C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E77A087AB3
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ak_nAjNOUnmc for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 20:22:23 +0000 (UTC)
X-Greylist: delayed 00:05:22 by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 53AD187AAD
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:22:23 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id e4so33914878ljn.4
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jul 2020 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9HqU9qZ8LmsuIM9rC8wWt6FyyRyxinkgL6r/PQ1v140=;
 b=NsMNCLtvpw+rfbkzZ7WMHoUxkhwYpEr7ti2zDzD4RO214DSM61TASKnJ70FUtvL8Xe
 OPkb+gbm15X1yDJx8XxVSNyulMFihrw0kGMzp8vrp1BuuVpeJX/44bcILZU1krIWZ1ij
 TCU/iBWbRN7DpMH6Osw8VUjMetNmm0b7KEZZj4o1KCjJjNrY8KaBojlb9ezzxTtQVnmh
 ciCxQfncvCUnyTDyh/AyZkjjtzGGjrpW0bj/UIgKdP1x6X/BPSLWc/7Qb/0pwsUDF8WI
 pCfcE1Jy0ZYxCK29bhuFMsA3hjr0CQFi6Yq6smYXJZhNjvpLa4GTNN/vGt8GXvyzOIqP
 7kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9HqU9qZ8LmsuIM9rC8wWt6FyyRyxinkgL6r/PQ1v140=;
 b=U1oNghPCeQqF8LQMQ7n6h+w+dfEsXQEtRAkAWnE5FeZztfsycOAeqmnmaBlcHdYral
 l/cgr+QVavGwoU6t4P4UYq+fK/I4V0Ez4bhq2ZQTUPK+LdabI971WOR6lpPuYyVKJdsI
 BEFuDjMM+XfA4I7q08ockM1uCt2VjyQ29pK66zWRoYKZFikJRL6Hel2BgEnvq18RFpzi
 QlyzU4oYzXTyQFyVWujX76sJs8+apu1yW+yi3oaFKXwFnf6+n8sUWH3xme/vJcTX/xYT
 e3qF89kqQy/RxBtzaae+9eYRNQayiJBA44MetrVBwyl+lCsYHPHhM63uX8y7YkZ3ZOUR
 DBKQ==
X-Gm-Message-State: AOAM531b0ghFTui95yI7qBDr/B3O9J6fnoZUFrAObRZ4qOglFP0KM7RT
 NjdO/azWMobZmny9ZnKwmteBccZP8q0=
X-Google-Smtp-Source: ABdhPJxGJkhWxJ6CLztWNrISccJQIv1xdDY/rNe/lZBtJ1m/1dz/spNq4FMTtpQYU5jq8Ot1Y9n/tA==
X-Received: by 2002:a2e:2c18:: with SMTP id s24mr10019389ljs.291.1593721020921; 
 Thu, 02 Jul 2020 13:17:00 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 13:17:00 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v3 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806
 SoC erratum #582743
Date: Thu,  2 Jul 2020 22:16:31 +0200
Message-Id: <20200702201633.22693-3-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
References: <20200702201633.22693-1-tn@semihalf.com>
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Hanna Hawa <hannah@marvell.com>

Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit to
ARM SMMUv2 registers.

Provide implementation relevant hooks:
- split the writeq/readq to two accesses of writel/readl.
- mask the MMU_IDR2.PTFSv8 fields to not use AArch64 format (but
only AARCH32_L) since with AArch64 format 32 bits access is not supported.

Note that separate writes/reads to 2 is not problem regards to
atomicity, because the driver use the readq/writeq while initialize
the SMMU, report for SMMU fault, and use spinlock in one
case (iova_to_phys).

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/iommu/arm-smmu-impl.c          | 52 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 936cf2a59ca4..157214d3abe1 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -125,6 +125,9 @@ stable kernels.
 | Cavium         | ThunderX2 Core  | #219            | CAVIUM_TX2_ERRATUM_219      |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c75b9d957b70..c1fc5e1b8193 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -147,6 +147,53 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
+{
+	u64 val;
+
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the readq to double readl
+	 */
+	val = (u64)readl_relaxed(arm_smmu_page(smmu, page) + off + 4) << 32;
+	val |= readl_relaxed(arm_smmu_page(smmu, page) + off);
+
+	return val;
+}
+
+static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
+			       u64 val)
+{
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the writeq to double writel
+	 */
+	writel_relaxed(upper_32_bits(val), arm_smmu_page(smmu, page) + off + 4);
+	writel_relaxed(lower_32_bits(val), arm_smmu_page(smmu, page) + off);
+}
+
+static u32 mrvl_mmu500_cfg_id2_fixup(u32 id)
+{
+
+	/*
+	 * Armada-AP806 erratum #582743.
+	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
+	 * formats altogether and allow using 32 bits access on the
+	 * interconnect.
+	 */
+	id &= ~(ARM_SMMU_ID2_PTFS_4K | ARM_SMMU_ID2_PTFS_16K |
+		ARM_SMMU_ID2_PTFS_64K);
+
+	return id;
+}
+
+static const struct arm_smmu_impl mrvl_mmu500_impl = {
+	.read_reg64 = mrvl_mmu500_readq,
+	.write_reg64 = mrvl_mmu500_writeq,
+	.cfg_id2_fixup = mrvl_mmu500_cfg_id2_fixup,
+	.reset = arm_mmu500_reset,
+};
+
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -160,6 +207,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	 */
 	switch (smmu->model) {
 	case ARM_MMU500:
+		if (of_device_is_compatible(smmu->dev->of_node,
+					    "marvell,ap806-smmu-500")) {
+			smmu->impl = &mrvl_mmu500_impl;
+			return smmu;
+		}
 		smmu->impl = &arm_mmu500_impl;
 		break;
 	case CAVIUM_SMMUV2:
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
