From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 07/13] drm/msm: Use sychronized interface of the IOMMU-API
Date: Thu, 17 Aug 2017 14:56:30 +0200
Message-ID: <1502974596-23835-8-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Joerg Roedel <jroedel@suse.de>, Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The map and unmap functions of the IOMMU-API changed their
semantics: They do no longer guarantee that the hardware
TLBs are synchronized with the page-table updates they made.

To make conversion easier, new synchronized functions have
been introduced which give these guarantees again until the
code is converted to use the new TLB-flush interface of the
IOMMU-API, which allows certain optimizations.

But for now, just convert this code to use the synchronized
functions so that it will behave as before.

Cc: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/gpu/drm/msm/msm_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index b23d336..b3525b7 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -64,7 +64,8 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	size_t ret;
 
 //	pm_runtime_get_sync(mmu->dev);
-	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
+	ret = iommu_map_sg_sync(iommu->domain, iova, sgt->sgl,
+				sgt->nents, prot);
 //	pm_runtime_put_sync(mmu->dev);
 	WARN_ON(ret < 0);
 
@@ -77,7 +78,7 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
 	pm_runtime_get_sync(mmu->dev);
-	iommu_unmap(iommu->domain, iova, len);
+	iommu_unmap_sync(iommu->domain, iova, len);
 	pm_runtime_put_sync(mmu->dev);
 
 	return 0;
-- 
2.7.4
