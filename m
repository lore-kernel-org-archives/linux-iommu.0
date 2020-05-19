Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF4CC433F1
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9F2207D4
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4EdnjwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9F2207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90FDB88885;
	Tue, 19 May 2020 18:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxuuHtdEndrx; Tue, 19 May 2020 18:02:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7C6B3888A2;
	Tue, 19 May 2020 18:02:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72C2AC0890;
	Tue, 19 May 2020 18:02:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 443C9C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3EE2486D76
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xw7rBCNk2dq for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:02:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C02886D5D
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:01 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z72so213766wmc.2
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w0kdAS+3V4p7jXN1k79MYNGRv9Y+4JMnAcNVoiF0l70=;
 b=Y4EdnjwYGiovh5kRncy2PI1+5V23I9EidrfOm90dz7a75obSThtBtY4iz/6hLBVCho
 5gutgO9+jYJaqa3AP50b579CyD3Xo8Os+g5ZMtz+rvzj3KIv4+JVix3pPmzIdWGBJpUr
 mRdFDzxwXg8P6rMBwMIB7hmJCUHwiDSjb9udlALkBO4crYuf5bUdIRrst4t2//W5+BIr
 qDjRWz0EZjqj5ojI8fljkyY6ePbeArnslKBHUJdWTLeNiK8/mjqfUvalHtpMS9aAXXYY
 1FNHNPtwsiFRQScSD/UobANFMpQMISm2uWThO2evgtfehAQl/p6SzjFc3OPNw3sSLGHi
 TQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w0kdAS+3V4p7jXN1k79MYNGRv9Y+4JMnAcNVoiF0l70=;
 b=AvrIlOHXy/TjtekQUhIb2bwYyPOsw6fiOqQPeKyc+cQTspM30BNc8Zlm/8c9pkvKWw
 MrpXafciKbr++8puNdena/rAIBv34/jbdCPiahE25XYPSLITQdFmQuJC7cA/Mvf4BKEu
 ea3DMWTM1RJ17Gsu9gJHpj0ky0zkGrIqkGLFTuVdkiEHTcmQlixdLeNvYrdQl4fASegB
 9UOKzgh5idDooywWLct3Nm7Ec3uPKAJWi3VnapxLubdNXBgmBuE8AojiLi5xjp9mGXTh
 MzM0VWhwA2tZIArlRdexvTWKdQLr6ya63Dy/Gi2EANnkYajTn7qL1NUeK6yQmgna/Yxa
 iP2A==
X-Gm-Message-State: AOAM530onm93Z1ypCoRYcujbxjEN1JCgXcnO56fMCv1b7CoKRzGoNU7O
 HTOmOpNY7S+KVcX1tTU74ORnHUazYc6WeA==
X-Google-Smtp-Source: ABdhPJxiur973rQO7P0is4n9bTcqUoLADPVJgaczJU1ETHTcZpVacHBincB+tnOWfVKyZnCnndXCAg==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr575120wmj.146.1589911319392; 
 Tue, 19 May 2020 11:01:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:01:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 15/24] iommu/arm-smmu-v3: Add SVA device feature
Date: Tue, 19 May 2020 19:54:53 +0200
Message-Id: <20200519175502.2504091-16-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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
 drivers/iommu/arm-smmu-v3.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a9f6f1d7014e..b016b61cee23 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -703,6 +703,8 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	bool				sva_enabled;
+	struct list_head		bonds;
 	unsigned int			ssid_bits;
 };
 
@@ -3013,6 +3015,19 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	/*
+	 * Checking that SVA is disabled ensures that this device isn't bound to
+	 * any mm, and can be safely detached from its old domain. Bonds cannot
+	 * be removed concurrently since we're holding the group mutex.
+	 */
+	mutex_lock(&sva_lock);
+	if (master->sva_enabled) {
+		mutex_unlock(&sva_lock);
+		dev_err(dev, "cannot attach - SVA enabled\n");
+		return -EBUSY;
+	}
+	mutex_unlock(&sva_lock);
+
 	arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -3161,6 +3176,7 @@ static int arm_smmu_add_device(struct device *dev)
 	master->smmu = smmu;
 	master->sids = fwspec->ids;
 	master->num_sids = fwspec->num_ids;
+	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
@@ -3230,6 +3246,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
+	WARN_ON(master->sva_enabled);
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
@@ -3349,6 +3366,109 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
+static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
+{
+	return false;
+}
+
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
+		if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
+			return false;
+
+		/* SSID and IOPF support are mandatory for the moment */
+		return master->ssid_bits && arm_smmu_iopf_supported(master);
+	default:
+		return false;
+	}
+}
+
+static bool arm_smmu_dev_feature_enabled(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	bool enabled = false;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		mutex_lock(&sva_lock);
+		enabled = master->sva_enabled;
+		mutex_unlock(&sva_lock);
+		return enabled;
+	default:
+		return false;
+	}
+}
+
+static int arm_smmu_dev_enable_sva(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	master->sva_enabled = true;
+	mutex_unlock(&sva_lock);
+
+	return 0;
+}
+
+static int arm_smmu_dev_disable_sva(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	if (!list_empty(&master->bonds)) {
+		dev_err(dev, "cannot disable SVA, device is bound\n");
+		mutex_unlock(&sva_lock);
+		return -EBUSY;
+	}
+	master->sva_enabled = false;
+	mutex_unlock(&sva_lock);
+
+	return 0;
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
+		return arm_smmu_dev_enable_sva(dev);
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
+		return arm_smmu_dev_disable_sva(dev);
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -3367,6 +3487,10 @@ static struct iommu_ops arm_smmu_ops = {
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
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
