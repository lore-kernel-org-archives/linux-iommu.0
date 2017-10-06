From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/amd: Enforce alignment for MSI IRQs
Date: Fri,  6 Oct 2017 13:34:12 +0200
Message-ID: <1507289652-30166-3-git-send-email-joro@8bytes.org>
References: <1507289652-30166-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507289652-30166-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Make use of the new alignment capability of
alloc_irq_index() to enforce IRQ index alignment
for MSI.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: 2b324506341cb ('iommu/amd: Add routines to manage irq remapping tables')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2d4ee25..cb7c531 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4102,7 +4102,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		else
 			ret = -ENOMEM;
 	} else {
-		index = alloc_irq_index(devid, nr_irqs, false);
+		bool align = (info->type == X86_IRQ_ALLOC_TYPE_MSI);
+
+		index = alloc_irq_index(devid, nr_irqs, align);
 	}
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
-- 
2.7.4
