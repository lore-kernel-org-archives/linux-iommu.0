From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()
Date: Wed, 23 Jan 2019 08:53:27 +0100
Message-ID: <20190123075327.27366-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The mtk_iommu_add_device() function keeps the fwspec in an
on-stack pointer and calls mtk_iommu_create_mapping(), which
might change its source, dev->iommu_fwspec. This causes the
on-stack pointer to be obsoleted and the device
initialization to fail. Update the on-stack fwspec pointer
after mtk_iommu_create_mapping() has been called.

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Fixes: a9bf2eec5a6f ('iommu/mediatek: Use helper functions to access dev->iommu_fwspec')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu_v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6ede4286b835..f60bdb85c4c0 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
 		iommu_spec.args_count = count;
 
 		mtk_iommu_create_mapping(dev, &iommu_spec);
+
+		/* dev->iommu_fwspec might have changed */
+		fwspec = dev_iommu_fwspec_get(dev);
+
 		of_node_put(iommu_spec.np);
 	}
 
-- 
2.13.7
