From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] of/device: Really only set bus DMA mask when appropriate
Date: Tue,  6 Nov 2018 11:54:15 +0000
Message-ID: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

of_dma_configure() was *supposed* to be following the same logic as
acpi_dma_configure() and only setting bus_dma_mask if some range was
specified by the firmware. However, it seems that subtlety got lost in
the process of fitting it into the differently-shaped control flow, and
as a result the force_dma==true case ends up always setting the bus mask
to the 32-bit default, which is not what anyone wants.

Make sure we only touch it if the DT actually said so.

Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
Reported-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Reported-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Sorry about that... I guess I only have test setups that either have
dma-ranges or where a 32-bit bus mask goes unnoticed :(

The Octeon and SMMU issues sound like they're purely down to this, and
it's probably related to at least one of John's Hikey woes.

Robin.

 drivers/of/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0f27fad9fe94..757ae867674f 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
-	dev->bus_dma_mask = mask;
+	if (!ret)
+		dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 
-- 
2.19.1.dirty
