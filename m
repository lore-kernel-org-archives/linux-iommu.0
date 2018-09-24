From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 20/20] iommu/tegra: gart: Perform code refactoring
Date: Mon, 24 Sep 2018 13:34:07 +0200
Message-ID: <20180924113407.GQ21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-21-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169524463769838319=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-21-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1169524463769838319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Content-Disposition: inline


--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:53AM +0300, Dmitry Osipenko wrote:
> Perform a major code cleanup to make it more readable and as a result
> easier to maintain. I removed some redundant safety-checks in the code
> and some debug code that isn't actually very useful for debugging, like
> enormous pagetable dump on each fault. The majority of the changes are
> code reshuffling, variables/whitespaces clean up and removal of debug
> messages that duplicate messages of the IOMMU-core.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 215 +++++++++++++++----------------------
>  1 file changed, 84 insertions(+), 131 deletions(-)

While I'm not strongly opposed to this, it's an awful lot of churn for
little to no gain. Yes, this driver may have its weak points in some
areas, but I don't think it's totally unreadable or unmaintainable.
Also, keep in mind that readability is very subjective.

If you set out to rewrite every piece of code in the kernel that you
think is unreadable, I don't think you'll end up a happy person.

> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 7182445c3b76..a36d0c568536 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -34,63 +34,56 @@
>  #define GART_CONFIG		(0x24 - GART_REG_BASE)
>  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
>  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> -#define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> +
> +#define GART_ENTRY_PHYS_ADDR_VALID	BIT(31)
> =20
>  #define GART_PAGE_SHIFT		12
>  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> -#define GART_PAGE_MASK						\
> -	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
> +#define GART_PAGE_MASK		GENMASK(30, GART_PAGE_SHIFT)
> =20
>  struct gart_device {
>  	void __iomem		*regs;
>  	u32			*savedata;
> -	u32			page_count;	/* total remappable size */
> -	dma_addr_t		iovmm_base;	/* offset to vmm_area */
> +	unsigned long		iovmm_base;	/* offset to vmm_area start */
> +	unsigned long		iovmm_end;	/* offset to vmm_area end */
>  	spinlock_t		pte_lock;	/* for pagetable */
>  	spinlock_t		dom_lock;	/* for active domain */
>  	unsigned int		active_devices;	/* number of active devices */
>  	struct iommu_domain	*active_domain;	/* current active domain */
> -	struct device		*dev;
> -
>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> +	struct device		*dev;
>  };
> =20
>  static struct gart_device *gart_handle; /* unique for a system */
> =20
>  static bool gart_debug;
> =20
> -#define GART_PTE(_pfn)						\
> -	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
> -
>  /*
>   * Any interaction between any block on PPSB and a block on APB or AHB
>   * must have these read-back to ensure the APB/AHB bus transaction is
>   * complete before initiating activity on the PPSB block.
>   */
> -#define FLUSH_GART_REGS(gart)	((void)readl((gart)->regs + GART_CONFIG))
> +#define FLUSH_GART_REGS(gart)	readl_relaxed((gart)->regs + GART_CONFIG)
> =20
>  #define for_each_gart_pte(gart, iova)					\
>  	for (iova =3D gart->iovmm_base;					\
> -	     iova < gart->iovmm_base + GART_PAGE_SIZE * gart->page_count; \
> +	     iova < gart->iovmm_end;					\
>  	     iova +=3D GART_PAGE_SIZE)
> =20
>  static inline void gart_set_pte(struct gart_device *gart,
> -				unsigned long offs, u32 pte)
> +				unsigned long iova, phys_addr_t pte)

I don't think this makes sense. phys_addr_t can be 64-bit and actually
will be in the majority of multi-platform builds. iova being unsigned
long is borderline, but probably fine since this driver is exclusive to
32-bit builds.

I think it'd be better to make sure elsewhere that only valid, 32-bit
values are passed in here and return an error at a higher level if
that's not the case. Silently casting away the upper 32 bits in the
writel_relaxed() below is suboptimal. Even if we don't care about the
type mismatch because Tegra20 doesn't have LPAE and therefore the upper
32 bits will always be 0 and the cast is in fact safe, I think we should
be explicitly casting at some point, and I think it should be at a
higher level than gart_set_pte().

>  {
> -	writel(offs, gart->regs + GART_ENTRY_ADDR);
> -	writel(pte, gart->regs + GART_ENTRY_DATA);
> -
> -	dev_dbg(gart->dev, "GART: %s %08lx:%08x\n",
> -		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
> +	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
> +	writel_relaxed(pte, gart->regs + GART_ENTRY_DATA);
>  }
> =20
>  static inline unsigned long gart_read_pte(struct gart_device *gart,
> -					  unsigned long offs)
> +					  unsigned long iova)
>  {
>  	unsigned long pte;
> =20
> -	writel(offs, gart->regs + GART_ENTRY_ADDR);
> -	pte =3D readl(gart->regs + GART_ENTRY_DATA);
> +	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
> +	pte =3D readl_relaxed(gart->regs + GART_ENTRY_DATA);
> =20
>  	return pte;
>  }
> @@ -102,49 +95,20 @@ static void do_gart_setup(struct gart_device *gart, =
const u32 *data)
>  	for_each_gart_pte(gart, iova)
>  		gart_set_pte(gart, iova, data ? *(data++) : 0);
> =20
> -	writel(1, gart->regs + GART_CONFIG);
> +	writel_relaxed(1, gart->regs + GART_CONFIG);
>  	FLUSH_GART_REGS(gart);
>  }
> =20
> -#ifdef DEBUG
> -static void gart_dump_table(struct gart_device *gart)
> +static inline bool gart_iova_range_invalid(struct gart_device *gart,
> +					   unsigned long iova, size_t bytes)
>  {
> -	unsigned long iova;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&gart->pte_lock, flags);
> -	for_each_gart_pte(gart, iova) {
> -		unsigned long pte;
> -
> -		pte =3D gart_read_pte(gart, iova);
> -
> -		dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
> -			(GART_ENTRY_PHYS_ADDR_VALID & pte) ? "v" : " ",
> -			iova, pte & GART_PAGE_MASK);
> -	}
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +	return unlikely(iova < gart->iovmm_base || bytes !=3D GART_PAGE_SIZE ||
> +			iova + bytes > gart->iovmm_end);
>  }
> -#else
> -static inline void gart_dump_table(struct gart_device *gart)
> -{
> -}
> -#endif
> =20
> -static inline bool gart_iova_range_valid(struct gart_device *gart,
> -					 unsigned long iova, size_t bytes)
> +static inline bool gart_pte_valid(struct gart_device *gart, unsigned lon=
g iova)
>  {
> -	unsigned long iova_start, iova_end, gart_start, gart_end;
> -
> -	iova_start =3D iova;
> -	iova_end =3D iova_start + bytes - 1;
> -	gart_start =3D gart->iovmm_base;
> -	gart_end =3D gart_start + gart->page_count * GART_PAGE_SIZE - 1;
> -
> -	if (iova_start < gart_start)
> -		return false;
> -	if (iova_end > gart_end)
> -		return false;
> -	return true;
> +	return !!(gart_read_pte(gart, iova) & GART_ENTRY_PHYS_ADDR_VALID);
>  }
> =20
>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
> @@ -187,7 +151,6 @@ static void gart_iommu_detach_dev(struct iommu_domain=
 *domain,
> =20
>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>  {
> -	struct gart_device *gart =3D gart_handle;
>  	struct iommu_domain *domain;
> =20
>  	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
> @@ -195,9 +158,8 @@ static struct iommu_domain *gart_iommu_domain_alloc(u=
nsigned type)
> =20
>  	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (domain) {
> -		domain->geometry.aperture_start =3D gart->iovmm_base;
> -		domain->geometry.aperture_end =3D gart->iovmm_base +
> -					gart->page_count * GART_PAGE_SIZE - 1;
> +		domain->geometry.aperture_start =3D gart_handle->iovmm_base;
> +		domain->geometry.aperture_end =3D gart_handle->iovmm_end - 1;
>  		domain->geometry.force_aperture =3D true;
>  	}
> =20
> @@ -209,34 +171,44 @@ static void gart_iommu_domain_free(struct iommu_dom=
ain *domain)
>  	kfree(domain);
>  }
> =20
> +static int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
> +			    phys_addr_t pa)
> +{
> +	if (unlikely(gart_debug && gart_pte_valid(gart, iova))) {
> +		dev_WARN(gart->dev, "GART: Page entry is in-use\n");
> +		return -EINVAL;
> +	}
> +
> +	gart_set_pte(gart, iova, GART_ENTRY_PHYS_ADDR_VALID | pa);
> +
> +	return 0;
> +}
> +
>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long iov=
a,
>  			  phys_addr_t pa, size_t bytes, int prot)
>  {
>  	struct gart_device *gart =3D gart_handle;
> -	unsigned long flags;
> -	unsigned long pfn;
> -	unsigned long pte;
> +	int ret;
> =20
> -	if (!gart_iova_range_valid(gart, iova, bytes))
> +	if (gart_iova_range_invalid(gart, iova, bytes))
>  		return -EINVAL;
> =20
> -	spin_lock_irqsave(&gart->pte_lock, flags);
> -	pfn =3D __phys_to_pfn(pa);
> -	if (!pfn_valid(pfn)) {
> -		dev_err(gart->dev, "GART: Invalid page: %pa\n", &pa);
> -		spin_unlock_irqrestore(&gart->pte_lock, flags);
> +	spin_lock(&gart->pte_lock);
> +	ret =3D __gart_iommu_map(gart, iova, pa);
> +	spin_unlock(&gart->pte_lock);
> +
> +	return ret;
> +}
> +
> +static int __gart_iommu_unmap(struct gart_device *gart, unsigned long io=
va)
> +{
> +	if (unlikely(gart_debug && !gart_pte_valid(gart, iova))) {
> +		dev_WARN(gart->dev, "GART: Page entry is invalid\n");
>  		return -EINVAL;
>  	}
> -	if (gart_debug) {
> -		pte =3D gart_read_pte(gart, iova);
> -		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
> -			spin_unlock_irqrestore(&gart->pte_lock, flags);
> -			dev_err(gart->dev, "GART: Page entry is in-use\n");
> -			return -EBUSY;
> -		}
> -	}
> -	gart_set_pte(gart, iova, GART_PTE(pfn));
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +
> +	gart_set_pte(gart, iova, 0);
> +
>  	return 0;
>  }
> =20
> @@ -244,15 +216,16 @@ static size_t gart_iommu_unmap(struct iommu_domain =
*domain, unsigned long iova,
>  			       size_t bytes)
>  {
>  	struct gart_device *gart =3D gart_handle;
> -	unsigned long flags;
> +	int err;
> =20
> -	if (!gart_iova_range_valid(gart, iova, bytes))
> +	if (gart_iova_range_invalid(gart, iova, bytes))
>  		return 0;
> =20
> -	spin_lock_irqsave(&gart->pte_lock, flags);
> -	gart_set_pte(gart, iova, 0);
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> -	return bytes;
> +	spin_lock(&gart->pte_lock);
> +	err =3D __gart_iommu_unmap(gart, iova);
> +	spin_unlock(&gart->pte_lock);
> +
> +	return err ? 0 : bytes;
>  }
> =20
>  static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
> @@ -260,24 +233,15 @@ static phys_addr_t gart_iommu_iova_to_phys(struct i=
ommu_domain *domain,
>  {
>  	struct gart_device *gart =3D gart_handle;
>  	unsigned long pte;
> -	phys_addr_t pa;
> -	unsigned long flags;
> =20
> -	if (!gart_iova_range_valid(gart, iova, 0))
> +	if (gart_iova_range_invalid(gart, iova, SZ_4K))
>  		return -EINVAL;
> =20
> -	spin_lock_irqsave(&gart->pte_lock, flags);
> +	spin_lock(&gart->pte_lock);
>  	pte =3D gart_read_pte(gart, iova);
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +	spin_unlock(&gart->pte_lock);
> =20
> -	pa =3D (pte & GART_PAGE_MASK);
> -	if (!pfn_valid(__phys_to_pfn(pa))) {
> -		dev_err(gart->dev, "GART: No entry for %08llx:%pa\n",
> -			 (unsigned long long)iova, &pa);
> -		gart_dump_table(gart);
> -		return -EINVAL;
> -	}
> -	return pa;
> +	return pte & GART_PAGE_MASK;
>  }
> =20
>  static bool gart_iommu_capable(enum iommu_cap cap)
> @@ -342,24 +306,19 @@ static const struct iommu_ops gart_iommu_ops =3D {
> =20
>  int tegra_gart_suspend(struct gart_device *gart)
>  {
> -	unsigned long iova;
>  	u32 *data =3D gart->savedata;
> -	unsigned long flags;
> +	unsigned long iova;
> =20
> -	spin_lock_irqsave(&gart->pte_lock, flags);
>  	for_each_gart_pte(gart, iova)
>  		*(data++) =3D gart_read_pte(gart, iova);
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);

Why is it safe to remove the lock here?

> +
>  	return 0;
>  }
> =20
>  int tegra_gart_resume(struct gart_device *gart)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&gart->pte_lock, flags);
>  	do_gart_setup(gart, gart->savedata);
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +
>  	return 0;
>  }
> =20
> @@ -368,8 +327,7 @@ struct gart_device *tegra_gart_probe(struct device *d=
ev,
>  				     struct tegra_mc *mc)
>  {
>  	struct gart_device *gart;
> -	struct resource *res_remap;
> -	void __iomem *gart_regs;
> +	struct resource *res;
>  	int ret;
> =20
>  	BUILD_BUG_ON(PAGE_SHIFT !=3D GART_PAGE_SHIFT);
> @@ -379,9 +337,8 @@ struct gart_device *tegra_gart_probe(struct device *d=
ev,
>  		return NULL;
> =20
>  	/* the GART memory aperture is required */
> -	res_remap =3D platform_get_resource(to_platform_device(dev),
> -					  IORESOURCE_MEM, 1);
> -	if (!res_remap) {
> +	res =3D platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, =
1);
> +	if (!res) {
>  		dev_err(dev, "GART: Memory aperture resource unavailable\n");
>  		return ERR_PTR(-ENXIO);
>  	}
> @@ -390,39 +347,35 @@ struct gart_device *tegra_gart_probe(struct device =
*dev,
>  	if (!gart)
>  		return ERR_PTR(-ENOMEM);
> =20
> +	gart_handle =3D gart;
> +
> +	gart->dev =3D dev;
> +	gart->regs =3D mc->regs + GART_REG_BASE;
> +	gart->iovmm_base =3D res->start;
> +	gart->iovmm_end =3D res->start + resource_size(res);

Why not simply:

	gart->iovmm_end =3D res->end;

?

Thierry

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluoy6wACgkQ3SOs138+
s6HWkg//fCyMuqEpWOyLm86Dn4YAM3o4hr2xgOqfbidQtt/rVCwbrwGKy9Bx2Lyu
XEHgQsWz8hSv9GKYm6yF/jWAu0X/LX9oF/oWNf4IkZBgc3kZdfWjepBbo2JYVquo
ozi3Toz1vGoQbi+/mqsjCfQHiw/aQAUn0XaNx8aC4oJKsc9JGadLFK67L2RzRmbL
PLvoyEW7E8AgHPfF/Lx/pwtSWyxL6KNGyKJ0NId/vbQ4hdDPr1xFMcm7tL+agwjz
9+m9xw1Hox9rPxBTicle0XthorvIUwGop2o0oVhXY8BVpKt8PARCVixhe/vRzeH7
eZi/9OoZ4xKmFQQsIhhDT5Pp8bWucPtSHaaR7Ds5PqNbojvuzJG1qOGcfn7R8WE8
yrhvAsyn4T0QrU0VI6+h6IvR8KQAeNpUJ9zT21Cz/ahcduG2ivPkmGRayxG4gHRW
5T5m6tbxzHnoZ/FgjX1hvOVHRsetXJZmmnd3frc8odxpB7W6dH6+f8Yt40pNlVsz
gwW6Iq1VvTQdIThC6qFbu4kEnO1XLNwwvyRf0kikhZq19U4+bz/4FUGAtRc9jy2r
/gkFAkIrvi4vQdAcS7afuXytCx+Lxg9w6UFkfyKo0oOHmeucJP5xmnH5DW7WvJuQ
Uw3qOi4RqOl1GGXGM1bOPj3GWKnHwb1Gx7DpgFdp14g3mOTPQPM=
=Aoju
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--

--===============1169524463769838319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1169524463769838319==--
