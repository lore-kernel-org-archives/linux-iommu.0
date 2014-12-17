From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from dt-specific callback instead of initcall
Date: Wed, 17 Dec 2014 18:02:51 +0200
Message-ID: <3147207.bM49L5sBIQ@avalon>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com> <1652261.Tf8nxQyMRf@avalon> <2560037.PCKFDiopkL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2560037.PCKFDiopkL@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-mm-sig@lists.linaro.org, Rob Herring <robh@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Wednesday 17 December 2014 16:41:33 Arnd Bergmann wrote:
> On Wednesday 17 December 2014 16:39:02 Laurent Pinchart wrote:
> > On Wednesday 17 December 2014 15:27:36 Arnd Bergmann wrote:
> > > On Wednesday 17 December 2014 01:24:42 Laurent Pinchart wrote:
> > > > If we forbid the IOMMU driver from being compiled as a module can't we
> > > > just rely on deferred probing ? The bus master driver will just be
> > > > reprobed after the IOMMU gets probed, like for other devices.
> > > > 
> > > > This could fail in case the IOMMU device permanently fails to probe.
> > > > There
> > > > would be something very wrong in the system in that case, Enabling the
> > > > bus
> > > > masters totally transparently without IOMMU support could not be such
> > > > a
> > > > good idea.
> > > 
> > > I believe in the majority of cases today, the IOMMU is entirely
> > > optional.
> > > There are valid reasons for not including the IOMMU driver in the
> > > kernel,
> > > e.g. when you know that all the machines with that driver can DMA to
> > > all of their RAM and you want to avoid the overhead of IOTLB misses.
> > 
> > Should that really be controlled by compiling the IOMMU driver out,
> > wouldn't it be better to disable the IOMMU devices in DT in that case ?
> 
> It's a policy decision that should only depend on the user. Modifying the
> DT is wrong here IMHO because the device is still connected to the IOMMU
> in hardware and we should correctly represent that.

I was thinking about setting status = "disabled" on the IOMMU nodes, not 
removing the IOMMU references in the bus master nodes.

> You can normally set 'iommu=off' or 'iommu=force' on the command line
> to force it on or off rather than letting the IOMMU driver decide whether
> the device turns it on. Not enabling the IOMMU at all should really just
> behave the same way as 'iommu=off', anything else would be very confusing.

Setting iommu=off sounds fine to me. The IOMMU core would then return a "no 
IOMMU present" error instead of -EPROBE_DEFER, and probing of the bus masters 
would continue without IOMMU support.

-- 
Regards,

Laurent Pinchart
