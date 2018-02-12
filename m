From: Dmitry Safonov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCHv2 3/6] iommu/intel: Introduce clear_primary_faults() helper
Date: Mon, 12 Feb 2018 16:48:22 +0000
Message-ID: <20180212164825.22421-4-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Reply-To: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180212164825.22421-1-dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, 0x7f454c46-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

To my mind it's a bit more readable - and I will re-use it in the next
patch.

Signed-off-by: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/dmar.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index accf58388bdb..33fb4244e438 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1611,6 +1611,15 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	return 0;
 }
 
+static void clear_primary_faults(struct intel_iommu *iommu)
+{
+	volatile void __iomem *fsts = iommu->reg + DMAR_FSTS_REG;
+
+	assert_raw_spin_locked(&iommu->register_lock);
+
+	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO, fsts);
+}
+
 #define PRIMARY_FAULT_REG_LEN (16)
 irqreturn_t dmar_fault(int irq, void *dev_id)
 {
@@ -1679,8 +1688,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	}
 
-	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO,
-	       iommu->reg + DMAR_FSTS_REG);
+	clear_primary_faults(iommu);
 
 unlock_exit:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-- 
2.13.6
