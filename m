From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
Date: Mon, 23 Jul 2018 23:16:12 +0100
Message-ID: <66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1532382222.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hch@lst.de, m.szyprowski@samsung.com
Cc: lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Now that we can track upstream DMA constraints properly with
bus_dma_mask instead of trying (and failing) to maintain it in
coherent_dma_mask, it doesn't make much sense for the firmware code to
be touching the latter at all. It's merely papering over bugs wherein a
driver has failed to call dma_set_coherent_mask() *and* the bus code has
not initialised any default value.

We don't really want to encourage more drivers coercing dma_mask so
we'll continue to fix that up if necessary, but add a warning to help
flush out any such buggy bus code that remains.

CC: Rob Herring <robh+dt@kernel.org>
CC: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0d39633e8545..5957cd4fa262 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -127,20 +127,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	}
 
 	/*
-	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
-	 * setup the correct supported mask.
+	 * If @dev is expected to be DMA-capable then the bus code that created
+	 * it should have initialised its dma_mask pointer by this point. For
+	 * now, we'll continue the legacy behaviour of coercing it to the
+	 * coherent mask if not, but we'll no longer do so quietly.
 	 */
-	if (!dev->coherent_dma_mask)
-		dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
+	if (!dev->dma_mask) {
+		dev_warn(dev, "DMA mask not set\n");
 		dev->dma_mask = &dev->coherent_dma_mask;
+	}
 
-	if (!size)
+	if (!size && dev->coherent_dma_mask)
 		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+	else if (!size)
+		size = 1ULL << 32;
 
 	dev->dma_pfn_offset = offset;
 
-- 
2.17.1.dirty
