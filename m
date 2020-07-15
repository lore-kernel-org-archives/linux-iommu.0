Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAECC433E7
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7460320663
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="gF+PCH8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7460320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 48FF420510;
	Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yJe+PjAOr-+8; Wed, 15 Jul 2020 07:07:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7227A20529;
	Wed, 15 Jul 2020 07:07:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C15CC07FF;
	Wed, 15 Jul 2020 07:07:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3248BC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1FCE88AC1B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id toLr1zWYUQgP for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 07:07:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6486B8ABF9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:04 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id z24so1363349ljn.8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XKlU4lKdj3Ftg6VNKCWCajRZmLcVTJL9ntL6mukO1Xo=;
 b=gF+PCH8lg8YMRFFsAE56yzhfmMGgdqCwmFwD+TI9qs4NjXA1tiHS6Ng9cBRIlXAV0+
 WCkjEPG3UJIHt6DeJHB/FjIubAtTL7CyxsoPExKei5HJM7ySufym6lJ+h8iRL9+vTUsw
 ISdsHJA9pYutZad938G9Urv189itUM0pmpe5WHRkQeLIjIhFcCykEhxNOtkdVMccCWtz
 EaTHFk3ScQ1oGdXiGcH/YtvSNom4QWkw2pEzygUwSi6xF6IHglEVq5V0amRAeFsVCEkZ
 +HTLxpKlANISyR6cgjlLextWUoGANjHqlz0Lv5HJ6im9wyutODiiMlXFlGzJTSIoqyIs
 zuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XKlU4lKdj3Ftg6VNKCWCajRZmLcVTJL9ntL6mukO1Xo=;
 b=fZKZq76McQcEfEMpj1SJwUxzt1+luZiyWqoXCFCEKhl2twezD2KczV91mWlsQVUIa5
 9m2WeVjREg4WU8MezsqWgbccFmXZncNQKv1xHXnisEdf5L9d0puVoMHkIanxykz53JLx
 Jz4A4GUd5x+k6oV4STgMO+mPFBkYjWWg1Sfr9l0LoGisVbzywKkPv+urW8hd4FzhqmwV
 TNg8TWBDbvhBA1veXU6SZkBXprV7YUTNoyZQBsQJARvn8PFWNwgs8ndII1fBK/6hD/hX
 PrNU7S6KnfRGO/0Ql/MHo+v+fPqHYTgisIFKQkXHaaMQPszK6Ku/vsd1Uop0JYTjiFmz
 RX8g==
X-Gm-Message-State: AOAM530XUyvGu77W5jikuON62/uMrhQJTMdq8Lx62wpoyXVREG424N2n
 3T1dH4y6ITHLsL0Exp+u4Pg11Q==
X-Google-Smtp-Source: ABdhPJyht9u1Fi6qxzop87V103kj55HzGKn38flKrFtKPYX7IW+C8BjpSSZJXdo5uDLpBlP6rEyH7Q==
X-Received: by 2002:a2e:9585:: with SMTP id w5mr3671931ljh.58.1594796822599;
 Wed, 15 Jul 2020 00:07:02 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 00:07:01 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v4 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806
 SoC erratum #582743
Date: Wed, 15 Jul 2020 09:06:47 +0200
Message-Id: <20200715070649.18733-3-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
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

Note that most 64-bit registers like TTBRn can be accessed as two 32-bit
halves without issue, and AArch32 format ensures that the register writes
which must be atomic (for TLBI etc.) need only be 32-bit.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/iommu/arm-smmu-impl.c          | 45 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index c75b9d957b70..59422cb92488 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -147,6 +147,48 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
+{
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the readq to double readl
+	 */
+	return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + off);
+}
+
+static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
+			       u64 val)
+{
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the writeq to double writel
+	 */
+	hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + off);
+}
+
+static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
+{
+
+	/*
+	 * Armada-AP806 erratum #582743.
+	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
+	 * formats altogether and allow using 32 bits access on the
+	 * interconnect.
+	 */
+	smmu->features &= ~(ARM_SMMU_FEAT_FMT_AARCH64_4K |
+			    ARM_SMMU_FEAT_FMT_AARCH64_16K |
+			    ARM_SMMU_FEAT_FMT_AARCH64_64K);
+
+	return 0;
+}
+
+static const struct arm_smmu_impl mrvl_mmu500_impl = {
+	.read_reg64 = mrvl_mmu500_readq,
+	.write_reg64 = mrvl_mmu500_writeq,
+	.cfg_probe = mrvl_mmu500_cfg_probe,
+	.reset = arm_mmu500_reset,
+};
+
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -175,5 +217,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
 
+	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
+		smmu->impl = &mrvl_mmu500_impl;
+
 	return smmu;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
