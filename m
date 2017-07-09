From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 1/2] iommu/io-pgtable-arm: flush TLBs when
	IO_PGTABLE_QUIRK_TLBI_ON_MAP
Date: Sun,  9 Jul 2017 17:15:02 +0200
Message-ID: <1499613303-30173-2-git-send-email-eric.auger@redhat.com>
References: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1499613303-30173-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org
Cc: Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch implements the IO_PGTABLE_QUIRK_TLBI_ON_MAP quirk for
LPAE page tables. It forces TLB invalidations on map.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6e5df5e..0ad10fc 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -395,6 +395,8 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte *ptep = data->pgd;
 	int ret, lvl = ARM_LPAE_START_LVL(data);
 	arm_lpae_iopte prot;
+	struct io_pgtable *iop = &data->iop;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
 	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
@@ -402,6 +404,12 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
 	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
+		io_pgtable_tlb_add_flush(iop, iova, size,
+					 ARM_LPAE_GRANULE(data), false);
+		io_pgtable_tlb_sync(iop);
+	}
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -673,7 +681,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;
 
-	if (cfg->quirks & ~IO_PGTABLE_QUIRK_ARM_NS)
+	if (cfg->quirks &
+		~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_TLBI_ON_MAP))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -762,7 +771,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks)
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_TLBI_ON_MAP))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
-- 
2.5.5
