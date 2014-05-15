From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 09/10] iommu/ipmmu-vmsa: Remove stage 2 PTE bits definitions
Date: Thu, 15 May 2014 12:40:50 +0200
Message-ID: <1400150451-13469-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

We don't support stage 2 translation yet.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 27fd4d0..a4175d3 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -201,14 +201,6 @@ static LIST_HEAD(ipmmu_devices);
 #define ARM_VMSA_PTE_ATTRINDX_SHIFT	2
 #define ARM_VMSA_PTE_nG			(((pteval_t)1) << 11)
 
-/* Stage-2 PTE */
-#define ARM_VMSA_PTE_HAP_FAULT		(((pteval_t)0) << 6)
-#define ARM_VMSA_PTE_HAP_READ		(((pteval_t)1) << 6)
-#define ARM_VMSA_PTE_HAP_WRITE		(((pteval_t)2) << 6)
-#define ARM_VMSA_PTE_MEMATTR_OIWB	(((pteval_t)0xf) << 2)
-#define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
-#define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
-
 #define ARM_VMSA_PTE_CONT_ENTRIES	16
 #define ARM_VMSA_PTE_CONT_SIZE		(PAGE_SIZE * ARM_VMSA_PTE_CONT_ENTRIES)
 
-- 
1.8.5.5

