Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A03C37A6
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465484; cv=none; b=qmaDyRAyJ8MZYxN298EQyG3S7v1AkAyhbPypZcPdDhcdukGN8QmECg4CTDooSPDIeQ8QuyuKJHEhS1MVxsNW7ImpqMVJPc2307DTJye3SV7OrcpAVajnj6FHj1sp6/nGdpayGBfkWitdwDhhDPwrI8FJ53lW3r0C3bU6tn/xwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465484; c=relaxed/simple;
	bh=2h0GG/Swr87n8wCesaz3zlfAUEUFlxa47niZ6o25uxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfLc9qFWjWMtPaJObC2gMKMmi4F1nTvl9DjO/V9x6Cu3uZDEGygqYNu2m/9H4695bCRQBwL6sgo2DzUsGvw0jH3hSWNB+DiI1gY/ldZ1Ooog02RtklbUJxgyEgBJKKVdeleQlAZgB3uWpS445gQavthm/5VpQXFO3xZgoCfmTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PY+0rO8K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PY+0rO8K"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id C996220B7169;
	Tue,  2 Jun 2026 22:44:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C996220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780465465;
	bh=bFCmP32qQu3YMv/tXyuvWqYdOMsKZRPOVb86ajVfBNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PY+0rO8KS7ZzHXVkqo1K3d4vnNLL/9fm4VvGnX+OM7KdHlW33g5KFE7vi50JdNLJh
	 B3x2rHrL5EBR8mnRxW5RoIpk9nyYELqoxAfbXkp8kkZXym9Z3RVuOiZUfBW50+nVFq
	 v/ZbVi8Mylh23RyxelqG/iEl+JPEcAcY4SMBx14I=
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
Subject: [PATCH v7 1/6] iommufd: Support a HWPT without an iommu driver for noiommu
Date: Tue,  2 Jun 2026 22:44:33 -0700
Message-ID: <20260603054438.2450130-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
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
 drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
 drivers/iommu/iommufd/hwpt_noiommu.c    | 105 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 drivers/iommu/iommufd/main.c            |   1 +
 6 files changed, 134 insertions(+), 2 deletions(-)
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
index fe789c2dc0c9..0ae14cd3fc72 100644
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
index 6ac1965199e9..2682b5baa6e9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
+extern const struct iommu_ops iommufd_noiommu_ops;
+
 struct iommufd_attach;
 
 struct iommufd_group {
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
-- 
2.43.0

