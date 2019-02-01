From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/18] fotg210-udc: pass struct device to DMA API functions
Date: Fri,  1 Feb 2019 09:47:56 +0100
Message-ID: <20190201084801.10983-14-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index fe9cf415f2f1..cec49294bac6 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -326,6 +326,7 @@ static void fotg210_wait_dma_done(struct fotg210_ep *ep)
 static void fotg210_start_dma(struct fotg210_ep *ep,
 			struct fotg210_request *req)
 {
+	struct device *dev = &ep->fotg210->gadget.dev;
 	dma_addr_t d;
 	u8 *buffer;
 	u32 length;
@@ -348,10 +349,10 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
 			length = req->req.length;
 	}
 
-	d = dma_map_single(NULL, buffer, length,
+	d = dma_map_single(dev, buffer, length,
 			ep->dir_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	if (dma_mapping_error(NULL, d)) {
+	if (dma_mapping_error(dev, d)) {
 		pr_err("dma_mapping_error\n");
 		return;
 	}
@@ -366,7 +367,7 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
 	/* update actual transfer length */
 	req->req.actual += length;
 
-	dma_unmap_single(NULL, d, length, DMA_TO_DEVICE);
+	dma_unmap_single(dev, d, length, DMA_TO_DEVICE);
 }
 
 static void fotg210_ep0_queue(struct fotg210_ep *ep,
-- 
2.20.1
