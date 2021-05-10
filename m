Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DBC43462
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1016143C
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1016143C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 269AE83A5B;
	Mon, 10 May 2021 06:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id effnYpOW7MLb; Mon, 10 May 2021 06:54:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE2E583A57;
	Mon, 10 May 2021 06:54:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA72CC000D;
	Mon, 10 May 2021 06:54:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAB88C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7C3483A4B
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ViDx0Gl1-OkU for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 06:54:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 015088364B
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rWP+Pr2dwqNgcz0+au685uI1YgDiOB5kyFy/7LwWvgE=; b=t+KUQuC0F6cy8MI5DigCl/oJMr
 y5JxAZZ4YBUZD4MyPpPnxGNGVHhFv4BY4FDCWqnqr0RYB8PEYDrl/ENSq2LwXrHyCeelI7B6XMaph
 NIAKpK0CkOJ2FMVFliCdozEoU8XTd6siI2nHiIYwmNgueWaIO/sxyfUNnYDPxCtgbz0Diol8ofwdT
 YrgWrGuMis+X3QN44W55lZlitSxJN6xo3DkqBtjEGoHj9vJ90HYnGyMnwKl+ttYOuk5wA2iJeXoWI
 Kj2+Aa3lmKtqLkwXEBv3Z8nkwVtWpg6xqHfdhqaHpcKBf/4APfnR3tEzPBo2avj8R1qmcKlBgH4MZ
 1X6WkRWQ==;
Received: from [2001:4bb8:198:fbc8:e179:16d2:93d1:8e1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lfzo5-008Lol-Pg; Mon, 10 May 2021 06:54:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 5/6] iommu: remove IOMMU_DEV_FEAT_AUX
Date: Mon, 10 May 2021 08:54:04 +0200
Message-Id: <20210510065405.2334771-6-hch@lst.de>
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

This feature is entirely unused, and was only ever called by unused code
either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c | 82 -------------------------------------
 drivers/iommu/intel/svm.c   |  6 ---
 include/linux/intel-iommu.h |  1 -
 include/linux/iommu.h       |  2 -
 4 files changed, 91 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6cae6e4d693226..2603d95ecb4c0e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2573,7 +2573,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
-	info->auxd_enabled = 0;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -4546,19 +4545,6 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
-/*
- * Check whether a @domain could be attached to the @dev through the
- * aux-domain attach/detach APIs.
- */
-static inline bool
-is_aux_domain(struct device *dev, struct iommu_domain *domain)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-
-	return info && info->auxd_enabled &&
-			domain->type == IOMMU_DOMAIN_UNMANAGED;
-}
-
 static int prepare_domain_attach_device(struct iommu_domain *domain,
 					struct device *dev)
 {
@@ -4612,9 +4598,6 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		return -EPERM;
 	}
 
-	if (is_aux_domain(dev, domain))
-		return -EPERM;
-
 	/* normally dev is not mapped */
 	if (unlikely(domain_context_mapped(dev))) {
 		struct dmar_domain *old_domain;
@@ -5083,52 +5066,9 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-static int intel_iommu_enable_auxd(struct device *dev)
-{
-	struct device_domain_info *info;
-	struct intel_iommu *iommu;
-	unsigned long flags;
-	int ret;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu || dmar_disabled)
-		return -EINVAL;
-
-	if (!sm_supported(iommu) || !pasid_supported(iommu))
-		return -EINVAL;
-
-	ret = intel_iommu_enable_pasid(iommu, dev);
-	if (ret)
-		return -ENODEV;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
-	info->auxd_enabled = 1;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-}
-
-static int intel_iommu_disable_auxd(struct device *dev)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
-	if (!WARN_ON(!info))
-		info->auxd_enabled = 0;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-}
-
 static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
-	if (feat == IOMMU_DEV_FEAT_AUX)
-		return intel_iommu_enable_auxd(dev);
-
 	if (feat == IOMMU_DEV_FEAT_IOPF) {
 		struct device_domain_info *info = get_domain_info(dev);
 
@@ -5152,26 +5092,6 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static int
-intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
-{
-	if (feat == IOMMU_DEV_FEAT_AUX)
-		return intel_iommu_disable_auxd(dev);
-
-	return -ENODEV;
-}
-
-static bool
-intel_iommu_dev_feat_enabled(struct device *dev, enum iommu_dev_features feat)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-
-	if (feat == IOMMU_DEV_FEAT_AUX)
-		return scalable_mode_support() && info && info->auxd_enabled;
-
-	return false;
-}
-
 static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 					   struct device *dev)
 {
@@ -5283,9 +5203,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
-	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5165cea904211a..54b55f867438c8 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -347,10 +347,6 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 	sdev->iommu = iommu;
 
-	/* Only count users if device has aux domains */
-	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
-		sdev->users = 1;
-
 	/* Set up device context entry for PASID if not enabled already */
 	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
 	if (ret) {
@@ -412,8 +408,6 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 		goto out;
 
 	if (sdev) {
-		if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
-			sdev->users--;
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
 			intel_pasid_tear_down_entry(iommu, dev,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index c12b8e6545733c..4b855c42435f7c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -636,7 +636,6 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
-	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b0bf99dfd80d16..ef9e7dcef76e90 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -132,7 +132,6 @@ struct iommu_resv_region {
 
 /**
  * enum iommu_dev_features - Per device IOMMU features
- * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
  * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
  * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
  *			 enabling %IOMMU_DEV_FEAT_SVA requires
@@ -144,7 +143,6 @@ struct iommu_resv_region {
  * Device drivers enable a feature using iommu_dev_enable_feature().
  */
 enum iommu_dev_features {
-	IOMMU_DEV_FEAT_AUX,
 	IOMMU_DEV_FEAT_SVA,
 	IOMMU_DEV_FEAT_IOPF,
 };
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
