From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] iommu/msm: make msm_iommu_lock static
Date: Wed, 29 Apr 2015 21:05:17 +0200
Message-ID: <1430334318-4324-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

msm_iommu_lock is only used in msm_iommu.c

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/iommu/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 15a2063..f2a6321 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -47,7 +47,7 @@ __asm__ __volatile__ (							\
 
 static int msm_iommu_tex_class[4];
 
-DEFINE_SPINLOCK(msm_iommu_lock);
+static DEFINE_SPINLOCK(msm_iommu_lock);
 
 struct msm_priv {
 	unsigned long *pgtable;
-- 
1.9.1
