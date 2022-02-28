Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F517C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 00:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6D1C40556;
	Mon, 28 Feb 2022 00:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ai-1YKivTMS5; Mon, 28 Feb 2022 00:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ECBF3400C6;
	Mon, 28 Feb 2022 00:52:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4BADC0077;
	Mon, 28 Feb 2022 00:52:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6D21C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 00:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95A1560D7B
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 00:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCw8kapD-Zp7 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 00:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C37F60D79
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 00:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646009567; x=1677545567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YgSh5+zkpRoIJgCE/g6wcfO+mwq/lO0z+otlloGUuI4=;
 b=I4OKDOH5W588PmnnaDUJlA5jFQfM2Tgf72tdISBeOgJydeDBldaOtrip
 AGDrru18xlz4BY0DyVezMdC4FNBzCKdwIBr3p86TNoA8WKtoTprlPOwkB
 w+snPREkm/Mey4raJ586Yeqo8WGbBBWjDlrBZkmRC3yLuwYBun4ZVXGWs
 iXdLN81e2ZhX+rLtTLqS6N17F7rKsM+yrvLk+Mbp5wVRiAuDfyVcGBL2M
 3TvOhx1dCEnEkt8aAavUeiXKRfBYmaTM3AXwy11VMaaSewho10pcKjjJ9
 fNqgWEeMTeYSqti1NEM4KsF4VP5TQeOVXaiDUDdhZh8CyIr3KW5f1Avfx w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="313492951"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="313492951"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2022 16:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="550020142"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 27 Feb 2022 16:52:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
Date: Mon, 28 Feb 2022 08:50:46 +0800
Message-Id: <20220228005056.599595-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228005056.599595-1-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
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

Multiple devices may be placed in the same IOMMU group because they
cannot be isolated from each other. These devices must either be
entirely under kernel control or userspace control, never a mixture.

This adds dma ownership management in iommu core and exposes several
interfaces for the device drivers and the device userspace assignment
framework (i.e. VFIO), so that any conflict between user and kernel
controlled dma could be detected at the beginning.

The device driver oriented interfaces are,

	int iommu_device_use_default_domain(struct device *dev);
	void iommu_device_unuse_default_domain(struct device *dev);

By calling iommu_device_use_default_domain(), the device driver tells
the iommu layer that the device dma is handled through the kernel DMA
APIs. The iommu layer will manage the IOVA and use the default domain
for DMA address translation.

The device user-space assignment framework oriented interfaces are,

	int iommu_group_claim_dma_owner(struct iommu_group *group,
					void *owner);
	void iommu_group_release_dma_owner(struct iommu_group *group);
	bool iommu_group_dma_owner_claimed(struct iommu_group *group);

The device userspace assignment must be disallowed if the DMA owner
claiming interface returns failure.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  31 +++++++++
 drivers/iommu/iommu.c | 153 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..77972ef978b5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -675,6 +675,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
+int iommu_device_use_default_domain(struct device *dev);
+void iommu_device_unuse_default_domain(struct device *dev);
+
+int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
+void iommu_group_release_dma_owner(struct iommu_group *group);
+bool iommu_group_dma_owner_claimed(struct iommu_group *group);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1031,6 +1038,30 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
 }
+
+static inline int iommu_device_use_default_domain(struct device *dev)
+{
+	return 0;
+}
+
+static inline void iommu_device_unuse_default_domain(struct device *dev)
+{
+}
+
+static inline int
+iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_group_release_dma_owner(struct iommu_group *group)
+{
+}
+
+static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..eba8e8ccf19d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,8 @@ struct iommu_group {
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
+	unsigned int owner_cnt;
+	void *owner;
 };
 
 struct group_device {
@@ -294,7 +296,11 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
 
-	if (group->default_domain) {
+	/*
+	 * If device joined an existing group which has been claimed, don't
+	 * attach the default domain.
+	 */
+	if (group->default_domain && !group->owner) {
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
@@ -2109,7 +2115,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -2146,7 +2152,11 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (!group->default_domain) {
+	/*
+	 * If the group has been claimed already, do not re-attach the default
+	 * domain.
+	 */
+	if (!group->default_domain || group->owner) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
 		group->domain = NULL;
@@ -3095,3 +3105,140 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	return ret;
 }
+
+/**
+ * iommu_device_use_default_domain() - Device driver wants to handle device
+ *                                     DMA through the kernel DMA API.
+ * @dev: The device.
+ *
+ * The device driver about to bind @dev wants to do DMA through the kernel
+ * DMA API. Return 0 if it is allowed, otherwise an error.
+ */
+int iommu_device_use_default_domain(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	int ret = 0;
+
+	if (!group)
+		return 0;
+
+	mutex_lock(&group->mutex);
+	if (group->owner_cnt) {
+		if (group->domain != group->default_domain ||
+		    group->owner) {
+			ret = -EBUSY;
+			goto unlock_out;
+		}
+	}
+
+	group->owner_cnt++;
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+/**
+ * iommu_device_unuse_default_domain() - Device driver stops handling device
+ *                                       DMA through the kernel DMA API.
+ * @dev: The device.
+ *
+ * The device driver doesn't want to do DMA through kernel DMA API anymore.
+ * It must be called after iommu_device_use_default_domain().
+ */
+void iommu_device_unuse_default_domain(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	if (!group)
+		return;
+
+	mutex_lock(&group->mutex);
+	if (!WARN_ON(!group->owner_cnt))
+		group->owner_cnt--;
+
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
+/**
+ * iommu_group_claim_dma_owner() - Set DMA ownership of a group
+ * @group: The group.
+ * @owner: Caller specified pointer. Used for exclusive ownership.
+ *
+ * This is to support backward compatibility for vfio which manages
+ * the dma ownership in iommu_group level. New invocations on this
+ * interface should be prohibited.
+ */
+int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
+{
+	int ret = 0;
+
+	mutex_lock(&group->mutex);
+	if (group->owner_cnt) {
+		ret = -EPERM;
+		goto unlock_out;
+	} else {
+		if (group->domain && group->domain != group->default_domain) {
+			ret = -EBUSY;
+			goto unlock_out;
+		}
+
+		group->owner = owner;
+		if (group->domain)
+			__iommu_detach_group(group->domain, group);
+	}
+
+	group->owner_cnt++;
+unlock_out:
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
+
+/**
+ * iommu_group_release_dma_owner() - Release DMA ownership of a group
+ * @group: The group.
+ *
+ * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
+ */
+void iommu_group_release_dma_owner(struct iommu_group *group)
+{
+	mutex_lock(&group->mutex);
+	if (WARN_ON(!group->owner_cnt || !group->owner))
+		goto unlock_out;
+
+	group->owner_cnt = 0;
+	/*
+	 * The UNMANAGED domain should be detached before all USER
+	 * owners have been released.
+	 */
+	if (!WARN_ON(group->domain) && group->default_domain)
+		__iommu_attach_group(group->default_domain, group);
+	group->owner = NULL;
+unlock_out:
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
+
+/**
+ * iommu_group_dma_owner_claimed() - Query group dma ownership status
+ * @group: The group.
+ *
+ * This provides status query on a given group. It is racy and only for
+ * non-binding status reporting.
+ */
+bool iommu_group_dma_owner_claimed(struct iommu_group *group)
+{
+	unsigned int user;
+
+	mutex_lock(&group->mutex);
+	user = group->owner_cnt;
+	mutex_unlock(&group->mutex);
+
+	return user;
+}
+EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
