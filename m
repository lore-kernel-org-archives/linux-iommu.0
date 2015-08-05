From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/26] iommu/vt-d: Get rid of iommu_attach_vm_domain()
Date: Wed,  5 Aug 2015 17:18:35 +0200
Message-ID: <1438787937-7340-5-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The special case for VM domains is not needed, as other
domains could be attached to the iommu in the same way. So
get rid of this special case.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7f2e6c8..58fc4bb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1669,8 +1669,13 @@ static int __iommu_attach_domain(struct dmar_domain *domain,
 	int num;
 	unsigned long ndomains;
 
+	num = domain->iommu_did[iommu->seq_id];
+	if (num)
+		return num;
+
 	ndomains = cap_ndoms(iommu->cap);
-	num = find_first_zero_bit(iommu->domain_ids, ndomains);
+	num	 = find_first_zero_bit(iommu->domain_ids, ndomains);
+
 	if (num < ndomains) {
 		set_bit(num, iommu->domain_ids);
 		set_iommu_domain(iommu, num, domain);
@@ -1679,6 +1684,9 @@ static int __iommu_attach_domain(struct dmar_domain *domain,
 		num = -ENOSPC;
 	}
 
+	if (num < 0)
+		pr_err("%s: No free domain ids\n", iommu->name);
+
 	return num;
 }
 
@@ -1691,24 +1699,10 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 	spin_lock_irqsave(&iommu->lock, flags);
 	num = __iommu_attach_domain(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
-	if (num < 0)
-		pr_err("%s: No free domain ids\n", iommu->name);
 
 	return num;
 }
 
-static int iommu_attach_vm_domain(struct dmar_domain *domain,
-				  struct intel_iommu *iommu)
-{
-	int num;
-
-	num = domain->iommu_did[iommu->seq_id];
-	if (num)
-		return num;
-
-	return __iommu_attach_domain(domain, iommu);
-}
-
 static void iommu_detach_domain(struct dmar_domain *domain,
 				struct intel_iommu *iommu)
 {
@@ -1944,7 +1938,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	if (domain_type_is_vm_or_si(domain)) {
 		if (domain_type_is_vm(domain)) {
-			id = iommu_attach_vm_domain(domain, iommu);
+			id = __iommu_attach_domain(domain, iommu);
 			if (id < 0) {
 				spin_unlock_irqrestore(&iommu->lock, flags);
 				pr_err("%s: No free domain ids\n", iommu->name);
-- 
1.9.1
