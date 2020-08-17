Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A10C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:03:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AB420674
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUDew3pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AB420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 78C5620503;
	Mon, 17 Aug 2020 22:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xl6sInZ4qAvv; Mon, 17 Aug 2020 22:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 591C0204C6;
	Mon, 17 Aug 2020 22:02:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 341D5C088B;
	Mon, 17 Aug 2020 22:02:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C881C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6BD3986B5C
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3ooYCMKqjdg for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 22:02:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9070A86B55
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:55 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id s15so8761213pgc.8
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LzdV0h2igfBRYjOSWYcy1X96vcmzxH8Zm32RY0I1KrA=;
 b=rUDew3paXM/1UTLzl+JlTUgk4R/oHPWWBuVFx54pB8ftcwo1/j6MIpZth4TuO83cOV
 EqyU8GY+t6YVFTfCElw0MabdDnDG4kQEEKlAfB/mBNyLaoQ+npaSV2+29fuCtQrUYCxx
 iCvUOcW6IpF8CgBIJupeqMjv/dv3FOGDD2r3txf/32VzNQtfZQ/b7GaXrKI/EobqJL/2
 lrFhhpH7lRqzS8LgmXZf4+CN6rDOtD4HLsC2lP1CP7ZsX1D+rdkKi1UL8/j5WFZ2+ITV
 sQoLMg8PedXtw69Xg1+KLx0ss8UCMqFiiemxvFyueQVdh7va3dm0veuHEFVs78CX56S2
 Rhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LzdV0h2igfBRYjOSWYcy1X96vcmzxH8Zm32RY0I1KrA=;
 b=JPhmDdhlAkZWlQRws4QJrZxQUFeNsOEShZzOr1PaWKk94GvUvspa7oMmIwXa/ds75/
 dKSiizaEs0RFMbH5vY2ieC6Je2eBJtGywveegqshoj4t8y4n/8Cm3obpdn1TTp0a1Ahr
 UUyftCtXeZ7dLXZ7hvfNaCQV5Oa2By5j8A1plt+3afOWYC06sfwjxDCTVwpXhA+KoxG2
 vCT7YpT7mZ2JeME6RtOygvgHllbiOndcCl2sPED7LhGVpu2mmUdCrblRGgif0QHJFaJB
 Kjty0kJS3gmzT0kDECMmL7eh4aM5dcEJ34KMklyHxlMtTe8lbWBAWHIJlMBruTrRF0Ub
 K8jA==
X-Gm-Message-State: AOAM532gPOmNqTM6WTxKpPhmLqAkZ2ZY47k1LHQJtaPUFlaEgs7fE/e8
 W1JXgA4QpJ+WI4YHLzSNbRhSYI1GLnPBPenG
X-Google-Smtp-Source: ABdhPJwb8t1CQbhH6yNuY6DeH+w6HKBJ5/VIJHxAf3+qHcxYe1jyiu9hQHvMAolHr+gcnQ2EXW5Tdw==
X-Received: by 2002:a62:830d:: with SMTP id h13mr12499237pfe.269.1597701775010; 
 Mon, 17 Aug 2020 15:02:55 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 t25sm22039206pfl.198.2020.08.17.15.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 15:02:53 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 09/20] iommu/arm-smmu-qcom: Add implementation for the adreno
 GPU SMMU
Date: Mon, 17 Aug 2020 15:01:34 -0700
Message-Id: <20200817220238.603465-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817220238.603465-1-robdclark@gmail.com>
References: <20200817220238.603465-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 Hanna Hawa <hannah@marvell.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Add a special implementation for the SMMU attached to most Adreno GPU
target triggered from the qcom,adreno-smmu compatible string.

The new Adreno SMMU implementation will enable split pagetables
(TTBR1) for the domain attached to the GPU device (SID 0) and
hard code it context bank 0 so the GPU hardware can implement
per-instance pagetables.

Co-developed-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |   3 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 149 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
 3 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 88f17cc33023..d199b4bff15d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -223,6 +223,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
 
+	if (of_device_is_compatible(smmu->dev->of_node, "qcom,adreno-smmu"))
+		return qcom_adreno_smmu_impl_init(smmu);
+
 	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
 		smmu->impl = &mrvl_mmu500_impl;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index be4318044f96..5640d9960610 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/adreno-smmu-priv.h>
 #include <linux/of_device.h>
 #include <linux/qcom_scm.h>
 
@@ -12,6 +13,132 @@ struct qcom_smmu {
 	struct arm_smmu_device smmu;
 };
 
+#define QCOM_ADRENO_SMMU_GPU_SID 0
+
+static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int i;
+
+	/*
+	 * The GPU will always use SID 0 so that is a handy way to uniquely
+	 * identify it and configure it for per-instance pagetables
+	 */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
+
+		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
+			return true;
+	}
+
+	return false;
+}
+
+static const struct io_pgtable_cfg *qcom_adreno_smmu_get_ttbr1_cfg(
+		const void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct io_pgtable *pgtable =
+		io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+	return &pgtable->cfg;
+}
+
+/*
+ * Local implementation to configure TTBR0 with the specified pagetable config.
+ * The GPU driver will call this to enable TTBR0 when per-instance pagetables
+ * are active
+ */
+
+static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
+		const struct io_pgtable_cfg *pgtbl_cfg)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+
+	/* The domain must have split pagetables already enabled */
+	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
+		return -EINVAL;
+
+	/* If the pagetable config is NULL, disable TTBR0 */
+	if (!pgtbl_cfg) {
+		/* Do nothing if it is already disabled */
+		if ((cb->tcr[0] & ARM_SMMU_TCR_EPD0))
+			return -EINVAL;
+
+		/* Set TCR to the original configuration */
+		cb->tcr[0] = arm_smmu_lpae_tcr(&pgtable->cfg);
+		cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
+	} else {
+		u32 tcr = cb->tcr[0];
+
+		/* Don't call this again if TTBR0 is already enabled */
+		if (!(cb->tcr[0] & ARM_SMMU_TCR_EPD0))
+			return -EINVAL;
+
+		tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
+		tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
+
+		cb->tcr[0] = tcr;
+		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+		cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
+	}
+
+	arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
+
+	return 0;
+}
+
+static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
+		struct device *dev, int start, int count)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	/*
+	 * Assign context bank 0 to the GPU device so the GPU hardware can
+	 * switch pagetables
+	 */
+	if (qcom_adreno_smmu_is_gpu_device(dev)) {
+		start = 0;
+		count = 1;
+	} else {
+		start = 1;
+	}
+
+	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
+}
+
+static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
+		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
+{
+	struct adreno_smmu_priv *priv;
+
+	/* Only enable split pagetables for the GPU device (SID 0) */
+	if (!qcom_adreno_smmu_is_gpu_device(dev))
+		return 0;
+
+	/*
+	 * All targets that use the qcom,adreno-smmu compatible string *should*
+	 * be AARCH64 stage 1 but double check because the arm-smmu code assumes
+	 * that is the case when the TTBR1 quirk is enabled
+	 */
+	if ((smmu_domain->stage == ARM_SMMU_DOMAIN_S1) &&
+	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
+		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
+
+	/*
+	 * Initialize private interface with GPU:
+	 */
+
+	priv = dev_get_drvdata(dev);
+	priv->cookie = smmu_domain;
+	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
+	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
+
+	return 0;
+}
+
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
@@ -65,7 +192,15 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.reset = qcom_smmu500_reset,
 };
 
-struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
+static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
+	.init_context = qcom_adreno_smmu_init_context,
+	.def_domain_type = qcom_smmu_def_domain_type,
+	.reset = qcom_smmu500_reset,
+	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
+};
+
+static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
+		const struct arm_smmu_impl *impl)
 {
 	struct qcom_smmu *qsmmu;
 
@@ -75,8 +210,18 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	qsmmu->smmu = *smmu;
 
-	qsmmu->smmu.impl = &qcom_smmu_impl;
+	qsmmu->smmu.impl = impl;
 	devm_kfree(smmu->dev, smmu);
 
 	return &qsmmu->smmu;
 }
+
+struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
+{
+	return qcom_smmu_create(smmu, &qcom_smmu_impl);
+}
+
+struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu)
+{
+	return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
+}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 27c83333fc50..cd75a33967bb 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -519,6 +519,7 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
+struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu);
 
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
