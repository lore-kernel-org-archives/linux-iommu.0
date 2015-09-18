From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] iommu/vt-d: fix memory leak
Date: Fri, 18 Sep 2015 16:27:07 +0530
Message-ID: <1442573827-28795-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: iommu@lists.linux-foundation.org

We are returning NULL if we are not able to attach the iommu to the
domain but while returning we missed freeing info.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/iommu/intel-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8a74fcc..668acf7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2305,6 +2305,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
+		free_devinfo_mem(info);
 		return NULL;
 	}
 
-- 
1.9.1
