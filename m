From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/26] iommu/vt-d: Split up iommu->domains array
Date: Wed,  5 Aug 2015 17:18:34 +0200
Message-ID: <1438787937-7340-4-git-send-email-joro@8bytes.org>
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

This array is indexed by the domain-id and contains the
pointers to the domains attached to this iommu. Modern
systems support 65536 domain ids, so that this array has a
size of 512kb, per iommu.

This is a huge waste of space, as the array is usually
sparsely populated. This patch makes the array
two-dimensional and allocates the memory for the domain
pointers on-demand.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 54 ++++++++++++++++++++++++++++++++++++---------
 include/linux/intel-iommu.h |  2 +-
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e6a5966..7f2e6c8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -569,13 +569,32 @@ static struct kmem_cache *iommu_devinfo_cache;
 
 static struct dmar_domain* get_iommu_domain(struct intel_iommu *iommu, u16 did)
 {
-	return iommu->domains[did];
+	struct dmar_domain **domains;
+	int idx = did >> 8;
+
+	domains = iommu->domains[idx];
+	if (!domains)
+		return NULL;
+
+	return domains[did & 0xff];
 }
 
 static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
 			     struct dmar_domain *domain)
 {
-	iommu->domains[did] = domain;
+	struct dmar_domain **domains;
+	int idx = did >> 8;
+
+	if (!iommu->domains[idx]) {
+		size_t size = 256 * sizeof(struct dmar_domain *);
+		iommu->domains[idx] = kzalloc(size, GFP_ATOMIC);
+	}
+
+	domains = iommu->domains[idx];
+	if (WARN_ON(!domains))
+		return;
+	else
+		domains[did & 0xff] = domain;
 }
 
 static inline void *alloc_pgtable_page(int node)
@@ -1528,35 +1547,43 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
-	unsigned long ndomains;
-	unsigned long nlongs;
+	u32 ndomains, nlongs;
+	size_t size;
 
 	ndomains = cap_ndoms(iommu->cap);
-	pr_debug("%s: Number of Domains supported <%ld>\n",
+	pr_debug("%s: Number of Domains supported <%d>\n",
 		 iommu->name, ndomains);
 	nlongs = BITS_TO_LONGS(ndomains);
 
 	spin_lock_init(&iommu->lock);
 
-	/* TBD: there might be 64K domains,
-	 * consider other allocation for future chip
-	 */
 	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
 	if (!iommu->domain_ids) {
 		pr_err("%s: Allocating domain id array failed\n",
 		       iommu->name);
 		return -ENOMEM;
 	}
-	iommu->domains = kcalloc(ndomains, sizeof(struct dmar_domain *),
-			GFP_KERNEL);
-	if (!iommu->domains) {
+
+	size = ((ndomains >> 8) + 1) * sizeof(struct dmar_domain **);
+	iommu->domains = kzalloc(size, GFP_KERNEL);
+
+	if (iommu->domains) {
+		size = 256 * sizeof(struct dmar_domain *);
+		iommu->domains[0] = kzalloc(size, GFP_KERNEL);
+	}
+
+	if (!iommu->domains || !iommu->domains[0]) {
 		pr_err("%s: Allocating domain array failed\n",
 		       iommu->name);
 		kfree(iommu->domain_ids);
+		kfree(iommu->domains);
 		iommu->domain_ids = NULL;
+		iommu->domains    = NULL;
 		return -ENOMEM;
 	}
 
+
+
 	/*
 	 * If Caching mode is set, then invalid translations are tagged
 	 * with domain-id 0, hence we need to pre-allocate it. We also
@@ -1598,6 +1625,11 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
 	if ((iommu->domains) && (iommu->domain_ids)) {
+		int elems = (cap_ndoms(iommu->cap) >> 8) + 1;
+		int i;
+
+		for (i = 0; i < elems; i++)
+			kfree(iommu->domains[i]);
 		kfree(iommu->domains);
 		kfree(iommu->domain_ids);
 		iommu->domains = NULL;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d9a366d..6240063 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -344,7 +344,7 @@ struct intel_iommu {
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
-	struct dmar_domain **domains; /* ptr to domains */
+	struct dmar_domain ***domains; /* ptr to domains */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
-- 
1.9.1
