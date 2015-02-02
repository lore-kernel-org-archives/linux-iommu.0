From: Feng Wu <feng.wu@intel.com>
Subject: [v4 8/8] iommu, x86: Properly handler PI for IOMMU hotplug
Date: Mon,  2 Feb 2015 16:01:54 +0800
Message-ID: <1422864114-19324-9-git-send-email-feng.wu@intel.com>
References: <1422864114-19324-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422864114-19324-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dwmw2@infradead.org, joro@8bytes.or
Cc: jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Return error when inserting a new IOMMU which doesn't support PI
if PI is currently in use.

Signed-off-by: Feng Wu <feng.wu@intel.com>
---
 drivers/iommu/intel_irq_remapping.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 130a92b..0c2c317 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1339,6 +1339,9 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 		return -EINVAL;
 	if (!ecap_ir_support(iommu->ecap))
 		return 0;
+	if (irq_remapping_cap(IRQ_POSTING_CAP) &&
+	    !cap_pi_support(iommu->cap))
+		return -EBUSY;
 
 	if (insert) {
 		if (!iommu->ir_table)
-- 
1.7.1
