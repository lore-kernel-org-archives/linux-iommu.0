From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/4] iommu: Remove trace-events include from iommu.h
Date: Wed, 26 Apr 2017 17:45:06 +0200
Message-ID: <1493221506-7651-5-git-send-email-joro@8bytes.org>
References: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

It is not needed there anymore. All places needing it are
fixed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 1 +
 include/linux/iommu.h                    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 463b69c..e011c8d 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -23,6 +23,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
+#include <linux/dma-mapping.h>
 
 #include "mtk_vpu.h"
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2a62593..407d8b8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -26,8 +26,6 @@
 #include <linux/err.h>
 #include <linux/of.h>
 
-#include <trace/events/iommu.h>
-
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
-- 
1.9.1
