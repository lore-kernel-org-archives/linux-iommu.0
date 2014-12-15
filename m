From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
	instead of initcall
Date: Mon, 15 Dec 2014 17:43:02 +0000
Message-ID: <20141215174302.GU20738@arm.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1826772.xgprzQcfXd@avalon> <20141215171700.GP20738@arm.com>
	<1458739.IClpD3xz3i@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458739.IClpD3xz3i@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 15, 2014 at 05:27:30PM +0000, Laurent Pinchart wrote:
> On Monday 15 December 2014 17:17:00 Will Deacon wrote:
> > On Sun, Dec 14, 2014 at 12:45:36PM +0000, Laurent Pinchart wrote:
> > > On Wednesday 19 November 2014 12:15:47 Marek Szyprowski wrote:
> > > > +static int __init exynos_iommu_of_setup(struct device_node *np)
> > > > +{
> > > > +	struct platform_device *pdev;
> > > > +
> > > > +	if (!init_done)
> > > > +		exynos_iommu_init();
> > > > +
> > > > +	pdev = of_platform_device_create(np, NULL,
> > > > platform_bus_type.dev_root);
> > > > +	if (IS_ERR(pdev))
> > > > +		return PTR_ERR(pdev);
> > > 
> > > If we end up having to create the IOMMU platform devices from within the
> > > drivers, the introduction of IOMMU_OF_DECLARE starts to feel like a
> > > workaround to me. I wonder whether it wouldn't then be better to let the
> > > driver core instantiate the IOMMU platform device from DT as for all
> > > other devices, and use device notifiers to defer probe of the bus masters
> > > until the required IOMMU(s) are registered.
> > > 
> > > Will, what's your opinion on that ?
> > 
> > Creating the platform device manually for the IOMMU is indeed grotty, but I
> > don't really understand why it's needed. Interrupt controllers, for example,
> > seem to get by without one.
> 
> There's several reasons, one of the most compelling ones I can think of at the 
> moment is runtime PM. IRQ controllers close to the CPU use CPU PM notifiers 
> instead. Note that IRQ controllers that are further away from the CPU (such as 
> GPIO-based IRQ controllers) are real platform devices and use runtime PM.

Ok, that's a good point, but the IOMMU will still probe later anyway, right?

> IOMMUs are not as low-level as system interrupt controllers or system clocks. 
> I'm beginning to agree with Thierry that they should be treated as normal 
> platform devices as they're not required earlier than probe time of their bus 
> master devices.

Well, I think you'd have to propose patches for discussion since I'm
certainly not wed to the current approach; I just want something that
allows of_{dma,iommu}_configure to run with the information it needs.

The usual answer is `we should model buses properly', but that's really
not practical afaict.

Will
