Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96383C43219
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F59441015;
	Wed, 18 May 2022 18:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qd5fm62Q_jJH; Wed, 18 May 2022 18:17:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 177FC40374;
	Wed, 18 May 2022 18:17:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACEE9C007F;
	Wed, 18 May 2022 18:17:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1092EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5C32605EA
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5JKpvc4du3xZ for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AAF661247
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652897855; x=1684433855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4E0rUsQ0j9aptl5lb7L0UIOwroU6cL8nhCs1ddmoug0=;
 b=fZ3RZtt6lYBvdcyWz4quWa/W5Vlk0WqgbM/fa4UkNZ+8zGFgOs67hyTe
 C6i2lOAnMqhOkBmcj08GYma+Mw6hpAzXuVSBKjS6kvpi/iGzEDetpva2F
 2YHRW1qRyjF67fOlLuMkrFV2HYSn481iAGejNzKtv5GjtqE/xfXUVgm6O
 RITvTYnUvOMEgto1MbRz1bDZE/vVFMmSaieZW1xga04T42zkzWAUnISaJ
 Ax3KD85fbvwhN+WjUM55gUY0mPaTL3UBDbUDmSfZEYEhlRMsga5QyWFsb
 kEmOeOGmHi6cmB86fdQ99fqwnPbDtb7cBndmkD3TtPM/vOlEXb5RcdGuQ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259392422"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="259392422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="639405497"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for attach_dev_pasid
Date: Wed, 18 May 2022 11:21:17 -0700
Message-Id: <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/intel/iommu.c | 72 +++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1c2c92b657c7..75615c105fdf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 				    u64 addr, unsigned int mask)
 {
 	u16 sid, qdep;
+	ioasid_t pasid;
 
 	if (!info || !info->ats_enabled)
 		return;
 
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
+	pasid = iommu_get_pasid_from_domain(info->dev, &info->domain->domain);
+	if (pasid != INVALID_IOASID) {
+		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
+					 pasid, qdep, addr, mask);
+	}
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
 }
@@ -1591,6 +1597,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
+	struct iommu_domain *iommu_domain = &domain->domain;
 
 	BUG_ON(pages == 0);
 
@@ -1599,6 +1606,9 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 
 	if (domain_use_first_level(domain)) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		/* flush additional kernel DMA PASIDs attached */
+		if (iommu_domain->dma_pasid)
+			qi_flush_piotlb(iommu, did, iommu_domain->dma_pasid, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -4255,6 +4265,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
 	unsigned long flags;
+	ioasid_t pasid;
 
 	assert_spin_locked(&device_domain_lock);
 
@@ -4265,10 +4276,15 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain = info->domain;
 
 	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
+		if (dev_is_pci(info->dev) && sm_supported(iommu)) {
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
-
+			pasid = iommu_get_pasid_from_domain(info->dev,
+							    &info->domain->domain);
+			if (pasid != INVALID_IOASID)
+				intel_pasid_tear_down_entry(iommu, info->dev,
+							    pasid, false);
+		}
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
 		intel_pasid_free_table(info->dev);
@@ -4904,6 +4920,56 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
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
+	if (WARN_ON(pasid == PASID_RID2PASID))
+		return -EINVAL;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
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
+	spin_unlock_irqrestore(&device_domain_lock, flags);
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
+	if (pasid != iommu_get_pasid_from_domain(info->dev, &info->domain->domain))
+		return;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4932,6 +4998,8 @@ const struct iommu_ops intel_iommu_ops = {
 		.iova_to_phys		= intel_iommu_iova_to_phys,
 		.free			= intel_iommu_domain_free,
 		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+		.attach_dev_pasid	= intel_iommu_attach_dev_pasid,
+		.detach_dev_pasid	= intel_iommu_detach_dev_pasid,
 	}
 };
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
