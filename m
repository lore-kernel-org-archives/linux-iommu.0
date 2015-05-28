From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 21/22] iommu/amd: Remove unused fields from struct
	dma_ops_domain
Date: Thu, 28 May 2015 18:41:44 +0200
Message-ID: <1432831305-11126-22-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The list_head and target_dev members are not used anymore.
Remove them.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 1 -
 drivers/iommu/amd_iommu_types.h | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 978741b..6e73fa1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1886,7 +1886,6 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 		goto free_dma_dom;
 
 	dma_dom->need_flush = false;
-	dma_dom->target_dev = 0xffff;
 
 	add_domain_to_list(&dma_dom->domain);
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index fe796cf..bb56560 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -446,8 +446,6 @@ struct aperture_range {
  * Data container for a dma_ops specific protection domain
  */
 struct dma_ops_domain {
-	struct list_head list;
-
 	/* generic protection domain information */
 	struct protection_domain domain;
 
@@ -462,12 +460,6 @@ struct dma_ops_domain {
 
 	/* This will be set to true when TLB needs to be flushed */
 	bool need_flush;
-
-	/*
-	 * if this is a preallocated domain, keep the device for which it was
-	 * preallocated in this variable
-	 */
-	u16 target_dev;
 };
 
 /*
-- 
1.9.1
