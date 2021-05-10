Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF55C433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617B26143C
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617B26143C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F08D883A55;
	Mon, 10 May 2021 06:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXo0Lief1uEv; Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71EDE83673;
	Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45CCFC0025;
	Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C53DDC0025
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA986404CD
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXp_HiCBHDYq for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 06:54:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F21C404C7
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=J4wnRhUW85g7b8REjkDSBHaFrFOXcnqtIaimbdGL+eE=; b=M707CFPadOj9Lca0Qky7FDBsdw
 bYfIPqP+OUODpv+V+/gbHzCH1Ri7tN7JxjswFSfDUWh/IXNmuUplKjxsdx9f9ctCizhnQXfj0m8cq
 kEs11aRbUVQmF2IGRng16Tu4bb+DoVS3BmYO7hgLXOw/GDWQPR6VBDPT/iTspgm4IB2gKUwOAPgAo
 y1c9YTDehzkQfeQPRZ2jftR/s99fYT7VXiVoXdahYdc/VNidofBlnlx0vByoPp+lXqwVb4W8Hfnb6
 wS8Q4kV/0eGSXJFZFE7lPStfQTKuZAIDV/kKqDgsyT+6+mg3QwqJ4+PzP8avZ57IyG3ZKWaLUCx5g
 QAzZllqw==;
Received: from [2001:4bb8:198:fbc8:e179:16d2:93d1:8e1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lfzo2-008Loa-VW; Mon, 10 May 2021 06:54:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4/6] iommu: remove iommu_aux_{attach,detach}_device
Date: Mon, 10 May 2021 08:54:03 +0200
Message-Id: <20210510065405.2334771-5-hch@lst.de>
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

These are entirely unused now, and were only called by the previously
entirely unused vfio mdev iommu interaction.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c | 205 ------------------------------------
 drivers/iommu/iommu.c       |  33 ------
 include/linux/intel-iommu.h |  10 --
 include/linux/iommu.h       |  17 ---
 4 files changed, 265 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc07f316adcb18..6cae6e4d693226 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1497,18 +1497,6 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 			break;
 		}
 
-	if (!has_iotlb_device) {
-		struct subdev_domain_info *sinfo;
-
-		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
-			info = get_domain_info(sinfo->pdev);
-			if (info && info->ats_enabled) {
-				has_iotlb_device = true;
-				break;
-			}
-		}
-	}
-
 	domain->has_iotlb_device = has_iotlb_device;
 }
 
@@ -1606,7 +1594,6 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 {
 	unsigned long flags;
 	struct device_domain_info *info;
-	struct subdev_domain_info *sinfo;
 
 	if (!domain->has_iotlb_device)
 		return;
@@ -1614,11 +1601,6 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
-		info = get_domain_info(sinfo->pdev);
-		__iommu_flush_dev_iotlb(info, addr, mask);
-	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
@@ -1903,7 +1885,6 @@ static struct dmar_domain *alloc_domain(int flags)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
-	INIT_LIST_HEAD(&domain->subdevices);
 
 	return domain;
 }
@@ -2593,7 +2574,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->iommu = iommu;
 	info->pasid_table = NULL;
 	info->auxd_enabled = 0;
-	INIT_LIST_HEAD(&info->subdevices);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -4579,168 +4559,6 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
 			domain->type == IOMMU_DOMAIN_UNMANAGED;
 }
 
-static inline struct subdev_domain_info *
-lookup_subdev_info(struct dmar_domain *domain, struct device *dev)
-{
-	struct subdev_domain_info *sinfo;
-
-	if (!list_empty(&domain->subdevices)) {
-		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
-			if (sinfo->pdev == dev)
-				return sinfo;
-		}
-	}
-
-	return NULL;
-}
-
-static int auxiliary_link_device(struct dmar_domain *domain,
-				 struct device *dev)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
-
-	assert_spin_locked(&device_domain_lock);
-	if (WARN_ON(!info))
-		return -EINVAL;
-
-	if (!sinfo) {
-		sinfo = kzalloc(sizeof(*sinfo), GFP_ATOMIC);
-		sinfo->domain = domain;
-		sinfo->pdev = dev;
-		list_add(&sinfo->link_phys, &info->subdevices);
-		list_add(&sinfo->link_domain, &domain->subdevices);
-	}
-
-	return ++sinfo->users;
-}
-
-static int auxiliary_unlink_device(struct dmar_domain *domain,
-				   struct device *dev)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
-	int ret;
-
-	assert_spin_locked(&device_domain_lock);
-	if (WARN_ON(!info || !sinfo || sinfo->users <= 0))
-		return -EINVAL;
-
-	ret = --sinfo->users;
-	if (!ret) {
-		list_del(&sinfo->link_phys);
-		list_del(&sinfo->link_domain);
-		kfree(sinfo);
-	}
-
-	return ret;
-}
-
-static int aux_domain_add_dev(struct dmar_domain *domain,
-			      struct device *dev)
-{
-	int ret;
-	unsigned long flags;
-	struct intel_iommu *iommu;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return -ENODEV;
-
-	if (domain->default_pasid <= 0) {
-		u32 pasid;
-
-		/* No private data needed for the default pasid */
-		pasid = ioasid_alloc(NULL, PASID_MIN,
-				     pci_max_pasids(to_pci_dev(dev)) - 1,
-				     NULL);
-		if (pasid == INVALID_IOASID) {
-			pr_err("Can't allocate default pasid\n");
-			return -ENODEV;
-		}
-		domain->default_pasid = pasid;
-	}
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = auxiliary_link_device(domain, dev);
-	if (ret <= 0)
-		goto link_failed;
-
-	/*
-	 * Subdevices from the same physical device can be attached to the
-	 * same domain. For such cases, only the first subdevice attachment
-	 * needs to go through the full steps in this function. So if ret >
-	 * 1, just goto out.
-	 */
-	if (ret > 1)
-		goto out;
-
-	/*
-	 * iommu->lock must be held to attach domain to iommu and setup the
-	 * pasid entry for second level translation.
-	 */
-	spin_lock(&iommu->lock);
-	ret = domain_attach_iommu(domain, iommu);
-	if (ret)
-		goto attach_failed;
-
-	/* Setup the PASID entry for mediated devices: */
-	if (domain_use_first_level(domain))
-		ret = domain_setup_first_level(iommu, domain, dev,
-					       domain->default_pasid);
-	else
-		ret = intel_pasid_setup_second_level(iommu, domain, dev,
-						     domain->default_pasid);
-	if (ret)
-		goto table_failed;
-
-	spin_unlock(&iommu->lock);
-out:
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-
-table_failed:
-	domain_detach_iommu(domain, iommu);
-attach_failed:
-	spin_unlock(&iommu->lock);
-	auxiliary_unlink_device(domain, dev);
-link_failed:
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
-
-	return ret;
-}
-
-static void aux_domain_remove_dev(struct dmar_domain *domain,
-				  struct device *dev)
-{
-	struct device_domain_info *info;
-	struct intel_iommu *iommu;
-	unsigned long flags;
-
-	if (!is_aux_domain(dev, &domain->domain))
-		return;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
-	iommu = info->iommu;
-
-	if (!auxiliary_unlink_device(domain, dev)) {
-		spin_lock(&iommu->lock);
-		intel_pasid_tear_down_entry(iommu, dev,
-					    domain->default_pasid, false);
-		domain_detach_iommu(domain, iommu);
-		spin_unlock(&iommu->lock);
-	}
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
-}
-
 static int prepare_domain_attach_device(struct iommu_domain *domain,
 					struct device *dev)
 {
@@ -4813,33 +4631,12 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
-static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
-					 struct device *dev)
-{
-	int ret;
-
-	if (!is_aux_domain(dev, domain))
-		return -EPERM;
-
-	ret = prepare_domain_attach_device(domain, dev);
-	if (ret)
-		return ret;
-
-	return aux_domain_add_dev(to_dmar_domain(domain), dev);
-}
-
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
 	dmar_remove_one_dev_info(dev);
 }
 
-static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
-					  struct device *dev)
-{
-	aux_domain_remove_dev(to_dmar_domain(domain), dev);
-}
-
 #ifdef CONFIG_INTEL_IOMMU_SVM
 /*
  * 2D array for converting and sanitizing IOMMU generic TLB granularity to
@@ -5474,8 +5271,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.enable_nesting		= intel_iommu_enable_nesting,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
-	.aux_attach_dev		= intel_iommu_aux_attach_device,
-	.aux_detach_dev		= intel_iommu_aux_detach_device,
 	.map			= intel_iommu_map,
 	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6721ac17baf29b..c4b92270946c2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2901,39 +2901,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
 
-/*
- * Aux-domain specific attach/detach.
- *
- * Only works if iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) returns
- * true. Also, as long as domains are attached to a device through this
- * interface, any tries to call iommu_attach_device() should fail
- * (iommu_detach_device() can't fail, so we fail when trying to re-attach).
- * This should make us safe against a device being attached to a guest as a
- * whole while there are still pasid users on it (aux and sva).
- */
-int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (domain->ops->aux_attach_dev)
-		ret = domain->ops->aux_attach_dev(domain, dev);
-
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
-
-void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
-{
-	if (domain->ops->aux_detach_dev) {
-		domain->ops->aux_detach_dev(domain, dev);
-		trace_detach_device_from_domain(dev);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
-
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03faf20a6817e8..c12b8e6545733c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -548,7 +548,6 @@ struct dmar_domain {
 
 	bool has_iotlb_device;
 	struct list_head devices;	/* all devices' list */
-	struct list_head subdevices;	/* all subdevices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -621,15 +620,6 @@ struct intel_iommu {
 	struct dmar_drhd_unit *drhd;
 };
 
-/* Per subdevice private data */
-struct subdev_domain_info {
-	struct list_head link_phys;	/* link to phys device siblings */
-	struct list_head link_domain;	/* link to domain siblings */
-	struct device *pdev;		/* physical device derived from */
-	struct dmar_domain *domain;	/* aux-domain */
-	int users;			/* user count */
-};
-
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d8aa5c8a5ba57a..b0bf99dfd80d16 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -258,10 +258,6 @@ struct iommu_ops {
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
-	/* Aux-domain specific attach/detach entries */
-	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
-
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
@@ -590,8 +586,6 @@ void iommu_release_device(struct device *dev);
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
-int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
-void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
@@ -931,17 +925,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline int
-iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
-{
-	return -ENODEV;
-}
-
-static inline void
-iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
-{
-}
-
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
