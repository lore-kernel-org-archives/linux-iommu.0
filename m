Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76783C43217
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 02:11:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408E5611C1
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 02:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 408E5611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20D2060704;
	Mon, 15 Nov 2021 02:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ySyrUrk6fyl8; Mon, 15 Nov 2021 02:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F30FF606F7;
	Mon, 15 Nov 2021 02:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1674C002E;
	Mon, 15 Nov 2021 02:10:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E0FC0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 02:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 652DB40278
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 02:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIIFLduBz1qP for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 02:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9B0F40255
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 02:10:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230825912"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; d="scan'208";a="230825912"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2021 18:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; d="scan'208";a="505714623"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 14 Nov 2021 18:10:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 06/11] iommu: Expose group variants of dma ownership interfaces
Date: Mon, 15 Nov 2021 10:05:47 +0800
Message-Id: <20211115020552.2378167-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org, rafael@kernel.org,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>
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

The vfio needs to set DMA_OWNER_USER for the entire group when attaching
it to a vfio container. So expose group variants of setting/releasing dma
ownership for this purpose.

This also exposes the helper iommu_group_dma_owner_unclaimed() for vfio
report to userspace if the group is viable to user assignment, for
compatibility with VFIO_GROUP_FLAGS_VIABLE.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 21 ++++++++++++++++
 drivers/iommu/iommu.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f77eb9e7788a..3d2dfd220d3c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -696,6 +696,10 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 int iommu_device_set_dma_owner(struct device *dev, enum iommu_dma_owner owner,
 			       struct file *user_file);
 void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner owner);
+int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
+			      struct file *user_file);
+void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
+bool iommu_group_dma_owner_unclaimed(struct iommu_group *group);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1112,6 +1116,23 @@ static inline void iommu_device_release_dma_owner(struct device *dev,
 						  enum iommu_dma_owner owner)
 {
 }
+
+static inline int iommu_group_set_dma_owner(struct iommu_group *group,
+					    enum iommu_dma_owner owner,
+					    struct file *user_file)
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
index 916a4d448150..3dcd3fc4290a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3431,6 +3431,63 @@ static void __iommu_group_release_dma_owner(struct iommu_group *group,
 	}
 }
 
+/**
+ * iommu_group_set_dma_owner() - Set DMA ownership of a group
+ * @group: The group.
+ * @owner: DMA_OWNER_KERNEL or DMA_OWNER_USER.
+ * @user_file: The device fd when set USER ownership.
+ *
+ * This is to support backward compatibility for legacy vfio which manages
+ * dma ownership in group level. New invocations on this interface should be
+ * prohibited. Instead, please turn to iommu_device_set_dma_owner().
+ */
+int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
+			      struct file *user_file)
+{
+	int ret;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_dma_owner(group, owner, user_file);
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_set_dma_owner);
+
+/**
+ * iommu_group_release_dma_owner() - Release DMA ownership of a group
+ * @group: The group.
+ * @owner: DMA_OWNER_KERNEL or DMA_OWNER_USER.
+ *
+ * Release the DMA ownership claimed by iommu_group_set_dma_owner().
+ */
+void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner)
+{
+	mutex_lock(&group->mutex);
+	__iommu_group_release_dma_owner(group, owner);
+	mutex_unlock(&group->mutex);
+}
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
+	enum iommu_dma_owner owner;
+
+	mutex_lock(&group->mutex);
+	owner = group->dma_owner;
+	mutex_unlock(&group->mutex);
+
+	return owner == DMA_OWNER_NONE;
+}
+EXPORT_SYMBOL_GPL(iommu_group_dma_owner_unclaimed);
+
 /**
  * iommu_device_set_dma_owner() - Set DMA ownership of a device
  * @dev: The device.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
