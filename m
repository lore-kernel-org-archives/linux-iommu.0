From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 05/09] iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master
Date: Wed, 08 Mar 2017 20:02:13 +0900
Message-ID: <148897093339.16106.5329228083105867675.sendpatchset@little-apple>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

The r8a7795 IPMMU supports 40-bit bus mastering. Both
the coherent DMA mask and the streaming DMA mask are
set to unlock the 40-bit address space for coherent
allocations and streaming operations.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V2:
 - Updated the code and commit message to use 40 bits instead of 64 bits

 Changes since V1:
 - Updated the commit message

 drivers/iommu/ipmmu-vmsa.c |    1 +
 1 file changed, 1 insertion(+)

--- 0016/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-03-08 18:29:56.390607110 +0900
@@ -1103,6 +1103,7 @@ static int ipmmu_probe(struct platform_d
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = match->data;
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
