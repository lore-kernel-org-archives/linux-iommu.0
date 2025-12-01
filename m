Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0732337BB3
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610221; cv=none; b=pIcECGBCCTl84u9Dmy8IzXB5FoMUx2YyW0/+b61+al5FOXpvlIQe+MSkw2h67i204QOBEKUjctccfrg1Msc+kfeJwk3xJqv3fhkvw8Lx1ojXlTzpToLy1eAp62AOhuGEqUdZjfK5ibM+06SCmxQPDXRBMb42ikN2d6biLgrme54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610221; c=relaxed/simple;
	bh=ZvmATApHccUp68CQ/saVJ9hiW70Tyo+WzC7+4XAfl9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6nGWI7hA+1SaGaKW0blrahiJK1hCQkr2C5k7dqTDNDNVFkJQABllkSpoViIepGrGBbAW5xCKc97wWYi+84Fiz9XQSNmz/lOLcNFVZqVRLtLp4tvsuAfWWHV3eLT7vtAUCStRw4j5xP/lUyW8r15Qa0eFQOVBewwmp9Qqx2agoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DToxhsNP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DToxhsNP"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8387206595C;
	Mon,  1 Dec 2025 09:30:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8387206595C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610218;
	bh=TVQKRGF9FbbhmjAA0nq52YgUFuaZHHjhE8pX0uhFLuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DToxhsNPtD/BY4H0tcP6MClzlNBTrQTaLImoU90tWzOYo8PbnqBhkBMg27VUAnVYj
	 49R21v0CbCTOmegHiUAS8+iHL+9CmWAnIYufCrSYnEA7gsIRKJBvoggBThssqF29qg
	 n/Gv9xBoZ3yUIwQ6npUAHOeXuDBedmYnYERmn9IY=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 4/8] iommu: Add a dummy driver for noiommu mode
Date: Mon,  1 Dec 2025 09:30:08 -0800
Message-Id: <20251201173012.18371-5-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a dummy IOMMU driver that enables VFIO character devices (cdevs)
to operate under No-IOMMU mode using IOMMUFD.

Similar to VFIO’s existing No-IOMMU mode, this requires userspace to set
the enable_unsafe_noiommu module parameter, allowing DMA only with
physical addresses. Unlike the traditional VFIO No-IOMMU mode, this option
supports IOMMUFD IOAS UAPIs (e.g., map and unmap) by leveraging mock page
tables provided by the generic IOMMU page table layer.

In this model, IOVAs exposed to userspace are not used for DMA. Instead,
they serve as keys to retrieve corresponding physical addresses from the
mock IO page tables. Memory pinning is still performed the same way as
if there is a physical IOMMU.

For in-kernel DMA, DMA APIs will use direct mode only since this driver
provides identity domain only.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/Kconfig   |  25 +++++
 drivers/iommu/Makefile  |   1 +
 drivers/iommu/noiommu.c | 204 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/iommu/noiommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c9ae3221cd6f..9b3423180d16 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -359,6 +359,31 @@ config HYPERV_IOMMU
 	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
 	  guest and root partitions.
 
+config NOIOMMU_MODE_IOMMU
+	bool "Dummy IOMMU driver to support noiommu mode for IOMMUFD"
+	depends on PCI
+	depends on VFIO_NOIOMMU && VFIO_DEVICE_CDEV
+	depends on IOMMUFD_DRIVER
+	depends on IOMMU_PT
+	depends on GENERIC_PT
+	depends on IOMMU_PT_AMDV1
+	select IOMMU_API
+	help
+	  This option introduces a dummy IOMMU driver that enables VFIO cdevs
+	  to operate under no-IOMMU mode using IOMMUFD. Similar to VFIO’s
+	  existing no-IOMMU mode, this requires userspace to set the
+	  enable_unsafe_noiommu module parameter, allowing DMA only with physical
+	  addresses. Unlike the traditional VFIO no-IOMMU mode, this option
+	  supports IOMMUFD IOAS UAPIs such as map and unmap by leveraging mock
+	  page tables provided by the generic IOMMU page table layer. The IOVAs
+	  exposed to userspace are not used for DMA; instead, they serve as keys
+	  to retrieve corresponding physical addresses from these mock tables.
+	  Memory pinning is still performed to ensure that physical pages remain
+	  resident during DMA operations.
+	  VFIO group based No-IOMMU mode is mutually exclusive with this option.
+
+	  If unsure, say N here.
+
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index b17ef9818759..226041e928fa 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_NOIOMMU_MODE_IOMMU) += noiommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
diff --git a/drivers/iommu/noiommu.c b/drivers/iommu/noiommu.c
new file mode 100644
index 000000000000..06125a190686
--- /dev/null
+++ b/drivers/iommu/noiommu.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Microsoft Corporation.
+ */
+
+#define pr_fmt(fmt) "NOIOMMU: " fmt
+#include <linux/device.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/generic_pt/iommu.h>
+#include <linux/vfio.h>
+
+#include "iommu-priv.h"
+
+struct noiommu_dev {
+	struct iommu_device		iommu;
+	struct device *dev;
+};
+
+struct noiommu_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+	};
+};
+
+static struct iommu_ops noiommu_ops;
+
+struct noiommu_dev noiommu_dev = {
+    .iommu = {
+        .ops = &noiommu_ops,
+    },
+};
+
+static void noiommu_release_device(struct device *dev)
+{
+}
+
+static struct iommu_device *noiommu_probe_device(struct device *dev)
+{
+	/* Support VFIO PCI devices only */
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	return &noiommu_dev.iommu;
+}
+
+static int noiommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	return 0;
+}
+
+static void noiommu_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+static const struct iommu_domain_ops noiommu_amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.free = noiommu_domain_free,
+	.attach_dev = noiommu_attach_dev,
+};
+
+static struct iommu_domain *
+noiommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
+			       const struct iommu_user_data *user_data)
+{
+	struct noiommu_domain *noiommu_dom;
+	struct pt_iommu_amdv1_cfg cfg = {};
+	int rc;
+
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (vfio_noiommu_enabled() == false) {
+		pr_info("Must enable unsafe_noiommu_mode\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	cfg.common.hw_max_vasz_lg2 = 64;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.features = BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+	cfg.starting_level = 2;
+
+	noiommu_dom = kzalloc(sizeof(*noiommu_dom), GFP_KERNEL);
+	if (!noiommu_dom)
+		return ERR_PTR(-ENOMEM);
+
+	noiommu_dom->amdv1.iommu.nid = NUMA_NO_NODE;
+	noiommu_dom->domain.ops = &noiommu_amdv1_ops;
+
+	/* Use mock page table which is based on AMDV1 */
+	rc = pt_iommu_amdv1_noiommu_init(&noiommu_dom->amdv1, &cfg, GFP_KERNEL);
+	if (rc) {
+		kfree(noiommu_dom);
+		return ERR_PTR(rc);
+	}
+
+	return &noiommu_dom->domain;
+}
+
+static int noiommu_domain_nop_attach(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	return 0;
+}
+
+static const struct iommu_domain_ops noiommu_nop_ops = {
+	.attach_dev = noiommu_domain_nop_attach,
+};
+
+static struct iommu_domain noiommu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &noiommu_nop_ops,
+};
+
+static struct iommu_domain noiommu_blocking_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &noiommu_nop_ops,
+};
+
+static bool noiommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	/* Fake cache coherency support to allow iommufd-dev bind */
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct iommu_ops noiommu_ops = {
+	.default_domain = &noiommu_identity_domain,
+	.blocked_domain = &noiommu_blocking_domain,
+	.capable		= noiommu_capable,
+	.domain_alloc_paging_flags = noiommu_domain_alloc_paging_flags,
+	.probe_device		= noiommu_probe_device,
+	.release_device		= noiommu_release_device,
+	.device_group = generic_device_group,
+	.owner			= THIS_MODULE,
+	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.attach_dev		= noiommu_attach_dev,
+		.free			= noiommu_domain_free,
+	}
+};
+
+struct notifier_block noiommu_bus_nb = {
+	/* data */
+};
+
+static int iommu_noiommu_dev_add(struct device *dev, struct iommu_device *iommu)
+{
+	return iommu_fwspec_init(dev, iommu->fwnode);
+}
+
+static int __init noiommu_init(void)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (iommu_is_registered()) {
+		pr_info("IOMMU devices already registered, skipping No-IOMMU driver\n");
+		return 0;
+	}
+    pr_debug("Initializing No-IOMMU driver\n");
+    iommu_device_sysfs_add(&noiommu_dev.iommu, noiommu_dev.dev, NULL,
+     "%s", "noiommu");
+
+	if (iommu_device_register_bus(&noiommu_dev.iommu, &noiommu_ops,
+		&pci_bus_type, &noiommu_bus_nb))
+		return -ENODEV;
+
+	for_each_pci_dev(pdev) {
+		if (iommu_noiommu_dev_add(&pdev->dev, &noiommu_dev.iommu)) {
+			dev_err(&pdev->dev, "Failed to add no-IOMMU fwspec \n");
+			continue;
+		}
+		iommu_probe_device(&pdev->dev);
+		dev_dbg(&pdev->dev, "Probed PCI device for no IOMMU\n");
+	}
+
+	return 0;
+}
+early_initcall(noiommu_init);
+
+static void __exit noiommu_exit(void)
+{
+    pr_debug("Exiting No-IOMMU driver\n");
+
+	/* No hardware resources to clean up */
+    iommu_device_unregister(&noiommu_dev.iommu);
+
+}
+
+module_init(noiommu_init);
+module_exit(noiommu_exit);
+
+MODULE_DESCRIPTION("No-IOMMU driver for PCI devices without hardware IOMMU");
+MODULE_AUTHOR("Anonymous");
+MODULE_LICENSE("GPL v2");
\ No newline at end of file
-- 
2.34.1

