From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] xhci: Set DMA parameters appropriately
Date: Wed, 11 Oct 2017 14:56:56 +0100
Message-ID: <347776be09eb0ca947c1c8ced46ee3ca92d92e28.1507730115.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

xHCI requires that data buffers do not cross 64KB boundaries (and are
thus at most 64KB long as well) - whilst xhci_queue_{bulk,isoc}_tx()
already split their input buffers into individual TRBs as necessary,
it's still a good idea to advertise the limitations via the standard DMA
API mechanism, so that most producers like the block layer and the DMA
mapping implementations can lay things out correctly to begin with.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/usb/host/xhci.c | 4 ++++
 drivers/usb/host/xhci.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 74b4500641c2..1e7e1e3d8c48 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4883,6 +4883,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 		dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	}
 
+	dev->dma_parms = &xhci->dma_parms;
+	dma_set_max_seg_size(dev, SZ_64K);
+	dma_set_seg_boundary(dev, SZ_64K - 1);
+
 	xhci_dbg(xhci, "Calling HCD init\n");
 	/* Initialize HCD and host controller data structures. */
 	retval = xhci_init(hcd);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7ef69ea0b480..afcae4cc908d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1767,6 +1767,9 @@ struct xhci_hcd {
 	struct dma_pool	*small_streams_pool;
 	struct dma_pool	*medium_streams_pool;
 
+	/* DMA alignment restrictions */
+	struct device_dma_parameters dma_parms;
+
 	/* Host controller watchdog timer structures */
 	unsigned int		xhc_state;
 
-- 
2.13.4.dirty
