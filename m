From: 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Thu, 10 Jan 2013 18:19:05 +0100
Message-ID: <20130110171844.GA2650@8bytes.org>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
	<032401cde783$485ae1a0$d910a4e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <032401cde783$485ae1a0$d910a4e0$@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Cho KyongHo' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2012 at 10:18:46AM -0800, Kukjin Kim wrote:
> Cho KyongHo wrote:

> > Diffstats:
> >  arch/arm/boot/dts/exynos5250-smdk5250.dts  |    2 +-
> >  arch/arm/boot/dts/exynos5250.dtsi          |   27 +-
> >  arch/arm/mach-exynos/Kconfig               |    5 -
> >  arch/arm/mach-exynos/Makefile              |    1 -
> >  arch/arm/mach-exynos/clock-exynos4.c       |   41 +-
> >  arch/arm/mach-exynos/clock-exynos4210.c    |    9 +-
> >  arch/arm/mach-exynos/clock-exynos4212.c    |   23 +-
> >  arch/arm/mach-exynos/clock-exynos5.c       |   87 +-
> >  arch/arm/mach-exynos/dev-sysmmu.c          |  274 ------
> >  arch/arm/mach-exynos/include/mach/sysmmu.h |   66 --
> >  arch/arm/mach-exynos/mach-exynos4-dt.c     |   34 +
> >  arch/arm/mach-exynos/mach-exynos5-dt.c     |   30 +
> >  drivers/iommu/Kconfig                      |    2 +-
> >  drivers/iommu/Makefile                     |    2 +-
> >  drivers/iommu/exynos-iommu.c               | 1477 +++++++++++++++++++++--
> > -----
> >  15 files changed, 1284 insertions(+), 796 deletions(-)
> 
> Joerg, it's time to merge this. If you don't mind, let me pick up this whole
> series into Samsung tree because this touches many Samsung stuff.

Well, looking at the diffstat the IOMMU changes are a lot larger than
the exynos ones. So I think this should go through the IOMMU tree once
the latest review comments are fixed.

> Happy new year, thanks.

Happy new year too,

      Joerg
