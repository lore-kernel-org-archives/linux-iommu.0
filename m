From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/26] iommu/vt-d: Keep track of per-iommu domain ids
Date: Wed,  5 Aug 2015 17:18:32 +0200
Message-ID: <1438787937-7340-2-git-send-email-joro@8bytes.org>
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

Instead of searching in the domain array for already
allocated domain ids, keep track of them explicitly.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 51 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0649b94..c3c5167 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -378,6 +378,9 @@ struct dmar_domain {
 	DECLARE_BITMAP(iommu_bmp, DMAR_UNITS_SUPPORTED);
 					/* bitmap of iommus this domain uses*/
 
+	u16	iommu_did[DMAR_UNITS_SUPPORTED];
+					/* Domain ids per IOMMU */
+
 	struct list_head devices;	/* all devices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
@@ -1543,11 +1546,13 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	}
 
 	/*
-	 * if Caching mode is set, then invalid translations are tagged
-	 * with domainid 0. Hence we need to pre-allocate it.
+	 * If Caching mode is set, then invalid translations are tagged
+	 * with domain-id 0, hence we need to pre-allocate it. We also
+	 * use domain-id 0 as a marker for non-allocated domain-id, so
+	 * make sure it is not used for a real domain.
 	 */
-	if (cap_caching_mode(iommu->cap))
-		set_bit(0, iommu->domain_ids);
+	set_bit(0, iommu->domain_ids);
+
 	return 0;
 }
 
@@ -1560,9 +1565,10 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 		for_each_set_bit(i, iommu->domain_ids, cap_ndoms(iommu->cap)) {
 			/*
 			 * Domain id 0 is reserved for invalid translation
-			 * if hardware supports caching mode.
+			 * if hardware supports caching mode and used as
+			 * a non-allocated marker.
 			 */
-			if (cap_caching_mode(iommu->cap) && i == 0)
+			if (i == 0)
 				continue;
 
 			domain = iommu->domains[i];
@@ -1624,6 +1630,7 @@ static int __iommu_attach_domain(struct dmar_domain *domain,
 	if (num < ndomains) {
 		set_bit(num, iommu->domain_ids);
 		iommu->domains[num] = domain;
+		domain->iommu_did[iommu->seq_id] = num;
 	} else {
 		num = -ENOSPC;
 	}
@@ -1650,12 +1657,10 @@ static int iommu_attach_vm_domain(struct dmar_domain *domain,
 				  struct intel_iommu *iommu)
 {
 	int num;
-	unsigned long ndomains;
 
-	ndomains = cap_ndoms(iommu->cap);
-	for_each_set_bit(num, iommu->domain_ids, ndomains)
-		if (iommu->domains[num] == domain)
-			return num;
+	num = domain->iommu_did[iommu->seq_id];
+	if (num)
+		return num;
 
 	return __iommu_attach_domain(domain, iommu);
 }
@@ -1664,22 +1669,17 @@ static void iommu_detach_domain(struct dmar_domain *domain,
 				struct intel_iommu *iommu)
 {
 	unsigned long flags;
-	int num, ndomains;
+	int num;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	if (domain_type_is_vm_or_si(domain)) {
-		ndomains = cap_ndoms(iommu->cap);
-		for_each_set_bit(num, iommu->domain_ids, ndomains) {
-			if (iommu->domains[num] == domain) {
-				clear_bit(num, iommu->domain_ids);
-				iommu->domains[num] = NULL;
-				break;
-			}
-		}
-	} else {
-		clear_bit(domain->id, iommu->domain_ids);
-		iommu->domains[domain->id] = NULL;
-	}
+
+	num = domain->iommu_did[iommu->seq_id];
+
+	WARN_ON(num == 0);
+
+	clear_bit(num, iommu->domain_ids);
+	iommu->domains[num]		 = NULL;
+
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
@@ -1708,6 +1708,7 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 	if (test_and_clear_bit(iommu->seq_id, domain->iommu_bmp)) {
 		count = --domain->iommu_count;
 		domain_update_iommu_cap(domain);
+		domain->iommu_did[iommu->seq_id] = 0;
 	}
 	spin_unlock_irqrestore(&domain->iommu_lock, flags);
 
-- 
1.9.1
