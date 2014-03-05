From: Zhouyi Zhou <zhouzhouyi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] IOMMU: iopte free should check wether input argument is
	NULL
Date: Wed,  5 Mar 2014 18:20:19 +0800
Message-ID: <1394014820-1249-1-git-send-email-yizhouzhou@ict.ac.cn>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Zhouyi Zhou <zhouzhouyi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhouyi Zhou <yizhouzhou-6xnC4QlcT6v/PtFMR13I2A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Zhouyi Zhou <zhouzhouyi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

iopte free should check wether input argument is NULL because kmem_cache_free
will panic on NULL argument 

Signed-off-by: Zhouyi Zhou <yizhouzhou-6xnC4QlcT6v/PtFMR13I2A@public.gmane.org>
Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

---
 drivers/iommu/omap-iommu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bcd78a7..51211e8 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -523,7 +523,8 @@ static void flush_iopte_range(u32 *first, u32 *last)
 static void iopte_free(u32 *iopte)
 {
 	/* Note: freed iopte's must be clean ready for re-use */
-	kmem_cache_free(iopte_cachep, iopte);
+	if (iopte)
+		kmem_cache_free(iopte_cachep, iopte);
 }
 
 static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
