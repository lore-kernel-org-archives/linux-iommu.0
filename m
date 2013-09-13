From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH 1/1] x86/iommu: correct ICS register offset
Date: Fri, 13 Sep 2013 14:27:32 +0800
Message-ID: <1379053652-29206-1-git-send-email-zhen-hual@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Li, Zhen-Hua" <zhen-hual@hp.com>
List-Id: iommu@lists.linux-foundation.org

According to Intel Vt-D specs, the offset of Invalidation complete
status register should be 0x9C, not 0x98.

See Intel's VT-d spec, Revision 1.3, Chapter 10.4, Page 98;

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 include/linux/intel-iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 78e2ada..d380c5e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -55,7 +55,7 @@
 #define DMAR_IQT_REG	0x88	/* Invalidation queue tail register */
 #define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
 #define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
-#define DMAR_ICS_REG	0x98	/* Invalidation complete status register */
+#define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
 #define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
 
 #define OFFSET_STRIDE		(9)
-- 
1.8.4.rc3
