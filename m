Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5E831F98B
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524135; cv=none; b=tl/nVslDajv1oX71p2vY85M5MGqKwnRcitZh6+m9Um3fLU/eqaGnYiYqDeb8tDyOAHX8RnTPfXXUCzxjOX2379yYrPKJ17WcwgJlvWpVDjyyIoZcY+PJcqlQ7SRL4cmnY9hZzR9+T7FDDb6WMi7Xact5dUXusq9ReppdWkCmf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524135; c=relaxed/simple;
	bh=7JmlzQkOyORWKRKcDTRx8V2A+rBeBaHPMv0bPpG/x6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIA2/84KCUYM4bYkBjl3UA/jZUOE7QRLBB9Fkz0aZoavDo9RB/4zSIkUZb7kx5WigzeYuMzzCy3DVK+iXr2/wMxeRKxrZwtO+VS8ZhkjI11x5tsCMSkvcqrzMSK6SlslZvQetLqflGCXe6OK2lI7zrPO0tYeGxh5ySElX+RwXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sj2xQquH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sj2xQquH"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20F2620B7169;
	Wed,  3 Jun 2026 15:01:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20F2620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780524118;
	bh=NnRp4LSPrsHHXBhPsyKwV2T0cmByZ1kV7iBycWX7Dj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sj2xQquHdPn9pIQ8DSItbM4Rzn09fRBNzMxN3xQweGHHlUpD0McN+mAtJTscVewai
	 w2On6NaiXip2S6p+WHLHhtJlteG6DQoRKHLBANF0QRVq8f6YzvvyEivMhKpuiXjyI/
	 5qzRz7pvF/i+8Js2dfoksrTyyVUKD5ADRmqDBsyc=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: [PATCH v8 1/6] iommufd: Support a HWPT without an iommu driver for noiommu
Date: Wed,  3 Jun 2026 15:02:06 -0700
Message-ID: <20260603220211.2584590-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Create just a little part of a real iommu driver, enough to
slot in under the dev_iommu_ops() and allow iommufd to call
domain_alloc_paging_flags() and fail everything else.

This allows explicitly creating a HWPT under an IOAS.

A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
from the VFIO group/container based noiommu mode.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
V8:
  - Guard vIOMMU and vDevice allocation paths for noiommu (Sashiko)
v7:
  - Drain no-IOMMU generic-PT freelist (Sashiko)
  - Import generic-PT IOMMU namespace (Sashiko)
v6: (Yi)
  - Sort includes alphabetically (iommu.h after generic_pt/iommu.h)
  - Fix comment: s/mock page table/SW-only page table/ to avoid confusion
    with selftest mock
  - Rewrite noiommu_amdv1_ops comment: explain why AMDV1 format is chosen
    (multi-page size options), remove references to group-container mode distinction
v5:
   - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
   - Use consistent wording referring to VFIO noiommu mode (Kevin)
   - Copyright date fix (Kevin)
v4:
   - Make iommufd_noiommu_ops const
v3:
   - Add comment to explain the design difference over the
     legacy noiommu VFIO code.
---
 drivers/iommu/iommufd/Kconfig           |  12 +++
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/hw_pagetable.c    |  19 ++++-
 drivers/iommu/iommufd/hwpt_noiommu.c    | 105 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  12 +++
 drivers/iommu/iommufd/main.c            |   1 +
 drivers/iommu/iommufd/viommu.c          |  14 +++-
 7 files changed, 158 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 455bac0351f2..6c3bea83631b 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -16,6 +16,18 @@ config IOMMUFD
 	  If you don't know what to do here, say N.
 
 if IOMMUFD
+config IOMMUFD_NOIOMMU
+	bool
+	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_AMDV1
+	help
+	  Provides a SW-only IO page table for devices without hardware
+	  IOMMU backing. This uses the AMDV1 page table format for
+	  IOVA-to-PA lookups only, not for hardware DMA translation.
+	  To be selected by VFIO_NOIOMMU when VFIO_DEVICE_CDEV is enabled.
+
 config IOMMUFD_VFIO_CONTAINER
 	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
 	depends on VFIO_GROUP && !VFIO_CONTAINER
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..67207914bb6e 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -10,6 +10,7 @@ iommufd-y := \
 	vfio_compat.o \
 	viommu.o
 
+iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fe789c2dc0c9..8f95c75d47f3 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,15 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
+{
+	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->igroup->group)
+		return &iommufd_noiommu_ops;
+	if (WARN_ON_ONCE(!idev->dev->iommu))
+		return NULL;
+	return dev_iommu_ops(idev->dev);
+}
+
 static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->domain)
@@ -114,11 +123,13 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
 				IOMMU_HWPT_FAULT_ID_VALID |
 				IOMMU_HWPT_ALLOC_PASID;
-	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	const struct iommu_ops *ops = get_iommu_ops(idev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
+	if (!ops)
+		return ERR_PTR(-ENODEV);
 	lockdep_assert_held(&ioas->mutex);
 
 	if ((flags || user_data) && !ops->domain_alloc_paging_flags)
@@ -229,7 +240,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 			  struct iommufd_device *idev, u32 flags,
 			  const struct iommu_user_data *user_data)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	const struct iommu_ops *ops = get_iommu_ops(idev);
 	struct iommufd_hwpt_nested *hwpt_nested;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -389,10 +400,12 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		hwpt = &hwpt_nested->common;
 	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
 		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommu_device *iommu_dev;
 		struct iommufd_viommu *viommu;
 
 		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
-		if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+		iommu_dev = iommufd_device_get_iommu_dev(idev);
+		if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
 			rc = -EINVAL;
 			goto out_unlock;
 		}
diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c b/drivers/iommu/iommufd/hwpt_noiommu.c
new file mode 100644
index 000000000000..9b8b5eb71491
--- /dev/null
+++ b/drivers/iommu/iommufd/hwpt_noiommu.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+#include "iommufd_private.h"
+
+static const struct iommu_domain_ops noiommu_amdv1_ops;
+
+struct noiommu_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu_amdv1 amdv1;
+	};
+	spinlock_t lock;
+};
+PT_IOMMU_CHECK_DOMAIN(struct noiommu_domain, amdv1.iommu, domain);
+
+static void noiommu_change_top(struct pt_iommu *iommu_table,
+			       phys_addr_t top_paddr, unsigned int top_level)
+{
+}
+
+static spinlock_t *noiommu_get_top_lock(struct pt_iommu *iommupt)
+{
+	struct noiommu_domain *domain =
+		container_of(iommupt, struct noiommu_domain, amdv1.iommu);
+
+	return &domain->lock;
+}
+
+static const struct pt_iommu_driver_ops noiommu_driver_ops = {
+	.get_top_lock = noiommu_get_top_lock,
+	.change_top = noiommu_change_top,
+};
+
+static struct iommu_domain *
+noiommu_alloc_paging_flags(struct device *dev, u32 flags,
+			   const struct iommu_user_data *user_data)
+{
+	struct pt_iommu_amdv1_cfg cfg = {};
+	struct noiommu_domain *dom;
+	int rc;
+
+	if (flags || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	cfg.common.hw_max_vasz_lg2 = 64;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.starting_level = 2;
+	cfg.common.features =
+		(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
+
+	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
+	if (!dom)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&dom->lock);
+	dom->amdv1.iommu.nid = NUMA_NO_NODE;
+	dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
+	dom->domain.ops = &noiommu_amdv1_ops;
+
+	/* Use SW-only page table which is based on AMDV1 */
+	rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
+	if (rc) {
+		kfree(dom);
+		return ERR_PTR(rc);
+	}
+
+	return &dom->domain;
+}
+
+static void noiommu_domain_free(struct iommu_domain *iommu_domain)
+{
+	struct noiommu_domain *domain =
+		container_of(iommu_domain, struct noiommu_domain, domain);
+
+	pt_iommu_deinit(&domain->amdv1.iommu);
+	kfree(domain);
+}
+
+static void noiommu_iotlb_sync(struct iommu_domain *domain,
+			       struct iommu_iotlb_gather *gather)
+{
+	iommu_put_pages_list(&gather->freelist);
+}
+
+/*
+ * Domain ops for iommufd no-IOMMU mode. Uses AMDV1 format as a
+ * SW-only IOPT because it has the best multi-page size options
+ * of all the formats. IOVAs serve only for IOVA-to-PA lookups,
+ * not for hardware DMA translation.
+ */
+static const struct iommu_domain_ops noiommu_amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.iotlb_sync = noiommu_iotlb_sync,
+	.free = noiommu_domain_free,
+};
+
+const struct iommu_ops iommufd_noiommu_ops = {
+	.domain_alloc_paging_flags = noiommu_alloc_paging_flags,
+};
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9..c8ed612e896a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
+extern const struct iommu_ops iommufd_noiommu_ops;
+
 struct iommufd_attach;
 
 struct iommufd_group {
@@ -501,6 +503,16 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_device, obj);
 }
 
+static inline struct iommu_device *
+iommufd_device_get_iommu_dev(struct iommufd_device *idev)
+{
+	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->igroup->group)
+		return NULL;
+	if (WARN_ON_ONCE(!idev->dev->iommu))
+		return NULL;
+	return __iommu_get_iommu_dev(idev->dev);
+}
+
 void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..f6ae60bd3f70 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -804,5 +804,6 @@ MODULE_ALIAS("devname:vfio/vfio");
 MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_IMPORT_NS("IOMMUFD");
 MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33..b51f67fdf4e3 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -25,6 +25,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
+	struct iommu_device *iommu_dev;
 	const struct iommu_ops *ops;
 	size_t viommu_size;
 	int rc;
@@ -36,7 +37,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ops = dev_iommu_ops(idev->dev);
+	iommu_dev = iommufd_device_get_iommu_dev(idev);
+	if (!iommu_dev) {
+		rc = -EOPNOTSUPP;
+		goto out_put_idev;
+	}
+	ops = iommu_dev->ops;
 	if (!ops->get_viommu_size || !ops->viommu_init) {
 		rc = -EOPNOTSUPP;
 		goto out_put_idev;
@@ -87,7 +93,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 * pluggable IOMMU instance (if exists) is responsible for refcounting
 	 * on its own.
 	 */
-	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
+	viommu->iommu_dev = iommu_dev;
 
 	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
 			      user_data.len ? &user_data : NULL);
@@ -146,6 +152,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	struct iommufd_vdevice *vdev, *curr;
 	size_t vdev_size = sizeof(*vdev);
 	struct iommufd_viommu *viommu;
+	struct iommu_device *iommu_dev;
 	struct iommufd_device *idev;
 	u64 virt_id = cmd->virt_id;
 	int rc = 0;
@@ -164,7 +171,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_viommu;
 	}
 
-	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+	iommu_dev = iommufd_device_get_iommu_dev(idev);
+	if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
 		rc = -EINVAL;
 		goto out_put_idev;
 	}
-- 
2.43.0

