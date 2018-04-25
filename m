From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device() API
Date: Wed, 25 Apr 2018 12:10:48 +0200
Message-ID: <20180425101051.15349-2-thierry.reding@gmail.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180425101051.15349-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The dma_iommu_detach_device() API can be used by drivers to forcibly
detach a device from an IOMMU that architecture code might have attached
to. This is useful for drivers that need explicit control over the IOMMU
using the IOMMU API directly.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/dma-mapping.c  | 8 ++++++++
 include/linux/dma-mapping.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index d82566d6e237..18ddf32b10c9 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -366,3 +366,11 @@ void dma_deconfigure(struct device *dev)
 	of_dma_deconfigure(dev);
 	acpi_dma_deconfigure(dev);
 }
+
+void dma_iommu_detach_device(struct device *dev)
+{
+#ifdef arch_iommu_detach_device
+	arch_iommu_detach_device(dev);
+#endif
+}
+EXPORT_SYMBOL(dma_iommu_detach_device);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0f589e..732191a2c64e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -671,6 +671,8 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 static inline void arch_teardown_dma_ops(struct device *dev) { }
 #endif
 
+extern void dma_iommu_detach_device(struct device *dev);
+
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->max_segment_size)
-- 
2.17.0
