From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Thu, 10 Jan 2013 10:06:24 -0800
Message-ID: <026e01cdef5d$364fd150$a2ef73f0$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
 <20130110171844.GA2650@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20130110171844.GA2650@8bytes.org>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Joerg Roedel' <joro@8bytes.org>
Cc: 'Cho KyongHo' <pullip.cho@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>
List-Id: iommu@lists.linux-foundation.org

'Joerg Roedel' wrote:
> 
> On Mon, Dec 31, 2012 at 10:18:46AM -0800, Kukjin Kim wrote:
> > Cho KyongHo wrote:
> 
> > > Diffstats:
> > >  arch/arm/boot/dts/exynos5250-smdk5250.dts  |    2 +-
> > >  arch/arm/boot/dts/exynos5250.dtsi          |   27 +-
> > >  arch/arm/mach-exynos/Kconfig               |    5 -
> > >  arch/arm/mach-exynos/Makefile              |    1 -
> > >  arch/arm/mach-exynos/clock-exynos4.c       |   41 +-
> > >  arch/arm/mach-exynos/clock-exynos4210.c    |    9 +-
> > >  arch/arm/mach-exynos/clock-exynos4212.c    |   23 +-
> > >  arch/arm/mach-exynos/clock-exynos5.c       |   87 +-
> > >  arch/arm/mach-exynos/dev-sysmmu.c          |  274 ------
> > >  arch/arm/mach-exynos/include/mach/sysmmu.h |   66 --
> > >  arch/arm/mach-exynos/mach-exynos4-dt.c     |   34 +
> > >  arch/arm/mach-exynos/mach-exynos5-dt.c     |   30 +
> > >  drivers/iommu/Kconfig                      |    2 +-
> > >  drivers/iommu/Makefile                     |    2 +-
> > >  drivers/iommu/exynos-iommu.c               | 1477
> +++++++++++++++++++++--
> > > -----
> > >  15 files changed, 1284 insertions(+), 796 deletions(-)
> >
> > Joerg, it's time to merge this. If you don't mind, let me pick up this
whole
> > series into Samsung tree because this touches many Samsung stuff.
> 
> Well, looking at the diffstat the IOMMU changes are a lot larger than
> the exynos ones. So I think this should go through the IOMMU tree once
> the latest review comments are fixed.
> 
If so, too many ugly merge conflicts will be happened when Linus merges for
v3.9 because the legacy(current) exynos clock stuff is going away in Samsung
tree and as I said, this touches Samsung stuff widely. Of course, Stephen
should complain the conflicts between your tree and mine once you apply this
whole series in your -next before Linus' merge for v3.9. I believe, you
don't want it.

You know, we have several options to avoid it. When you take this series in
your tree, you can provide topic branch for me. Or this series should be
separated for arch/arm/ and drivers/ for both trees, then only drivers/iommu
changes should be picked up in your tree. I'm OK both, let me know which one
you would prefer or other way.

BTW, KyongHo, you need to update the clock changes for exynos-iommu against
on exynos common clock stuff. 

Thanks.

- Kukjin 
