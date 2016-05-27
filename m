From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/2] iommu/vt-d: use marco for dmar_domain's second level
	size and shift
Date: Fri, 27 May 2016 22:24:08 +0000
Message-ID: <1464387848-16942-3-git-send-email-richard.weiyang@gmail.com>
References: <1464387848-16942-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464387848-16942-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

In the origin commit, the size of the second level is hard coded to an
integer, 256.

This patch defines two marco for the second level size and shift.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 12 ++++++------
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1c8b587..dd050d7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -616,7 +616,7 @@ static struct kmem_cache *iommu_devinfo_cache;
 static struct dmar_domain* get_iommu_domain(struct intel_iommu *iommu, u16 did)
 {
 	struct dmar_domain **domains;
-	int idx = did >> 8;
+	int idx = did >> DMAR_DOMS_SHIFT;
 
 	domains = iommu->domains[idx];
 	if (!domains)
@@ -629,10 +629,10 @@ static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
 			     struct dmar_domain *domain)
 {
 	struct dmar_domain **domains;
-	int idx = did >> 8;
+	int idx = did >> DMAR_DOMS_SHIFT;
 
 	if (!iommu->domains[idx]) {
-		size_t size = 256 * sizeof(struct dmar_domain *);
+		size_t size = DMAR_DOMS_SIZE * sizeof(struct dmar_domain *);
 		iommu->domains[idx] = kzalloc(size, GFP_ATOMIC);
 	}
 
@@ -1634,11 +1634,11 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 		return -ENOMEM;
 	}
 
-	size = DIV_ROUND_UP(ndomains, 256) * sizeof(struct dmar_domain **);
+	size = DIV_ROUND_UP(ndomains, DMAR_DOMS_SIZE) * sizeof(struct dmar_domain **);
 	iommu->domains = kzalloc(size, GFP_KERNEL);
 
 	if (iommu->domains) {
-		size = 256 * sizeof(struct dmar_domain *);
+		size = DMAR_DOMS_SIZE * sizeof(struct dmar_domain *);
 		iommu->domains[0] = kzalloc(size, GFP_KERNEL);
 	}
 
@@ -1699,7 +1699,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
 	if ((iommu->domains) && (iommu->domain_ids)) {
-		int elems = DIV_ROUND_UP(cap_ndoms(iommu->cap), 256);
+		int elems = DIV_ROUND_UP(cap_ndoms(iommu->cap), DMAR_DOMS_SIZE);
 		int i;
 
 		for (i = 0; i < elems; i++)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2d9b650..afcb7bf 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -412,6 +412,8 @@ struct intel_iommu {
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
+#define DMAR_DOMS_SHIFT 8
+#define DMAR_DOMS_SIZE (1 << DMAR_DOMS_SHIFT )
 	struct dmar_domain ***domains; /* ptr to domains */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
-- 
2.5.0
