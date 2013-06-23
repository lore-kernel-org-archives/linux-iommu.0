From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2] iommu: Use %pa and %zx instead of casting
Date: Sun, 23 Jun 2013 12:29:04 -0700
Message-ID: <1372015744.3137.74.camel@joe-AO722>
References: <20130621153331.2881.35589.stgit@bling.home>
	<20130623114930.GA2557@8bytes.org> <1372009427.3137.54.camel@joe-AO722>
	<CAMuHMdWb4WK9ZuJ-vwdywgDSSbZTnnS1emF02VzrUgrSt5VKsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdWb4WK9ZuJ-vwdywgDSSbZTnnS1emF02VzrUgrSt5VKsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

printk supports using %pa for phys_addr_t and
%zx for size_t so use those instead of %lx and
casts to unsigned long.

Other miscellaneous changes around this:

Always use 0x%zx for size instead of one use of decimal.
Coalesce format and align arguments.

Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
---
> While we're at it, paddr is phys_addr_t (which can be 32-bit or 64-bit),
> so it should be cast to unsigned long long (instead of unsigned long),
> and printed using %llx (instead of %lx).

Sounds good to me, except using %pa instead is better still.

 drivers/iommu/iommu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab1fa19..fbe9ca7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -807,20 +807,18 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	 * size of the smallest page supported by the hardware
 	 */
 	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
-		pr_err("unaligned: iova 0x%lx pa 0x%lx size 0x%lx min_pagesz "
-			"0x%x\n", iova, (unsigned long)paddr,
-			(unsigned long)size, min_pagesz);
+		pr_err("unaligned: iova 0x%lx pa 0x%pa size 0x%zx min_pagesz 0x%x\n",
+		       iova, &paddr, size, min_pagesz);
 		return -EINVAL;
 	}
 
-	pr_debug("map: iova 0x%lx pa 0x%lx size 0x%lx\n", iova,
-				(unsigned long)paddr, (unsigned long)size);
+	pr_debug("map: iova 0x%lx pa 0x%pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
 		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
 
-		pr_debug("mapping: iova 0x%lx pa 0x%lx pgsize %lu\n", iova,
-			 (unsigned long)paddr, (unsigned long)pgsize);
+		pr_debug("mapping: iova 0x%lx pa 0x%pa pgsize 0x%zx\n",
+			 iova, &paddr, pgsize);
 
 		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
@@ -857,13 +855,12 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
@@ -876,8 +873,8 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		if (!unmapped_page)
 			break;
 
-		pr_debug("unmapped: iova 0x%lx size %lx\n", iova,
-					(unsigned long)unmapped_page);
+		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
+			 iova, unmapped_page);
 
 		iova += unmapped_page;
 		unmapped += unmapped_page;
