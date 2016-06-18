From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] iommu/amd: Remove create_workqueue
Date: Sat, 18 Jun 2016 13:58:30 +0530
Message-ID: <20160618082830.GA6631@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Tejun Heo <tj@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

alloc_workqueue replaces deprecated create_workqueue().

A dedicated workqueue has been used since the workitem (viz
&fault->work), is involved in IO page-fault handling.
WQ_MEM_RECLAIM has been set to guarantee forward progress under memory
pressure, which is a requirement here.
Since there are only a fixed number of work items, explicit concurrency
limit is unnecessary.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/iommu/amd_iommu_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 56999d2f..0d52ceb 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -961,7 +961,7 @@ static int __init amd_iommu_v2_init(void)
 	spin_lock_init(&state_lock);

 	ret = -ENOMEM;
-	iommu_wq = create_workqueue("amd_iommu_v2");
+	iommu_wq = alloc_workqueue("amd_iommu_v2", WQ_MEM_RECLAIM, 0);
 	if (iommu_wq == NULL)
 		goto out;

--
2.1.4
