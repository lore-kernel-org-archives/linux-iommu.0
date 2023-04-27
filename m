Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8728485
	for <iommu@lists.linux.dev>; Thu, 27 Apr 2023 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682617526; x=1714153526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b47cHt2vFYeXlFrXhgvZHs8+gCR1tr502DezdYmRDRI=;
  b=HFBnclfBJ/wMtCUQF5ifJS5lHoP8XFut4DdShKJReILGM64sGB2SfNCZ
   QwsQNiIcTjPFMxRsAgaybwN5Bk1NoMq8Er2j+2yyToxwEwuBoqd9sN0yQ
   RPbeof/sQ/GZZYqVzj8mRf4AeahSpxkwT7ddqNh086nbIfxtnyPQCchAX
   h1KhOn4Y/UpmeC+fo99Ph9Ioqv5s2gFqETIqkBBaEF4Fs3cAHXk0FzTy3
   TfenYKyvUnIAOlrGg4s6/s5DhpHllF91zWSG/gz82z2/yfk2Nv2yvtxnt
   xUILqEALaGdGfzFSOuiNKc9Ib+2C0fP2FEk7yYA8Mx7GBkDz2kMUf4i3X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350398744"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350398744"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024219723"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024219723"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 10:45:23 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	narayan.ranganathan@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Date: Thu, 27 Apr 2023 10:49:36 -0700
Message-Id: <20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that use ENQCMDS to submit work on buffers mapped by DMA API
must attach a PASID to the default domain of the device. In preparation
for this use case, this patch implements set_dev_pasid() for the
default_domain_ops.

If the device context has not been set up prior to this call, this will
set up the device context in addition to PASID attachment.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 92 ++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 388453a7415e..f9d6c31cdc8e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -278,6 +278,8 @@ static LIST_HEAD(dmar_satc_units);
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
 static void device_block_translation(struct device *dev);
+static void intel_iommu_detach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -4091,8 +4093,7 @@ static void device_block_translation(struct device *dev)
 	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, dev,
-						    IOMMU_DEF_RID_PASID, false);
+			intel_iommu_detach_device_pasid(&info->domain->domain, dev, IOMMU_DEF_RID_PASID);
 		else
 			domain_context_clear(info);
 	}
@@ -4761,28 +4762,86 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static void intel_iommu_detach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
 {
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	struct iommu_domain *domain;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_pasid_info *i, *dev_pasid = NULL;
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
 
-	/* Domain type specific cleanup: */
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (domain) {
-		switch (domain->type) {
-		case IOMMU_DOMAIN_SVA:
-			intel_svm_remove_dev_pasid(dev, pasid);
-			break;
-		default:
-			/* should never reach here */
-			WARN_ON(1);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_for_each_entry(i, &dmar_domain->dev_pasids, link_domain) {
+		if (i->dev == dev && i->pasid == pasid) {
+			list_del(&i->link_domain);
+			dev_pasid = i;
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	if (WARN_ON(!dev_pasid))
+		return;
+
+	/* PASID entry already cleared during SVA unbind */
+	if (domain->type != IOMMU_DOMAIN_SVA)
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+	kfree(dev_pasid);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	dmar_domain = to_dmar_domain(domain);
+
+	/*
+	 * SVA Domain type specific cleanup: Not ideal but not until we have
+	 * IOPF capable domain specific ops, we need this special case.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		return intel_svm_remove_dev_pasid(dev, pasid);
 
-	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	intel_iommu_detach_device_pasid(domain, dev, pasid);
+	domain_detach_iommu(dmar_domain, info->iommu);
 }
 
+static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
+					   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	int ret;
+
+	if (!pasid_supported(iommu))
+		return -ENODEV;
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Most likely the device context has already been set up, will only
+	 * take a domain ID reference. Otherwise, device context will be set
+	 * up here.
+	 * The upper layer APIs make no assumption about the ordering between
+	 * device attachment and the PASID attachment.
+	 */
+	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	if (ret) {
+		dev_err(dev, "Attach device failed\n");
+		return ret;
+	}
+	return dmar_domain_attach_device_pasid(dmar_domain, iommu, dev, pasid);
+}
+
+
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4802,6 +4861,7 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
+		.set_dev_pasid          = intel_iommu_attach_device_pasid,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-- 
2.25.1

