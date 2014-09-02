From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
 masters
Date: Tue, 02 Sep 2014 14:46:22 +0200
Message-ID: <4561708.C5IqxBT0S9@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <3261702.HRSZJsEv5z@wuerfel> <5405B86C.9010704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5405B86C.9010704@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "jroedel@suse.de" <jroedel@suse.de>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, "hdoyu@nvidia.com" <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 September 2014 14:30:36 Marek Szyprowski wrote:
> >>>> However we also need to figure out how to let drivers to make their own
> >>>> configuration, like it is required by Exynos DRM subsystem, which consist
> >>>> of several devices, each having its own IOMMU controller, but for
> >>>> convenience those drivers assume that they all have been bound to the same,
> >>>> single domain.
> >>> IIRC with the way we ended up putting the mask into the iommu descriptor of
> >>> the ARM SMMU, you can put multiple devices into the same iommu group, and
> >>> have them automatically share a domain.
> >>>
> >>> I don't know if the same would work for the Samsung implementation.
> >> The question is how to transfer such information from the device
> >> drivers, that
> >> need/benefit from such configuration to iommu driver, which does all the
> >> setup?
> >> This is something completely internal to particular drivers and should
> >> not be
> >> exported to device tree or userspace. Thierry suggested to hardcode this
> >> information in the iommu driver, but I'm looking for other approaches.
> >> Maybe simply releasing device from the default dma-mapping domain before
> >> attaching to custom one will be the easiest solution.
> > For the ARM SMMU, the problem is that there is not necessarily a good way
> > to partition the masters into IOMMU groups automatically, therefore we
> > want to provide some hints in DT. On a machine that can have more domains
> > than it has masters, this is not a problem and we can always use an
> > all-ones mask, but for a machine on which this is not the case, the
> > problem is simplified a lot of we hardcode the masks in a way that can
> > always work, putting multiple devices into an iommu group if necessary.
> 
> Well, I was talking about the Exynos IOMMU case, where there are no hw
> restrictions and grouping is done just to make things easier for the Exynos
> DRM drivers (a buffer gets the same DMA address for all devices, which
> are a part of virtual Exynos DRM device).

Does that mean you don't actually need to use multiple contexts here and
could actually just use the normal dma-mapping interface if there is
a way to ensure the mappings are always shared across these masters?

Or do you need this in addition to being able to use multiple masters
so you can have multiple rendering contexts in user space?

	Arnd
