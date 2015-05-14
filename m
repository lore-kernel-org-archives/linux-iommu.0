From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [RFC/PATCH 1/9] arm: dma-mapping: Don't override dma_ops in
	arch_setup_dma_ops()
Date: Fri, 15 May 2015 02:00:02 +0300
Message-ID: <1431644410-2997-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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

The arch_setup_dma_ops() function is in charge of setting dma_ops with a
call to set_dma_ops(). set_dma_ops() is also called from

- highbank and mvebu bus notifiers
- dmabounce (to be replaced with swiotlb)
- arm_iommu_attach_device

(arm_iommu_attach_device is itself called from IOMMU and bus master
device drivers)

To allow the arch_setup_dma_ops() call to be moved from device add time
to device probe time we must ensure that dma_ops already setup by any of
the above callers will not be overriden.

Aftering replacing dmabounce with swiotlb, converting IOMMU drivers to
of_xlate and taking care of highbank and mvebu, the workaround should be
removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 09c5fe3d30c2..7aa5e339a596 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2117,6 +2117,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	struct dma_map_ops *dma_ops;
 
 	dev->archdata.dma_coherent = coherent;
+
+	/*
+	 * Don't override the dma_ops if they have already been set. Ideally
+	 * this should be the only location where dma_ops are set, remove this
+	 * check when all other callers of set_dma_ops will have disappeared.
+	 */
+	if (dev->archdata.dma_ops)
+		return;
+
 	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
 		dma_ops = arm_get_iommu_dma_map_ops(coherent);
 	else
-- 
2.3.6
