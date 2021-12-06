Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89D7C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 02:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6749760A80;
	Mon,  6 Dec 2021 02:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYKvtOpH08O7; Mon,  6 Dec 2021 02:00:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C2E360746;
	Mon,  6 Dec 2021 02:00:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28379C001E;
	Mon,  6 Dec 2021 02:00:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA9B4C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8FF84044A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q-1LCunAbkhc for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 02:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6C8340445
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224099127"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="224099127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 18:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514542525"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 18:00:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 12/18] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
Date: Mon,  6 Dec 2021 09:58:57 +0800
Message-Id: <20211206015903.88687-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206015903.88687-1-baolu.lu@linux.intel.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
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
 include/linux/iommu.h | 13 +++++++++
 drivers/iommu/iommu.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index afcc07bc8d41..8c81ba11ae8c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -705,6 +705,8 @@ int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner ow
 			      void *owner_cookie);
 void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
 bool iommu_group_dma_owner_unclaimed(struct iommu_group *group);
+int iommu_attach_device_shared(struct iommu_domain *domain, struct device *dev);
+void iommu_detach_device_shared(struct iommu_domain *domain, struct device *dev);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -745,11 +747,22 @@ static inline int iommu_attach_device(struct iommu_domain *domain,
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
index 423197db99a9..6dc6e6ad6069 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -50,6 +50,7 @@ struct iommu_group {
 	struct list_head entry;
 	enum iommu_dma_owner dma_owner;
 	refcount_t owner_cnt;
+	refcount_t attach_cnt;
 	void *owner_cookie;
 };
 
@@ -2026,6 +2027,41 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
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
+	if (refcount_inc_not_zero(&group->attach_cnt)) {
+		if (group->domain != domain ||
+		    (group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN &&
+		     group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER)) {
+			refcount_dec(&group->attach_cnt);
+			ret = -EBUSY;
+		}
+
+		goto unlock_out;
+	}
+
+	ret = __iommu_attach_group(domain, group);
+	if (ret)
+		goto unlock_out;
+
+	refcount_set(&group->attach_cnt, 1);
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_attach_device_shared);
+
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
 	const struct iommu_ops *ops = domain->ops;
@@ -2281,6 +2317,31 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
+void iommu_detach_device_shared(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return;
+
+	mutex_lock(&group->mutex);
+	if (WARN_ON(group->domain != domain ||
+		    (group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN &&
+		     group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER)))
+		goto unlock_out;
+
+	if (refcount_dec_and_test(&group->attach_cnt)) {
+		__iommu_detach_group(domain, group);
+		group->dma_owner = DMA_OWNER_NONE;
+	}
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_device_shared);
+
 struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
 	struct iommu_domain *domain;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
