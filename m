From: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
Subject: [RFC 2/2] drivers: dma-mapping: parse per device reserved mem at probe time
Date: Sun, 26 Nov 2017 21:13:46 +0800
Message-ID: <20171126131346.12532-2-peng.fan@nxp.com>
References: <20171126131346.12532-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171126131346.12532-1-peng.fan-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Invoke of_reserved_mem_device_init at dma_configure, then
there is no need to call of_reserved_mem_device_init in device
specific probe function.

Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
---
 drivers/base/dma-mapping.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index e584eddef0a7..55dca06a7b55 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -351,7 +352,9 @@ int dma_configure(struct device *dev)
 	}
 
 	if (dma_dev->of_node) {
-		ret = of_dma_configure(dev, dma_dev->of_node);
+		ret = of_reserved_mem_device_init(dev);
+		if (ret)
+			ret = of_dma_configure(dev, dma_dev->of_node);
 	} else if (has_acpi_companion(dma_dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
@@ -367,5 +370,6 @@ int dma_configure(struct device *dev)
 void dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
+	of_reserved_mem_device_release(dev);
 	acpi_dma_deconfigure(dev);
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
