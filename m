From: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3] iommu/vt-d: Avoid write-tearing on PTE clear
Date: Wed, 15 Jun 2016 08:02:30 -0700
Message-ID: <1466002950-23326-1-git-send-email-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When a PTE is cleared, the write may be teared or perform by multiple
writes. In addition, in 32-bit kernel, writes are currently performed
using a single 64-bit write, which does not guarantee order.

The byte-code right now does not seem to cause a problem, but it may
still occur in the future.

Avoid this scenario by using WRITE_ONCE, and order the writes on
32-bit kernels.

Signed-off-by: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>

---
V3: Move split_dma_pte struct to dma_clear_pte (Joerg)
    Add comments (Joerg)
V2: Use two WRITE_ONCE on 32-bit to avoid reordering
---
 drivers/iommu/intel-iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e1852e8..5df87a3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -328,7 +328,28 @@ struct dma_pte {
 
 static inline void dma_clear_pte(struct dma_pte *pte)
 {
-	pte->val = 0;
+	/*
+	 * We want to prevent the compiler from doing store-tearing or multiple
+	 * writes when it clears the PTE. Otherwise, a DMA address may be
+	 * translated using a partially updated PTE.
+	 */
+#ifdef CONFIG_64BIT
+	WRITE_ONCE(pte->val, 0);
+#else
+	/*
+	 * On 32-bit platform the PTE must be updated in two chunks. We first
+	 * update the lower part that holds the present bit. The two writes are
+	 * ordered in the byte-code by WRITE_ONCE, and in the execution by x86
+	 * TSO-like memory model. This allows us to avoid using dma_wmb().
+	 */
+	struct split_dma_pte {
+		u32 val_low;
+		u32 val_high;
+	} __packed *sdma_pte = (struct split_dma_pte *)pte;
+
+	WRITE_ONCE(sdma_pte->val_low, 0);
+	WRITE_ONCE(sdma_pte->val_high, 0);
+#endif
 }
 
 static inline u64 dma_pte_addr(struct dma_pte *pte)
-- 
2.7.4
