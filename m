From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/15] iommu/shmobile: Make use of domain_alloc and domain_free
Date: Tue, 27 Jan 2015 00:51:41 +0100
Message-ID: <1422316305-19216-12-git-send-email-joro@8bytes.org>
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
 drivers/iommu/shmobile-iommu.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index f1b0077..a65601c 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -42,11 +42,17 @@ struct shmobile_iommu_domain {
 	spinlock_t map_lock;
 	spinlock_t attached_list_lock;
 	struct list_head attached_list;
+	struct iommu_domain domain;
 };
 
 static struct shmobile_iommu_archdata *ipmmu_archdata;
 static struct kmem_cache *l1cache, *l2cache;
 
+static struct shmobile_iommu_domain *to_sh_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct shmobile_iommu_domain, domain);
+}
+
 static int pgtable_alloc(struct shmobile_iommu_domain_pgtable *pgtable,
 			 struct kmem_cache *cache, size_t size)
 {
@@ -82,31 +88,34 @@ static void pgtable_write(struct shmobile_iommu_domain_pgtable *pgtable,
 				   sizeof(val) * count, DMA_TO_DEVICE);
 }
 
-static int shmobile_iommu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *
+shmobile_iommu_domain_alloc(enum iommu_domain_type type)
 {
 	struct shmobile_iommu_domain *sh_domain;
 	int i, ret;
 
-	sh_domain = kmalloc(sizeof(*sh_domain), GFP_KERNEL);
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	sh_domain = kzalloc(sizeof(*sh_domain), GFP_KERNEL);
 	if (!sh_domain)
-		return -ENOMEM;
+		return NULL;
 	ret = pgtable_alloc(&sh_domain->l1, l1cache, L1_SIZE);
 	if (ret < 0) {
 		kfree(sh_domain);
-		return ret;
+		return NULL;
 	}
 	for (i = 0; i < L1_LEN; i++)
 		sh_domain->l2[i].pgtable = NULL;
 	spin_lock_init(&sh_domain->map_lock);
 	spin_lock_init(&sh_domain->attached_list_lock);
 	INIT_LIST_HEAD(&sh_domain->attached_list);
-	domain->priv = sh_domain;
-	return 0;
+	return &sh_domain->domain;
 }
 
-static void shmobile_iommu_domain_destroy(struct iommu_domain *domain)
+static void shmobile_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct shmobile_iommu_domain *sh_domain = domain->priv;
+	struct shmobile_iommu_domain *sh_domain = to_sh_domain(domain);
 	int i;
 
 	for (i = 0; i < L1_LEN; i++) {
@@ -115,14 +124,13 @@ static void shmobile_iommu_domain_destroy(struct iommu_domain *domain)
 	}
 	pgtable_free(&sh_domain->l1, l1cache, L1_SIZE);
 	kfree(sh_domain);
-	domain->priv = NULL;
 }
 
 static int shmobile_iommu_attach_device(struct iommu_domain *domain,
 					struct device *dev)
 {
 	struct shmobile_iommu_archdata *archdata = dev->archdata.iommu;
-	struct shmobile_iommu_domain *sh_domain = domain->priv;
+	struct shmobile_iommu_domain *sh_domain = to_sh_domain(domain);
 	int ret = -EBUSY;
 
 	if (!archdata)
@@ -151,7 +159,7 @@ static void shmobile_iommu_detach_device(struct iommu_domain *domain,
 					 struct device *dev)
 {
 	struct shmobile_iommu_archdata *archdata = dev->archdata.iommu;
-	struct shmobile_iommu_domain *sh_domain = domain->priv;
+	struct shmobile_iommu_domain *sh_domain = to_sh_domain(domain);
 
 	if (!archdata)
 		return;
@@ -214,7 +222,7 @@ static int shmobile_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t size, int prot)
 {
 	struct shmobile_iommu_domain_pgtable l2 = { .pgtable = NULL };
-	struct shmobile_iommu_domain *sh_domain = domain->priv;
+	struct shmobile_iommu_domain *sh_domain = to_sh_domain(domain);
 	unsigned int l1index, l2index;
 	int ret;
 
@@ -258,7 +266,7 @@ static size_t shmobile_iommu_unmap(struct iommu_domain *domain,
 				   unsigned long iova, size_t size)
 {
 	struct shmobile_iommu_domain_pgtable l2 = { .pgtable = NULL };
-	struct shmobile_iommu_domain *sh_domain = domain->priv;
+	struct shmobile_iommu_domain *sh_domain = to_sh_domain(domain);
 	unsigned int l1index, l2index;
 	uint32_t l2entry = 0;
 	size_t ret = 0;
@@ -298,7 +306,7 @@ done:
 static phys_addr_t shmobile_iommu_iova_to_phys(struct iommu_domain *domain,
 					       dma_addr_t iova)
 {
-	struct shmobile_iommu_domain *sh_domain = domain->priv;
+	struct shmobile_iommu_domain *sh_domain = to_sh_domain(domain);
 	uint32_t l1entry = 0, l2entry = 0;
 	unsigned int l1index, l2index;
 
@@ -355,8 +363,8 @@ static int shmobile_iommu_add_device(struct device *dev)
 }
 
 static const struct iommu_ops shmobile_iommu_ops = {
-	.domain_init = shmobile_iommu_domain_init,
-	.domain_destroy = shmobile_iommu_domain_destroy,
+	.domain_alloc = shmobile_iommu_domain_alloc,
+	.domain_free = shmobile_iommu_domain_free,
 	.attach_dev = shmobile_iommu_attach_device,
 	.detach_dev = shmobile_iommu_detach_device,
 	.map = shmobile_iommu_map,
-- 
1.8.4.5
