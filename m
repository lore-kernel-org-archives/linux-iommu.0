From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
Date: Fri,  7 Dec 2018 16:31:35 +0000
Message-ID: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544199754.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: iommu@lists.linux-foundation.org, m.szyprowski@samsung.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Rather than checking the DMA attribute at each callsite, just pass it
through for acpi_dma_configure() to handle directly. That can then deal
with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
installing dummy DMA ops instead of just skipping setup entirely. This
will then free up the dev->dma_ops == NULL case for some valuable
fastpath optimisations.

CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c      | 5 +++++
 drivers/base/platform.c  | 3 +--
 drivers/pci/pci-driver.c | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd1c59fb0e17..b75ae34ed188 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	const struct iommu_ops *iommu;
 	u64 dma_addr = 0, size = 0;
 
+	if (attr == DEV_DMA_NOT_SUPPORTED) {
+		set_dma_ops(dev, &dma_dummy_ops);
+		return 0;
+	}
+
 	iort_dma_setup(dev, &dma_addr, &size);
 
 	iommu = iort_iommu_configure(dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..c6daca875c17 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
 	}
 
 	return ret;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..f899a28b90f8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
 
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
-- 
2.19.1.dirty
