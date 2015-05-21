From: Feng Wu <feng.wu@intel.com>
Subject: [v6 5/8] iommu, x86: Add cap_pi_support() to detect VT-d PI capability
Date: Thu, 21 May 2015 14:59:12 +0800
Message-ID: <1432191555-3516-6-git-send-email-feng.wu@intel.com>
References: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: tglx@linutronix.de, jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Add helper function to detect VT-d Posted-Interrupts capability.

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: David Woodhouse <David.Woodhouse@intel.com>
---
 include/linux/intel-iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0af9b03..0c251be 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -87,6 +87,7 @@ static inline void dmar_writeq(void __iomem *addr, u64 val)
 /*
  * Decoding Capability Register
  */
+#define cap_pi_support(c)	(((c) >> 59) & 1)
 #define cap_read_drain(c)	(((c) >> 55) & 1)
 #define cap_write_drain(c)	(((c) >> 54) & 1)
 #define cap_max_amask_val(c)	(((c) >> 48) & 0x3f)
-- 
2.1.0
