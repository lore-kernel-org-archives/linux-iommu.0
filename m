From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 09/10] drivers: acpi: Configure acpi devices dma operation at probe time
Date: Wed, 30 Nov 2016 05:52:23 +0530
Message-ID: <1480465344-11862-10-git-send-email-sricharan@codeaurora.org>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

With all the DT based devices getting their dma ops configured
during probe time to have the right iommu setup, let us do the
same for acpi based devices as well.

Configuring DMA ops at probe time will allow deferring device probe when
the IOMMU isn't available yet. The dma_configure for the device is now called
from the generic device_attach callback just before the bus/driver probe
is called. This way, configuring the DMA ops for the device would be called
at the same place for all bus_types, hence the deferred probing mechanism
should work for all buses as well.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/acpi/glue.c        |  6 ------
 drivers/base/dma-mapping.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index f8d6564..458445f 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -168,7 +168,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	struct list_head *physnode_list;
 	unsigned int node_id;
 	int retval = -EINVAL;
-	enum dev_dma_attr attr;
 
 	if (has_acpi_companion(dev)) {
 		if (acpi_dev) {
@@ -225,10 +224,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	if (!has_acpi_companion(dev))
 		ACPI_COMPANION_SET(dev, acpi_dev);
 
-	attr = acpi_get_dma_attr(acpi_dev);
-	if (attr != DEV_DMA_NOT_SUPPORTED)
-		acpi_dma_configure(dev, attr);
-
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				   physical_node_name);
@@ -250,7 +245,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	return 0;
 
  err:
-	acpi_dma_deconfigure(dev);
 	ACPI_COMPANION_SET(dev, NULL);
 	put_device(dev);
 	put_device(&acpi_dev->dev);
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 576fdfb..2ec4dae 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -347,17 +347,29 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
  * Common configuration to enable DMA API use for a device
  */
 #include <linux/pci.h>
+#include <linux/acpi.h>
 
 int dma_configure(struct device *dev)
 {
+	struct acpi_device *adev;
+	enum dev_dma_attr attr;
+
 	if (dev_is_pci(dev))
 		return pci_dma_configure(dev);
 	else if (dev->of_node)
 		return of_dma_configure(dev, dev->of_node);
+	else if (has_acpi_companion(dev)) {
+		adev = to_acpi_device_node(dev->fwnode);
+		attr = acpi_get_dma_attr(adev);
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			return acpi_dma_configure(dev, attr);
+	}
+
 	return 0;
 }
 
 void dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
+	acpi_dma_deconfigure(dev);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
