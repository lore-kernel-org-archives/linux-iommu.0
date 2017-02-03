From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] iommu: to avoid an unnecessary assignment
Date: Fri, 3 Feb 2017 17:35:02 +0800
Message-ID: <1486114502-10984-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Move the assignment statement into if branch above, where it only
needs to be.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dbe7f65..b231400 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1714,13 +1714,14 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 		fwspec = krealloc(dev->iommu_fwspec, size, GFP_KERNEL);
 		if (!fwspec)
 			return -ENOMEM;
+
+		dev->iommu_fwspec = fwspec;
 	}

 	for (i = 0; i < num_ids; i++)
 		fwspec->ids[fwspec->num_ids + i] = ids[i];

 	fwspec->num_ids += num_ids;
-	dev->iommu_fwspec = fwspec;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
--
2.5.0
