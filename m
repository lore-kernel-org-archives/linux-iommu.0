From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: [PATCH 4.9 039/153] iommu/vt-d: Fix some macros that are incorrectly
	specified in intel-iommu
Date: Fri, 10 Mar 2017 10:07:52 +0100
Message-ID: <20170310083949.466048906@linuxfoundation.org>
References: <20170310083947.108106897@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170310083947.108106897-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit aaa59306b0b7e0ca4ba92cc04c5db101cbb1c096 upstream.

Some of the macros are incorrect with wrong bit-shifts resulting in picking
the incorrect invalidation granularity. Incorrect Source-ID in extended
devtlb invalidation caused device side errors.

To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Fixes: 2f26e0a9 ("iommu/vt-d: Add basic SVM PASID support")
Signed-off-by: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

---
 include/linux/intel-iommu.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -153,8 +153,8 @@ static inline void dmar_writeq(void __io
 #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
 #define DMA_TLB_DSI_FLUSH (((u64)2) << 60)
 #define DMA_TLB_PSI_FLUSH (((u64)3) << 60)
-#define DMA_TLB_IIRG(type) ((type >> 60) & 7)
-#define DMA_TLB_IAIG(val) (((val) >> 57) & 7)
+#define DMA_TLB_IIRG(type) ((type >> 60) & 3)
+#define DMA_TLB_IAIG(val) (((val) >> 57) & 3)
 #define DMA_TLB_READ_DRAIN (((u64)1) << 49)
 #define DMA_TLB_WRITE_DRAIN (((u64)1) << 48)
 #define DMA_TLB_DID(id)	(((u64)((id) & 0xffff)) << 32)
@@ -164,9 +164,9 @@ static inline void dmar_writeq(void __io
 
 /* INVALID_DESC */
 #define DMA_CCMD_INVL_GRANU_OFFSET  61
-#define DMA_ID_TLB_GLOBAL_FLUSH	(((u64)1) << 3)
-#define DMA_ID_TLB_DSI_FLUSH	(((u64)2) << 3)
-#define DMA_ID_TLB_PSI_FLUSH	(((u64)3) << 3)
+#define DMA_ID_TLB_GLOBAL_FLUSH	(((u64)1) << 4)
+#define DMA_ID_TLB_DSI_FLUSH	(((u64)2) << 4)
+#define DMA_ID_TLB_PSI_FLUSH	(((u64)3) << 4)
 #define DMA_ID_TLB_READ_DRAIN	(((u64)1) << 7)
 #define DMA_ID_TLB_WRITE_DRAIN	(((u64)1) << 6)
 #define DMA_ID_TLB_DID(id)	(((u64)((id & 0xffff) << 16)))
@@ -316,8 +316,8 @@ enum {
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
 #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
-#define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
-#define QI_DEV_EIOTLB_QDEP(qd)	(((qd) & 0x1f) << 16)
+#define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
+#define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
