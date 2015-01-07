From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 14/16] iommu/irq_remapping: Refine function irq_remapping_prepare() for maintenance
Date: Wed,  7 Jan 2015 15:31:41 +0800
Message-ID: <1420615903-28253-15-git-send-email-jiang.liu@linux.intel.com>
References: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Assign intel_irq_remap_ops to remap_ops only if
intel_irq_remap_ops.prepare() succeeds.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/irq_remapping.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index e7449b42504d..7d85d2ba0e8b 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -204,15 +204,15 @@ int __init irq_remapping_prepare(void)
 	if (disable_irq_remap)
 		return -ENOSYS;
 
-	remap_ops = &intel_irq_remap_ops;
-
-#ifdef CONFIG_AMD_IOMMU
-	if (amd_iommu_irq_ops.prepare() == 0) {
+	if (intel_irq_remap_ops.prepare() == 0)
+		remap_ops = &intel_irq_remap_ops;
+	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
+		 amd_iommu_irq_ops.prepare() == 0)
 		remap_ops = &amd_iommu_irq_ops;
-		return 0;
-	}
-#endif
-	return remap_ops->prepare();
+	else
+		return -ENOSYS;
+
+	return 0;
 }
 
 int __init irq_remapping_enable(void)
-- 
1.7.10.4
