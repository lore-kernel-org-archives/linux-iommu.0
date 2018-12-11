From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/6] dmaengine: sh: rcar-dmac: Use device_iommu_mapped()
Date: Tue, 11 Dec 2018 14:43:43 +0100
Message-ID: <20181211134343.10664-7-joro@8bytes.org>
References: <20181211134343.10664-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211134343.10664-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de, Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use Use device_iommu_mapped() to check if the device is
already mapped by an IOMMU.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 74fa2b1a6a86..2b4f25698169 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1809,7 +1809,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	 * level we can't disable it selectively, so ignore channel 0 for now if
 	 * the device is part of an IOMMU group.
 	 */
-	if (pdev->dev.iommu_group) {
+	if (device_iommu_mapped(&pdev->dev)) {
 		dmac->n_channels--;
 		channels_offset = 1;
 	}
-- 
2.17.1
