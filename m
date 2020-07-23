Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E3BC433F7
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD8A208E4
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MA/ebgX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD8A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3FE0893AD;
	Thu, 23 Jul 2020 15:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rf6q+pNSrNcB; Thu, 23 Jul 2020 15:06:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 872B289369;
	Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73438C0050;
	Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC48C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4B10B892B3
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v+Flfk2n0HkN for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 244248934F
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id b13so2377952edz.7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jrw/NadD7mFzT8TBC8lMm0pIPDE9dyvhyfTA7s3Qrzw=;
 b=MA/ebgX5Se7spe9U3ykZrqU7upYgH1nEUv7j2VNLEiQBMMGEOtspTB9MAk4GWf6fDL
 fZiVo0Y6/RPZCPanxi1YVndp05AGW/dommTEjJEFISljrimpkhmFAJXQhc2FIrym4wh4
 0tmJq8YDuYW1oSdrsApPP7gnoRMEojacDcPONQEKObfvlIw9+gBAbWkDlwgOaSgkHWdC
 vLBx+uePTPgUxOt50S0gd/02Ueb9AhXHnVEBo4qInLAvNp+iz/AfipW7x/Hl2PxpSm1Z
 SCLU3futU5dCG4raHOWP1VZxClEnW28EX5iJmfyf2QljA1Bp9eWAwDi0lpapKz2i1YKh
 2iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jrw/NadD7mFzT8TBC8lMm0pIPDE9dyvhyfTA7s3Qrzw=;
 b=WTXrA5CPT1JwmiRNrKnAzFNnddjq7RUXcru48LVDdgURRCUxZm/vJs8F8tk9wjWz1q
 SRmx2yZzdLv4Y7SQHxo6jTy8KHl53Hsk2VuRguLBaJPl8k0qMUq+zIxVSMiEsCs4D6hC
 ypp5hyv92l4SsCtc+NSw6sy+FpYKJN0pKLTqvtekdpcK+W3aASkuEDDiqWpEf+WEtut7
 LQFI+ALNoKCIHMrRQKRxbGYpkGQkg4TvZgEW3Q8+aBc/20iuq0irucSfW67+FmrWwn3u
 yn5O4TmhovYX2ieaACUT8O/mpFUVq5oRVZ8AbPFNaOtb6RbE/bslLnN2ogYs3TaMA8N2
 CJog==
X-Gm-Message-State: AOAM531wNtF/ImeRxoi168p/SL7PQEWBXEuF6ULeVOB02PSQ3OEsf4Kw
 ONJpL1B7lJAesVSQftfcP6M+8hhtihc=
X-Google-Smtp-Source: ABdhPJxWJieOow5IF9rR+um8s0iDowKOUoOfgOi0Ugh+W2dv56Mb0L6soYgMpIjyNrZdDv0HRz7IFw==
X-Received: by 2002:a05:6402:b9b:: with SMTP id
 cf27mr4677754edb.84.1595516759135; 
 Thu, 23 Jul 2020 08:05:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm2145952eji.49.2020.07.23.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:05:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v9 11/13] iommu/arm-smmu-v3: Add SVA device feature
Date: Thu, 23 Jul 2020 16:57:23 +0200
Message-Id: <20200723145724.3014766-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723145724.3014766-1-jean-philippe@linaro.org>
References: <20200723145724.3014766-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, will@kernel.org
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

Implement the IOMMU device feature callbacks to support the SVA feature.
At the moment dev_has_feat() returns false since I/O Page Faults isn't
yet implemented.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.h     | 26 +++++++++++
 drivers/iommu/arm-smmu-v3-sva.c | 49 ++++++++++++++++++++
 drivers/iommu/arm-smmu-v3.c     | 79 +++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.h b/drivers/iommu/arm-smmu-v3.h
index 7b14b48a26c7..ba34914813ff 100644
--- a/drivers/iommu/arm-smmu-v3.h
+++ b/drivers/iommu/arm-smmu-v3.h
@@ -646,6 +646,8 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	bool				sva_enabled;
+	struct list_head		bonds;
 	unsigned int			ssid_bits;
 };
 
@@ -687,10 +689,34 @@ bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
+bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
+bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
+int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
+int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
 	return false;
 }
+
+static inline bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
+{
+	return false;
+}
+
+static inline bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
+{
+	return false;
+}
+
+static inline int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
+{
+	return -ENODEV;
+}
+
+static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm-smmu-v3-sva.c b/drivers/iommu/arm-smmu-v3-sva.c
index eedc6c8264f1..b6805effede4 100644
--- a/drivers/iommu/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm-smmu-v3-sva.c
@@ -10,6 +10,8 @@
 #include "arm-smmu-v3.h"
 #include "io-pgtable-arm.h"
 
+static DEFINE_MUTEX(sva_lock);
+
 /*
  * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
  * the private entry. Careful here, we may be modifying the context tables of
@@ -196,3 +198,50 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 
 	return true;
 }
+
+static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
+{
+	return false;
+}
+
+bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
+{
+	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
+		return false;
+
+	/* SSID and IOPF support are mandatory for the moment */
+	return master->ssid_bits && arm_smmu_iopf_supported(master);
+}
+
+bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
+{
+	bool enabled;
+
+	mutex_lock(&sva_lock);
+	enabled = master->sva_enabled;
+	mutex_unlock(&sva_lock);
+	return enabled;
+}
+
+int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
+{
+	mutex_lock(&sva_lock);
+	master->sva_enabled = true;
+	mutex_unlock(&sva_lock);
+
+	return 0;
+}
+
+int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
+{
+	mutex_lock(&sva_lock);
+	if (!list_empty(&master->bonds)) {
+		dev_err(master->dev, "cannot disable SVA, device is bound\n");
+		mutex_unlock(&sva_lock);
+		return -EBUSY;
+	}
+	master->sva_enabled = false;
+	mutex_unlock(&sva_lock);
+
+	return 0;
+}
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 558973e3cc1b..0fd63d93bd2c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2163,6 +2163,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	/*
+	 * Checking that SVA is disabled ensures that this device isn't bound to
+	 * any mm, and can be safely detached from its old domain. Bonds cannot
+	 * be removed concurrently since we're holding the group mutex.
+	 */
+	if (arm_smmu_master_sva_enabled(master)) {
+		dev_err(dev, "cannot attach - SVA enabled\n");
+		return -EBUSY;
+	}
+
 	arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -2310,6 +2320,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->smmu = smmu;
 	master->sids = fwspec->ids;
 	master->num_sids = fwspec->num_ids;
+	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
@@ -2362,6 +2373,7 @@ static void arm_smmu_release_device(struct device *dev)
 		return;
 
 	master = dev_iommu_priv_get(dev);
+	WARN_ON(arm_smmu_master_sva_enabled(master));
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	kfree(master);
@@ -2479,6 +2491,69 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
+static bool arm_smmu_dev_has_feature(struct device *dev,
+				     enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return arm_smmu_master_sva_supported(master);
+	default:
+		return false;
+	}
+}
+
+static bool arm_smmu_dev_feature_enabled(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return arm_smmu_master_sva_enabled(master);
+	default:
+		return false;
+	}
+}
+
+static int arm_smmu_dev_enable_feature(struct device *dev,
+				       enum iommu_dev_features feat)
+{
+	if (!arm_smmu_dev_has_feature(dev, feat))
+		return -ENODEV;
+
+	if (arm_smmu_dev_feature_enabled(dev, feat))
+		return -EBUSY;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return arm_smmu_master_enable_sva(dev_iommu_priv_get(dev));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int arm_smmu_dev_disable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	if (!arm_smmu_dev_feature_enabled(dev, feat))
+		return -EINVAL;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return arm_smmu_master_disable_sva(dev_iommu_priv_get(dev));
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2497,6 +2572,10 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
+	.dev_has_feat		= arm_smmu_dev_has_feature,
+	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
+	.dev_enable_feat	= arm_smmu_dev_enable_feature,
+	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
