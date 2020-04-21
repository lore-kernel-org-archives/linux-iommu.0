Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8589AC55183
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 20:20:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522D8206D9
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="KiH9ar0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522D8206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 277B587E7D;
	Tue, 21 Apr 2020 20:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VIkL4AJaa+V4; Tue, 21 Apr 2020 20:20:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9291487D6E;
	Tue, 21 Apr 2020 20:20:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 791F9C1797;
	Tue, 21 Apr 2020 20:20:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A70D8C0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 20:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9293F2035B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 20:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rh33KduZrBOf for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 20:20:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id C6ACC2034B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 20:20:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587500433; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8Z/altQqTKdjp/pVqayBVEKEPSRCz4KgGRuB1EudGTI=;
 b=KiH9ar0IVNTlkKca/URMwyPoJ6FltpMDn5miDfvxwVkU/iba5hod3CV+e6efjDKx9631wzFv
 ckZRbBeUZqFrDZmHxpU49IeXpQK1DcpGmvyUZ1VODJIN3gd+wNW0gkUQ0RTgK1j9qqbyvks9
 vYxp7HCum2eVLISrrGMY6Nx5dGc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f5582.7fb5218ce7d8-smtp-out-n03;
 Tue, 21 Apr 2020 20:20:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5ED3DC432C2; Tue, 21 Apr 2020 20:20:17 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 609F3C432C2;
 Tue, 21 Apr 2020 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 609F3C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jcrouse@codeaurora.org>
Subject: [PATCH] iomm/arm-smmu: Add stall implementation hook
Date: Wed, 22 Apr 2020 01:50:04 +0530
Message-Id: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Add stall implementation hook to enable stalling
faults on QCOM platforms which supports it without
causing any kind of hardware mishaps. Without this
on QCOM platforms, GPU faults can cause unrelated
GPU memory accesses to return zeroes. This has the
unfortunate result of command-stream reads from CP
getting invalid data, causing a cascade of fail.

Suggested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
This has been attempted previously by Rob Clark in 2017, 2018.
Hopefully we can get something concluded in 2020.
 * https://patchwork.kernel.org/patch/9953803/
 * https://patchwork.kernel.org/patch/10618713/
---
 drivers/iommu/arm-smmu-qcom.c | 1 +
 drivers/iommu/arm-smmu.c      | 7 +++++++
 drivers/iommu/arm-smmu.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index 24c071c1d8b0..a13b229389d4 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -32,6 +32,7 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
 	.reset = qcom_sdm845_smmu500_reset,
+	.stall = true,
 };
 
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e622f4e33379..16b03fca9966 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -488,6 +488,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 			    fsr, iova, fsynr, cbfrsynra, idx);
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+
+	if (smmu->impl && smmu->impl->stall && (fsr & ARM_SMMU_FSR_SS))
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+				  ARM_SMMU_RESUME_TERMINATE);
+
 	return IRQ_HANDLED;
 }
 
@@ -659,6 +664,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= ARM_SMMU_SCTLR_E;
+	if (smmu->impl && smmu->impl->stall)
+		reg |= ARM_SMMU_SCTLR_CFCFG;
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 8d1cd54d82a6..d5134e0d5cce 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -386,6 +386,7 @@ struct arm_smmu_impl {
 	int (*init_context)(struct arm_smmu_domain *smmu_domain);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
+	bool stall;
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
