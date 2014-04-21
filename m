From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] arm: dma-mapping: Fix mapping size value
Date: Mon, 21 Apr 2014 12:17:27 +0530
Message-ID: <1398062847-5770-2-git-send-email-ritesh.harjani@gmail.com>
References: <1398062847-5770-1-git-send-email-ritesh.harjani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398062847-5770-1-git-send-email-ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: mp.vikram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, menon.vinayak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

68efd7d2fb("arm: dma-mapping: remove order parameter from
arm_iommu_create_mapping()") is causing kernel panic
because it wrongly sets the value of mapping->size:

Unable to handle kernel NULL pointer dereference at virtual
address 000000a0
pgd = e7a84000
[000000a0] *pgd=00000000
...
PC is at bitmap_clear+0x48/0xd0
LR is at __iommu_remove_mapping+0x130/0x164

Fix it by correcting mapping->size value.

Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f62aa06..6b00be1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1963,8 +1963,8 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 	mapping->nr_bitmaps = 1;
 	mapping->extensions = extensions;
 	mapping->base = base;
-	mapping->size = bitmap_size << PAGE_SHIFT;
 	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	mapping->size = mapping->bits << PAGE_SHIFT;
 
 	spin_lock_init(&mapping->lock);
 
-- 
1.8.1.3
