From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] ACPI/IORT: Fix CONFIG_IOMMU_API dependency
Date: Fri, 28 Apr 2017 16:59:49 +0100
Message-ID: <1493395189-10857-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: iommu@lists.linux-foundation.org

The IOMMU probe deferral IORT rework had to add code in
iort_iommu_configure() and iort_iommu_xlate() that requires
the IOMMU_API to be selected in order to compile and work.

Stub out the pieces of code that depend on CONFIG_IOMMU_API
to be selected to prevent compilation failures such as:

drivers/acpi/arm64/iort.c: In function 'iort_iommu_xlate':
drivers/acpi/arm64/iort.c:647:22: error: 'struct iommu_fwspec' has no
member named 'ops'

by wrapping the code in static inline functions that provide a NOP
implementation when CONFIG_IOMMU_API is not selected.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Sricharan R <sricharan@codeaurora.org>
---
Joerg, all,

as reported by Arnd:

https://lkml.org/lkml/2017/4/27/303

we have this issue in -next and I managed to write this patch in a
way that applies to Joerg's tree - branch:

arm/core

and does not conflict with ACPI IORT patches queued via arm64 tree.

I know it is late and it is not a major breakage, so either Joerg
applies this patch to his arm/core branch or I can send a fix for -rc1
when both the IOMMU and arm64 trees are merged, please let me know how
you prefer handling it, it is a bit rushed owing to where we are in
the cycle.

Thanks !
Lorenzo

 drivers/acpi/arm64/iort.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e7b1940..a629e83 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -536,6 +536,33 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 	}
 }
 
+#ifdef CONFIG_IOMMU_API
+static inline
+const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
+{
+	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
+}
+
+static inline
+int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
+{
+	int err = 0;
+
+	if (!IS_ERR_OR_NULL(ops) && ops->add_device && dev->bus &&
+	    !dev->iommu_group)
+		err = ops->add_device(dev);
+
+	return err;
+}
+#else
+static inline
+const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
+{ return NULL; }
+static inline
+int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
+{ return 0; }
+#endif
+
 static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 					struct acpi_iort_node *node,
 					u32 streamid)
@@ -543,14 +570,14 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 	const struct iommu_ops *ops = NULL;
 	int ret = -ENODEV;
 	struct fwnode_handle *iort_fwnode;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 
 	/*
 	 * If we already translated the fwspec there
 	 * is nothing left to do, return the iommu_ops.
 	 */
-	if (fwspec && fwspec->ops)
-		return fwspec->ops;
+	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+	if (ops)
+		return ops;
 
 	if (node) {
 		iort_fwnode = iort_get_fwnode(node);
@@ -611,6 +638,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	struct acpi_iort_node *node, *parent;
 	const struct iommu_ops *ops = NULL;
 	u32 streamid = 0;
+	int err;
 
 	if (dev_is_pci(dev)) {
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
@@ -654,13 +682,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * add_device callback for dev, replay it to get things in order.
 	 */
-	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
-	    dev->bus && !dev->iommu_group) {
-		int err = ops->add_device(dev);
-
-		if (err)
-			ops = ERR_PTR(err);
-	}
+	err = iort_add_device_replay(ops, dev);
+	if (err)
+		ops = ERR_PTR(err);
 
 	return ops;
 }
-- 
2.10.0

