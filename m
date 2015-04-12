From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 15/16] iommu/fsl: Make use of domain_alloc and domain_free
Date: Sun, 12 Apr 2015 14:25:58 +0000
Message-ID: <BN3PR0301MB1219162C883B327D4D9F55FCEAF80@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
	<1427373799-18662-16-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427373799-18662-16-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Joerg Roedel
> Sent: Thursday, March 26, 2015 6:13 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: Alexandre Courbot; linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Heiko Stuebner;
> Arnd Bergmann; Stephen Warren; Will Deacon; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Kukjin Kim;
> Thierry Reding; jroedel-l3A5Bk7waGM@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Yingjoe
> Chen; David Woodhouse; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: [PATCH 15/16] iommu/fsl: Make use of domain_alloc and
> domain_free
> 
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Implement domain_alloc and domain_free iommu-ops as a replacement for
> domain_init/domain_destroy.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 60 ++++++++++++++++++++++--------
> -----------
>  drivers/iommu/fsl_pamu_domain.h |  2 +-
>  2 files changed, 33 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index ceebd28..1d45293 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -33,6 +33,11 @@ static struct kmem_cache *fsl_pamu_domain_cache;
> static struct kmem_cache *iommu_devinfo_cache;  static
> DEFINE_SPINLOCK(device_domain_lock);
> 
> +static struct fsl_dma_domain *to_fsl_dma_domain(struct iommu_domain
> +*dom) {
> +	return container_of(dom, struct fsl_dma_domain, iommu_domain);
> }
> +
>  static int __init iommu_init_mempool(void)  {
>  	fsl_pamu_domain_cache =
> kmem_cache_create("fsl_pamu_domain",
> @@ -65,7 +70,7 @@ static phys_addr_t get_phys_addr(struct
> fsl_dma_domain *dma_domain, dma_addr_t i
>  	struct dma_window *win_ptr = &dma_domain->win_arr[0];
>  	struct iommu_domain_geometry *geom;
> 
> -	geom = &dma_domain->iommu_domain->geometry;
> +	geom = &dma_domain->iommu_domain.geometry;
> 
>  	if (!win_cnt || !dma_domain->geom_size) {
>  		pr_debug("Number of windows/geometry not configured
> for the domain\n"); @@ -123,7 +128,7 @@ static int map_win(int liodn,
> struct fsl_dma_domain *dma_domain)  {
>  	int ret;
>  	struct dma_window *wnd = &dma_domain->win_arr[0];
> -	phys_addr_t wnd_addr = dma_domain->iommu_domain-
> >geometry.aperture_start;
> +	phys_addr_t wnd_addr =
> +dma_domain->iommu_domain.geometry.aperture_start;
>  	unsigned long flags;
> 
>  	spin_lock_irqsave(&iommu_lock, flags); @@ -172,7 +177,7 @@ static
> int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32
> wnd_nr
>  	} else {
>  		phys_addr_t wnd_addr;
> 
> -		wnd_addr = dma_domain->iommu_domain-
> >geometry.aperture_start;
> +		wnd_addr = dma_domain-
> >iommu_domain.geometry.aperture_start;
> 
>  		ret = pamu_config_ppaace(liodn, wnd_addr,
>  					 wnd->size,
> @@ -384,7 +389,7 @@ static void attach_device(struct fsl_dma_domain
> *dma_domain, int liodn, struct d  static phys_addr_t
> fsl_pamu_iova_to_phys(struct iommu_domain *domain,
>  					 dma_addr_t iova)
>  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
> 
>  	if (iova < domain->geometry.aperture_start ||
>  	    iova > domain->geometry.aperture_end) @@ -398,11 +403,9 @@
> static bool fsl_pamu_capable(enum iommu_cap cap)
>  	return cap == IOMMU_CAP_CACHE_COHERENCY;  }
> 
> -static void fsl_pamu_domain_destroy(struct iommu_domain *domain)
> +static void fsl_pamu_domain_free(struct iommu_domain *domain)
>  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> -
> -	domain->priv = NULL;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
> 
>  	/* remove all the devices from the device list */
>  	detach_device(NULL, dma_domain);
> @@ -413,23 +416,24 @@ static void fsl_pamu_domain_destroy(struct
> iommu_domain *domain)
>  	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);  }
> 
> -static int fsl_pamu_domain_init(struct iommu_domain *domain)
> +static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
>  {
>  	struct fsl_dma_domain *dma_domain;
> 
> +	if (type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;
> +
>  	dma_domain = iommu_alloc_dma_domain();
>  	if (!dma_domain) {
>  		pr_debug("dma_domain allocation failed\n");
> -		return -ENOMEM;
> +		return NULL;
>  	}
> -	domain->priv = dma_domain;
> -	dma_domain->iommu_domain = domain;
>  	/* defaul geometry 64 GB i.e. maximum system address */
> -	domain->geometry.aperture_start = 0;
> -	domain->geometry.aperture_end = (1ULL << 36) - 1;
> -	domain->geometry.force_aperture = true;
> +	dma_domain->iommu_domain. geometry.aperture_start = 0;
> +	dma_domain->iommu_domain.geometry.aperture_end = (1ULL <<
> 36) - 1;
> +	dma_domain->iommu_domain.geometry.force_aperture = true;
> 
> -	return 0;
> +	return &dma_domain->iommu_domain;
>  }
> 
>  /* Configure geometry settings for all LIODNs associated with domain */
> @@ -499,7 +503,7 @@ static int disable_domain_win(struct fsl_dma_domain
> *dma_domain, u32 wnd_nr)
> 
>  static void fsl_pamu_window_disable(struct iommu_domain *domain, u32
> wnd_nr)  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	unsigned long flags;
>  	int ret;
> 
> @@ -530,7 +534,7 @@ static void fsl_pamu_window_disable(struct
> iommu_domain *domain, u32 wnd_nr)  static int
> fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
>  				  phys_addr_t paddr, u64 size, int prot)  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	struct dma_window *wnd;
>  	int pamu_prot = 0;
>  	int ret;
> @@ -607,7 +611,7 @@ static int handle_attach_device(struct
> fsl_dma_domain *dma_domain,
>  				int num)
>  {
>  	unsigned long flags;
> -	struct iommu_domain *domain = dma_domain->iommu_domain;
> +	struct iommu_domain *domain = &dma_domain->iommu_domain;
>  	int ret = 0;
>  	int i;
> 
> @@ -653,7 +657,7 @@ static int handle_attach_device(struct
> fsl_dma_domain *dma_domain,  static int fsl_pamu_attach_device(struct
> iommu_domain *domain,
>  				  struct device *dev)
>  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	const u32 *liodn;
>  	u32 liodn_cnt;
>  	int len, ret = 0;
> @@ -691,7 +695,7 @@ static int fsl_pamu_attach_device(struct
> iommu_domain *domain,  static void fsl_pamu_detach_device(struct
> iommu_domain *domain,
>  				   struct device *dev)
>  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	const u32 *prop;
>  	int len;
>  	struct pci_dev *pdev = NULL;
> @@ -723,7 +727,7 @@ static void fsl_pamu_detach_device(struct
> iommu_domain *domain,  static  int configure_domain_geometry(struct
> iommu_domain *domain, void *data)  {
>  	struct iommu_domain_geometry *geom_attr = data;
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	dma_addr_t geom_size;
>  	unsigned long flags;
> 
> @@ -813,7 +817,7 @@ static int configure_domain_dma_state(struct
> fsl_dma_domain *dma_domain, bool en  static int
> fsl_pamu_set_domain_attr(struct iommu_domain *domain,
>  				    enum iommu_attr attr_type, void *data)  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	int ret = 0;
> 
>  	switch (attr_type) {
> @@ -838,7 +842,7 @@ static int fsl_pamu_set_domain_attr(struct
> iommu_domain *domain,  static int fsl_pamu_get_domain_attr(struct
> iommu_domain *domain,
>  				    enum iommu_attr attr_type, void *data)  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	int ret = 0;
> 
>  	switch (attr_type) {
> @@ -999,7 +1003,7 @@ static void fsl_pamu_remove_device(struct device
> *dev)
> 
>  static int fsl_pamu_set_windows(struct iommu_domain *domain, u32
> w_count)  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
>  	unsigned long flags;
>  	int ret;
> 
> @@ -1048,15 +1052,15 @@ static int fsl_pamu_set_windows(struct
> iommu_domain *domain, u32 w_count)
> 
>  static u32 fsl_pamu_get_windows(struct iommu_domain *domain)  {
> -	struct fsl_dma_domain *dma_domain = domain->priv;
> +	struct fsl_dma_domain *dma_domain =
> to_fsl_dma_domain(domain);
> 
>  	return dma_domain->win_cnt;
>  }
> 
>  static const struct iommu_ops fsl_pamu_ops = {
>  	.capable	= fsl_pamu_capable,
> -	.domain_init	= fsl_pamu_domain_init,
> -	.domain_destroy = fsl_pamu_domain_destroy,
> +	.domain_alloc	= fsl_pamu_domain_alloc,
> +	.domain_free    = fsl_pamu_domain_free,
>  	.attach_dev	= fsl_pamu_attach_device,
>  	.detach_dev	= fsl_pamu_detach_device,
>  	.domain_window_enable = fsl_pamu_window_enable, diff --git
> a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
> index c90293f..f2b0f74 100644
> --- a/drivers/iommu/fsl_pamu_domain.h
> +++ b/drivers/iommu/fsl_pamu_domain.h
> @@ -71,7 +71,7 @@ struct fsl_dma_domain {
>  	u32				stash_id;
>  	struct pamu_stash_attribute	dma_stash;
>  	u32				snoop_id;
> -	struct iommu_domain		*iommu_domain;
> +	struct iommu_domain		iommu_domain;
>  	spinlock_t			domain_lock;
>  };
Acked-by: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
