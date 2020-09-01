Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF61C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D6C20767
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvt4z6NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D6C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A271866AF;
	Tue,  1 Sep 2020 16:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXuQr3ZGbYjs; Tue,  1 Sep 2020 16:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F29E3869D0;
	Tue,  1 Sep 2020 16:47:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE0FAC0052;
	Tue,  1 Sep 2020 16:47:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCC67C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AD9392034D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6h3xmmaCh9JY for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:47:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 946E4214EB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:28 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id o16so910202pjr.2
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HHQe8hd0SNUst71ZNXeL5chYz56GGcoaTg6ES2ptaYQ=;
 b=Vvt4z6NYCla4GP+vjbTyAMlKrVVgcHmpCYZH5Z5TjYwOUTKsymhis7Ay1mZnAPameZ
 MneTXP8iZFk4BUdv5V6yeY8O04TY9zDM+oMhEzCStH8zZGerYpnGlwQSNVuGaDYpL2Oc
 Y8HETyj7gC0dcdzGKKTYx2D5uLm4fqZyJBf6ItlCOiBYHwJFoevanLVLBXLq90BfqJQF
 wjQrk4FGPHIzoo2647pbgAOQZXScG5vltEDKyvqz+DxRL29DvJoMg5AT9JGM+OF9wP3Z
 O4d6I4Ycjd3yqoto4uk59y1G4FQMxA6qtyRkiQzvv597aLu+pJfh62F7uDArGJFcMKhH
 2N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HHQe8hd0SNUst71ZNXeL5chYz56GGcoaTg6ES2ptaYQ=;
 b=ZMqh0vfuptAEAn7SD6gCWtHeowA5EHtPbTRa6EzzDFzK/fYWqw+FPaGdZ5JxLve3QG
 gPbLV99GVi4teIcGF9HwGp9f7jBJwnb4UffKMM7GjsOGjZ9ul5/s94taSSxsnLiYteKe
 jAbiZgrOvZJ1iV3OrEGl9j3fEyqRsMQ5LyjSesEbQKA3hybj8sUr0vTGm4TytS84CfmU
 LKsqmQaDWPcKa6/JPXwDW45xwJabh0FKZY7UpVRVJpk36y/ysGgNLJTbJaZM6HX5VQzW
 BFN+++KOa6b6RJHsjV+i2achm5VXAOgIpgQrEcS3jB4rAqk6hKtUyrkOktWXnGL2myav
 T2gw==
X-Gm-Message-State: AOAM5318dJqNdbYc43qzUA72ccUls0SwjYPPz1JdtsTHOWh5JVzONVRp
 viEC7GB87X1R7/M256nmU9o=
X-Google-Smtp-Source: ABdhPJwrz7fA6ioJ6DgxUvLVHDoIaOlNAA5IhAzEfNhey3L+TN5atixeGGeG3X40lEuWD68FTalp5w==
X-Received: by 2002:a17:90a:f682:: with SMTP id
 cl2mr2492580pjb.158.1598978848095; 
 Tue, 01 Sep 2020 09:47:28 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id b18sm2607960pgk.36.2020.09.01.09.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:47:27 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 16/20] iommu/arm-smmu-qcom: Add implementation for the
 adreno GPU SMMU
Date: Tue,  1 Sep 2020 09:46:33 -0700
Message-Id: <20200901164707.2645413-17-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
