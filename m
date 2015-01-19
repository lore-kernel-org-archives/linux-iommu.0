From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 17/18] iommu: exynos: init from dt-specific callback
	instead of initcall
Date: Mon, 19 Jan 2015 11:33:31 +0000
Message-ID: <20150119113331.GG32131@arm.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
	<1421399592-7482-18-git-send-email-m.szyprowski@samsung.com>
	<10691050.Z5RGmE4fp0@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10691050.Z5RGmE4fp0@avalon>
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
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 19, 2015 at 01:11:07AM +0000, Laurent Pinchart wrote:
> On Friday 16 January 2015 10:13:11 Marek Szyprowski wrote:
> > This patch introduces IOMMU_OF_DECLARE-based initialization to the
> > driver, which replaces subsys_initcall-based procedure.
> > exynos_iommu_of_setup ensures that each sysmmu controller is probed
> > before its master device.

[...]

> > +static int __init exynos_iommu_of_setup(struct device_node *np)
> > +{
> > +	struct platform_device *pdev;
> > +
> > +	if (!init_done)
> > +		exynos_iommu_init();
> > +
> > +	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
> 
> This feels like a hack to me. What happens here is that you're using the 
> IOMMU_OF_DECLARE mechanism to make sure that the iommu platform device will be 
> created and registered before the normal OF bus populate mechanism kicks in, 
> thus ensuring that the iommu gets probed before other devices. In practice 
> this is pretty similar to using different init levels, which is what Will's 
> patch set was trying to avoid in the first place. Creating a new kind of init 
> levels mechanism doesn't sound very good to me.
> 
> The existing exynos-iommu driver is based on classic instantiation of a 
> platform device from DT, using the normal device probing mechanism. As such it 
> relies on the availability of a struct device for various helper functions. I 
> thus understand why you want a struct device being registered for the iommu, 
> instead of initializing the device right from the exynos_iommu_of_setup() 
> function without a corresponding struct device being registered.
> 
> This leads me to question whether we should really introduce IOMMU_OF_DECLARE. 
> Using regular deferred probing seems more and more like a better solution to 
> me.

We seem to be going round and round on this argument. I said before that
I'm not against changing this [1], but somebody would need to propose
patches, which hasn't happened in recent history.

Arnd also makes some good arguments against using probing [2], which would
need further discussion.

Basically, it looks like there are two sides to this argument and I don't
see anything changing without patch proposals. The only thing that the
current discussions seem to be achieving is blocking people like Marek,
who are trying to make use of what we have in mainline today!

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310783.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310992.html
