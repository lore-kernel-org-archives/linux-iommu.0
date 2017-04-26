From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/4] iommu: Include device.h in iommu.h
Date: Wed, 26 Apr 2017 17:45:03 +0200
Message-ID: <1493221506-7651-2-git-send-email-joro@8bytes.org>
References: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

We make use of 'struct device' in iommu.h, so include
device.h to make it available explicitly.

Re-order the other headers while at it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e4de0d..0232104 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -19,11 +19,13 @@
 #ifndef __LINUX_IOMMU_H
 #define __LINUX_IOMMU_H
 
+#include <linux/scatterlist.h>
+#include <linux/device.h>
+#include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/types.h>
-#include <linux/scatterlist.h>
+
 #include <trace/events/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
-- 
1.9.1
