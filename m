From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] iommu/amd: Set global dma_ops if swiotlb is disabled
Date: Tue, 28 Jul 2015 16:58:51 +0200
Message-ID: <1438095531-26777-6-git-send-email-joro@8bytes.org>
References: <1438095531-26777-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438095531-26777-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Some AMD systems also have non-PCI devices which can do DMA.
Those can't be handled by the AMD IOMMU, as the hardware can
only handle PCI. These devices would end up with no dma_ops,
as neither the per-device nor the global dma_ops will get
set. SWIOTLB provides global dma_ops when it is active, so
make sure there are global dma_ops too when swiotlb is
disabled.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e29baa6..fa9508b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2853,6 +2853,15 @@ int __init amd_iommu_init_dma_ops(void)
 	swiotlb        = iommu_pass_through ? 1 : 0;
 	iommu_detected = 1;
 
+	/*
+	 * In case we don't initialize SWIOTLB (actually the common case
+	 * when AMD IOMMU is enabled), make sure there are global
+	 * dma_ops set as a fall-back for devices not handled by this
+	 * driver (for example non-PCI devices).
+	 */
+	if (!swiotlb)
+		dma_ops = &nommu_dma_ops;
+
 	amd_iommu_stats_init();
 
 	if (amd_iommu_unmap_flush)
-- 
1.9.1
