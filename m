From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 17/18] iommu: exynos: init from dt-specific callback instead of initcall
Date: Tue, 20 Jan 2015 15:41:08 +0200
Message-ID: <1998769.ho0KpoUOzK@avalon>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com> <10691050.Z5RGmE4fp0@avalon> <20150119113331.GG32131@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150119113331.GG32131@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 19 January 2015 11:33:31 Will Deacon wrote:
> On Mon, Jan 19, 2015 at 01:11:07AM +0000, Laurent Pinchart wrote:
> > On Friday 16 January 2015 10:13:11 Marek Szyprowski wrote:
> >> This patch introduces IOMMU_OF_DECLARE-based initialization to the
> >> driver, which replaces subsys_initcall-based procedure.
> >> exynos_iommu_of_setup ensures that each sysmmu controller is probed
> >> before its master device.
> 
> [...]
> 
> >> +static int __init exynos_iommu_of_setup(struct device_node *np)
> >> +{
> >> +	struct platform_device *pdev;
> >> +
> >> +	if (!init_done)
> >> +		exynos_iommu_init();
> >> +
> >> +	pdev = of_platform_device_create(np, NULL,
> >> platform_bus_type.dev_root);
> >> +	if (IS_ERR(pdev))
> >> +		return PTR_ERR(pdev);
> > 
> > This feels like a hack to me. What happens here is that you're using the
> > IOMMU_OF_DECLARE mechanism to make sure that the iommu platform device
> > will be created and registered before the normal OF bus populate
> > mechanism kicks in, thus ensuring that the iommu gets probed before other
> > devices. In practice this is pretty similar to using different init
> > levels, which is what Will's patch set was trying to avoid in the first
> > place. Creating a new kind of init levels mechanism doesn't sound very
> > good to me.
> > 
> > The existing exynos-iommu driver is based on classic instantiation of a
> > platform device from DT, using the normal device probing mechanism. As
> > such it relies on the availability of a struct device for various helper
> > functions. I thus understand why you want a struct device being
> > registered for the iommu, instead of initializing the device right from
> > the exynos_iommu_of_setup() function without a corresponding struct
> > device being registered.
> > 
> > This leads me to question whether we should really introduce
> > IOMMU_OF_DECLARE. Using regular deferred probing seems more and more like
> > a better solution to me.
> 
> We seem to be going round and round on this argument. I said before that
> I'm not against changing this [1], but somebody would need to propose
> patches, which hasn't happened in recent history.
> 
> Arnd also makes some good arguments against using probing [2], which would
> need further discussion.
> 
> Basically, it looks like there are two sides to this argument and I don't
> see anything changing without patch proposals. The only thing that the
> current discussions seem to be achieving is blocking people like Marek,
> who are trying to make use of what we have in mainline today!

To be perfectly clear, I won't block patches here without submitting a 
counterproposal (unless there's something fundamentally wrong of course). I 
still believe the deferred probe approach should be given at least a try, but 
as I don't have time to implement that myself now, I won't try to block 
anything.

> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310783.
> html
> [2]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310992.
> html

-- 
Regards,

Laurent Pinchart
