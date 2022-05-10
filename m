Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B5C4332F
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 21:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 161DE40390;
	Tue, 10 May 2022 21:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LFAHYK20uIit; Tue, 10 May 2022 21:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D425A40439;
	Tue, 10 May 2022 21:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE604C0032;
	Tue, 10 May 2022 21:03:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B89FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 21:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FBF383032
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 21:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1CJHZcvZNYlg for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 21:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C6DF83065
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652216601; x=1683752601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BWGbvczE9hHSwD7LKlNCfOE3pQLWXV9yP/c7WBdOTFs=;
 b=CIZiIGiTI4/6nT76bSsZD9us8vF/LyF4wGia7EWTMsojBpFFhP2eXbNJ
 lW7yC9d53Vtj9AJPh6ZOHC5n/5x5EP11SCcKyKuuvocQO1DOfp9t09U2W
 1QpTU0zxVvb+mISmXKYRNRmQ4SBQhFrFfaADUZ2iE8EwSw0WTdcrpcazV
 5yDTYUjhqFCDhWV37j8Z9IY1TwL07rFfbfnHg/1wgz08PB5JlPxWLooZP
 l+wcuGSfNQA1AJzN30QJMRsM9vT5Y/caxL02m9ReRIsknigrAGcYhH1lG
 4lrxS3Ex4/ulACnMHUIYDzcQf+M1VZbAbjbvt5Jz1dITdJhoZ5hX5vLth w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251551569"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="251551569"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 14:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="553017098"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga002.jf.intel.com with ESMTP; 10 May 2022 14:03:20 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 vkoul@kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for attach_dev_pasid
Date: Tue, 10 May 2022 14:07:01 -0700
Message-Id: <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

On VT-d platforms with scalable mode enabled, devices issue DMA requests
with PASID need to attach PASIDs to given IOMMU domains. The attach
operation involves the following:
- Programming the PASID into the device's PASID table
- Tracking device domain and the PASID relationship
- Managing IOTLB and device TLB invalidations

This patch add attach_dev_pasid functions to the default domain ops which
is used by DMA and identity domain types. It could be extended to support
other domain types whenever necessary.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 81 ++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  1 +
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a51b96fa9b3a..5408418f4f4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1562,6 +1562,10 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
+	if (info->pasid) {
+		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
+					 info->pasid, qdep, addr, mask);
+	}
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
 }
@@ -1591,6 +1595,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
+	struct iommu_domain *iommu_domain = &domain->domain;
 
 	BUG_ON(pages == 0);
 
@@ -1599,6 +1604,9 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 
 	if (domain_use_first_level(domain)) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		/* flush additional kernel DMA PASIDs attached */
+		if (iommu_domain->pasid)
+			qi_flush_piotlb(iommu, did, iommu_domain->pasid, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -4265,10 +4273,13 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain = info->domain;
 
 	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
+		if (dev_is_pci(info->dev) && sm_supported(iommu)) {
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
-
+			if (info->pasid)
+				intel_pasid_tear_down_entry(iommu, info->dev,
+							    info->pasid, false);
+		}
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
 		intel_pasid_free_table(info->dev);
@@ -4912,6 +4923,70 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
+					struct device *dev,
+					ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!sm_supported(iommu) || !info)
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	/*
+	 * If the same device already has a PASID attached, just return.
+	 * DMA layer will return the PASID value to the caller.
+	 */
+	if (pasid != PASID_RID2PASID && info->pasid) {
+		if (info->pasid == pasid)
+			ret = 0;
+		else {
+			dev_warn(dev, "Cannot attach PASID %u, %u already attached\n",
+				 pasid, info->pasid);
+			ret = -EBUSY;
+		}
+		goto out_unlock_domain;
+	}
+
+	spin_lock(&iommu->lock);
+	if (hw_pass_through && domain_type_is_si(dmar_domain))
+		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
+						     dev, pasid);
+	else if (domain_use_first_level(dmar_domain))
+		ret = domain_setup_first_level(iommu, dmar_domain,
+					       dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
+						     dev, pasid);
+
+	spin_unlock(&iommu->lock);
+out_unlock_domain:
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+	if (!ret)
+		info->pasid = pasid;
+
+	return ret;
+}
+
+static void intel_iommu_detach_dev_pasid(struct iommu_domain *domain,
+					struct device *dev,
+					ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+
+	WARN_ON(info->pasid != pasid);
+	spin_lock_irqsave(&iommu->lock, flags);
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	info->pasid = 0;
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4940,6 +5015,8 @@ const struct iommu_ops intel_iommu_ops = {
 		.iova_to_phys		= intel_iommu_iova_to_phys,
 		.free			= intel_iommu_domain_free,
 		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+		.attach_dev_pasid	= intel_iommu_attach_dev_pasid,
+		.detach_dev_pasid	= intel_iommu_detach_dev_pasid,
 	}
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5af24befc9f1..55845a8c4f4d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -627,6 +627,7 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	ioasid_t pasid; /* DMA request with PASID */
 };
 
 static inline void __iommu_flush_cache(
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
