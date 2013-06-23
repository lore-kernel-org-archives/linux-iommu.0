From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu: Use %zx instead %lx and cast to unsigned long
Date: Sun, 23 Jun 2013 10:43:47 -0700
Message-ID: <1372009427.3137.54.camel@joe-AO722>
References: <20130621153331.2881.35589.stgit@bling.home>
	<20130623114930.GA2557@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130623114930.GA2557-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

printf support size_t hex type %zx so use that
instead of %lx and a cast to unsigned long.

Other miscellaneous changes around this:

Always use 0x%zx for size instead of one use of decimal.
Coalesce format and align arguments.

Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab1fa19..7aa98c8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -807,20 +807,19 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	 * size of the smallest page supported by the hardware
 	 */
 	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
-		pr_err("unaligned: iova 0x%lx pa 0x%lx size 0x%lx min_pagesz "
-			"0x%x\n", iova, (unsigned long)paddr,
-			(unsigned long)size, min_pagesz);
+		pr_err("unaligned: iova 0x%lx pa 0x%lx size 0x%zx min_pagesz 0x%x\n",
+		       iova, (unsigned long)paddr, size, min_pagesz);
 		return -EINVAL;
 	}
 
-	pr_debug("map: iova 0x%lx pa 0x%lx size 0x%lx\n", iova,
-				(unsigned long)paddr, (unsigned long)size);
+	pr_debug("map: iova 0x%lx pa 0x%lx size 0x%zx\n",
+		 iova, (unsigned long)paddr, size);
 
 	while (size) {
 		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
 
-		pr_debug("mapping: iova 0x%lx pa 0x%lx pgsize %lu\n", iova,
-			 (unsigned long)paddr, (unsigned long)pgsize);
+		pr_debug("mapping: iova 0x%lx pa 0x%lx pgsize 0x%zx\n",
+			 iova, (unsigned long)paddr, pgsize);
 
 		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
@@ -857,13 +856,12 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 	 * by the hardware
 	 */
 	if (!IS_ALIGNED(iova | size, min_pagesz)) {
-		pr_err("unaligned: iova 0x%lx size 0x%lx min_pagesz 0x%x\n",
-					iova, (unsigned long)size, min_pagesz);
+		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
+		       iova, size, min_pagesz);
 		return -EINVAL;
 	}
 
-	pr_debug("unmap this: iova 0x%lx size 0x%lx\n", iova,
-							(unsigned long)size);
+	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
 
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
@@ -876,8 +874,8 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		if (!unmapped_page)
 			break;
 
-		pr_debug("unmapped: iova 0x%lx size %lx\n", iova,
-					(unsigned long)unmapped_page);
+		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
+			 iova, unmapped_page);
 
 		iova += unmapped_page;
 		unmapped += unmapped_page;
