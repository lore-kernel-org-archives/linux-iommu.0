From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 12/16] iommu/amd: Check for irq-remap support amd_iommu_prepare()
Date: Wed,  7 Jan 2015 15:31:39 +0800
Message-ID: <1420615903-28253-13-git-send-email-jiang.liu@linux.intel.com>
References: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <jroedel@suse.de>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This allows to get rid of the irq_remapping_supported()
function and all its call-backs into the Intel and AMD
IOMMU drivers.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/amd_iommu_init.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b0522f15730f..0039f87f48b8 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2123,6 +2123,9 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 #ifdef CONFIG_IRQ_REMAP
 int __init amd_iommu_prepare(void)
 {
+	if (!amd_iommu_irq_remap)
+		return -1;
+
 	return iommu_go_to_state(IOMMU_ACPI_FINISHED);
 }
 
-- 
1.7.10.4
