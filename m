Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8635FC433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 06:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4434D84B3A;
	Fri, 17 Dec 2021 06:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X8ar0cq-6QxG; Fri, 17 Dec 2021 06:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08B5683F9A;
	Fri, 17 Dec 2021 06:38:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA043C002F;
	Fri, 17 Dec 2021 06:38:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9B1CC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B83E084B3A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9v7QfvB19kp7 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 06:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14BEE83F9A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237232486"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="237232486"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 22:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="519623298"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 22:38:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
Date: Fri, 17 Dec 2021 14:37:02 +0800
Message-Id: <20211217063708.1740334-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

The iommu_attach/detach_device() interfaces were exposed for the device
drivers to attach/detach their own domains. The commit <426a273834eae>
("iommu: Limit iommu_attach/detach_device to device with their own group")
restricted them to singleton groups to avoid different device in a group
attaching different domain.

As we've introduced device DMA ownership into the iommu core. We can now
introduce interfaces for muliple-device groups, and "all devices are in the
same address space" is still guaranteed.

The iommu_attach/detach_device_shared() could be used when multiple drivers
sharing the group claim the DMA_OWNER_PRIVATE_DOMAIN ownership. The first
call of iommu_attach_device_shared() attaches the domain to the group.
Other drivers could join it later. The domain will be detached from the
group after all drivers unjoin it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/iommu.h | 13 +++++++
 drivers/iommu/iommu.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5ad4cf13370d..1bc03118dfb3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -703,6 +703,8 @@ int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner ow
 			      void *owner_cookie);
 void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
 bool iommu_group_dma_owner_unclaimed(struct iommu_group *group);
+int iommu_attach_device_shared(struct iommu_domain *domain, struct device *dev);
+void iommu_detach_device_shared(struct iommu_domain *domain, struct device *dev);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -743,11 +745,22 @@ static inline int iommu_attach_device(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline int iommu_attach_device_shared(struct iommu_domain *domain,
+					     struct device *dev)
+{
+	return -ENODEV;
+}
+
 static inline void iommu_detach_device(struct iommu_domain *domain,
 				       struct device *dev)
 {
 }
 
+static inline void iommu_detach_device_shared(struct iommu_domain *domain,
+					      struct device *dev)
+{
+}
+
 static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
 	return NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8bec71b1cc18..3ad66cb9bedc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -50,6 +50,7 @@ struct iommu_group {
 	struct list_head entry;
 	enum iommu_dma_owner dma_owner;
 	unsigned int owner_cnt;
+	unsigned int attach_cnt;
 	void *owner_cookie;
 };
 
@@ -3512,3 +3513,81 @@ void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner own
 	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_device_release_dma_owner);
+
+/**
+ * iommu_attach_device_shared() - Attach shared domain to a device
+ * @domain: The shared domain.
+ * @dev: The device.
+ *
+ * Similar to iommu_attach_device(), but allowed for shared-group devices
+ * and guarantees that all devices in an iommu group could only be attached
+ * by a same iommu domain. The caller should explicitly set the dma ownership
+ * of DMA_OWNER_PRIVATE_DOMAIN or DMA_OWNER_PRIVATE_DOMAIN_USER type before
+ * calling it and use the paired helper iommu_detach_device_shared() for
+ * cleanup.
+ */
+int iommu_attach_device_shared(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_group *group;
+	int ret = 0;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	if (group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN &&
+	    group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER) {
+		ret = -EPERM;
+		goto unlock_out;
+	}
+
+	if (group->attach_cnt) {
+		if (group->domain != domain) {
+			ret = -EBUSY;
+			goto unlock_out;
+		}
+	} else {
+		ret = __iommu_attach_group(domain, group);
+		if (ret)
+			goto unlock_out;
+	}
+
+	group->attach_cnt++;
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_attach_device_shared);
+
+/**
+ * iommu_detach_device_shared() - Detach a domain from device
+ * @domain: The domain.
+ * @dev: The device.
+ *
+ * The detach helper paired with iommu_attach_device_shared().
+ */
+void iommu_detach_device_shared(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return;
+
+	mutex_lock(&group->mutex);
+	if (WARN_ON(!group->attach_cnt || group->domain != domain ||
+		    (group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN &&
+		     group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER)))
+		goto unlock_out;
+
+	if (--group->attach_cnt == 0)
+		__iommu_detach_group(domain, group);
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_device_shared);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
