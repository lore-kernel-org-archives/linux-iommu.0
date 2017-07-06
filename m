From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/2] Revert "iommu/io-pgtable: Avoid redundant TLB syncs"
Date: Thu,  6 Jul 2017 17:55:31 +0100
Message-ID: <451e91afbca0c225635cb6203c68f74a11d0da49.1499360104.git.robin.murphy@arm.com>
References: <367e86d1e73867eaf0467732c10c7dc74380f97c.1499360104.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <367e86d1e73867eaf0467732c10c7dc74380f97c.1499360104.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The tlb_sync_pending flag was necessary for correctness in the Mediatek
M4U driver, but since it offered a small theoretical optimisation for
all io-pgtable users it was implemented as a high-level thing. However,
now that some users may not be using a synchronising lock, there are
several ways this flag can go wrong for them, and at worst it could
result in incorrect behaviour.

Since we've addressed the correctness issue within the Mediatek driver
itself, and fixing the optimisation aspect to be concurrency-safe would
be quite a headache (and impose extra overhead on every operation for
the sake of slightly helping one case which will virtually never happen
in typical usage), let's just retire it.

This reverts commit 88492a4700360a086e55d8874ad786105a5e8b0f.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 524263a7ae6f..a3e667077b14 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -158,14 +158,12 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops);
  * @fmt:    The page table format.
  * @cookie: An opaque token provided by the IOMMU driver and passed back to
  *          any callback routines.
- * @tlb_sync_pending: Private flag for optimising out redundant syncs.
  * @cfg:    A copy of the page table configuration.
  * @ops:    The page table operations in use for this set of page tables.
  */
 struct io_pgtable {
 	enum io_pgtable_fmt	fmt;
 	void			*cookie;
-	bool			tlb_sync_pending;
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	ops;
 };
@@ -175,22 +173,17 @@ struct io_pgtable {
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
 	iop->cfg.tlb->tlb_flush_all(iop->cookie);
-	iop->tlb_sync_pending = true;
 }
 
 static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
 		unsigned long iova, size_t size, size_t granule, bool leaf)
 {
 	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
-	iop->tlb_sync_pending = true;
 }
 
 static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
 {
-	if (iop->tlb_sync_pending) {
-		iop->cfg.tlb->tlb_sync(iop->cookie);
-		iop->tlb_sync_pending = false;
-	}
+	iop->cfg.tlb->tlb_sync(iop->cookie);
 }
 
 /**
-- 
2.12.2.dirty
