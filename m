From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] dmar: Zero out memory
Date: Wed,  6 Feb 2013 09:50:10 +0100
Message-ID: <1360140610-48309-1-git-send-email-hare@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

kmemcheck complained about the use of uninitialized memory.
So there.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 86e2f4a..2623a57 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1040,7 +1040,7 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 
 	qi->desc = page_address(desc_page);
 
-	qi->desc_status = kmalloc(QI_LENGTH * sizeof(int), GFP_ATOMIC);
+	qi->desc_status = kzalloc(QI_LENGTH * sizeof(int), GFP_ATOMIC);
 	if (!qi->desc_status) {
 		free_page((unsigned long) qi->desc);
 		kfree(qi);
