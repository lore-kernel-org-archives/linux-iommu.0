Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4764C433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCD16143C
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCD16143C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F93D401BB;
	Mon, 10 May 2021 06:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KhKEvdanGPVO; Mon, 10 May 2021 06:54:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4062340139;
	Mon, 10 May 2021 06:54:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0BB7C000D;
	Mon, 10 May 2021 06:54:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1489C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82B7A60BA2
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K449xpiJxKiJ for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 06:54:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D446760B4D
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=RcSq52eIXwC9wF6wEpHGzusRbVkYO0JaaHKEFZFJCck=; b=Zz0R6k3D4V3mos57AUJaTHimbe
 V+9MYW7gWl24Fn9IA8nku+pWprX6jlYzjrqDtVqRPqdjr4l3C3KNzwGE+7DmpmpcTN1Ufk7kzpTS3
 TLtjBCxlVhCu7XE3I45/BUxSP+oTDbJZaVup5Eq5Ns12GbO2KbQ5xu4j+tVCk05u+J1Gwv+hH+5/j
 oVwoFuRvjAgrdxDXo69Rmtd3Uv3fJ1rfCFupXxaY5NYlFhgPC9yqf1SbTjCivz81uV2DixeHkbjdh
 tVjTkjvWy0OrprHzXI9EqsK1VQGiw2b+CAornGlqpQL6InecJevC0D11cjFErb8MmR/kBE6M/hjT9
 p9vUVrww==;
Received: from [2001:4bb8:198:fbc8:e179:16d2:93d1:8e1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lfzo8-008Lov-Je; Mon, 10 May 2021 06:54:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 6/6] iommu: remove iommu_dev_feature_enabled
Date: Mon, 10 May 2021 08:54:05 +0200
Message-Id: <20210510065405.2334771-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510065405.2334771-1-hch@lst.de>
References: <20210510065405.2334771-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
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

Remove the unused iommu_dev_feature_enabled function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  1 -
 drivers/iommu/iommu.c                       | 13 -------------
 include/linux/iommu.h                       |  9 ---------
 3 files changed, 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9689563eec0f30..77deabf2ab9c83 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2666,7 +2666,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.sva_bind		= arm_smmu_sva_bind,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c4b92270946c2f..3d0d67b918a98f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2888,19 +2888,6 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
-bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
-{
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
-
-		if (ops->dev_feat_enabled)
-			return ops->dev_feat_enabled(dev, feat);
-	}
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
-
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef9e7dcef76e90..c0685c88b3f8b5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -198,7 +198,6 @@ struct iommu_iotlb_gather {
  *                      driver init to device driver init (default no)
  * @dev_has/enable/disable_feat: per device entries to check/enable/disable
  *                               iommu specific features.
- * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
@@ -252,7 +251,6 @@ struct iommu_ops {
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
 	/* Per device IOMMU features */
-	bool (*dev_feat_enabled)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
@@ -583,7 +581,6 @@ void iommu_release_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
@@ -905,12 +902,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
-static inline bool
-iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
-{
-	return false;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
