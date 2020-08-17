Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCFC433E3
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FDF20657
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnCBbMg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FDF20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C20F487A9C;
	Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pUl0YI0ULgVh; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0EAE287AA5;
	Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF9B7C088E;
	Mon, 17 Aug 2020 17:18:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 723A2C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6028287AA5
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFu1XR9gdOmg for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 17:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5120087A5F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:43 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id o18so18644456eje.7
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7bLyuMpAwb3TPARm6JshTa7I82G4plmlRqOFxlFkxKY=;
 b=BnCBbMg7+P/Fkc7Kb/JvexHf8GtJCubk9jsNWiZ9EbZWDboK8grpgDcumDB4Ej/HCi
 qV1GyEja4PGPfmfhjlhOcTzJZhxG+nC7bMF9Upq6iP3hpwDP6lWfiU+FrgSW4FCVBUNn
 +CxgG8h58e6+8ERuF/p1Hbi1i9Z0bqZOiDaD/zZb4w3C1tN0mrrKhNWEUC3+7yFgGzAs
 VPYqFTnqiMFoOjGayINTwHSeX9XmaDib3xxyjDA6fsIy/D1NlgI/pLqbOfAKHGnG1Xx/
 OB5mUPN6tGq3HQN6hE2QL9xnyTD/CdO3gCrO7GykUTjv2A/5swKJhp9M6oJG6Lmoqnne
 Z/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7bLyuMpAwb3TPARm6JshTa7I82G4plmlRqOFxlFkxKY=;
 b=C9pFOj6/7wO+mjfsp4RX0eILYu9Twq6gsRMKeldV7fABg1EQpcTlYhpyc/OlcRj2G3
 bXX3bXNhhFyB8NskjYie3q7ZW8Yb8++UeD+Z5g3GS9JLbSPjpBJI/qnKATsynLYkRShx
 zEpuEWX1CiprynZmFJ0eGXIJPKAClcYGEjZ7SNaY+VLccD/mcr1cXjnzhfnBSAzzWE5P
 jV5xo8w82t5zBCIFjOUDxbHZ8TCMbK6bdXY31dZW363skH0dV2OvE0fcKXILQ3RTFYyM
 x9yBnnynJKNxRmpM8apJdxRVgkKGfaJ/nlb1go8EzsvcnOMeuHLKm5MuVkrgdfKAtYOz
 YTow==
X-Gm-Message-State: AOAM531IBEqgNtZ/C6DaKfrfc0SnUnjWLEp+K4QIxQ6EmsLR81xIlxn9
 PxfLcQnQratFPc3M4bz2eQ3Jc1k0R5mcLSQU
X-Google-Smtp-Source: ABdhPJw3upK09tIeBcqPxK5kZBnaBx6T1QJDE32RrnaM6tEGIlp5Ma4Q3X1itnWtzGLve0BIhhlmnQ==
X-Received: by 2002:a17:906:2a14:: with SMTP id
 j20mr16886944eje.376.1597684721471; 
 Mon, 17 Aug 2020 10:18:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lc18sm14672502ejb.29.2020.08.17.10.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 10:18:40 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH RESEND v9 11/13] iommu/arm-smmu-v3: Add SVA device feature
Date: Mon, 17 Aug 2020 19:15:57 +0200
Message-Id: <20200817171558.325917-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817171558.325917-1-jean-philippe@linaro.org>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhengxiang9@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 26 ++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 49 ++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 79 +++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7b14b48a26c7..ba34914813ff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bf81d91ce71e..28027620cf2e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -10,6 +10,8 @@
 #include "arm-smmu-v3.h"
 #include "../../io-pgtable-arm.h"
 
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 15cb3d9c1a5d..5ed5bb42298f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
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
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
