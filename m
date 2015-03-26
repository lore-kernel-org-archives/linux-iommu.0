From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 15/16] iommu/fsl: Make use of domain_alloc and domain_free
Date: Thu, 26 Mar 2015 13:43:18 +0100
Message-ID: <1427373799-18662-16-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Implement domain_alloc and domain_free iommu-ops as a
replacement for domain_init/domain_destroy.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/fsl_pamu_domain.c | 60 ++++++++++++++++++++++-------------------
 drivers/iommu/fsl_pamu_domain.h |  2 +-
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index ceebd28..1d45293 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -33,6 +33,11 @@ static struct kmem_cache *fsl_pamu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 static DEFINE_SPINLOCK(device_domain_lock);
 
+static struct fsl_dma_domain *to_fsl_dma_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct fsl_dma_domain, iommu_domain);
+}
+
 static int __init iommu_init_mempool(void)
 {
 	fsl_pamu_domain_cache = kmem_cache_create("fsl_pamu_domain",
@@ -65,7 +70,7 @@ static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t i
 	struct dma_window *win_ptr = &dma_domain->win_arr[0];
 	struct iommu_domain_geometry *geom;
 
-	geom = &dma_domain->iommu_domain->geometry;
+	geom = &dma_domain->iommu_domain.geometry;
 
 	if (!win_cnt || !dma_domain->geom_size) {
 		pr_debug("Number of windows/geometry not configured for the domain\n");
@@ -123,7 +128,7 @@ static int map_win(int liodn, struct fsl_dma_domain *dma_domain)
 {
 	int ret;
 	struct dma_window *wnd = &dma_domain->win_arr[0];
-	phys_addr_t wnd_addr = dma_domain->iommu_domain->geometry.aperture_start;
+	phys_addr_t wnd_addr = dma_domain->iommu_domain.geometry.aperture_start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu_lock, flags);
@@ -172,7 +177,7 @@ static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr
 	} else {
 		phys_addr_t wnd_addr;
 
-		wnd_addr = dma_domain->iommu_domain->geometry.aperture_start;
+		wnd_addr = dma_domain->iommu_domain.geometry.aperture_start;
 
 		ret = pamu_config_ppaace(liodn, wnd_addr,
 					 wnd->size,
@@ -384,7 +389,7 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
 					 dma_addr_t iova)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
@@ -398,11 +403,9 @@ static bool fsl_pamu_capable(enum iommu_cap cap)
 	return cap == IOMMU_CAP_CACHE_COHERENCY;
 }
 
-static void fsl_pamu_domain_destroy(struct iommu_domain *domain)
+static void fsl_pamu_domain_free(struct iommu_domain *domain)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
-
-	domain->priv = NULL;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 
 	/* remove all the devices from the device list */
 	detach_device(NULL, dma_domain);
@@ -413,23 +416,24 @@ static void fsl_pamu_domain_destroy(struct iommu_domain *domain)
 	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
 }
 
-static int fsl_pamu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
 {
 	struct fsl_dma_domain *dma_domain;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
 	dma_domain = iommu_alloc_dma_domain();
 	if (!dma_domain) {
 		pr_debug("dma_domain allocation failed\n");
-		return -ENOMEM;
+		return NULL;
 	}
-	domain->priv = dma_domain;
-	dma_domain->iommu_domain = domain;
 	/* defaul geometry 64 GB i.e. maximum system address */
-	domain->geometry.aperture_start = 0;
-	domain->geometry.aperture_end = (1ULL << 36) - 1;
-	domain->geometry.force_aperture = true;
+	dma_domain->iommu_domain. geometry.aperture_start = 0;
+	dma_domain->iommu_domain.geometry.aperture_end = (1ULL << 36) - 1;
+	dma_domain->iommu_domain.geometry.force_aperture = true;
 
-	return 0;
+	return &dma_domain->iommu_domain;
 }
 
 /* Configure geometry settings for all LIODNs associated with domain */
@@ -499,7 +503,7 @@ static int disable_domain_win(struct fsl_dma_domain *dma_domain, u32 wnd_nr)
 
 static void fsl_pamu_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	unsigned long flags;
 	int ret;
 
@@ -530,7 +534,7 @@ static void fsl_pamu_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 static int fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				  phys_addr_t paddr, u64 size, int prot)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	struct dma_window *wnd;
 	int pamu_prot = 0;
 	int ret;
@@ -607,7 +611,7 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 				int num)
 {
 	unsigned long flags;
-	struct iommu_domain *domain = dma_domain->iommu_domain;
+	struct iommu_domain *domain = &dma_domain->iommu_domain;
 	int ret = 0;
 	int i;
 
@@ -653,7 +657,7 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 static int fsl_pamu_attach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	const u32 *liodn;
 	u32 liodn_cnt;
 	int len, ret = 0;
@@ -691,7 +695,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 static void fsl_pamu_detach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	const u32 *prop;
 	int len;
 	struct pci_dev *pdev = NULL;
@@ -723,7 +727,7 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
 static  int configure_domain_geometry(struct iommu_domain *domain, void *data)
 {
 	struct iommu_domain_geometry *geom_attr = data;
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	dma_addr_t geom_size;
 	unsigned long flags;
 
@@ -813,7 +817,7 @@ static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool en
 static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	int ret = 0;
 
 	switch (attr_type) {
@@ -838,7 +842,7 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	int ret = 0;
 
 	switch (attr_type) {
@@ -999,7 +1003,7 @@ static void fsl_pamu_remove_device(struct device *dev)
 
 static int fsl_pamu_set_windows(struct iommu_domain *domain, u32 w_count)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	unsigned long flags;
 	int ret;
 
@@ -1048,15 +1052,15 @@ static int fsl_pamu_set_windows(struct iommu_domain *domain, u32 w_count)
 
 static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
 {
-	struct fsl_dma_domain *dma_domain = domain->priv;
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 
 	return dma_domain->win_cnt;
 }
 
 static const struct iommu_ops fsl_pamu_ops = {
 	.capable	= fsl_pamu_capable,
-	.domain_init	= fsl_pamu_domain_init,
-	.domain_destroy = fsl_pamu_domain_destroy,
+	.domain_alloc	= fsl_pamu_domain_alloc,
+	.domain_free    = fsl_pamu_domain_free,
 	.attach_dev	= fsl_pamu_attach_device,
 	.detach_dev	= fsl_pamu_detach_device,
 	.domain_window_enable = fsl_pamu_window_enable,
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index c90293f..f2b0f74 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -71,7 +71,7 @@ struct fsl_dma_domain {
 	u32				stash_id;
 	struct pamu_stash_attribute	dma_stash;
 	u32				snoop_id;
-	struct iommu_domain		*iommu_domain;
+	struct iommu_domain		iommu_domain;
 	spinlock_t			domain_lock;
 };
 
-- 
1.9.1
