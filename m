Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E866C433FE
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 06:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0CB583F9A;
	Fri, 17 Dec 2021 06:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zkhd_rkPJR4b; Fri, 17 Dec 2021 06:38:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2A0384B3A;
	Fri, 17 Dec 2021 06:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9E7C002F;
	Fri, 17 Dec 2021 06:38:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0855CC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAE2B84B3B
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUFZdMD05xcl for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 06:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4478584B3A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239642403"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="239642403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 22:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="519623260"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 22:38:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v4 06/13] iommu: Expose group variants of dma ownership
 interfaces
Date: Fri, 17 Dec 2021 14:37:01 +0800
Message-Id: <20211217063708.1740334-7-baolu.lu@linux.intel.com>
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

The vfio needs to set DMA_OWNER_PRIVATE_DOMAIN_USER for the entire group
when attaching it to a vfio container. Expose group variants of setting/
releasing dma ownership for this purpose.

This also exposes the helper iommu_group_dma_owner_unclaimed() for vfio
to report to userspace if the group is viable to user assignment for
compatibility with VFIO_GROUP_FLAGS_VIABLE.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 21 +++++++++++++++++++
 drivers/iommu/iommu.c | 47 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 53a023ee1ac0..5ad4cf13370d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -699,6 +699,10 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 int iommu_device_set_dma_owner(struct device *dev, enum iommu_dma_owner owner,
 			       void *owner_cookie);
 void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner owner);
+int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
+			      void *owner_cookie);
+void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
+bool iommu_group_dma_owner_unclaimed(struct iommu_group *group);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1115,6 +1119,23 @@ static inline void iommu_device_release_dma_owner(struct device *dev,
 						  enum iommu_dma_owner owner)
 {
 }
+
+static inline int iommu_group_set_dma_owner(struct iommu_group *group,
+					    enum iommu_dma_owner owner,
+					    void *owner_cookie)
+{
+	return -EINVAL;
+}
+
+static inline void iommu_group_release_dma_owner(struct iommu_group *group,
+						 enum iommu_dma_owner owner)
+{
+}
+
+static inline bool iommu_group_dma_owner_unclaimed(struct iommu_group *group)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 573e253bad51..8bec71b1cc18 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3365,9 +3365,19 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret;
 }
 
-static int iommu_group_set_dma_owner(struct iommu_group *group,
-				     enum iommu_dma_owner owner,
-				     void *owner_cookie)
+/**
+ * iommu_group_set_dma_owner() - Set DMA ownership of a group
+ * @group: The group.
+ * @owner: DMA owner type.
+ * @owner_cookie: Caller specified pointer. Could be used for exclusive
+ *                declaration. Could be NULL.
+ *
+ * This is to support backward compatibility for legacy vfio which manages
+ * dma ownership in group level. New invocations on this interface should be
+ * prohibited. Instead, please turn to iommu_device_set_dma_owner().
+ */
+int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
+			      void *owner_cookie)
 {
 	int ret = 0;
 
@@ -3398,9 +3408,16 @@ static int iommu_group_set_dma_owner(struct iommu_group *group,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_group_set_dma_owner);
 
-static void iommu_group_release_dma_owner(struct iommu_group *group,
-					  enum iommu_dma_owner owner)
+/**
+ * iommu_group_release_dma_owner() - Release DMA ownership of a group
+ * @group: The group.
+ * @owner: DMA owner type.
+ *
+ * Release the DMA ownership claimed by iommu_group_set_dma_owner().
+ */
+void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner)
 {
 	mutex_lock(&group->mutex);
 	if (WARN_ON(!group->owner_cnt || group->dma_owner != owner))
@@ -3423,6 +3440,26 @@ static void iommu_group_release_dma_owner(struct iommu_group *group,
 unlock_out:
 	mutex_unlock(&group->mutex);
 }
+EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
+
+/**
+ * iommu_group_dma_owner_unclaimed() - Is group dma ownership claimed
+ * @group: The group.
+ *
+ * This provides status check on a given group. It is racey and only for
+ * non-binding status reporting.
+ */
+bool iommu_group_dma_owner_unclaimed(struct iommu_group *group)
+{
+	unsigned int user;
+
+	mutex_lock(&group->mutex);
+	user = group->owner_cnt;
+	mutex_unlock(&group->mutex);
+
+	return !user;
+}
+EXPORT_SYMBOL_GPL(iommu_group_dma_owner_unclaimed);
 
 /**
  * iommu_device_set_dma_owner() - Set DMA ownership of a device
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
