From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from
 dt-specific callback instead of initcall
Date: Wed, 17 Dec 2014 15:53:25 +0100
Message-ID: <1418828005.3347.7.camel@pengutronix.de>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	 <1921117.BkWucCVOZq@wuerfel> <1652354.DLhQnkm7xS@avalon>
	 <3015182.XtvMmOW5GD@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <3015182.XtvMmOW5GD@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Cho KyongHo <pullip.cho@samsung.com>, linaro-mm-sig@lists.linaro.org, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, David Wodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Am Mittwoch, den 17.12.2014, 15:27 +0100 schrieb Arnd Bergmann:
> On Wednesday 17 December 2014 01:24:42 Laurent Pinchart wrote:
> > 
> > If we forbid the IOMMU driver from being compiled as a module can't we just 
> > rely on deferred probing ? The bus master driver will just be reprobed after 
> > the IOMMU gets probed, like for other devices.
> > 
> > This could fail in case the IOMMU device permanently fails to probe. There 
> > would be something very wrong in the system in that case, Enabling the bus 
> > masters totally transparently without IOMMU support could not be such a good 
> > idea.
> 
> I believe in the majority of cases today, the IOMMU is entirely optional.
> There are valid reasons for not including the IOMMU driver in the kernel,
> e.g. when you know that all the machines with that driver can DMA to
> all of their RAM and you want to avoid the overhead of IOTLB misses.
> 
This is similar to the problems we discussed with the componentized
device framework and in the end everybody agreed on a simple rule:
if the device node is enabled in the DT there must be a driver bound to
it before other devices depending on this node can be probed.

If we apply the same logic to the IOMMU situation we get two
possibilities to allow bypassing the IOMMU:
1. completely disable the IOMMU node in the DT
2. leave node enabled in DT, but add a bypass property

Obviously the second option still requires to have the IOMMU driver
available, but is more flexible. Right now everything depends on the
IOMMU being in passthrough mode at reset with no driver bound. If a
device comes around where this isn't the case thing will break with the
current assumptions or the first option.

Having the IOMMU node enabled in DT with no driver available to the
kernel seems like an invalid configuration which should be expected to
break. Exactly the same thing as with componentized devices...

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
