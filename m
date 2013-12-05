From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] iommu: add missing include
Date: Wed,  4 Dec 2013 17:22:53 -0800
Message-ID: <1386206573-16158-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Brian Norris <computersforpeace@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Hiroshi DOYU <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Fix a warning in of_iommu.c:

drivers/iommu/of_iommu.c:38:5: warning: no previous prototype for 'of_get_dma_window' [-Wmissing-prototypes]

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index ee249bc959f8..e550ccb7634e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -20,6 +20,7 @@
 #include <linux/export.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
 
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
-- 
1.8.5
