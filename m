From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] iommu: Remove pci.h include from trace/events/iommu.h
Date: Wed, 26 Apr 2017 17:45:05 +0200
Message-ID: <1493221506-7651-4-git-send-email-joro@8bytes.org>
References: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493221506-7651-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

The include file does not need any PCI specifics, so remove
that include. Also fix the places that relied on it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c    | 1 +
 drivers/iommu/fsl_pamu.h       | 1 +
 drivers/iommu/rockchip-iommu.c | 1 +
 drivers/iommu/tegra-smmu.c     | 1 +
 include/linux/dma-iommu.h      | 1 +
 include/trace/events/iommu.h   | 1 -
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 81cdb2e..982f85b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -28,6 +28,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
+#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index aab723f..c3434f2 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -20,6 +20,7 @@
 #define __FSL_PAMU_H
 
 #include <linux/iommu.h>
+#include <linux/pci.h>
 
 #include <asm/fsl_pamu_stash.h>
 
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9afcbf7..0ba303a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 9305964..eeb19f5 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 5725c94..abd9465 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -20,6 +20,7 @@
 #include <asm/errno.h>
 
 #ifdef CONFIG_IOMMU_DMA
+#include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/msi.h>
 
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 2c7befb..99254ed 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -11,7 +11,6 @@
 #define _TRACE_IOMMU_H
 
 #include <linux/tracepoint.h>
-#include <linux/pci.h>
 
 struct device;
 
-- 
1.9.1
