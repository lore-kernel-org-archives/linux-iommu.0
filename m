From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback instead of initcall
Date: Tue, 16 Dec 2014 12:40:28 +0100
Message-ID: <1681211.YVY9bd22gV@wuerfel>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com> <4894156.QdIh4JzSl0@avalon> <20141215181323.GX20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141215181323.GX20738@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, David Wodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tomasz.figa@gmail.com>, Cho KyongHo <pullip.cho@samsung.com>, Inki Dae <inki.dae@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Monday 15 December 2014 18:13:23 Will Deacon wrote:
> > > > IOMMUs are not as low-level as system interrupt controllers or system
> > > > clocks. I'm beginning to agree with Thierry that they should be treated
> > > > as normal platform devices as they're not required earlier than probe
> > > > time of their bus master devices.
> > > 
> > > Well, I think you'd have to propose patches for discussion since I'm
> > > certainly not wed to the current approach; I just want something that
> > > allows of_{dma,iommu}_configure to run with the information it needs.
> > 
> > Do we need of_dma_configure() to run when the device is created, or could we 
> > postpone it to just before probe time ?
> 
> I'm not sure I can answer that one... Arnd?

I believe we could postpone it to probe time, but I'd rather not.
The way I see the arguments in favor, we have mainly cosmetic arguments:

- Doing it at probe time would eliminate the ugly section magic hack
- iommu drivers could be implemented as loadable modules with platform
  drivers, for consistency with most other drivers

On the other hand, I see:

- DMA configuration is traditionally done at device creation time, and
  changing that is more likely to introduce bugs than leaving it
  where it is.
- On a lot of machines, the IOMMU is optional, and the probe function
  cannot know the difference between an IOMMU driver that is left out
  of the kernel and one that will be initialized later, using a fixed
  entry point for initializing the IOMMU makes the behavior consistent

There is a third option in theory, which is to only enable the IOMMU
as part of dma_set_mask(). I've done that in the past on powerpc, but
the new approach seems cleaner.

	Arnd
