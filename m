Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82C47CC64
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524881; cv=none; b=OoZ/l0sbrlhv8NoTiSZjADC4gzglFhWqMAa0H4hvM6lGNdaTYfj1kU7gS0ZKMAvk+hS2+szS2WlxqTSFDeTEw5PmRSpM8q+SR6ytmXK7cKfVF5uUqM1FS5UxcwCPp8ayhtYwHU8YeuEKd03vJ63aCU2abLd8OtLBAHmde6IojVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524881; c=relaxed/simple;
	bh=t6bqBr6IS5XERY7OEmVlf1KEsbach914eDo3vRK3Gxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBJFs7epXMwwftlLOq7VE9D85BZXBC9tuaknN5AxnW7Q78bXqC5vWArvXm6BSCE4HRUS1FgYJswN/8MKAKZSuS+mbuDqBtPv6l+ldOMT18fLfz+AucQ7WmosgDx230WMu6VXayneoxdqkRFZpAjKqrayu0Z4pdht+QQeNMmDows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g7ADrjTm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7ADrjTm"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 05E3820B716A;
	Mon, 11 May 2026 11:41:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05E3820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778524877;
	bh=1IHhz2EChqzP1rLu37BY3+70LmYJ70cE8ptFEXHUdbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7ADrjTm3Cg8RRYCx0TQy5DtmNjWDbZyC+axF6x6y2zimIuj/DcNCRIhDI5vfIMTS
	 3O/clQQFCj7N2pr2vUb4d1Rk7gcxmMSXvX4gZyPvgYeUBBdLSSU7hAe/04NCffNIcZ
	 5EBV6bXC0FOUPMv0rIK7xtMYEu1w12SXYVxeOqRw=
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
	Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 2/9] iommufd: Support a HWPT without an iommu driver for noiommu
Date: Mon, 11 May 2026 11:41:07 -0700
Message-ID: <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
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
 drivers/iommu/iommufd/Kconfig           |  13 +++
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
 drivers/iommu/iommufd/hwpt_noiommu.c    | 102 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 5 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 455bac0351f2..74d6ea5b5b3b 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -16,6 +16,19 @@ config IOMMUFD
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
+
+	  Selected by VFIO_CDEV_NOIOMMU. Not intended to be enabled directly.
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
index 000000000000..b1efc4bca880
--- /dev/null
+++ b/drivers/iommu/iommufd/hwpt_noiommu.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/iommu.h>
+#include <linux/generic_pt/iommu.h>
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
+	/* Use mock page table which is based on AMDV1 */
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
+/*
+ * AMDV1 is used as a SW-only page table for no-IOMMU mode, similar to the
+ * iommufd selftest mock page table.
+ * Unlike the VFIO group-container based no-IOMMU mode, where no container
+ * level APIs are supported, this allows IOAS and hwpt objects to exist
+ * without hardware IOMMU support. IOVAs are used only for IOVA-to-PA
+ * lookups not for hardware translation in DMA.
+ *
+ * This is only used with iommufd and cdev-based interfaces and does not
+ * apply to the VFIO group-container based noiommu mode.
+ */
+static const struct iommu_domain_ops noiommu_amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
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
-- 
2.43.0

