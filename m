From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/4] iommu/io-pgtable-arm-v7s: Fix attributes when splitting blocks
Date: Thu, 18 Aug 2016 14:05:39 +0100
Message-ID: <1471525542-14969-2-git-send-email-will.deacon@arm.com>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, joro@8bytes.org, stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy@arm.com>

Due to the attribute bits being all over the place in the different
types of short-descriptor PTEs, when remapping an existing entry, e.g.
splitting a section into pages, we take the approach of decomposing
the PTE attributes back to the IOMMU API flags to start from scratch.

On inspection, though, the existing code seems to have got the read-only
bit backwards and ignored the XN bit. How embarrassing...

Fortunately the primary user so far, the Mediatek IOMMU, both never
splits blocks (because it only serves non-overlapping DMA API calls) and
also ignores permissions anyway, but let's put things right before any
future users trip up.

Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 8c6139986d7d..def8ca1c982d 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -286,12 +286,14 @@ static int arm_v7s_pte_to_prot(arm_v7s_iopte pte, int lvl)
 	int prot = IOMMU_READ;
 	arm_v7s_iopte attr = pte >> ARM_V7S_ATTR_SHIFT(lvl);
 
-	if (attr & ARM_V7S_PTE_AP_RDONLY)
+	if (!(attr & ARM_V7S_PTE_AP_RDONLY))
 		prot |= IOMMU_WRITE;
 	if ((attr & (ARM_V7S_TEX_MASK << ARM_V7S_TEX_SHIFT)) == 0)
 		prot |= IOMMU_MMIO;
 	else if (pte & ARM_V7S_ATTR_C)
 		prot |= IOMMU_CACHE;
+	if (pte & ARM_V7S_ATTR_XN(lvl))
+		prot |= IOMMU_NOEXEC;
 
 	return prot;
 }
-- 
2.1.4
