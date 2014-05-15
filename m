From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 05/10] iommu/ipmmu-vmsa: Set the PTE contiguous hint bit
	when possible
Date: Thu, 15 May 2014 12:40:46 +0200
Message-ID: <1400150451-13469-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The contiguous hint bit signals to the IOMMU that a range of 16 PTEs
refer to physically contiguous memory. It improves performances by
dividing the number of TLB lookups by 16, effectively implementing 64kB
page sizes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b34a4b7b..150e18e 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -209,6 +209,9 @@ static LIST_HEAD(ipmmu_devices);
 #define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
 #define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
 
+#define ARM_VMSA_PTE_CONT_ENTRIES	16
+#define ARM_VMSA_PTE_CONT_SIZE		(PAGE_SIZE * ARM_VMSA_PTE_CONT_ENTRIES)
+
 #define IPMMU_PTRS_PER_PTE		512
 #define IPMMU_PTRS_PER_PMD		512
 #define IPMMU_PTRS_PER_PGD		4
@@ -569,10 +572,44 @@ static int ipmmu_alloc_init_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
 	pteval |= ARM_VMSA_PTE_SH_IS;
 	start = pte;
 
-	/* Install the page table entries. */
+	/*
+	 * Install the page table entries.
+	 *
+	 * Set the contiguous hint in the PTEs where possible. The hint
+	 * indicates a series of ARM_VMSA_PTE_CONT_ENTRIES PTEs mapping a
+	 * physically contiguous region with the following constraints:
+	 *
+	 * - The region start is aligned to ARM_VMSA_PTE_CONT_SIZE
+	 * - Each PTE in the region has the contiguous hint bit set
+	 *
+	 * We don't support partial unmapping so there's no need to care about
+	 * clearing the contiguous hint from neighbour PTEs.
+	 */
 	do {
-		*pte++ = pfn_pte(pfn++, __pgprot(pteval));
-		addr += PAGE_SIZE;
+		unsigned long chunk_end;
+
+		/*
+		 * If the address is aligned to a contiguous region size and the
+		 * mapping size is large enough, process the largest possible
+		 * number of PTEs multiple of ARM_VMSA_PTE_CONT_ENTRIES.
+		 * Otherwise process the smallest number of PTEs to align the
+		 * address to a contiguous region size or to complete the
+		 * mapping.
+		 */
+		if (IS_ALIGNED(addr, ARM_VMSA_PTE_CONT_SIZE) &&
+		    end - addr >= ARM_VMSA_PTE_CONT_SIZE) {
+			chunk_end = round_down(end, ARM_VMSA_PTE_CONT_SIZE);
+			pteval |= ARM_VMSA_PTE_CONT;
+		} else {
+			chunk_end = min(ALIGN(addr, ARM_VMSA_PTE_CONT_SIZE),
+					end);
+			pteval &= ~ARM_VMSA_PTE_CONT;
+		}
+
+		do {
+			*pte++ = pfn_pte(pfn++, __pgprot(pteval));
+			addr += PAGE_SIZE;
+		} while (addr != chunk_end);
 	} while (addr != end);
 
 	ipmmu_flush_pgtable(mmu, start, sizeof(*pte) * (pte - start));
-- 
1.8.5.5
