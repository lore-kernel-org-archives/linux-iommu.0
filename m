From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
	instead of initcall
Date: Mon, 15 Dec 2014 19:27:30 +0200
Message-ID: <1458739.IClpD3xz3i@avalon>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1826772.xgprzQcfXd@avalon> <20141215171700.GP20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141215171700.GP20738-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 15 December 2014 17:17:00 Will Deacon wrote:
> On Sun, Dec 14, 2014 at 12:45:36PM +0000, Laurent Pinchart wrote:
> > On Wednesday 19 November 2014 12:15:47 Marek Szyprowski wrote:
> > > This patch introduces IOMMU_OF_DECLARE-based initialization to the
> > > driver, which replaces subsys_initcall-based procedure.
> > > exynos_iommu_of_setup ensures that each sysmmu controller is probed
> > > before its master device.
> > > 
> > > Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > > 
> > >  drivers/iommu/exynos-iommu.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > > index cd28dc09db39..88f9afe641a0 100644
> > > --- a/drivers/iommu/exynos-iommu.c
> > > +++ b/drivers/iommu/exynos-iommu.c
> > 
> > [snip]
> > 
> > > @@ -1125,4 +1134,21 @@ err_reg_driver:
> > >  	kmem_cache_destroy(lv2table_kmem_cache);
> > >  	return ret;
> > >  
> > >  }
> > > 
> > > -subsys_initcall(exynos_iommu_init);
> > > +
> > > +static int __init exynos_iommu_of_setup(struct device_node *np)
> > > +{
> > > +	struct platform_device *pdev;
> > > +
> > > +	if (!init_done)
> > > +		exynos_iommu_init();
> > > +
> > > +	pdev = of_platform_device_create(np, NULL,
> > > platform_bus_type.dev_root);
> > > +	if (IS_ERR(pdev))
> > > +		return PTR_ERR(pdev);
> > 
> > If we end up having to create the IOMMU platform devices from within the
> > drivers, the introduction of IOMMU_OF_DECLARE starts to feel like a
> > workaround to me. I wonder whether it wouldn't then be better to let the
> > driver core instantiate the IOMMU platform device from DT as for all
> > other devices, and use device notifiers to defer probe of the bus masters
> > until the required IOMMU(s) are registered.
> > 
> > Will, what's your opinion on that ?
> 
> Creating the platform device manually for the IOMMU is indeed grotty, but I
> don't really understand why it's needed. Interrupt controllers, for example,
> seem to get by without one.

There's several reasons, one of the most compelling ones I can think of at the 
moment is runtime PM. IRQ controllers close to the CPU use CPU PM notifiers 
instead. Note that IRQ controllers that are further away from the CPU (such as 
GPIO-based IRQ controllers) are real platform devices and use runtime PM.

IOMMUs are not as low-level as system interrupt controllers or system clocks. 
I'm beginning to agree with Thierry that they should be treated as normal 
platform devices as they're not required earlier than probe time of their bus 
master devices.

-- 
Regards,

Laurent Pinchart
