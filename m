From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v4 6/8] dma-mapping: set dma segment properties in
	of_dma_configure
Date: Fri, 14 Nov 2014 18:56:35 +0000
Message-ID: <1415991397-9618-7-git-send-email-will.deacon@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415991397-9618-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

of_dma_configure determines the size of the DMA range for a device by
either parsing the dma-ranges property or inspecting the coherent DMA
mask. This same information can be used to initialise the max segment
size and boundary_mask to a default value.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/of/platform.c           | 4 ++++
 include/linux/amba/bus.h        | 1 +
 include/linux/platform_device.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b89caf8c7586..0a2842d91db4 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -191,6 +191,8 @@ static void of_dma_configure(struct device *dev)
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
 	}
 	dev->dma_pfn_offset = offset;
+	dma_set_max_seg_size(dev, size);
+	dma_set_seg_boundary(dev, size);
 
 	coherent = of_dma_is_coherent(dev->of_node);
 	dev_dbg(dev, "device is%sdma coherent\n",
@@ -236,6 +238,7 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
+	dev->dev.dma_parms = &dev->dma_parms;
 	of_dma_configure(&dev->dev);
 
 	if (of_device_add(dev) != 0) {
@@ -295,6 +298,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = parent;
 	dev->dev.platform_data = platform_data;
+	dev->dev.dma_parms = &dev->dma_parms;
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index c324f5700d1a..9b232eeb6c20 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -32,6 +32,7 @@ struct amba_device {
 	struct clk		*pclk;
 	unsigned int		periphid;
 	unsigned int		irq[AMBA_NR_IRQS];
+	struct device_dma_parameters dma_parms;
 };
 
 struct amba_driver {
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 153d303af7eb..8dc48487b34b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -27,6 +27,8 @@ struct platform_device {
 	u32		num_resources;
 	struct resource	*resource;
 
+	struct device_dma_parameters dma_parms;
+
 	const struct platform_device_id	*id_entry;
 	char *driver_override; /* Driver name to force a match */
 
-- 
2.1.1
