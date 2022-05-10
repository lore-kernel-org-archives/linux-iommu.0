Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC9C4332F
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 06:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A4578195D;
	Tue, 10 May 2022 06:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkpioz0w0rCz; Tue, 10 May 2022 06:21:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 447278194C;
	Tue, 10 May 2022 06:21:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E55D8C0039;
	Tue, 10 May 2022 06:21:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27809C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE85E8199D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yguZG9HKsLtt for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 06:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 054158195D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652163670; x=1683699670;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SkuWVMiahK5jbVuor3KDnHkiDiZb/OYULE9ThL5dTD0=;
 b=loJAb1Y9//U5iBpwbZqTxHnLQRsnu2QZvVMzTDC0/BAj8u6fk0Cu0n4m
 DPN5wz+uyeznMIbKSQ4v2noP+UMImHBceB3/eB3M9yukINkpz1lZKmdFs
 sw3ZCeBsPKN9RXVZ8h4ne4GKufuLUfQyTImbWrO4SU5Gv/aEi5RWIut4J
 D+RUWan2VKJm48Tc/qWySfOnQyBD7ERyW1nqzJH/lE+qWeLsOfcmX4sZB
 uYK9HV80ZCPjAZMzw1QsXfTpJgp8f42fOkftrBdrAV/S/H8eKiv/mp71m
 cRwgj+mefS2U/GtHCC8JxFbCy33HqRoX6GNZfsur2jobtBm+dzCZxJ9LJ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266863675"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266863675"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 23:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="552636397"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:20:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Date: Tue, 10 May 2022 14:17:29 +0800
Message-Id: <20220510061738.2761430-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

 - SVA (Shared Virtual Address)
 - kernel DMA with PASID
 - hardware-assist mediated device

This adds a pair of common domain ops for this purpose and adds helpers
to attach/detach a domain to/from a {device, PASID}. Some buses, like
PCI, route packets without considering the PASID value. Thus a DMA target
address with PASID might be treated as P2P if the address falls into the
MMIO BAR of other devices in the group. To make things simple, these
interfaces only apply to devices belonging to the singleton groups, and
the singleton is immutable in fabric i.e. not affected by hotplug.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 21 +++++++++++++
 drivers/iommu/iommu.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b8ffaf2cb1d0..ab36244d4e94 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -263,6 +263,8 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @attach_dev_pasid: attach an iommu domain to a pasid of device
+ * @detach_dev_pasid: detach an iommu domain from a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -283,6 +285,10 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*attach_dev_pasid)(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid);
+	void (*detach_dev_pasid)(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t pasid);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -678,6 +684,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1051,6 +1061,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
+					     struct device *dev, ioasid_t pasid)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29906bc16371..16e8db2d86fc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -38,6 +38,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -630,6 +631,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -3190,3 +3192,72 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+static bool device_group_immutable_singleton(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	int count;
+
+	if (!group)
+		return false;
+
+	mutex_lock(&group->mutex);
+	count = iommu_group_device_count(group);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	if (count != 1)
+		return false;
+
+	/*
+	 * The PCI device could be considered to be fully isolated if all
+	 * devices on the path from the device to the host-PCI bridge are
+	 * protected from peer-to-peer DMA by ACS.
+	 */
+	if (dev_is_pci(dev))
+		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
+					    REQ_ACS_FLAGS);
+
+	return true;
+}
+
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -EINVAL;
+	void *curr;
+
+	if (!domain->ops->attach_dev_pasid)
+		return -EOPNOTSUPP;
+
+	if (!device_group_immutable_singleton(dev))
+		return -EINVAL;
+
+	group = iommu_group_get(dev);
+	mutex_lock(&group->mutex);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr)
+		goto out_unlock;
+	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	domain->ops->detach_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
