From: Oza Pawandeep via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [RFC PATCH 2/2] of/pci: call pci specific dma-ranges instead of
	memory-mapped.
Date: Thu, 30 Mar 2017 15:29:46 +0530
Message-ID: <1490867986-5675-2-git-send-email-oza.oza@broadcom.com>
References: <1490867986-5675-1-git-send-email-oza.oza@broadcom.com>
Reply-To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490867986-5675-1-git-send-email-oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

it is possible that PCI device supports 64-bit DMA addressing,
and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
however PCI host bridge may have limitations on the inbound
transaction addressing. As an example, consider NVME SSD device
connected to iproc-PCIe controller.

Currently, the IOMMU DMA ops only considers PCI device dma_mask
when allocating an IOVA. This is particularly problematic on
ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to
PA for in-bound transactions only after PCI Host has forwarded
these transactions on SOC IO bus. This means on such ARM/ARM64
SOCs the IOVA of in-bound transactions has to honor the addressing
restrictions of the PCI Host.

this patch calls pci specific of_pci_dma_get_ranges, instead of
calling memory-mapped one, which returns wrong size and also
not meant for PCI world.

with this, it gets accurate resources back, and largest possible
inbound window size. with that largest possible dma_mask can be
generated.

Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

diff --git a/drivers/of/device.c b/drivers/of/device.c
index b1e6beb..d6a8dde 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/of_pci.h>
 
 #include <asm/errno.h>
 #include "of_private.h"
@@ -89,6 +90,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	bool coherent;
 	unsigned long offset;
 	const struct iommu_ops *iommu;
+	struct resource_entry *window;
+	LIST_HEAD(res);
 
 	/*
 	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
@@ -104,7 +107,24 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;
 
-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	if (dev_is_pci(dev)) {
+		size = 0;
+		ret = of_pci_get_dma_ranges(np, &res);
+		if (!ret) {
+			resource_list_for_each_entry(window, &res) {
+				struct resource *res_dma = window->res;
+				if (size < resource_size(res_dma)) {
+					dma_addr = res_dma->start - window->offset;
+					paddr = res_dma->start;
+					size = resource_size(res_dma);
+				}
+			}
+		}
+		pci_free_resource_list(&res);
+	}
+	else
+		ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+
 	if (ret < 0) {
 		dma_addr = offset = 0;
 		size = dev->coherent_dma_mask + 1;
-- 
1.9.1
