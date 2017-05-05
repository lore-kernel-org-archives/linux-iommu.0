From: Oza Pawandeep via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v4 2/3] iommu/pci: reserve IOVA for PCI masters
Date: Fri,  5 May 2017 19:17:19 +0530
Message-ID: <1493992040-31222-3-git-send-email-oza.oza@broadcom.com>
References: <1493992040-31222-1-git-send-email-oza.oza@broadcom.com>
Reply-To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493992040-31222-1-git-send-email-oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
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

this patch reserves the IOVA for PCI masters.
ARM64 based SOCs may have scattered memory banks.
such as iproc based SOC has

<0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
<0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
<0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
<0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */

but incoming PCI transcation addressing capability is limited
by host bridge, for example if max incoming window capability
is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.

to address this problem, iommu has to avoid allocating IOVA which
are reserved. which inturn does not allocate IOVA if it falls into hole.

Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48d36ce..08764b0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -171,8 +172,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct device_node *np = bridge->dev.parent->of_node;
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	int ret;
+	dma_addr_t tmp_dma_addr = 0, dma_addr;
+	LIST_HEAD(res);
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM &&
@@ -183,6 +188,36 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* PCI inbound memory reservation. */
+	ret = of_pci_get_dma_ranges(np, &res);
+	if (!ret) {
+		resource_list_for_each_entry(window, &res) {
+			struct resource *res_dma = window->res;
+
+			dma_addr = res_dma->start - window->offset;
+			if (tmp_dma_addr > dma_addr) {
+				pr_warn("PCI: failed to reserve iovas; ranges should be sorted\n");
+				return;
+			}
+			if (tmp_dma_addr != dma_addr) {
+				lo = iova_pfn(iovad, tmp_dma_addr);
+				hi = iova_pfn(iovad, dma_addr - 1);
+				reserve_iova(iovad, lo, hi);
+			}
+			tmp_dma_addr = window->res->end - window->offset;
+		}
+		/*
+		 * the last dma-range should honour based on the
+		 * 32/64-bit dma addresses.
+		 */
+		if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
+			lo = iova_pfn(iovad, tmp_dma_addr);
+			hi = iova_pfn(iovad,
+				      DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
+			reserve_iova(iovad, lo, hi);
+		}
+	}
 }
 
 /**
-- 
1.9.1
