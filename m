From: "Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH 2/3] iova: Use alloc_percpu_aligned()
Date: Wed,  2 Aug 2017 16:52:19 +0800
Message-ID: <20170802085220.4315-3-ying.huang@intel.com>
References: <20170802085220.4315-1-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802085220.4315-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Huang Ying <ying.huang@intel.com>

To use the newly introduced alloc_percpu_aligned(), which can allocate
cache line size aligned percpu memory dynamically.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 246f14c83944..83196f8e8fd5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -698,7 +698,7 @@ static void init_iova_rcaches(struct iova_domain *iovad)
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
-		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
+		rcache->cpu_rcaches = alloc_percpu_aligned(*cpu_rcache);
 		if (WARN_ON(!rcache->cpu_rcaches))
 			continue;
 		for_each_possible_cpu(cpu) {
-- 
2.13.2
