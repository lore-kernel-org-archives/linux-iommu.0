From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/7] iommu/amd: Remove amd_iommu_disabled check from amd_iommu_detect()
Date: Fri, 16 Jun 2017 16:10:00 +0200
Message-ID: <1497622200-18188-8-git-send-email-joro@8bytes.org>
References: <1497622200-18188-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497622200-18188-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This check needs to happens later now, when all previously
enabled IOMMUs have been disabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index eedd3d3..bc9dfcf 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2576,9 +2576,6 @@ int __init amd_iommu_detect(void)
 	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
 		return -ENODEV;
 
-	if (amd_iommu_disabled)
-		return -ENODEV;
-
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
 		return ret;
-- 
2.7.4
