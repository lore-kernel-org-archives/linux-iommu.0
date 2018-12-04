From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH] iommu: fix amd_iommu=force_isolation
Date: Tue,  4 Dec 2018 15:37:16 -0700
Message-ID: <20181204223716.214159-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
List-Id: iommu@lists.linux-foundation.org

The parameter is still there but it's ignored. We need to check its
value before deciding to go into passthrough mode for AMD IOMMU.

Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..3e4219e6cff0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2195,7 +2195,8 @@ static int amd_iommu_add_device(struct device *dev)
 
 	BUG_ON(!dev_data);
 
-	if (iommu_pass_through || dev_data->iommu_v2)
+	if (iommu_pass_through ||
+	    (!amd_iommu_force_isolation && dev_data->iommu_v2))
 		iommu_request_dm_for_dev(dev);
 
 	/* Domains are initialized for this device - have a look what we ended up with */
-- 
2.20.0.rc1.387.gf8505762e3-goog
