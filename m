Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC3361DB0
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201257; cv=none; b=Yo91XW8tMsilpeCPnPsMpUtzcGefDqAvY2q0PHAyvHqWBYCY+rfXrV55W332iun9orKE3BsIpsCTp/OUhwLISa9fduzH/fAsO034v9XItcC256aJKi7xIzw3LPb83iK8RcbpxLEIg0RiS5aWYIIZmvadke3ppfs/CqhnWwhZNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201257; c=relaxed/simple;
	bh=Lhuq5xAlpwVPJn07YR/Cag2fu1WPE3u3MTdnXtAAdOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/5c46/FOzHbNxVVr9KPMzwzwTFhNg6u2wu//ytV5Qb3kf41yxUlqKMO+mH9kLiHuCMjGoGF7CQljuBHPgEx/DqN82qs4oXlr8iawgBVCwjlI1/g1FhNxqhfmR+TOFVfdyWJhDWLhp+QzH/N9WiB7+yNIhd3/DS1B8+1qbiZVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MlRp2nCR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MlRp2nCR"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CE4D120B6F08;
	Tue, 14 Apr 2026 14:14:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE4D120B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776201255;
	bh=DueQqGsTeBZ5f9epBqPjmXrmVIT9Xztuh7ie4O7QWxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlRp2nCRMjo3p5MuVZNqNBiIb4zcwNBqx6YZY56JszJAra5mlEdnyczHLzhI7BwNr
	 BYZZGQhx9ygYjAzNLC1MhyMmlHa0iJ0lKDJwsNhRLGoBgcmY5sm5MgnaOfhobRCnyh
	 ISP19pgS8GAqHBKUh/GiG7T4441XWm2dbIe3Iiok=
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
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver for noiommu
Date: Tue, 14 Apr 2026 14:14:03 -0700
Message-Id: <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

---
v4:
   - Make iommufd_noiommu_ops const
v3:
   - Add comment to explain the design difference over the
     legacy noiommu VFIO code.

fix const hwpt
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/hw_pagetable.c    |  11 ++-
 drivers/iommu/iommufd/hwpt_noiommu.c    | 102 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 4 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..2b1a020b14a6 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -10,6 +10,7 @@ iommufd-y := \
 	vfio_compat.o \
 	viommu.o
 
+iommufd-$(CONFIG_VFIO_NOIOMMU) += hwpt_noiommu.o
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fe789c2dc0c9..37316d77277d 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,13 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
+{
+	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) && !idev->igroup->group)
+		return &iommufd_noiommu_ops;
+	return dev_iommu_ops(idev->dev);
+}
+
 static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->domain)
@@ -114,7 +121,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
 				IOMMU_HWPT_FAULT_ID_VALID |
 				IOMMU_HWPT_ALLOC_PASID;
-	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	const struct iommu_ops *ops = get_iommu_ops(idev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -229,7 +236,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
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
index 000000000000..1c8cae02beec
--- /dev/null
+++ b/drivers/iommu/iommufd/hwpt_noiommu.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
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
+ * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to the
+ * iommufd selftest mock page table.
+ * Unlike legacy VFIO no-IOMMU mode, where no container level APIs are
+ * supported, this allows IOAS and hwpt objects to exist without hardware
+ * IOMMU support. IOVAs are used only for IOVA-to-PA lookups not for
+ * hardware translation in DMA.
+ *
+ * This is only used with iommufd and cdev-based interfaces and does not
+ * apply to legacy VFIO group-container based noiommu mode.
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
2.34.1

