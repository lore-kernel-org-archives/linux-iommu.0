Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621341428B
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQTGk+hL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510676; x=1733046676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oxDYXG3AJzaeGNtpp4op0WAgqkteWZvXNKWbORIdg58=;
  b=AQTGk+hLusXSvlzOCxF2YGFNFIZhxGcrrHh56uwR9yxTkaTeK+ac5e9Y
   ABdVHKJZ+bpghVU6qB1XAJgKy053tiMo/R8IgNZW57rXvURqXJDBipPc0
   F+nuO+SyXALfNQ39zTIerfTuBPNQ7/K/tzzQ4+mYrP4urhU/LoT8jEgRx
   x9gPZzard/MGbjftu4NKP9UiTKB1DZBpekSD5+1vh34MmrvpcNUFca60O
   V3XuKHTyINh3Fhti7q7wdUVOSEKQHEDn7qsinUJKgzpEVHsTU/BZFSoCC
   jZVimKswuh3J7dWnGOU6OGmozmQVcWJbQQnv77YjNdFuNVwkizk3C5zFy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="479794164"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="479794164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="11414337"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:51:12 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com,
	jgg@nvidia.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	yi.l.liu@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 14/42] iommufd: Enable KVM HW page table object to be proxy between KVM and IOMMU
Date: Sat,  2 Dec 2023 17:22:16 +0800
Message-Id: <20231202092216.14278-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Enable IOMMUFD KVM HW page table object to serve as proxy between KVM and
IOMMU driver. Config IOMMUFD_KVM_HWPT is added to turn on/off this ability.

KVM HW page table object first gets KVM TDP fd object via KVM exported
interface kvm_tdp_fd_get() and then queries KVM for vendor meta data of
page tables exported (shared) by KVM. It then passes the meta data to IOMMU
driver to create a IOMMU_DOMAIN_KVM domain via op domain_alloc_kvm.
IOMMU driver is responsible to check compatibility between IOMMU hardware
and the KVM exported page tables.

After successfully creating IOMMU_DOMAIN_KVM domain, IOMMUFD KVM HW page
table object registers invalidation callback to KVM to receive invalidation
notifications. It then passes the notification to IOMMU driver via op
cache_invalidate_kvm to invalidate hardware TLBs.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/iommufd/Kconfig            |  10 ++
 drivers/iommu/iommufd/Makefile           |   1 +
 drivers/iommu/iommufd/hw_pagetable_kvm.c | 183 +++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h  |   9 ++
 4 files changed, 203 insertions(+)
 create mode 100644 drivers/iommu/iommufd/hw_pagetable_kvm.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 99d4b075df49e..d79e0c1e00a4d 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -32,6 +32,16 @@ config IOMMUFD_VFIO_CONTAINER
 
 	  Unless testing IOMMUFD, say N here.
 
+config IOMMUFD_KVM_HWPT
+	bool "Supports KVM managed HW page tables"
+	default n
+	help
+	  Selecting this option will allow IOMMUFD to create IOMMU stage 2
+	  page tables whose paging structure and mappings are managed by
+	  KVM MMU. IOMMUFD serves as proxy between KVM and IOMMU driver to
+	  allow IOMMU driver to get paging structure meta data and cache
+	  invalidate notifications from KVM.
+
 config IOMMUFD_TEST
 	bool "IOMMU Userspace API Test support"
 	depends on DEBUG_KERNEL
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 34b446146961c..ae1e0b5c300dc 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -8,6 +8,7 @@ iommufd-y := \
 	pages.o \
 	vfio_compat.o
 
+iommufd-$(CONFIG_IOMMUFD_KVM_HWPT) += hw_pagetable_kvm.o
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/hw_pagetable_kvm.c b/drivers/iommu/iommufd/hw_pagetable_kvm.c
new file mode 100644
index 0000000000000..e0e205f384ed5
--- /dev/null
+++ b/drivers/iommu/iommufd/hw_pagetable_kvm.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
+#include <linux/kvm_tdp_fd.h>
+
+#include "../iommu-priv.h"
+#include "iommufd_private.h"
+
+static void iommufd_kvmtdp_invalidate(void *data,
+				      unsigned long start, unsigned long size)
+{
+	void (*invalidate_fn)(struct iommu_domain *domain,
+			      unsigned long iova, unsigned long size);
+	struct iommufd_hw_pagetable *hwpt = data;
+
+	if (!hwpt || !hwpt_is_kvm(hwpt))
+		return;
+
+	invalidate_fn = hwpt->domain->ops->cache_invalidate_kvm;
+
+	if (!invalidate_fn)
+		return;
+
+	invalidate_fn(hwpt->domain, start, size);
+
+}
+
+struct kvm_tdp_importer_ops iommufd_import_ops = {
+	.invalidate = iommufd_kvmtdp_invalidate,
+};
+
+static inline int kvmtdp_register(struct kvm_tdp_fd *tdp_fd, void *data)
+{
+	if (!tdp_fd->ops->register_importer || !tdp_fd->ops->register_importer)
+		return -EOPNOTSUPP;
+
+	return tdp_fd->ops->register_importer(tdp_fd, &iommufd_import_ops, data);
+}
+
+static inline void kvmtdp_unregister(struct kvm_tdp_fd *tdp_fd)
+{
+	WARN_ON(!tdp_fd->ops->unregister_importer);
+
+	tdp_fd->ops->unregister_importer(tdp_fd, &iommufd_import_ops);
+}
+
+static inline void *kvmtdp_get_metadata(struct kvm_tdp_fd *tdp_fd)
+{
+	if (!tdp_fd->ops->get_metadata)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return tdp_fd->ops->get_metadata(tdp_fd);
+}
+
+/*
+ * Get KVM TDP FD object and ensure tdp_fd->ops is available
+ */
+static inline struct kvm_tdp_fd *kvmtdp_get(int fd)
+{
+	struct kvm_tdp_fd *tdp_fd = NULL;
+	struct kvm_tdp_fd *(*get_func)(int fd) = NULL;
+	void (*put_func)(struct kvm_tdp_fd *) = NULL;
+
+	get_func = symbol_get(kvm_tdp_fd_get);
+
+	if (!get_func)
+		goto out;
+
+	put_func = symbol_get(kvm_tdp_fd_put);
+	if (!put_func)
+		goto out;
+
+	tdp_fd = get_func(fd);
+	if (!tdp_fd)
+		goto out;
+
+	if (tdp_fd->ops) {
+		/* success */
+		goto out;
+	}
+
+	put_func(tdp_fd);
+	tdp_fd = NULL;
+
+out:
+	if (get_func)
+		symbol_put(kvm_tdp_fd_get);
+
+	if (put_func)
+		symbol_put(kvm_tdp_fd_put);
+
+	return tdp_fd;
+}
+
+static void kvmtdp_put(struct kvm_tdp_fd *tdp_fd)
+{
+	void (*put_func)(struct kvm_tdp_fd *) = NULL;
+
+	put_func = symbol_get(kvm_tdp_fd_put);
+	WARN_ON(!put_func);
+
+	put_func(tdp_fd);
+
+	symbol_put(kvm_tdp_fd_put);
+}
+
+void iommufd_hwpt_kvm_destroy(struct iommufd_object *obj)
+{
+	struct kvm_tdp_fd *tdp_fd;
+	struct iommufd_hwpt_kvm *hwpt_kvm =
+		container_of(obj, struct iommufd_hwpt_kvm, common.obj);
+
+	if (hwpt_kvm->common.domain)
+		iommu_domain_free(hwpt_kvm->common.domain);
+
+	tdp_fd = hwpt_kvm->context;
+	kvmtdp_unregister(tdp_fd);
+	kvmtdp_put(tdp_fd);
+}
+
+void iommufd_hwpt_kvm_abort(struct iommufd_object *obj)
+{
+	iommufd_hwpt_kvm_destroy(obj);
+}
+
+struct iommufd_hwpt_kvm *
+iommufd_hwpt_kvm_alloc(struct iommufd_ctx *ictx,
+		       struct iommufd_device *idev, u32 flags,
+		       const struct iommu_hwpt_kvm_info *kvm_data)
+{
+
+	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommufd_hwpt_kvm *hwpt_kvm;
+	struct iommufd_hw_pagetable *hwpt;
+	struct kvm_tdp_fd *tdp_fd;
+	void *meta_data;
+	int rc;
+
+	if (!ops->domain_alloc_kvm)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (kvm_data->fd < 0)
+		return ERR_PTR(-EINVAL);
+
+	tdp_fd = kvmtdp_get(kvm_data->fd);
+	if (!tdp_fd)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	meta_data = kvmtdp_get_metadata(tdp_fd);
+	if (!meta_data || IS_ERR(meta_data)) {
+		rc = -EFAULT;
+		goto out_put_tdp;
+	}
+
+	hwpt_kvm = __iommufd_object_alloc(ictx, hwpt_kvm, IOMMUFD_OBJ_HWPT_KVM,
+					  common.obj);
+	if (IS_ERR(hwpt_kvm)) {
+		rc = PTR_ERR(hwpt_kvm);
+		goto out_put_tdp;
+	}
+
+	hwpt_kvm->context = tdp_fd;
+	hwpt = &hwpt_kvm->common;
+
+	hwpt->domain = ops->domain_alloc_kvm(idev->dev, flags, meta_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+
+	rc = kvmtdp_register(tdp_fd, hwpt);
+	if (rc)
+		goto out_abort;
+
+	return hwpt_kvm;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
+out_put_tdp:
+	kvmtdp_put(tdp_fd);
+	return ERR_PTR(rc);
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a46a6e3e537f9..2c3149b1d5b55 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -432,6 +432,14 @@ static inline bool iommufd_selftest_is_mock_dev(struct device *dev)
 #endif
 
 struct iommu_hwpt_kvm_info;
+#ifdef CONFIG_IOMMUFD_KVM_HWPT
+struct iommufd_hwpt_kvm *
+iommufd_hwpt_kvm_alloc(struct iommufd_ctx *ictx,
+		       struct iommufd_device *idev, u32 flags,
+		       const struct iommu_hwpt_kvm_info *kvm_data);
+void iommufd_hwpt_kvm_abort(struct iommufd_object *obj);
+void iommufd_hwpt_kvm_destroy(struct iommufd_object *obj);
+#else
 static inline struct iommufd_hwpt_kvm *
 iommufd_hwpt_kvm_alloc(struct iommufd_ctx *ictx,
 		       struct iommufd_device *idev, u32 flags,
@@ -447,5 +455,6 @@ static inline void iommufd_hwpt_kvm_abort(struct iommufd_object *obj)
 static inline void iommufd_hwpt_kvm_destroy(struct iommufd_object *obj)
 {
 }
+#endif
 
 #endif
-- 
2.17.1

