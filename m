From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 09/26] iommu/vt-d: Kill dmar_domain->id
Date: Wed,  5 Aug 2015 17:18:40 +0200
Message-ID: <1438787937-7340-10-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This field is now obsolete because all places use the
per-iommu domain-ids. Kill the remaining uses of this field
and remove it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 35a918e..25b2ba7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -374,7 +374,6 @@ static int hw_pass_through = 1;
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
 
 struct dmar_domain {
-	int	id;			/* domain id */
 	int	nid;			/* node id */
 	DECLARE_BITMAP(iommu_bmp, DMAR_UNITS_SUPPORTED);
 					/* bitmap of iommus this domain uses*/
@@ -1653,8 +1652,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 
 static struct dmar_domain *alloc_domain(int flags)
 {
-	/* domain id for virtual machine, it won't be set in context */
-	static atomic_t vm_domid = ATOMIC_INIT(0);
 	struct dmar_domain *domain;
 
 	domain = alloc_domain_mem();
@@ -1666,8 +1663,6 @@ static struct dmar_domain *alloc_domain(int flags)
 	domain->flags = flags;
 	spin_lock_init(&domain->iommu_lock);
 	INIT_LIST_HEAD(&domain->devices);
-	if (flags & DOMAIN_FLAG_VIRTUAL_MACHINE)
-		domain->id = atomic_inc_return(&vm_domid);
 
 	return domain;
 }
@@ -2390,8 +2385,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	domain->id = iommu_attach_domain(domain, iommu);
-	if (domain->id < 0) {
+	if (iommu_attach_domain(domain, iommu) < 0) {
 		free_domain_mem(domain);
 		return NULL;
 	}
@@ -2444,8 +2438,7 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 		return -ENOMEM;
 	}
 
-	pr_debug("Mapping reserved region %llx-%llx for domain %d\n",
-		 start, end, domain->id);
+	pr_debug("Mapping reserved region %llx-%llx\n", start, end);
 	/*
 	 * RMRR range might have overlap with physical memory range,
 	 * clear it first
-- 
1.9.1
