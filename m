From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [RFC/PATCH 3/9] of: dma: Move range size workaround to
	of_dma_get_range()
Date: Fri, 15 May 2015 02:00:04 +0300
Message-ID: <1431644410-2997-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Invalid dma-ranges values should be worked around when retrieving the
DMA range in of_dma_get_range(), not by all callers of the function.
This isn't much of a problem now that we have a single caller, but that
situation will change when moving DMA configuration to device probe
time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/of/address.c | 20 ++++++++++++++++++--
 drivers/of/device.c  | 15 ---------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 78a7dcbec7d8..75eebd19ebfa 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -924,8 +924,8 @@ EXPORT_SYMBOL(of_io_request_and_map);
  *	CPU addr (phys_addr_t)	: pna cells
  *	size			: nsize cells
  *
- * It returns -ENODEV if "dma-ranges" property was not found
- * for this device in DT.
+ * Return 0 on success, -ENODEV if the "dma-ranges" property was not found for
+ * this device in DT, or -EINVAL if the CPU address or size is invalid.
  */
 int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
 {
@@ -986,6 +986,22 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	*dma_addr = dmaaddr;
 
 	*size = of_read_number(ranges + naddr + pna, nsize);
+	/*
+	 * DT nodes sometimes incorrectly set the size as a mask. Work around
+	 * those incorrect DT by computing the size as mask + 1.
+	 */
+	if (*size & 1) {
+		pr_warn("%s: size 0x%llx for dma-range in node(%s) set as mask\n",
+			__func__, *size, np->full_name);
+		*size = *size + 1;
+	}
+
+	if (!*size) {
+		pr_err("%s: invalid size zero for dma-range in node(%s)\n",
+		       __func__, np->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
 
 	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 		 *dma_addr, *paddr, *size);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 20c1332a0018..530aa1ed3e1b 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -109,21 +109,6 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 		size = dev->coherent_dma_mask + 1;
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
-
-		/*
-		 * Add a work around to treat the size as mask + 1 in case
-		 * it is defined in DT as a mask.
-		 */
-		if (size & 1) {
-			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
-				 size);
-			size = size + 1;
-		}
-
-		if (!size) {
-			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
-			return;
-		}
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
-- 
2.3.6
