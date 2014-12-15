From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 03/10] iommu/ipmmu-vmsa: Invalidate TLB after unmapping
Date: Mon, 15 Dec 2014 02:13:42 +0200
Message-ID: <1418602429-11276-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The TLB must be invalidated after unmapping memory to remove stale TLB
entries. this was supposed to be performed already, but a bug in the
driver prevented the TLB invalidate function from being called. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index fcb603d8b041..9838d119045d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -785,7 +785,6 @@ static int ipmmu_clear_mapping(struct ipmmu_vmsa_domain *domain,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	int ret = 0;
 
 	if (!pgd)
 		return -EINVAL;
@@ -847,8 +846,7 @@ static int ipmmu_clear_mapping(struct ipmmu_vmsa_domain *domain,
 done:
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	if (ret)
-		ipmmu_tlb_invalidate(domain);
+	ipmmu_tlb_invalidate(domain);
 
 	return 0;
 }
-- 
2.0.4

