Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20817E8
	for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 01:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178397; x=1698714397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1d6sViO5fWOIGO0wlM7s87valHVmhNuqdZzNLB22vw=;
  b=X3G3Yt7aSET1IM7/q0SH7zS5rW/BiZ3Gue+4FYS6sYhMRwZHlUrjY1oE
   C3BnCAPtcIs3U6vUoR4smIU1pa/mPsNEBK2ipq1yHfgP9wrscxtRS60AZ
   Ds42q+pH4l81wNb9A3bj/mKk0cj6GuIZ6v37f/lx0AGMexnVXMC10RdAw
   VZsR617LwfsuFDcEE7jhYAB+AZMhe6CH9g5CfIShCuu5OtCIJodXgbsI2
   l5W87A1S5D1XUaUZwO+QQLXI7CpjZAvp2bDgCrAsQ9kHRCU56Zwt4t2nI
   JPuw1oo2qa1+dMTvlv+GMJtsb5Gr75vKJf2PBMWnNQkG+rbrGI2Cvhgm7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="335447156"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="335447156"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496256"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496256"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:06:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 09/13] iommu/sva: Refactoring iommu_sva_bind/unbind_device()
Date: Mon, 31 Oct 2022 08:59:13 +0800
Message-Id: <20221031005917.45690-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing iommu SVA interfaces are implemented by calling the SVA
specific iommu ops provided by the IOMMU drivers. There's no need for
any SVA specific ops in iommu_ops vector anymore as we can achieve
this through the generic attach/detach_dev_pasid domain ops.

This refactors the IOMMU SVA interfaces implementation by using the
iommu_attach/detach_device_pasid interfaces and align them with the
concept of the SVA iommu domain. Put the new SVA code in the SVA
related file in order to make it self-contained.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h         |  43 +++++++------
 drivers/iommu/iommu-sva-lib.c | 111 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |  91 ----------------------------
 3 files changed, 134 insertions(+), 111 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 776baa375967..bee5659d07eb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -645,6 +645,7 @@ struct iommu_fwspec {
  */
 struct iommu_sva {
 	struct device			*dev;
+	struct iommu_domain		*domain;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
@@ -686,11 +687,6 @@ void iommu_release_device(struct device *dev);
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 
-struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm);
-void iommu_sva_unbind_device(struct iommu_sva *handle);
-u32 iommu_sva_get_pasid(struct iommu_sva *handle);
-
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1026,21 +1022,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
-{
-	return NULL;
-}
-
-static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
-{
-}
-
-static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
-{
-	return IOMMU_PASID_INVALID;
-}
-
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
@@ -1154,4 +1135,26 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_m
 
 #endif	/* CONFIG_IOMMU_DMA */
 
+#ifdef CONFIG_IOMMU_SVA
+struct iommu_sva *iommu_sva_bind_device(struct device *dev,
+					struct mm_struct *mm);
+void iommu_sva_unbind_device(struct iommu_sva *handle);
+u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+#else
+static inline struct iommu_sva *
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+{
+	return NULL;
+}
+
+static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+{
+}
+
+static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return IOMMU_PASID_INVALID;
+}
+#endif /* CONFIG_IOMMU_SVA */
+
 #endif /* __LINUX_IOMMU_H */
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..e425573a1787 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -4,6 +4,7 @@
  */
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
+#include <linux/iommu.h>
 
 #include "iommu-sva-lib.h"
 
@@ -69,3 +70,113 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to mm_users
+ *
+ * Create a bond between device and address space, allowing the device to
+ * access the mm using the PASID returned by iommu_sva_get_pasid(). If a
+ * bond already exists between @device and @mm, an additional internal
+ * reference is taken. Caller must call iommu_sva_unbind_device()
+ * to release each reference.
+ *
+ * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
+ * initialize the required SVA features.
+ *
+ * On error, returns an ERR_PTR value.
+ */
+struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+{
+	struct iommu_domain *domain;
+	struct iommu_sva *handle;
+	ioasid_t max_pasids;
+	int ret;
+
+	max_pasids = dev->iommu->max_pasids;
+	if (!max_pasids)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Allocate mm->pasid if necessary. */
+	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&iommu_sva_lock);
+	/* Search for an existing domain. */
+	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
+						IOMMU_DOMAIN_SVA);
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
+		goto out_unlock;
+	}
+
+	if (domain) {
+		domain->users++;
+		goto out;
+	}
+
+	/* Allocate a new domain and set it on device pasid. */
+	domain = iommu_sva_domain_alloc(dev, mm);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	if (ret)
+		goto out_free_domain;
+	domain->users = 1;
+out:
+	mutex_unlock(&iommu_sva_lock);
+	handle->dev = dev;
+	handle->domain = domain;
+
+	return handle;
+
+out_free_domain:
+	iommu_domain_free(domain);
+out_unlock:
+	mutex_unlock(&iommu_sva_lock);
+	kfree(handle);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
+
+/**
+ * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
+ * @handle: the handle returned by iommu_sva_bind_device()
+ *
+ * Put reference to a bond between device and address space. The device should
+ * not be issuing any more transaction for this PASID. All outstanding page
+ * requests for this PASID must have been flushed to the IOMMU.
+ */
+void iommu_sva_unbind_device(struct iommu_sva *handle)
+{
+	struct iommu_domain *domain = handle->domain;
+	ioasid_t pasid = domain->mm->pasid;
+	struct device *dev = handle->dev;
+
+	mutex_lock(&iommu_sva_lock);
+	if (--domain->users == 0) {
+		iommu_detach_device_pasid(domain, dev, pasid);
+		iommu_domain_free(domain);
+	}
+	mutex_unlock(&iommu_sva_lock);
+	kfree(handle);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	struct iommu_domain *domain = handle->domain;
+
+	return domain->mm->pasid;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6a1cd2018e30..c9da0a1bb3b8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2751,97 +2751,6 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
-/**
- * iommu_sva_bind_device() - Bind a process address space to a device
- * @dev: the device
- * @mm: the mm to bind, caller must hold a reference to it
- *
- * Create a bond between device and address space, allowing the device to access
- * the mm using the returned PASID. If a bond already exists between @device and
- * @mm, it is returned and an additional reference is taken. Caller must call
- * iommu_sva_unbind_device() to release each reference.
- *
- * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
- * initialize the required SVA features.
- *
- * On error, returns an ERR_PTR value.
- */
-struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
-{
-	struct iommu_group *group;
-	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (!ops->sva_bind)
-		return ERR_PTR(-ENODEV);
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return ERR_PTR(-ENODEV);
-
-	/* Ensure device count and domain don't change while we're binding */
-	mutex_lock(&group->mutex);
-
-	/*
-	 * To keep things simple, SVA currently doesn't support IOMMU groups
-	 * with more than one device. Existing SVA-capable systems are not
-	 * affected by the problems that required IOMMU groups (lack of ACS
-	 * isolation, device ID aliasing and other hardware issues).
-	 */
-	if (iommu_group_device_count(group) != 1)
-		goto out_unlock;
-
-	handle = ops->sva_bind(dev, mm);
-
-out_unlock:
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
-	return handle;
-}
-EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
-
-/**
- * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
- * @handle: the handle returned by iommu_sva_bind_device()
- *
- * Put reference to a bond between device and address space. The device should
- * not be issuing any more transaction for this PASID. All outstanding page
- * requests for this PASID must have been flushed to the IOMMU.
- */
-void iommu_sva_unbind_device(struct iommu_sva *handle)
-{
-	struct iommu_group *group;
-	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (!ops->sva_unbind)
-		return;
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return;
-
-	mutex_lock(&group->mutex);
-	ops->sva_unbind(handle);
-	mutex_unlock(&group->mutex);
-
-	iommu_group_put(group);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
-
-u32 iommu_sva_get_pasid(struct iommu_sva *handle)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
-
-	if (!ops->sva_get_pasid)
-		return IOMMU_PASID_INVALID;
-
-	return ops->sva_get_pasid(handle);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
-
 /*
  * Changes the default domain of an iommu group that has *only* one device
  *
-- 
2.34.1

