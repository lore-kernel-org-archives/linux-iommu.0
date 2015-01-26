From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/15] iommu/msm: Make use of domain_alloc and domain_free
Date: Tue, 27 Jan 2015 00:51:40 +0100
Message-ID: <1422316305-19216-11-git-send-email-joro@8bytes.org>
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
 drivers/iommu/msm_iommu.c | 73 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index e1b0537..f023c7a 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -52,8 +52,14 @@ DEFINE_SPINLOCK(msm_iommu_lock);
 struct msm_priv {
 	unsigned long *pgtable;
 	struct list_head list_attached;
+	struct iommu_domain domain;
 };
 
+static struct msm_priv *to_msm_priv(struct iommu_domain *dom)
+{
+	return container_of(dom, struct msm_priv, domain);
+}
+
 static int __enable_clocks(struct msm_iommu_drvdata *drvdata)
 {
 	int ret;
@@ -79,7 +85,7 @@ static void __disable_clocks(struct msm_iommu_drvdata *drvdata)
 
 static int __flush_iotlb(struct iommu_domain *domain)
 {
-	struct msm_priv *priv = domain->priv;
+	struct msm_priv *priv = to_msm_priv(domain);
 	struct msm_iommu_drvdata *iommu_drvdata;
 	struct msm_iommu_ctx_drvdata *ctx_drvdata;
 	int ret = 0;
@@ -209,10 +215,14 @@ static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
 	SET_M(base, ctx, 1);
 }
 
-static int msm_iommu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *msm_iommu_domain_alloc(enum iommu_domain_type type)
 {
-	struct msm_priv *priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	struct msm_priv *priv;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		goto fail_nomem;
 
@@ -224,20 +234,19 @@ static int msm_iommu_domain_init(struct iommu_domain *domain)
 		goto fail_nomem;
 
 	memset(priv->pgtable, 0, SZ_16K);
-	domain->priv = priv;
 
-	domain->geometry.aperture_start = 0;
-	domain->geometry.aperture_end   = (1ULL << 32) - 1;
-	domain->geometry.force_aperture = true;
+	priv->domain.geometry.aperture_start = 0;
+	priv->domain.geometry.aperture_end   = (1ULL << 32) - 1;
+	priv->domain.geometry.force_aperture = true;
 
-	return 0;
+	return &priv->domain;
 
 fail_nomem:
 	kfree(priv);
-	return -ENOMEM;
+	return NULL;
 }
 
-static void msm_iommu_domain_destroy(struct iommu_domain *domain)
+static void msm_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct msm_priv *priv;
 	unsigned long flags;
@@ -245,20 +254,17 @@ static void msm_iommu_domain_destroy(struct iommu_domain *domain)
 	int i;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	priv = domain->priv;
-	domain->priv = NULL;
+	priv = to_msm_priv(domain);
 
-	if (priv) {
-		fl_table = priv->pgtable;
+	fl_table = priv->pgtable;
 
-		for (i = 0; i < NUM_FL_PTE; i++)
-			if ((fl_table[i] & 0x03) == FL_TYPE_TABLE)
-				free_page((unsigned long) __va(((fl_table[i]) &
-								FL_BASE_MASK)));
+	for (i = 0; i < NUM_FL_PTE; i++)
+		if ((fl_table[i] & 0x03) == FL_TYPE_TABLE)
+			free_page((unsigned long) __va(((fl_table[i]) &
+							FL_BASE_MASK)));
 
-		free_pages((unsigned long)priv->pgtable, get_order(SZ_16K));
-		priv->pgtable = NULL;
-	}
+	free_pages((unsigned long)priv->pgtable, get_order(SZ_16K));
+	priv->pgtable = NULL;
 
 	kfree(priv);
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
@@ -276,9 +282,9 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
-	priv = domain->priv;
+	priv = to_msm_priv(domain);
 
-	if (!priv || !dev) {
+	if (!dev) {
 		ret = -EINVAL;
 		goto fail;
 	}
@@ -330,9 +336,9 @@ static void msm_iommu_detach_dev(struct iommu_domain *domain,
 	int ret;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	priv = domain->priv;
+	priv = to_msm_priv(domain);
 
-	if (!priv || !dev)
+	if (!dev)
 		goto fail;
 
 	iommu_drvdata = dev_get_drvdata(dev->parent);
@@ -382,11 +388,7 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long va,
 		goto fail;
 	}
 
-	priv = domain->priv;
-	if (!priv) {
-		ret = -EINVAL;
-		goto fail;
-	}
+	priv = to_msm_priv(domain);
 
 	fl_table = priv->pgtable;
 
@@ -484,10 +486,7 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
-	priv = domain->priv;
-
-	if (!priv)
-		goto fail;
+	priv = to_msm_priv(domain);
 
 	fl_table = priv->pgtable;
 
@@ -566,7 +565,7 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
-	priv = domain->priv;
+	priv = to_msm_priv(domain);
 	if (list_empty(&priv->list_attached))
 		goto fail;
 
@@ -674,8 +673,8 @@ fail:
 
 static const struct iommu_ops msm_iommu_ops = {
 	.capable = msm_iommu_capable,
-	.domain_init = msm_iommu_domain_init,
-	.domain_destroy = msm_iommu_domain_destroy,
+	.domain_alloc = msm_iommu_domain_alloc,
+	.domain_free = msm_iommu_domain_free,
 	.attach_dev = msm_iommu_attach_dev,
 	.detach_dev = msm_iommu_detach_dev,
 	.map = msm_iommu_map,
-- 
1.8.4.5
