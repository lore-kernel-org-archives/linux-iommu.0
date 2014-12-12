From: Feng Wu <feng.wu@intel.com>
Subject: [v3 07/26] iommu, x86: Add cap_pi_support() to detect VT-d PI capability
Date: Fri, 12 Dec 2014 23:14:41 +0800
Message-ID: <1418397300-10870-8-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, pbonzini@redhat.com, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com
Cc: eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Add helper function to detect VT-d Posted-Interrupts capability.

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/intel-iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ecaf3a9..8174ae8 100644
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
1.9.1
