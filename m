Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA05C433E5
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F077B20E65
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F077B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C8E6587236;
	Wed, 24 Jun 2020 08:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8cg7AOfSreJn; Wed, 24 Jun 2020 08:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B4988719A;
	Wed, 24 Jun 2020 08:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA7ECC0894;
	Wed, 24 Jun 2020 08:48:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77FE9C016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 736F588889
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZPZ1mXwDo0Oz for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 08:48:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7A16F8887C
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:48:57 +0000 (UTC)
IronPort-SDR: 4Jxh9KJfhkhUNKNTlg5VFIXLqfPQnVTrUtsgrzqkqoe3v7Hqss5s7zOnSZ3JkjYAysqI1f1afT
 1rB1nNoRt4kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141879060"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="141879060"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 01:48:56 -0700
IronPort-SDR: ZuNjk+8VQJ/PKrC5QryMb7568r+qxl4BDN2mSL+nKSXPaaZp0j754iOps4QVoQIMXENV2RNi9j
 gngxAlzWHpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="275624508"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 01:48:55 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST (alloc/free)
Date: Wed, 24 Jun 2020 01:55:19 -0700
Message-Id: <1592988927-48009-7-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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

This patch allows user space to request PASID allocation/free, e.g. when
serving the request from the guest.

PASIDs that are not freed by userspace are automatically freed when the
IOASID set is destroyed when process exits.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v1 -> v2:
*) move the vfio_mm related code to be a seprate module
*) use a single structure for alloc/free, could support a range of PASIDs
*) fetch vfio_mm at group_attach time instead of at iommu driver open time
---
 drivers/vfio/Kconfig            |  1 +
 drivers/vfio/vfio_iommu_type1.c | 96 ++++++++++++++++++++++++++++++++++++++++-
 drivers/vfio/vfio_pasid.c       | 10 +++++
 include/linux/vfio.h            |  6 +++
 include/uapi/linux/vfio.h       | 36 ++++++++++++++++
 5 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 3d8a108..95d90c6 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -2,6 +2,7 @@
 config VFIO_IOMMU_TYPE1
 	tristate
 	depends on VFIO
+	select VFIO_PASID if (X86)
 	default n
 
 config VFIO_IOMMU_SPAPR_TCE
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 8c143d5..d0891c5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -73,6 +73,7 @@ struct vfio_iommu {
 	bool			v2;
 	bool			nesting;
 	struct iommu_nesting_info *nesting_info;
+	struct vfio_mm		*vmm;
 	bool			dirty_page_tracking;
 	bool			pinned_page_dirty_scope;
 };
@@ -1933,6 +1934,17 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 
 	list_splice_tail(iova_copy, iova);
 }
+
+static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
+{
+	if (iommu->vmm) {
+		vfio_mm_put(iommu->vmm);
+		iommu->vmm = NULL;
+	}
+
+	kfree(iommu->nesting_info);
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -2067,6 +2079,25 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_detach;
 		}
 		iommu->nesting_info = info;
+
+		if (info->features & IOMMU_NESTING_FEAT_SYSWIDE_PASID) {
+			struct vfio_mm *vmm;
+			int sid;
+
+			vmm = vfio_mm_get_from_task(current);
+			if (IS_ERR(vmm)) {
+				ret = PTR_ERR(vmm);
+				goto out_detach;
+			}
+			iommu->vmm = vmm;
+
+			sid = vfio_mm_ioasid_sid(vmm);
+			ret = iommu_domain_set_attr(domain->domain,
+						    DOMAIN_ATTR_IOASID_SID,
+						    &sid);
+			if (ret)
+				goto out_detach;
+		}
 	}
 
 	/* Get aperture info */
@@ -2178,7 +2209,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	kfree(iommu->nesting_info);
+	if (iommu->nesting_info)
+		vfio_iommu_release_nesting_info(iommu);
 	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
@@ -2380,7 +2412,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 				else
 					vfio_iommu_unmap_unpin_reaccount(iommu);
 
-				kfree(iommu->nesting_info);
+				if (iommu->nesting_info)
+					vfio_iommu_release_nesting_info(iommu);
 			}
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
@@ -2852,6 +2885,63 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 	return -EINVAL;
 }
 
+static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
+					unsigned int min,
+					unsigned int max)
+{
+	int ret = -ENOTSUPP;
+
+	mutex_lock(&iommu->lock);
+	if (iommu->vmm)
+		ret = vfio_pasid_alloc(iommu->vmm, min, max);
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
+static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
+					unsigned int min,
+					unsigned int max)
+{
+	int ret = -ENOTSUPP;
+
+	mutex_lock(&iommu->lock);
+	if (iommu->vmm) {
+		vfio_pasid_free_range(iommu->vmm, min, max);
+		ret = 0;
+	}
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
+static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
+					  unsigned long arg)
+{
+	struct vfio_iommu_type1_pasid_request req;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct vfio_iommu_type1_pasid_request, range);
+
+	if (copy_from_user(&req, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (req.argsz < minsz || (req.flags & ~VFIO_PASID_REQUEST_MASK))
+		return -EINVAL;
+
+	if (req.range.min > req.range.max)
+		return -EINVAL;
+
+	switch (req.flags & VFIO_PASID_REQUEST_MASK) {
+	case VFIO_IOMMU_ALLOC_PASID:
+		return vfio_iommu_type1_pasid_alloc(iommu,
+					req.range.min, req.range.max);
+	case VFIO_IOMMU_FREE_PASID:
+		return vfio_iommu_type1_pasid_free(iommu,
+					req.range.min, req.range.max);
+	default:
+		return -EINVAL;
+	}
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -2868,6 +2958,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		return vfio_iommu_type1_unmap_dma(iommu, arg);
 	case VFIO_IOMMU_DIRTY_PAGES:
 		return vfio_iommu_type1_dirty_pages(iommu, arg);
+	case VFIO_IOMMU_PASID_REQUEST:
+		return vfio_iommu_type1_pasid_request(iommu, arg);
 	}
 
 	return -ENOTTY;
diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
index dd5b6d1..2ea9f1a 100644
--- a/drivers/vfio/vfio_pasid.c
+++ b/drivers/vfio/vfio_pasid.c
@@ -54,6 +54,7 @@ void vfio_mm_put(struct vfio_mm *vmm)
 {
 	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_pasid.vfio_mm_lock);
 }
+EXPORT_SYMBOL_GPL(vfio_mm_put);
 
 static void vfio_mm_get(struct vfio_mm *vmm)
 {
@@ -103,6 +104,13 @@ struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
 	mmput(mm);
 	return vmm;
 }
+EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
+
+int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
+{
+	return vmm->ioasid_sid;
+}
+EXPORT_SYMBOL_GPL(vfio_mm_ioasid_sid);
 
 int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
 {
@@ -112,6 +120,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
 
 	return (pasid == INVALID_IOASID) ? -ENOSPC : pasid;
 }
+EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
 
 void vfio_pasid_free_range(struct vfio_mm *vmm,
 			    ioasid_t min, ioasid_t max)
@@ -129,6 +138,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
 	for (; pasid <= max; pasid++)
 		ioasid_free(pasid);
 }
+EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
 
 static int __init vfio_pasid_init(void)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 74e077d..8e60a32 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -101,6 +101,7 @@ struct vfio_mm;
 #if IS_ENABLED(CONFIG_VFIO_PASID)
 extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
 extern void vfio_mm_put(struct vfio_mm *vmm);
+int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
 extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
 extern void vfio_pasid_free_range(struct vfio_mm *vmm,
 					ioasid_t min, ioasid_t max);
@@ -114,6 +115,11 @@ static inline void vfio_mm_put(struct vfio_mm *vmm)
 {
 }
 
+static inline int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
+{
+	return -ENOTTY;
+}
+
 static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
 {
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index f1f39e1..657b2db 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1162,6 +1162,42 @@ struct vfio_iommu_type1_dirty_bitmap_get {
 
 #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
 
+/**
+ * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
+ *				struct vfio_iommu_type1_pasid_request)
+ *
+ * PASID (Processor Address Space ID) is a PCIe concept for tagging
+ * address spaces in DMA requests. When system-wide PASID allocation
+ * is required by underlying iommu driver (e.g. Intel VT-d), this
+ * provides an interface for userspace to request pasid alloc/free
+ * for its assigned devices. Userspace should check the availability
+ * of this API through VFIO_IOMMU_GET_INFO.
+ *
+ * @flags=VFIO_IOMMU_ALLOC_PASID, allocate a single PASID within @range.
+ * @flags=VFIO_IOMMU_FREE_PASID, free the PASIDs within @range.
+ * @range is [min, max], which means both @min and @max are inclusive.
+ * ALLOC_PASID and FREE_PASID are mutually exclusive.
+ *
+ * returns: allocated PASID value on success, -errno on failure for
+ *	     ALLOC_PASID;
+ *	     0 for FREE_PASID operation;
+ */
+struct vfio_iommu_type1_pasid_request {
+	__u32	argsz;
+#define VFIO_IOMMU_ALLOC_PASID	(1 << 0)
+#define VFIO_IOMMU_FREE_PASID	(1 << 1)
+	__u32	flags;
+	struct {
+		__u32	min;
+		__u32	max;
+	} range;
+};
+
+#define VFIO_PASID_REQUEST_MASK	(VFIO_IOMMU_ALLOC_PASID | \
+					 VFIO_IOMMU_FREE_PASID)
+
+#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
