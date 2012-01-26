From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/msm: Fix error handling in msm_iommu_unmap()
Date: Thu, 26 Jan 2012 18:29:44 +0100
Message-ID: <1327598984-20662-1-git-send-email-joerg.roedel@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Error handling in msm_iommu_unmap() is broken. On some error
conditions retval is set to a non-zero value which causes
the function to return 'len' at the end. This hides the
error from the user. Zero should be returned in those error
cases.

Cc: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/msm_iommu.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 08a90b8..cee307e 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -482,23 +482,19 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
 
 	priv = domain->priv;
 
-	if (!priv) {
-		ret = -ENODEV;
+	if (!priv)
 		goto fail;
-	}
 
 	fl_table = priv->pgtable;
 
 	if (len != SZ_16M && len != SZ_1M &&
 	    len != SZ_64K && len != SZ_4K) {
 		pr_debug("Bad length: %d\n", len);
-		ret = -EINVAL;
 		goto fail;
 	}
 
 	if (!fl_table) {
 		pr_debug("Null page table\n");
-		ret = -EINVAL;
 		goto fail;
 	}
 
@@ -507,7 +503,6 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
 
 	if (*fl_pte == 0) {
 		pr_debug("First level PTE is 0\n");
-		ret = -ENODEV;
 		goto fail;
 	}
 
-- 
1.7.5.4
