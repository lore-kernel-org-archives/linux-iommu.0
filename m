Return-Path: <SRS0=M77+=AX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656CDC433EB
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB5020725
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB5020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BD07888D6;
	Sun, 12 Jul 2020 11:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5dUFIcJa6t2; Sun, 12 Jul 2020 11:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0073788B39;
	Sun, 12 Jul 2020 11:14:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF847C08A2;
	Sun, 12 Jul 2020 11:14:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92489C088E
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7E60B893CC
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5it14JZpOHNO for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jul 2020 11:14:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A5EBD893E8
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
IronPort-SDR: BcRQyFiJ2GTy9WRzzWWSm1ZMznTnEnrtiXBQksi902n+eERjJsPNBmYui+S6ZYmlNWyej/vvow
 vVKWzXZT5usQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148489869"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="148489869"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:14:30 -0700
IronPort-SDR: 5yAiOl0Wd+ssI/rYRfPswvB/HSl6aFpz59CVRp2VRXwLlhj5xM53BLj4aWQO9suL32XxjCu4BS
 bCWctd+RlJaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="315788579"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 12 Jul 2020 04:14:30 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v5 10/15] vfio/type1: Support binding guest page tables to
 PASID
Date: Sun, 12 Jul 2020 04:21:05 -0700
Message-Id: <1594552870-55687-11-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

Nesting translation allows two-levels/stages page tables, with 1st level
for guest translations (e.g. GVA->GPA), 2nd level for host translations
(e.g. GPA->HPA). This patch adds interface for binding guest page tables
to a PASID. This PASID must have been allocated to user space before the
binding request.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v3 -> v4:
*) address comments from Alex on v3

v2 -> v3:
*) use __iommu_sva_unbind_gpasid() for unbind call issued by VFIO
   https://lore.kernel.org/linux-iommu/1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com/

v1 -> v2:
*) rename subject from "vfio/type1: Bind guest page tables to host"
*) remove VFIO_IOMMU_BIND, introduce VFIO_IOMMU_NESTING_OP to support bind/
   unbind guet page table
*) replaced vfio_iommu_for_each_dev() with a group level loop since this
   series enforces one group per container w/ nesting type as start.
*) rename vfio_bind/unbind_gpasid_fn() to vfio_dev_bind/unbind_gpasid_fn()
*) vfio_dev_unbind_gpasid() always successful
*) use vfio_mm->pasid_lock to avoid race between PASID free and page table
   bind/unbind
---
 drivers/vfio/vfio_iommu_type1.c | 166 ++++++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_pasid.c       |  26 +++++++
 include/linux/vfio.h            |  20 +++++
 include/uapi/linux/vfio.h       |  31 ++++++++
 4 files changed, 243 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 55b4065..f0f21ff 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -149,6 +149,30 @@ struct vfio_regions {
 #define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
 #define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
 
+struct domain_capsule {
+	struct vfio_group *group;
+	struct iommu_domain *domain;
+	void *data;
+};
+
+/* iommu->lock must be held */
+static struct vfio_group *vfio_find_nesting_group(struct vfio_iommu *iommu)
+{
+	struct vfio_domain *d;
+	struct vfio_group *group = NULL;
+
+	if (!iommu->nesting_info)
+		return NULL;
+
+	/* only support singleton container with nesting type */
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		list_for_each_entry(group, &d->group_list, next) {
+			break;
+		}
+	}
+	return group;
+}
+
 static int put_pfn(unsigned long pfn, int prot);
 
 static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
@@ -2349,6 +2373,48 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
+{
+	struct domain_capsule *dc = (struct domain_capsule *)data;
+	unsigned long arg = *(unsigned long *)dc->data;
+
+	return iommu_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
+}
+
+static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
+{
+	struct domain_capsule *dc = (struct domain_capsule *)data;
+	unsigned long arg = *(unsigned long *)dc->data;
+
+	iommu_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
+	return 0;
+}
+
+static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
+{
+	struct domain_capsule *dc = (struct domain_capsule *)data;
+	struct iommu_gpasid_bind_data *unbind_data =
+				(struct iommu_gpasid_bind_data *)dc->data;
+
+	__iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
+	return 0;
+}
+
+static void vfio_group_unbind_gpasid_fn(ioasid_t pasid, void *data)
+{
+	struct domain_capsule *dc = (struct domain_capsule *)data;
+	struct iommu_gpasid_bind_data unbind_data;
+
+	unbind_data.argsz = offsetof(struct iommu_gpasid_bind_data, vendor);
+	unbind_data.flags = 0;
+	unbind_data.hpasid = pasid;
+
+	dc->data = &unbind_data;
+
+	iommu_group_for_each_dev(dc->group->iommu_group,
+				 dc, __vfio_dev_unbind_gpasid_fn);
+}
+
 static void vfio_iommu_type1_detach_group(void *iommu_data,
 					  struct iommu_group *iommu_group)
 {
@@ -2392,6 +2458,21 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
+		if (iommu->nesting_info && iommu->vmm &&
+		    (iommu->nesting_info->features &
+					IOMMU_NESTING_FEAT_BIND_PGTBL)) {
+			struct domain_capsule dc = { .group = group,
+						     .domain = domain->domain,
+						     .data = NULL };
+
+			/*
+			 * Unbind page tables bound with system wide PASIDs
+			 * which are allocated to user space.
+			 */
+			vfio_mm_for_each_pasid(iommu->vmm, &dc,
+					       vfio_group_unbind_gpasid_fn);
+		}
+
 		vfio_iommu_detach_group(domain, group);
 		update_dirty_scope = !group->pinned_page_dirty_scope;
 		list_del(&group->next);
@@ -2938,6 +3019,89 @@ static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
 	}
 }
 
+static long vfio_iommu_handle_pgtbl_op(struct vfio_iommu *iommu,
+				       bool is_bind, unsigned long arg)
+{
+	struct iommu_nesting_info *info;
+	struct domain_capsule dc = { .data = &arg };
+	struct vfio_group *group;
+	struct vfio_domain *domain;
+	int ret;
+
+	mutex_lock(&iommu->lock);
+
+	info = iommu->nesting_info;
+	if (!info || !(info->features & IOMMU_NESTING_FEAT_BIND_PGTBL)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock_iommu;
+	}
+
+	if (!iommu->vmm) {
+		ret = -EINVAL;
+		goto out_unlock_iommu;
+	}
+
+	group = vfio_find_nesting_group(iommu);
+	if (!group) {
+		ret = -EINVAL;
+		goto out_unlock_iommu;
+	}
+
+	domain = list_first_entry(&iommu->domain_list,
+				  struct vfio_domain, next);
+	dc.group = group;
+	dc.domain = domain->domain;
+
+	/* Avoid race with other containers within the same process */
+	vfio_mm_pasid_lock(iommu->vmm);
+
+	if (is_bind) {
+		ret = iommu_group_for_each_dev(group->iommu_group, &dc,
+					       vfio_dev_bind_gpasid_fn);
+		if (ret)
+			iommu_group_for_each_dev(group->iommu_group, &dc,
+						 vfio_dev_unbind_gpasid_fn);
+	} else {
+		iommu_group_for_each_dev(group->iommu_group,
+					 &dc, vfio_dev_unbind_gpasid_fn);
+		ret = 0;
+	}
+
+	vfio_mm_pasid_unlock(iommu->vmm);
+out_unlock_iommu:
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
+static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
+					unsigned long arg)
+{
+	struct vfio_iommu_type1_nesting_op hdr;
+	unsigned int minsz;
+	int ret;
+
+	minsz = offsetofend(struct vfio_iommu_type1_nesting_op, flags);
+
+	if (copy_from_user(&hdr, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (hdr.argsz < minsz || hdr.flags & ~VFIO_NESTING_OP_MASK)
+		return -EINVAL;
+
+	switch (hdr.flags & VFIO_NESTING_OP_MASK) {
+	case VFIO_IOMMU_NESTING_OP_BIND_PGTBL:
+		ret = vfio_iommu_handle_pgtbl_op(iommu, true, arg + minsz);
+		break;
+	case VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL:
+		ret = vfio_iommu_handle_pgtbl_op(iommu, false, arg + minsz);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -2956,6 +3120,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		return vfio_iommu_type1_dirty_pages(iommu, arg);
 	case VFIO_IOMMU_PASID_REQUEST:
 		return vfio_iommu_type1_pasid_request(iommu, arg);
+	case VFIO_IOMMU_NESTING_OP:
+		return vfio_iommu_type1_nesting_op(iommu, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
index ebec244..ecabaaa 100644
--- a/drivers/vfio/vfio_pasid.c
+++ b/drivers/vfio/vfio_pasid.c
@@ -216,6 +216,8 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
 	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
 	 * teardown necessary structures depending on the to-be-freed
 	 * PASID.
+	 * Hold pasid_lock also avoids race with PASID usages like bind/
+	 * unbind page tables to requested PASID.
 	 */
 	mutex_lock(&vmm->pasid_lock);
 	while ((vid = vfio_find_pasid(vmm, min, max)) != NULL)
@@ -224,6 +226,30 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
 }
 EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
 
+int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
+			   void (*fn)(ioasid_t id, void *data))
+{
+	int ret;
+
+	mutex_lock(&vmm->pasid_lock);
+	ret = ioasid_set_for_each_ioasid(vmm->ioasid_sid, fn, data);
+	mutex_unlock(&vmm->pasid_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_mm_for_each_pasid);
+
+void vfio_mm_pasid_lock(struct vfio_mm *vmm)
+{
+	mutex_lock(&vmm->pasid_lock);
+}
+EXPORT_SYMBOL_GPL(vfio_mm_pasid_lock);
+
+void vfio_mm_pasid_unlock(struct vfio_mm *vmm)
+{
+	mutex_unlock(&vmm->pasid_lock);
+}
+EXPORT_SYMBOL_GPL(vfio_mm_pasid_unlock);
+
 static int __init vfio_pasid_init(void)
 {
 	mutex_init(&vfio_mm_lock);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index a111108..2bc8347 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -105,6 +105,11 @@ int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
 extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
 extern void vfio_pasid_free_range(struct vfio_mm *vmm,
 				  ioasid_t min, ioasid_t max);
+extern int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
+				  void (*fn)(ioasid_t id, void *data));
+extern void vfio_mm_pasid_lock(struct vfio_mm *vmm);
+extern void vfio_mm_pasid_unlock(struct vfio_mm *vmm);
+
 #else
 static inline struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
 {
@@ -129,6 +134,21 @@ static inline void vfio_pasid_free_range(struct vfio_mm *vmm,
 					  ioasid_t min, ioasid_t max)
 {
 }
+
+static inline int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
+					 void (*fn)(ioasid_t id, void *data))
+{
+	return -ENOTTY;
+}
+
+static inline void vfio_mm_pasid_lock(struct vfio_mm *vmm)
+{
+}
+
+static inline void vfio_mm_pasid_unlock(struct vfio_mm *vmm)
+{
+}
+
 #endif /* CONFIG_VFIO_PASID */
 
 /*
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 96a115f..a8ad786 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1209,6 +1209,37 @@ struct vfio_iommu_type1_pasid_request {
 
 #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
 
+/**
+ * VFIO_IOMMU_NESTING_OP - _IOW(VFIO_TYPE, VFIO_BASE + 19,
+ *				struct vfio_iommu_type1_nesting_op)
+ *
+ * This interface allows user space to utilize the nesting IOMMU
+ * capabilities as reported in VFIO_IOMMU_TYPE1_INFO_CAP_NESTING
+ * cap through VFIO_IOMMU_GET_INFO.
+ *
+ * @data[] types defined for each op:
+ * +=================+===============================================+
+ * | NESTING OP      |      @data[]                                  |
+ * +=================+===============================================+
+ * | BIND_PGTBL      |      struct iommu_gpasid_bind_data            |
+ * +-----------------+-----------------------------------------------+
+ * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
+ * +-----------------+-----------------------------------------------+
+ *
+ * returns: 0 on success, -errno on failure.
+ */
+struct vfio_iommu_type1_nesting_op {
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_NESTING_OP_MASK	(0xffff) /* lower 16-bits for op */
+	__u8	data[];
+};
+
+#define VFIO_IOMMU_NESTING_OP_BIND_PGTBL	(0)
+#define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL	(1)
+
+#define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE, VFIO_BASE + 19)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
