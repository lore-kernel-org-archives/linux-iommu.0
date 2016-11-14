From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 2/2] arm64: Wire up iommu_dma_{map, unmap}_resource()
Date: Mon, 14 Nov 2016 12:16:27 +0000
Message-ID: <4f2a2b3061142977ed16f1b260595af1fc497c96.1479125555.git.robin.murphy@arm.com>
References: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With no coherency to worry about, just plug'em straight in.

Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3f74d0d98de6..5cd0a383b14b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -796,6 +796,8 @@ static struct dma_map_ops iommu_dma_ops = {
 	.sync_single_for_device = __iommu_sync_single_for_device,
 	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
 	.sync_sg_for_device = __iommu_sync_sg_for_device,
+	.map_resource = iommu_dma_map_resource,
+	.unmap_resource = iommu_dma_unmap_resource,
 	.dma_supported = iommu_dma_supported,
 	.mapping_error = iommu_dma_mapping_error,
 };
-- 
2.10.2.dirty
