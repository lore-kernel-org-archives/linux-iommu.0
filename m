From: Laura Abbott <lauraa@codeaurora.org>
Subject: [RFC PATCHv3 02/11] iommu/omap: Use get_vm_area directly
Date: Thu,  2 Jan 2014 13:53:20 -0800
Message-ID: <1388699609-18214-3-git-send-email-lauraa@codeaurora.org>
References: <1388699609-18214-1-git-send-email-lauraa@codeaurora.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1388699609-18214-1-git-send-email-lauraa@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kmpark@infradead.org>, Dave Hansen <dave@sr71.net>, linux-mm@kvack.org, Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, Laura Abbott <lauraa@codeaurora.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

There is no need to call __get_vm_area with VMALLOC_START and
VMALLOC_END when get_vm_area already does that. Call get_vm_area
directly.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 drivers/iommu/omap-iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index d147259..6280d50 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -214,7 +214,7 @@ static void *vmap_sg(const struct sg_table *sgt)
 	if (!total)
 		return ERR_PTR(-EINVAL);
 
-	new = __get_vm_area(total, VM_IOREMAP, VMALLOC_START, VMALLOC_END);
+	new = get_vm_area(total, VM_IOREMAP);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 	va = (u32)new->addr;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
