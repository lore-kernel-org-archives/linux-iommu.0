Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59447C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 05:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2618E408FF;
	Tue, 15 Mar 2022 05:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlLqJMiONoun; Tue, 15 Mar 2022 05:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 181C1408FA;
	Tue, 15 Mar 2022 05:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E308EC008E;
	Tue, 15 Mar 2022 05:04:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D129C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BF1241607
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDa0upRT3nl5 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CC17415BF
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647320639; x=1678856639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9Q9rSf59BKk7qLg8hPcHDXhXEuoUaTeoAQ+DuVJmmyE=;
 b=QRIiLFeKdDxQHZWweapAV+tW4e1+N4WOtiUPs7aVLSl0yaDkHO1owIXa
 fWQw/W/rSUnt6EDKnFVyTSx4l2H2s4dhOpgnN3VQ1d88h0w2nM1fP0C9V
 SJis7Knz73o43ytUwY7p7AmpfAQtshc72tj9MftKUWza/9kzfil6SYm0B
 5T0nvOBIXz4+vCgL0LihwdCQ9yodoPjPGm3dHB88/ikkfCqDOdGSIHSbO
 K7E3pJ437dgGltWLH4zjM5tO6BfKpGKaCZnh4YoPgUxeRT9Hki7OAhnFY
 wId0RYqU6cA8TIOeL9Awc709NcaTRld3+Q0DcffqWjjXdOZCKjz7ES/ps g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342640149"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="342640149"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="580383575"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach ops
Date: Mon, 14 Mar 2022 22:07:07 -0700
Message-Id: <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>
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
with PASID need to attach to the correct IOMMU domains.
The attach operation involves the following:
- programming the PASID into device's PASID table
- tracking device domain and the PASID relationship
- managing IOTLB and device TLB invalidations

This patch extends DMAR domain and device domain info with xarrays to
track per domain and per device PASIDs.  It provides the flexibility to
be used beyond DMA API PASID support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 194 +++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  12 ++-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 881f8361eca2..9267194eaed3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1622,20 +1622,48 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 			   qdep, addr, mask);
 }
 
+static void __iommu_flush_dev_piotlb(struct device_domain_info *info,
+					u64 address,
+				     ioasid_t pasid, unsigned int mask)
+{
+	u16 sid, qdep;
+
+	if (!info || !info->ats_enabled)
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
+				 pasid, qdep, address, mask);
+}
+
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
 	unsigned long flags;
 	struct device_domain_info *info;
 	struct subdev_domain_info *sinfo;
+	unsigned long pasid;
+	struct pasid_info *pinfo;
 
 	if (!domain->has_iotlb_device)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &domain->devices, link)
-		__iommu_flush_dev_iotlb(info, addr, mask);
-
+	list_for_each_entry(info, &domain->devices, link) {
+		/*
+		 * We cannot use PASID based devTLB invalidation on RID2PASID
+		 * Device does not understand RID2PASID/0. This is different
+		 * than IOTLB invalidation where RID2PASID is also used for
+		 * tagging.
+		 */
+		xa_for_each(&info->pasids, pasid, pinfo) {
+			if (!pasid)
+				__iommu_flush_dev_iotlb(info, addr, mask);
+			else
+				__iommu_flush_dev_piotlb(info, addr, pasid, mask);
+		}
+	}
 	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
 		info = get_domain_info(sinfo->pdev);
 		__iommu_flush_dev_iotlb(info, addr, mask);
@@ -1648,6 +1676,8 @@ static void domain_flush_piotlb(struct intel_iommu *iommu,
 				u64 addr, unsigned long npages, bool ih)
 {
 	u16 did = domain->iommu_did[iommu->seq_id];
+	struct pasid_info *pinfo;
+	unsigned long pasid;
 
 	if (domain->default_pasid)
 		qi_flush_piotlb(iommu, did, domain->default_pasid,
@@ -1655,6 +1685,21 @@ static void domain_flush_piotlb(struct intel_iommu *iommu,
 
 	if (!list_empty(&domain->devices))
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
+
+	if (list_empty(&domain->devices) || xa_empty(&domain->pasids))
+		return;
+
+	/*
+	 * Flush IOTLBs for all the PASIDs attached to this domain, RID2PASID
+	 * included.
+	 * TODO: If there are many PASIDs, we may resort to flush with
+	 * domain ID which may have performance benefits due to fewer
+	 * invalidation descriptors. VM exits may be reduced when running on
+	 * vIOMMU. The current use cases utilize no more than 2 PASIDs per
+	 * device, i.e. RID2PASID and a kernel DMA API PASID.
+	 */
+	xa_for_each(&domain->pasids, pasid, pinfo)
+		qi_flush_piotlb(iommu, did, pasid, addr, npages, ih);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1902,6 +1947,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->subdevices);
+	xa_init(&domain->pasids);
 
 	return domain;
 }
@@ -2556,6 +2602,144 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
+
+static bool is_device_domain_attached(struct dmar_domain *dmar_domain,
+				      struct device *dev)
+{
+	struct device_domain_info *info;
+
+	list_for_each_entry(info, &dmar_domain->devices, link) {
+		if (info->dev == dev)
+			return true;
+	}
+
+	return false;
+}
+
+static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
+					struct device *dev, ioasid_t pasid)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info = get_domain_info(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct pasid_info *pinfo;
+	unsigned long flags;
+	int ret = 0;
+	void *entry;
+
+	if (!info)
+		return -ENODEV;
+	/*
+	 * Allow attaching kernel PASIDs only after the device is already attached
+	 * with RID2PASID, which is used for legacy DMA.
+	 */
+	if (pasid != PASID_RID2PASID && !is_device_domain_attached(dmar_domain, dev)) {
+		dev_err(dev, "Device not attached, must attach device before PASID!\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * The same PASID from the same device can only attach to this domain
+	 * once. PASID table is per device. NULL entry is not allowed in the
+	 * device-domain xarray.
+	 */
+	entry = xa_load(&info->pasids, pasid);
+	if (entry) {
+		dev_err(dev, "PASID %d already attached!\n", pasid);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+	if (hw_pass_through && domain_type_is_si(info->domain))
+		ret = intel_pasid_setup_pass_through(info->iommu, info->domain,
+						     dev, pasid);
+	else if (domain_use_first_level(dmar_domain))
+		ret = domain_setup_first_level(iommu, dmar_domain, dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain, dev, pasid);
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+	if (ret)
+		return ret;
+
+	xa_lock(&dmar_domain->pasids);
+	/*
+	 * Each domain could have multiple devices attached with shared or per
+	 * device PASIDs. At the domain level, we keep track of unique PASIDs and
+	 * device user count.
+	 * E.g. If a domain has two devices attached, device A has PASID 0, 1;
+	 * device B has PASID 0, 2. Then the domain would have PASID 0, 1, 2.
+	 */
+	entry = xa_load(&dmar_domain->pasids, pasid);
+	if (entry) {
+		pinfo = entry;
+	} else {
+		pinfo = kzalloc(sizeof(*pinfo), GFP_ATOMIC);
+		if (!pinfo)
+			return -ENOMEM;
+		pinfo->pasid = pasid;
+		/* Store the new PASID info in the per domain array */
+		ret = xa_err(__xa_store(&dmar_domain->pasids, pasid, pinfo,
+			     GFP_ATOMIC));
+		if (ret)
+			goto xa_store_err;
+	}
+	/* Store PASID in per device-domain array, this is for tracking devTLB */
+	ret = xa_err(xa_store(&info->pasids, pasid, pinfo, GFP_ATOMIC));
+	if (ret)
+		goto xa_store_err;
+
+	atomic_inc(&pinfo->users);
+	xa_unlock(&dmar_domain->pasids);
+
+	return 0;
+
+xa_store_err:
+	xa_unlock(&dmar_domain->pasids);
+	spin_lock_irqsave(&iommu->lock, flags);
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	if (!atomic_read(&pinfo->users)) {
+		__xa_erase(&dmar_domain->pasids, pasid);
+		kfree(pinfo);
+	}
+	return ret;
+}
+
+static void intel_iommu_detach_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info = get_domain_info(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	struct pasid_info *pinfo;
+
+	if (WARN_ON(!is_device_domain_attached(dmar_domain, dev)))
+		return;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	xa_lock(&dmar_domain->pasids);
+	pinfo = xa_load(&dmar_domain->pasids, pasid);
+	if (!pinfo) {
+		dev_err(dev, "PASID %d not attached!\n", pasid);
+		xa_unlock(&dmar_domain->pasids);
+		return;
+	}
+
+	xa_erase(&info->pasids, pasid);
+	if (atomic_dec_and_test(&pinfo->users)) {
+		__xa_erase(&dmar_domain->pasids, pasid);
+		kfree(pinfo);
+	}
+	xa_unlock(&dmar_domain->pasids);
+}
+
 static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    int bus, int devfn,
 						    struct device *dev,
@@ -2590,6 +2774,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->pasid_table = NULL;
 	info->auxd_enabled = 0;
 	INIT_LIST_HEAD(&info->subdevices);
+	xa_init(&info->pasids);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5165,6 +5350,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
+
 static void intel_iommu_get_resv_regions(struct device *device,
 					 struct list_head *head)
 {
@@ -5491,6 +5677,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.enable_nesting		= intel_iommu_enable_nesting,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
+	.attach_dev_pasid       = intel_iommu_attach_dev_pasid,
+	.detach_dev_pasid       = intel_iommu_detach_dev_pasid,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
 	.aux_detach_dev		= intel_iommu_aux_detach_device,
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 82955524fad8..3f4c98f170ec 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -567,7 +567,7 @@ struct dmar_domain {
 					 * The default pasid used for non-SVM
 					 * traffic on mediated devices.
 					 */
-
+	struct xarray	pasids;		/* Tracks the PASIDs attached to this domain */
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
@@ -628,6 +628,15 @@ struct subdev_domain_info {
 	int users;			/* user count */
 };
 
+struct pasid_info {
+	struct device_domain_info *info;
+	ioasid_t pasid;
+	atomic_t users;			/* Count the number of devices attached
+					 * with the PASID
+					 */
+	u32 flags;			/* permission and other attributes */
+};
+
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
@@ -650,6 +659,7 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	struct xarray pasids; /* PASIDs attached to this domain-device */
 };
 
 static inline void __iommu_flush_cache(
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
