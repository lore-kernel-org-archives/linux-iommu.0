From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 02/12] linux/types.h: Add dma_peer_addr_t type
Date: Wed, 22 Jul 2015 16:39:47 -0500
Message-ID: <1437601197-6481-3-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S.
	Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On some platforms, a dma_addr_t is only 32 bits wide, but the bus addresses
can be 64 bits wide. For peer-to-peer DMA, a device needs to use the full
64-bit address. Therefore, introduce a DMA address type that is not
constrained by the CPU DMA address size.

This is only needed for peer-to-peer DMA, so guard this definition with a
CONFIG_HAS_DMA_P2P check.

Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/types.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 8715287..dd85173 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -140,13 +140,13 @@ typedef unsigned long blkcnt_t;
 #define pgoff_t unsigned long
 
 /*
- * A dma_addr_t can hold any valid DMA address, i.e., any address returned
+ * A dma_addr_t can hold any valid DMA address, i.e., most addresses returned
  * by the DMA API.
  *
  * If the DMA API only uses 32-bit addresses, dma_addr_t need only be 32
  * bits wide.  Bus addresses, e.g., PCI BARs, may be wider than 32 bits,
  * but drivers do memory-mapped I/O to ioremapped kernel virtual addresses,
- * so they don't care about the size of the actual bus addresses.
+ * so they don't care about the size of the actual bus addresses in most cases.
  */
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 dma_addr_t;
@@ -154,6 +154,15 @@ typedef u64 dma_addr_t;
 typedef u32 dma_addr_t;
 #endif
 
+/*
+ * Unlike dma_addr_t, a dma_peer_addr_t can hold any bus address for the
+ * platform. Drivers should only need this for peer-to-peer use cases, where
+ * the DMA target is also on the bus.
+ */
+#ifdef CONFIG_HAS_DMA_P2P
+typedef u64 dma_peer_addr_t;
+#endif
+
 typedef unsigned __bitwise__ gfp_t;
 typedef unsigned __bitwise__ fmode_t;
 typedef unsigned __bitwise__ oom_flags_t;
-- 
2.4.6
