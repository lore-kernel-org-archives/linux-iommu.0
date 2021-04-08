Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ECC43460
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 01:43:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924776101D
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 01:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924776101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43B8960E22;
	Fri,  9 Apr 2021 01:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoZRxf5miE9p; Fri,  9 Apr 2021 01:43:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAF0660E39;
	Fri,  9 Apr 2021 01:43:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8AE1C000B;
	Fri,  9 Apr 2021 01:43:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 859B0C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 01:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64FFD607DB
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 01:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nwki5sCHWq8T for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 01:42:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F3C9607EE
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 01:42:58 +0000 (UTC)
IronPort-SDR: NOy77WR2p5tdzDp0jpQm5absldUPNLVD7/G/HsmTuTZoJ1bzsktll0F26YVLmvnClh6gHw7ygb
 QnAnlXVJcUFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="278943669"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; d="scan'208";a="278943669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2021 18:42:57 -0700
IronPort-SDR: 3lDXwmXYCjj2EljmHwTMaldsmws/BE03eedaOEj0v0hE+wkZk9yJpoQFty4LSMAhuPRmAi0Svo
 IBmoDKMz8YtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; d="scan'208";a="459050874"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 08 Apr 2021 18:42:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Date: Thu,  8 Apr 2021 10:08:56 -0700
Message-Id: <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The mm parameter in iommu_sva_bind_device() is intended for privileged
process perform bind() on behalf of other processes. This use case has
yet to be materialized, let alone potential security implications of
adding kernel hooks without explicit user consent.
In addition, with the agreement that IOASID allocation shall be subject
cgroup limit. It will be inline with misc cgroup proposal if IOASID
allocation as part of the SVA bind is limited to the current task.

Link: https://lore.kernel.org/linux-iommu/20210303160205.151d114e@jacob-builder/
Link: https://lore.kernel.org/linux-iommu/YFhiMLR35WWMW%2FHu@myrica/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/cdev.c                         |  2 +-
 drivers/dma/idxd/init.c                         |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  6 ++---
 drivers/iommu/iommu-sva-lib.c                   | 30 +++++++++++++++++++------
 drivers/iommu/iommu-sva-lib.h                   |  4 ++--
 drivers/iommu/iommu.c                           | 16 ++++++++-----
 drivers/misc/uacce/uacce.c                      |  2 +-
 include/linux/iommu.h                           |  7 +++---
 8 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 21ec82b..8c3347c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -103,7 +103,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = ctx;
 
 	if (device_pasid_enabled(idxd)) {
-		sva = iommu_sva_bind_device(dev, current->mm, 0);
+		sva = iommu_sva_bind_device(dev, 0);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
 			dev_err(dev, "pasid allocation failed: %d\n", rc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index cdc85f1..a583f79 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -306,7 +306,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
 
 	flags = IOMMU_SVA_BIND_SUPERVISOR;
 
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);
+	sva = iommu_sva_bind_device(&idxd->pdev->dev, flags);
 	if (IS_ERR(sva)) {
 		dev_warn(&idxd->pdev->dev,
 			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 23e287e..bdd5c79 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -329,7 +329,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_PTR(-ENOMEM);
 
 	/* Allocate a PASID for this mm if necessary */
-	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
+	ret = iommu_sva_alloc_pasid(1, (1U << master->ssid_bits) - 1);
 	if (ret)
 		goto err_free_bond;
 
@@ -347,7 +347,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	return &bond->sva;
 
 err_free_pasid:
-	iommu_sva_free_pasid(mm);
+	iommu_sva_free_pasid();
 err_free_bond:
 	kfree(bond);
 	return ERR_PTR(ret);
@@ -377,7 +377,7 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		iommu_sva_free_pasid(bond->mm);
+		iommu_sva_free_pasid();
 		kfree(bond);
 	}
 	mutex_unlock(&sva_lock);
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405..bd99f6b 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -12,27 +12,33 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
 
 /**
  * iommu_sva_alloc_pasid - Allocate a PASID for the mm
- * @mm: the mm
  * @min: minimum PASID value (inclusive)
  * @max: maximum PASID value (inclusive)
  *
- * Try to allocate a PASID for this mm, or take a reference to the existing one
- * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid, and must be released with iommu_sva_free_pasid().
+ * Try to allocate a PASID for the current mm, or take a reference to the
+ * existing one provided it fits within the [@min, @max] range. On success
+ * the PASID is available in the current mm->pasid, and must be released with
+ * iommu_sva_free_pasid().
  * @min must be greater than 0, because 0 indicates an unused mm->pasid.
  *
  * Returns 0 on success and < 0 on error.
  */
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
 {
 	int ret = 0;
 	ioasid_t pasid;
+	struct mm_struct *mm;
 
 	if (min == INVALID_IOASID || max == INVALID_IOASID ||
 	    min == 0 || max < min)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
+	mm = get_task_mm(current);
+	if (!mm) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 	if (mm->pasid) {
 		if (mm->pasid >= min && mm->pasid <= max)
 			ioasid_get(mm->pasid);
@@ -45,22 +51,32 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		else
 			mm->pasid = pasid;
 	}
+	mmput(mm);
+out_unlock:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
 /**
- * iommu_sva_free_pasid - Release the mm's PASID
+ * iommu_sva_free_pasid - Release the current mm's PASID
  * @mm: the mm
  *
  * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
  */
-void iommu_sva_free_pasid(struct mm_struct *mm)
+void iommu_sva_free_pasid(void)
 {
+	struct mm_struct *mm;
+
 	mutex_lock(&iommu_sva_lock);
+	mm = get_task_mm(current);
+	if (!mm)
+		goto out_unlock;
+
 	if (ioasid_put(mm->pasid))
 		mm->pasid = 0;
+	mmput(mm);
+out_unlock:
 	mutex_unlock(&iommu_sva_lock);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index b40990a..278b8b4 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -8,8 +8,8 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-void iommu_sva_free_pasid(struct mm_struct *mm);
+int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max);
+void iommu_sva_free_pasid(void);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bf0a20f..25840e6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/sched/mm.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -2959,9 +2960,8 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
 
 /**
- * iommu_sva_bind_device() - Bind a process address space to a device
+ * iommu_sva_bind_device() - Bind the current process address space to a device
  * @dev: the device
- * @mm: the mm to bind, caller must hold a reference to it
  * @flags: options for the bind operation
  *
  * Create a bond between device and address space, allowing the device to access
@@ -2975,9 +2975,10 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	struct iommu_group *group;
+	struct mm_struct *mm = NULL;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
@@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 		return ERR_PTR(-ENODEV);
 
 	/* Supervisor SVA does not need the current mm */
-	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
-		return ERR_PTR(-EINVAL);
+	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
+		mm = get_task_mm(current);
+		if (!mm)
+			return ERR_PTR(-EINVAL);
+	}
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 
@@ -3004,6 +3008,8 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 		goto out_unlock;
 
 	handle = ops->sva_bind(dev, mm, flags);
+	if (mm)
+		mmput(mm);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 27e0e04..da4401a 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
 
-	handle = iommu_sva_bind_device(uacce->parent, current->mm, 0);
+	handle = iommu_sva_bind_device(uacce->parent, 0);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a3fbaa2..cf752f3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,8 +231,8 @@ struct iommu_iotlb_gather {
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @aux_get_pasid: get the pasid given an aux-domain
- * @sva_bind: Bind process address space to device
- * @sva_unbind: Unbind process address space from device
+ * @sva_bind: Bind the current process address space to device
+ * @sva_unbind: Unbind the current process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @cache_invalidate: invalidate translation caches
@@ -652,7 +652,6 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
 					unsigned int flags);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
@@ -1028,7 +1027,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	return NULL;
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
