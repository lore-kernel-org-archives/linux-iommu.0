From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
Date: Fri,  1 Feb 2019 09:47:55 +0100
Message-ID: <20190201084801.10983-13-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
Sender: netdev-owner@vger.kernel.org
To: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

dma_map_single already transfers ownership to the device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index bc6abaea907d..fe9cf415f2f1 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -356,10 +356,6 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
 		return;
 	}
 
-	dma_sync_single_for_device(NULL, d, length,
-				   ep->dir_in ? DMA_TO_DEVICE :
-					DMA_FROM_DEVICE);
-
 	fotg210_enable_dma(ep, d, length);
 
 	/* check if dma is done */
-- 
2.20.1
