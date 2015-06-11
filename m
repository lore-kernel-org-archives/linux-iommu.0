From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] iommu/vt-d: Remove iommu_attach_domain_with_id()
Date: Thu, 11 Jun 2015 15:47:40 +0200
Message-ID: <1434030463-942-2-git-send-email-joro@8bytes.org>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434030463-942-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, zhen-hual-VXdhtT5mjnY@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

We don't re-use domain-ids from the old kernel, so this
function is not needed anymore. Remove it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 58abddb..b0fd5f2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1648,16 +1648,6 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 	return num;
 }
 
-static int iommu_attach_domain_with_id(struct dmar_domain *domain,
-			       struct intel_iommu *iommu,
-			       int domain_number)
-{
-	if (domain_number >= 0)
-		return domain_number;
-
-	return iommu_attach_domain(domain, iommu);
-}
-
 static int iommu_attach_vm_domain(struct dmar_domain *domain,
 				  struct intel_iommu *iommu)
 {
@@ -2326,7 +2316,6 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
-	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2361,7 +2350,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	if (!domain)
 		return NULL;
 
-	domain->id = iommu_attach_domain_with_id(domain, iommu, did);
+	domain->id = iommu_attach_domain(domain, iommu);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
 		return NULL;
-- 
1.9.1
