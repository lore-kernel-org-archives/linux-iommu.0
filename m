From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Thu, 10 Jan 2013 10:34:48 -0800
Message-ID: <027601cdef61$2df576a0$89e063e0$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
	<032401cde783$485ae1a0$d910a4e0$@samsung.com>
	<20130110171844.GA2650@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: 
Content-language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Cho KyongHo' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Kukjin Kim wrote:
> 
> 'Joerg Roedel' wrote:
> >
> > On Mon, Dec 31, 2012 at 10:18:46AM -0800, Kukjin Kim wrote:
> > > Cho KyongHo wrote:
> >
> > > > Diffstats:
> > > >  arch/arm/boot/dts/exynos5250-smdk5250.dts  |    2 +-
> > > >  arch/arm/boot/dts/exynos5250.dtsi          |   27 +-
> > > >  arch/arm/mach-exynos/Kconfig               |    5 -
> > > >  arch/arm/mach-exynos/Makefile              |    1 -
> > > >  arch/arm/mach-exynos/clock-exynos4.c       |   41 +-
> > > >  arch/arm/mach-exynos/clock-exynos4210.c    |    9 +-
> > > >  arch/arm/mach-exynos/clock-exynos4212.c    |   23 +-
> > > >  arch/arm/mach-exynos/clock-exynos5.c       |   87 +-
> > > >  arch/arm/mach-exynos/dev-sysmmu.c          |  274 ------
> > > >  arch/arm/mach-exynos/include/mach/sysmmu.h |   66 --
> > > >  arch/arm/mach-exynos/mach-exynos4-dt.c     |   34 +
> > > >  arch/arm/mach-exynos/mach-exynos5-dt.c     |   30 +
> > > >  drivers/iommu/Kconfig                      |    2 +-
> > > >  drivers/iommu/Makefile                     |    2 +-
> > > >  drivers/iommu/exynos-iommu.c               | 1477
> > +++++++++++++++++++++--
> > > > -----
> > > >  15 files changed, 1284 insertions(+), 796 deletions(-)
> > >
> > > Joerg, it's time to merge this. If you don't mind, let me pick up this
whole
> > > series into Samsung tree because this touches many Samsung stuff.
> >
> > Well, looking at the diffstat the IOMMU changes are a lot larger than
> > the exynos ones. So I think this should go through the IOMMU tree once
> > the latest review comments are fixed.
> >
> If so, too many ugly merge conflicts will be happened when Linus merges
for
> v3.9 because the legacy(current) exynos clock stuff is going away in
Samsung
> tree and as I said, this touches Samsung stuff widely. Of course, Stephen
> should complain the conflicts between your tree and mine once you apply
> this whole series in your -next before Linus' merge for v3.9. I believe,
you
> don't want it.
> 
> You know, we have several options to avoid it. When you take this series
in
> your tree, you can provide topic branch for me. Or this series should be
> separated for arch/arm/ and drivers/ for both trees, then only
> drivers/iommu changes should be picked up in your tree. I'm OK both, let
me
> know which one you would prefer or other way.
> 
Hmm, I think, just one [7/12] patch does matter so if you could create topic
branch and apply [7/12] patch firstly before other drivers/ changes would be
better to me. It's OK on both trees if I just _merge_ the first [7/12]
commit in the topic branch you provided for exynos-iommu. But you know, you
don't have to rebase it once I merge it in Samsung tree.

How about?

> BTW, KyongHo, you need to update the clock changes for exynos-iommu
> against on exynos common clock stuff.
> 
KyoungHo, your changes don't matter on exynos common clock stuff and I can
take care in my tree. So no need more work for it in your side. If any
updates, let you know.

Thanks.

- Kukjin
