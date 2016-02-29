From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 04/12] arm64/dma-mapping: Extend DMA ops workaround to PCI devices
Date: Mon, 29 Feb 2016 13:46:13 +0000
Message-ID: <ffcca878210c916962c562d3d1341aae93d593d0.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1456514380.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

PCI devices now suffer the same hiccup as platform devices, in that they
get their DMA ops configured before they have been added to their bus,
and thus before we know whether they have successfully registered with
an IOMMU or not. Until the necessary driver core changes to reorder
calls during device creation have been worked out, extend our delayed
notifier trick onto the PCI bus so as to avoid broken DMA ops for IOMMUs
there.

CC: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
CC: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757c..607e709 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -933,6 +933,10 @@ static int __init __iommu_dma_init(void)
 		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
 	if (!ret)
 		ret = register_iommu_dma_ops_notifier(&amba_bustype);
+#ifdef CONFIG_PCI
+	if (!ret)
+		ret = register_iommu_dma_ops_notifier(&pci_bus_type);
+#endif
 
 	/* handle devices queued before this arch_initcall */
 	if (!ret)
-- 
2.7.2.333.g70bd996.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
