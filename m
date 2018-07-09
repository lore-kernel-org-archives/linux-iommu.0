From: Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/7 v6] bus/fsl-mc: set coherent dma mask for devices on fsl-mc bus
Date: Mon,  9 Jul 2018 16:48:22 +0530
Message-ID: <1531135103-10699-7-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc: joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org, frowand.list@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
List-Id: iommu@lists.linux-foundation.org

of_dma_configure() API expects coherent_dma_mask to be correctly
set in the devices. This patch does the needful.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index fa43c7d..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
-- 
1.9.1
