From: Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH 3/4] of/device: Set bus DMA mask as appropriate
Date: Tue, 10 Jul 2018 18:17:18 +0100
Message-ID: <346c004b599fb77a2006a4eeb992b30feb06fce5.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robh+dt@kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

When an explicit DMA limit is described by firmware, we need to remember
it regardless of how drivers might subsequently update their devices'
masks. The new bus_dma_mask field does that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 33d85511d790..0d39633e8545 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,6 +149,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
+	dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 
-- 
2.17.1.dirty
