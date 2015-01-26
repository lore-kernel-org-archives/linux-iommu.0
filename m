From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/15] iommu/ipmmu-vmsa: Make use of domain_alloc and
	domain_free
Date: Tue, 27 Jan 2015 00:51:42 +0100
Message-ID: <1422316305-19216-13-git-send-email-joro@8bytes.org>
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

Implement domain_alloc and domain_free iommu-ops as a
replacement for domain_init/domain_destroy.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7486931..12270e1 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -37,7 +37,7 @@ struct ipmmu_vmsa_device {
 
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
-	struct iommu_domain *io_domain;
+	struct iommu_domain io_domain;
 
 	unsigned int context_id;
 	spinlock_t lock;			/* Protects mappings */
@@ -52,6 +52,11 @@ struct ipmmu_vmsa_archdata {
 static DEFINE_SPINLOCK(ipmmu_devices_lock);
 static LIST_HEAD(ipmmu_devices);
 
+static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
+}
+
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -435,7 +440,7 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 	 * TODO: We need to look up the faulty device based on the I/O VA. Use
 	 * the IOMMU device for now.
 	 */
-	if (!report_iommu_fault(domain->io_domain, mmu->dev, iova, 0))
+	if (!report_iommu_fault(&domain->io_domain, mmu->dev, iova, 0))
 		return IRQ_HANDLED;
 
 	dev_err_ratelimited(mmu->dev,
@@ -455,7 +460,7 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 		return IRQ_NONE;
 
 	io_domain = mmu->mapping->domain;
-	domain = io_domain->priv;
+	domain = to_vmsa_domain(io_domain);
 
 	return ipmmu_domain_irq(domain);
 }
@@ -854,31 +859,31 @@ done:
  * IOMMU Operations
  */
 
-static int ipmmu_domain_init(struct iommu_domain *io_domain)
+static struct iommu_domain *ipmmu_domain_alloc(enum iommu_domain_type type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
-		return -ENOMEM;
+		return NULL;
 
 	spin_lock_init(&domain->lock);
 
 	domain->pgd = kzalloc(IPMMU_PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
 	if (!domain->pgd) {
 		kfree(domain);
-		return -ENOMEM;
+		return NULL;
 	}
 
-	io_domain->priv = domain;
-	domain->io_domain = io_domain;
-
-	return 0;
+	return &domain->io_domain;
 }
 
-static void ipmmu_domain_destroy(struct iommu_domain *io_domain)
+static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	/*
 	 * Free the domain resources. We assume that all devices have already
@@ -894,7 +899,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 {
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_device *mmu = archdata->mmu;
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	int ret = 0;
 
@@ -933,7 +938,7 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	ipmmu_utlb_disable(domain, archdata->utlb);
 
@@ -945,7 +950,7 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	if (!domain)
 		return -ENODEV;
@@ -956,7 +961,7 @@ static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 			  size_t size)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	int ret;
 
 	ret = ipmmu_clear_mapping(domain, iova, size);
@@ -966,7 +971,7 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 				      dma_addr_t iova)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	pgd_t pgd;
 	pud_t pud;
 	pmd_t pmd;
@@ -1121,8 +1126,8 @@ static void ipmmu_remove_device(struct device *dev)
 }
 
 static const struct iommu_ops ipmmu_ops = {
-	.domain_init = ipmmu_domain_init,
-	.domain_destroy = ipmmu_domain_destroy,
+	.domain_alloc = ipmmu_domain_alloc,
+	.domain_free = ipmmu_domain_free,
 	.attach_dev = ipmmu_attach_device,
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
-- 
1.8.4.5
