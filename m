From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch Part1 V2 16/20] iommu/vt-d: release invalidation queue when destroying IOMMU unit
Date: Fri,  6 Dec 2013 11:21:19 +0800
Message-ID: <1386300083-6882-17-git-send-email-jiang.liu@linux.intel.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Release associated invalidation queue when destroying IOMMU unit
to avoid memory leak.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/dmar.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 812b596..a9d9d0f 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -745,6 +745,12 @@ static void free_iommu(struct intel_iommu *iommu)
 		destroy_irq(iommu->irq);
 	}
 
+	if (iommu->qi) {
+		free_page((unsigned long)iommu->qi->desc);
+		kfree(iommu->qi->desc_status);
+		kfree(iommu->qi);
+	}
+
 	if (iommu->reg)
 		unmap_iommu(iommu);
 
-- 
1.7.10.4
