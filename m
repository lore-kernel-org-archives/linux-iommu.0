Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C22BC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 03:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5C8E60B8D;
	Tue, 14 Jun 2022 03:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYEvISFIFn2V; Tue, 14 Jun 2022 03:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 50EF460B64;
	Tue, 14 Jun 2022 03:48:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 286EAC0039;
	Tue, 14 Jun 2022 03:48:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0800DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 03:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA2734148A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 03:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zbw75-ZCU9c2 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 03:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27CEB410E9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 03:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655178491; x=1686714491;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Z+homL9TlDoNnTKO1TKyZ126CI6TtWdfO0J6BkijQUY=;
 b=fANGNJHfySYznfRDJx8xfMIeUn9w7LTNXfOQ1c2MrIu1fqtZFrjdXDtS
 yfT3l2J2ZIUQP1ZjmOuoI+6eULFbYSvImGptwnoqsA0gT1cedh7GDyt0R
 fh8YHziu2frVuDfjyF+qu5JC3wu2dzxuWEQk6e9kfnYhYS+fpJv0xOrLM
 bpsjrKtxOsAbd6p2l5oiPMjhXPc+VBCKjvX+kAugHYxut5VXDemvuhhAo
 0+CuHsAVAk5wVnf0F5XrreFr5V+F+W6inmjyvKFMb/Sx7n29qtETD9tPT
 ZqeJrrbdE627l7leju4zBO5CvwKOKM6SkTU8R8uQxfnBRK8euI9i6gqj2 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279535621"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="279535621"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 20:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="830154109"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 20:48:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default domain
Date: Tue, 14 Jun 2022 11:44:11 +0800
Message-Id: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-kernel@vger.kernel.org
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

This allows the upper layers to set a domain to a PASID of a device
if the PASID feature is supported by the IOMMU hardware. The typical
use cases are, for example, kernel DMA with PASID and hardware
assisted mediated device drivers.

The attaching device and pasid information is tracked in a per-domain
list and is used for IOTLB and devTLB invalidation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |   8 +++
 drivers/iommu/intel/iommu.c | 118 +++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

---
Note: This is a follow-up of this patch:
https://lore.kernel.org/linux-iommu/20220607014942.3954894-4-baolu.lu@linux.intel.com/
which, removed the SVM_FLAG_SUPERVISOR_MODE support from the IOMMU SVA
interface and recommended the device driver to handle kernel DMA with
PASID through the kernel DMA APIs. It is nothing new anyway. It's
a simplified version of the previous callbacks which have existed in
the tree for more than one year. Those callbacks have been removed by
commit 241469685d8d ("iommu/vt-d: Remove aux-domain related callbacks")
in order for the new iommufd framework.

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2dd4c5193cc1..a703e0768f47 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,6 +541,7 @@ struct dmar_domain {
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
+	struct list_head subdevices;	/* all subdevices' list */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
@@ -626,6 +627,13 @@ struct device_domain_info {
 	struct pasid_table *pasid_table; /* pasid table */
 };
 
+/* PCI domain-subdevice relationship */
+struct subdev_domain_info {
+	struct list_head link_domain;	/* link to domain siblings */
+	struct device *dev;		/* physical device derived from */
+	ioasid_t pasid;			/* PASID on physical device */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index aeeb1185d397..6eced9e87cda 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1393,6 +1393,7 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
+	struct subdev_domain_info *sinfo;
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 
@@ -1403,6 +1404,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 			break;
 		}
 	}
+
+	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
+		info = dev_iommu_priv_get(sinfo->dev);
+		if (info->ats_enabled) {
+			has_iotlb_device = true;
+			break;
+		}
+	}
 	domain->has_iotlb_device = has_iotlb_device;
 	spin_unlock(&domain->lock);
 }
@@ -1495,6 +1504,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
+	struct subdev_domain_info *sinfo;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
@@ -1503,6 +1513,35 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
+
+	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
+		info = dev_iommu_priv_get(sinfo->dev);
+		qi_flush_dev_iotlb_pasid(info->iommu,
+					 PCI_DEVID(info->bus, info->devfn),
+					 info->pfsid, sinfo->pasid,
+					 info->ats_qdep, addr,
+					 mask);
+	}
+	spin_unlock(&domain->lock);
+}
+
+/*
+ * The VT-d spec requires to use PASID-based-IOTLB Invalidation to invalidate
+ * IOTLB and the paging-structure-caches for a first-level page table.
+ */
+static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
+				     struct dmar_domain *domain, u64 addr,
+				     unsigned long npages, bool ih)
+{
+	u16 did = domain->iommu_did[iommu->seq_id];
+	struct subdev_domain_info *sinfo;
+
+	spin_lock(&domain->lock);
+	list_for_each_entry(sinfo, &domain->subdevices, link_domain)
+		qi_flush_piotlb(iommu, did, sinfo->pasid, addr, npages, ih);
+
+	if (!list_empty(&domain->devices))
+		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
 	spin_unlock(&domain->lock);
 }
 
@@ -1522,7 +1561,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain_use_first_level(domain)) {
-		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1591,7 +1630,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = dmar_domain->iommu_did[iommu->seq_id];
 
 		if (domain_use_first_level(dmar_domain))
-			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
+			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1763,6 +1802,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->subdevices);
 	spin_lock_init(&domain->lock);
 
 	return domain;
@@ -4789,6 +4829,78 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
+					   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct subdev_domain_info *sinfo;
+	int ret;
+
+	if (!pasid_supported(iommu))
+		return -ENODEV;
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret)
+		goto out_free_sinfo;
+
+	if (domain_use_first_level(dmar_domain))
+		ret = domain_setup_first_level(iommu, dmar_domain, dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu,
+						     dmar_domain, dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
+	sinfo->dev = dev;
+	sinfo->pasid = pasid;
+	spin_lock(&dmar_domain->lock);
+	list_add(&sinfo->link_domain, &dmar_domain->subdevices);
+	spin_unlock(&dmar_domain->lock);
+
+	return 0;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free_sinfo:
+	kfree(sinfo);
+	return ret;
+}
+
+static void intel_iommu_detach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct subdev_domain_info *i, *n, *sinfo = NULL;
+	struct intel_iommu *iommu = info->iommu;
+
+	spin_lock(&dmar_domain->lock);
+	list_for_each_entry_safe(i, n, &dmar_domain->subdevices, link_domain) {
+		if (i->dev == dev && i->pasid == pasid) {
+			list_del(&i->link_domain);
+			sinfo = i;
+			break;
+		}
+	}
+	spin_unlock(&dmar_domain->lock);
+
+	if (WARN_ON(!sinfo))
+		return;
+
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	domain_detach_iommu(dmar_domain, iommu);
+	kfree(sinfo);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4809,6 +4921,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
 		.detach_dev		= intel_iommu_detach_device,
+		.set_dev_pasid		= intel_iommu_attach_device_pasid,
+		.block_dev_pasid	= intel_iommu_detach_device_pasid,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
