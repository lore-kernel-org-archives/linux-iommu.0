From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/15] iommu/vt-d: Make use of domain_alloc and domain_free
Date: Tue, 27 Jan 2015 00:51:34 +0100
Message-ID: <1422316305-19216-5-git-send-email-joro@8bytes.org>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422316305-19216-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Get rid of domain_init and domain_destroy and implement
domain_alloc/domain_free instead.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 48 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 40dfbc0..f3e979f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -336,7 +336,7 @@ struct dmar_domain {
 	DECLARE_BITMAP(iommu_bmp, DMAR_UNITS_SUPPORTED);
 					/* bitmap of iommus this domain uses*/
 
-	struct list_head devices; 	/* all devices' list */
+	struct list_head devices;	/* all devices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -355,6 +355,9 @@ struct dmar_domain {
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
 	spinlock_t	iommu_lock;	/* protect iommu set in domain */
 	u64		max_addr;	/* maximum mapped address */
+
+	struct iommu_domain domain;	/* generic domain data structure for
+					   iommu core */
 };
 
 /* PCI domain-device relationship */
@@ -446,6 +449,12 @@ static LIST_HEAD(device_domain_list);
 
 static const struct iommu_ops intel_iommu_ops;
 
+/* Convert generic 'struct iommu_domain to private struct dmar_domain */
+static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct dmar_domain, domain);
+}
+
 static int __init intel_iommu_setup(char *str)
 {
 	if (!str)
@@ -4363,44 +4372,45 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
-static int intel_iommu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *intel_iommu_domain_alloc(enum iommu_domain_type type)
 {
 	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
+
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
 
 	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
 	if (!dmar_domain) {
 		printk(KERN_ERR
 			"intel_iommu_domain_init: dmar_domain == NULL\n");
-		return -ENOMEM;
+		return NULL;
 	}
 	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 		printk(KERN_ERR
 			"intel_iommu_domain_init() failed\n");
 		domain_exit(dmar_domain);
-		return -ENOMEM;
+		return NULL;
 	}
 	domain_update_iommu_cap(dmar_domain);
-	domain->priv = dmar_domain;
 
+	domain = &dmar_domain->domain;
 	domain->geometry.aperture_start = 0;
 	domain->geometry.aperture_end   = __DOMAIN_MAX_ADDR(dmar_domain->gaw);
 	domain->geometry.force_aperture = true;
 
-	return 0;
+	return domain;
 }
 
-static void intel_iommu_domain_destroy(struct iommu_domain *domain)
+static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = domain->priv;
-
-	domain->priv = NULL;
-	domain_exit(dmar_domain);
+	domain_exit(to_dmar_domain(domain));
 }
 
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct dmar_domain *dmar_domain = domain->priv;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
 	int addr_width;
 	u8 bus, devfn;
@@ -4465,16 +4475,14 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
-	struct dmar_domain *dmar_domain = domain->priv;
-
-	domain_remove_one_dev_info(dmar_domain, dev);
+	domain_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
 {
-	struct dmar_domain *dmar_domain = domain->priv;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	u64 max_addr;
 	int prot = 0;
 	int ret;
@@ -4511,7 +4519,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				unsigned long iova, size_t size)
 {
-	struct dmar_domain *dmar_domain = domain->priv;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct page *freelist = NULL;
 	struct intel_iommu *iommu;
 	unsigned long start_pfn, last_pfn;
@@ -4559,7 +4567,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
-	struct dmar_domain *dmar_domain = domain->priv;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct dma_pte *pte;
 	int level = 0;
 	u64 phys = 0;
@@ -4618,8 +4626,8 @@ static void intel_iommu_remove_device(struct device *dev)
 
 static const struct iommu_ops intel_iommu_ops = {
 	.capable	= intel_iommu_capable,
-	.domain_init	= intel_iommu_domain_init,
-	.domain_destroy = intel_iommu_domain_destroy,
+	.domain_alloc	= intel_iommu_domain_alloc,
+	.domain_free	= intel_iommu_domain_free,
 	.attach_dev	= intel_iommu_attach_device,
 	.detach_dev	= intel_iommu_detach_device,
 	.map		= intel_iommu_map,
-- 
1.8.4.5
