From: Youquan Song <youquan.song@intel.com>
Subject: [PATCH 1/3] dmar: Fix domain id not update to newly create
Date: Fri, 13 Dec 2013 00:16:25 -0500
Message-ID: <1386911787-25375-1-git-send-email-youquan.song@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, David Woodhouse <David.Woodhouse@intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>, Youquan Song <youquan.song@intel.com>, zhiyuan.zhou@intel.com
List-Id: iommu@lists.linux-foundation.org

At domain_context_mapping_one(), if the domain is still not assign domain id,
it will assign a new domain_id for it, but the newly creating domain id is not
update to domain, so the domain will keep an unkown domain id.

It will cause the issues: like flush wrong domain in iommu->flush.flush_iotlb,
and free/release wrong domain.

Tested-by: Zhiyuan Zhou <zhiyuan.zhou@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 drivers/iommu/intel-iommu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfe..9cd522f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1625,6 +1625,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 		}
 	}
 
+	domain->id = id;
 	context_set_domain_id(context, id);
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
-- 
1.7.7.4
