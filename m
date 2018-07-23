From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 6/7] ACPI/IORT: Don't set default coherent DMA mask
Date: Mon, 23 Jul 2018 23:16:11 +0100
Message-ID: <3525869e8e7530128bf9718ae8af7d7564b3c684.1532382222.git.robin.murphy@arm.com>
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

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Hanjun Guo <hanjun.guo@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/iort.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bc51cff5505e..08f26db2da7e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -978,20 +978,20 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	int ret, msb;
 
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
-
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
+	if (!dev->dma_mask) {
+		dev_warn(dev, "DMA mask not set\n");
 		dev->dma_mask = &dev->coherent_dma_mask;
+	}
 
-	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+	if (dev->coherent_dma_mask)
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+	else
+		size = 1ULL << 32;
 
 	if (dev_is_pci(dev)) {
 		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
-- 
2.17.1.dirty
