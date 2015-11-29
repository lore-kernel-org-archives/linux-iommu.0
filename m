From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/3] iommu/amd: constify mmu_notifier_ops structures
Date: Sun, 29 Nov 2015 23:02:50 +0100
Message-ID: <1448834571-2988-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1448834571-2988-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1448834571-2988-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This mmu_notifier_ops structure is never modified, so declare it as
const, like the other mmu_notifier_ops structures.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The patches in this series are independent of each other.

 drivers/iommu/amd_iommu_v2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index d21d4ed..c847f2f 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -432,7 +432,7 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	unbind_pasid(pasid_state);
 }
 
-static struct mmu_notifier_ops iommu_mn = {
+static const struct mmu_notifier_ops iommu_mn = {
 	.release		= mn_release,
 	.clear_flush_young      = mn_clear_flush_young,
 	.invalidate_page        = mn_invalidate_page,

