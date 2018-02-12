From: Dmitry Safonov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCHv2 2/6] iommu/intel: Clean/document fault status flags
Date: Mon, 12 Feb 2018 16:48:21 +0000
Message-ID: <20180212164825.22421-3-dima@arista.com>
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

So one could decode them without opening the specification.

Signed-off-by: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
---
 include/linux/intel-iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8dad3dd26eae..ef169d67df92 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -209,12 +209,12 @@
 #define DMA_FECTL_IM (((u32)1) << 31)
 
 /* FSTS_REG */
-#define DMA_FSTS_PPF ((u32)2)
-#define DMA_FSTS_PFO ((u32)1)
-#define DMA_FSTS_IQE (1 << 4)
-#define DMA_FSTS_ICE (1 << 5)
-#define DMA_FSTS_ITE (1 << 6)
-#define DMA_FSTS_PRO (1 << 7)
+#define DMA_FSTS_PFO (1 << 0) /* Primary Fault Overflow */
+#define DMA_FSTS_PPF (1 << 1) /* Primary Pending Fault */
+#define DMA_FSTS_IQE (1 << 4) /* Invalidation Queue Error */
+#define DMA_FSTS_ICE (1 << 5) /* Invalidation Completion Error */
+#define DMA_FSTS_ITE (1 << 6) /* Invalidation Time-out Error */
+#define DMA_FSTS_PRO (1 << 7) /* Page Request Overflow */
 #define dma_fsts_fault_record_index(s) (((s) >> 8) & 0xff)
 
 /* FRCD_REG, 32 bits access */
-- 
2.13.6
