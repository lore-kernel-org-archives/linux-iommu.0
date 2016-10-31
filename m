From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] swiotlb: Rate-limit printing when running out of SW-IOMMU space
Date: Mon, 31 Oct 2016 16:45:03 +0100
Message-ID: <1477928704-10611-2-git-send-email-geert+renesas@glider.be>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

If the system runs out of SW-IOMMU space, changes are high successive
requests will fail, too, flooding the kernel log.  This is true
especially for streaming DMA, which is typically used repeatedly outside
the driver's initialization routine.  Add rate-limiting to fix this.

While at it, get rid of the open-coded dev_name() handling by using the
appropriate dev_err_*() variant.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 22e13a0e19d76a2b..6ce764410ae475cc 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -714,8 +714,8 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 	 * When the mapping is small enough return a static buffer to limit
 	 * the damage, or panic when the transfer is too big.
 	 */
-	printk(KERN_ERR "DMA: Out of SW-IOMMU space for %zu bytes at "
-	       "device %s\n", size, dev ? dev_name(dev) : "?");
+	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
+			    size);
 
 	if (size <= io_tlb_overflow || !do_panic)
 		return;
-- 
1.9.1

