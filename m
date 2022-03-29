Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF1C433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 05:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E093460B2A;
	Tue, 29 Mar 2022 05:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zvLQbVYSgaT8; Tue, 29 Mar 2022 05:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E3DC60A9D;
	Tue, 29 Mar 2022 05:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78033C001D;
	Tue, 29 Mar 2022 05:40:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25248C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1243640520
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwic0A1vCptN for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 05:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 579F3404F1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648532427; x=1680068427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WKkLvCTT03BDHMi45GzO4KtUhX/7xVoo1Mlm4MxAfn4=;
 b=i7ahvYNNqwRBdu/KfJCj73hH/YOB9TZQJJvYQoAEufDzLdnND6GPfyTv
 TJ3+kmKVkePE35+SZE1tOZ9BeH9rfLch/64pGqMIPCCTsCO0GAf8Lhn7l
 SjS3qla8AZ0wYqQlSGtDBnn0Z1cmmInEzTO/OaFobBY9ZsoU3fWcwdnC/
 f1C0i58mFkm+PeqodcMgUbFyKuDJYHtgSx4xC34PpPlV9SrjOEZHizwSe
 ayhgGae5iAeP3eF46meEr3TX39oCo0CTgaOZB5F0tSugcJACwRtdIHfxn
 Kyt2uiunn674tul55sU1K0RmvNxQYsEGETUgZLi+yE5oSl7PCC4VX4Bz1 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239099127"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="239099127"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 22:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="694603599"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v2 04/11] iommu: Add attach/detach_dev_pasid domain ops
Date: Tue, 29 Mar 2022 13:37:53 +0800
Message-Id: <20220329053800.3049561-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

This adds a pair of common domain ops for this purpose and adds some
common helpers to attach/detach a domain to/from a {device, PASID} and
get/put the domain attached to {device, PASID}.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 36 ++++++++++++++++++
 drivers/iommu/iommu.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29c4c2edd706..a46285488a57 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -269,6 +269,8 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @attach_dev_pasid: attach an iommu domain to a pasid of device
+ * @detach_dev_pasid: detach an iommu domain from a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -286,6 +288,10 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*attach_dev_pasid)(struct iommu_domain *domain,
+				struct device *dev, ioasid_t id);
+	void (*detach_dev_pasid)(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t id);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -679,6 +685,14 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
+void iommu_put_domain_for_dev_pasid(struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1047,6 +1061,28 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
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
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
+
+static inline void
+iommu_put_domain_for_dev_pasid(struct iommu_domain *domain)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9fb8a5b4491e..8163ad7f6902 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,8 @@
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
 
+#include "iommu-sva-lib.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
@@ -38,6 +40,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -631,6 +634,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -3173,3 +3177,87 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -EINVAL;
+	void *curr;
+
+	if (!domain->ops->attach_dev_pasid)
+		return -EINVAL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	/*
+	 * To keep things simple, we currently don't support IOMMU groups
+	 * with more than one device. Existing SVA-capable systems are not
+	 * affected by the problems that required IOMMU groups (lack of ACS
+	 * isolation, device ID aliasing and other hardware issues).
+	 */
+	if (!iommu_group_singleton_lockdown(group))
+		goto out_unlock;
+
+	xa_lock(&group->pasid_array);
+	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
+			    domain, GFP_KERNEL);
+	xa_unlock(&group->pasid_array);
+	if (curr)
+		goto out_unlock;
+
+	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
+
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
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (WARN_ON(!group))
+		return;
+
+	mutex_lock(&group->mutex);
+	domain->ops->detach_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+
+	mutex_lock(&group->mutex);
+	domain = xa_load(&group->pasid_array, pasid);
+	if (domain && domain->type == IOMMU_DOMAIN_SVA)
+		iommu_sva_domain_get_user(domain);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return domain;
+}
+
+void iommu_put_domain_for_dev_pasid(struct iommu_domain *domain)
+{
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		iommu_sva_domain_put_user(domain);
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
