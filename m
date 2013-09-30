From: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 07/12] ARM: EXYNOS: remove system mmu initialization
	from exynos tree
Date: Sun, 29 Sep 2013 20:38:38 -0400
Message-ID: <CAOw6vbKSQ2xTj7__D5F40vRLxU5Yt1NH4zEp4WcRtB1rVK5gQQ@mail.gmail.com>
References: <003a01cde30b$e13c1910$a3b44b30$%cho@samsung.com>
	<CAOw6vbJfi7UhwxgFKmMzO91fnywWZNTRVDLLSWQOkbbU=C5ndA@mail.gmail.com>
	<20130930093500.ffa527f8f5f004e02a9cb187@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8591252151621991135=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130930093500.ffa527f8f5f004e02a9cb187-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============8591252151621991135==
Content-Type: multipart/alternative; boundary=047d7bd756e2d6ba8604e78f0f07

--047d7bd756e2d6ba8604e78f0f07
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Sep 29, 2013 at 8:35 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> On Fri, 27 Sep 2013 14:55:51 -0400, Sean Paul wrote:
> > On Tue, Dec 25, 2012 at 8:54 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> wrote:
> > > This removes System MMU initialization from arch/arm/mach-exynos/
> > > to move them to DT and the exynos-iommu driver except gating clock
> > > definitions.
> > >
> >
> >
> > exynos with iommu support no longer compiles with this patch:
> >
> >   CC      drivers/iommu/exynos-iommu.o
> >
> /mnt/host/source/src/third_party/kernel-next/drivers/iommu/exynos-iommu.c:32:25:
> > fatal error: mach/sysmmu.h: No such file or directory
> > compilation terminated.
> > make[3]: *** [drivers/iommu/exynos-iommu.o] Error 1
> >
>
> It is my fault.
> I think you need to apply all v6 patches to compile correctly.
>
> Since v8 patches, I checked that every patch is compiled successfully.
>
>
I'm sorry I don't think I explained properly.

This patch has been merged to mainline without the rest of the series. As
such, mainline with exynos iommu does not currently compile.

Sean




>   iommu/exynos: do not include removed header
> patch from v7 patch removes including 'mach/sysmmu.h'.
>
> Thank you.
>
>
> > Sean
> >
> >
> > > Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >  arch/arm/mach-exynos/Kconfig               |   5 -
> > >  arch/arm/mach-exynos/Makefile              |   1 -
> > >  arch/arm/mach-exynos/clock-exynos4.c       |  41 +++--
> > >  arch/arm/mach-exynos/clock-exynos4210.c    |   9 +-
> > >  arch/arm/mach-exynos/clock-exynos4212.c    |  23 ++-
> > >  arch/arm/mach-exynos/clock-exynos5.c       |  62 ++++---
> > >  arch/arm/mach-exynos/dev-sysmmu.c          | 274
> -----------------------------
> > >  arch/arm/mach-exynos/include/mach/sysmmu.h |  66 -------
> > >  arch/arm/mach-exynos/mach-exynos4-dt.c     |  34 ++++
> > >  arch/arm/mach-exynos/mach-exynos5-dt.c     |  30 ++++
> > >  10 files changed, 137 insertions(+), 408 deletions(-)
> > >  delete mode 100644 arch/arm/mach-exynos/dev-sysmmu.c
> > >  delete mode 100644 arch/arm/mach-exynos/include/mach/sysmmu.h
> > >
> > > diff --git a/arch/arm/mach-exynos/Kconfig
> b/arch/arm/mach-exynos/Kconfig
> > > index 91d5b6f..eba6eb5 100644
> > > --- a/arch/arm/mach-exynos/Kconfig
> > > +++ b/arch/arm/mach-exynos/Kconfig
> > > @@ -103,11 +103,6 @@ config EXYNOS4_SETUP_FIMD0
> > >         help
> > >           Common setup code for FIMD0.
> > >
> > > -config EXYNOS_DEV_SYSMMU
> > > -       bool
> > > -       help
> > > -         Common setup code for SYSTEM MMU in EXYNOS platforms
> > > -
> > >  config EXYNOS4_DEV_USB_OHCI
> > >         bool
> > >         help
> > > diff --git a/arch/arm/mach-exynos/Makefile
> b/arch/arm/mach-exynos/Makefile
> > > index b189881..435757e 100644
> > > --- a/arch/arm/mach-exynos/Makefile
> > > +++ b/arch/arm/mach-exynos/Makefile
> > > @@ -52,7 +52,6 @@ obj-$(CONFIG_ARCH_EXYNOS4)            += dev-audio.o
> > >  obj-$(CONFIG_EXYNOS4_DEV_AHCI)         += dev-ahci.o
> > >  obj-$(CONFIG_EXYNOS_DEV_DMA)           += dma.o
> > >  obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)     += dev-ohci.o
> > > -obj-$(CONFIG_EXYNOS_DEV_SYSMMU)                += dev-sysmmu.o
> > >
> > >  obj-$(CONFIG_ARCH_EXYNOS)              += setup-i2c0.o
> > >  obj-$(CONFIG_EXYNOS4_SETUP_FIMC)       += setup-fimc.o
> > > diff --git a/arch/arm/mach-exynos/clock-exynos4.c
> b/arch/arm/mach-exynos/clock-exynos4.c
> > > index bbcb3de..8a8468d 100644
> > > --- a/arch/arm/mach-exynos/clock-exynos4.c
> > > +++ b/arch/arm/mach-exynos/clock-exynos4.c
> > > @@ -24,7 +24,6 @@
> > >
> > >  #include <mach/map.h>
> > >  #include <mach/regs-clock.h>
> > > -#include <mach/sysmmu.h>
> > >
> > >  #include "common.h"
> > >  #include "clock-exynos4.h"
> > > @@ -709,53 +708,53 @@ static struct clk exynos4_init_clocks_off[] = {
> > >                 .enable         = exynos4_clk_ip_peril_ctrl,
> > >                 .ctrlbit        = (1 << 14),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(mfc_l, 0),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.0",
> > >                 .enable         = exynos4_clk_ip_mfc_ctrl,
> > >                 .ctrlbit        = (1 << 1),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(mfc_r, 1),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.1",
> > >                 .enable         = exynos4_clk_ip_mfc_ctrl,
> > >                 .ctrlbit        = (1 << 2),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(tv, 2),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.2",
> > >                 .enable         = exynos4_clk_ip_tv_ctrl,
> > >                 .ctrlbit        = (1 << 4),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(jpeg, 3),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.3",
> > >                 .enable         = exynos4_clk_ip_cam_ctrl,
> > >                 .ctrlbit        = (1 << 11),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(rot, 4),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.4",
> > >                 .enable         = exynos4_clk_ip_image_ctrl,
> > >                 .ctrlbit        = (1 << 4),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(fimc0, 5),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.5",
> > >                 .enable         = exynos4_clk_ip_cam_ctrl,
> > >                 .ctrlbit        = (1 << 7),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(fimc1, 6),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.6",
> > >                 .enable         = exynos4_clk_ip_cam_ctrl,
> > >                 .ctrlbit        = (1 << 8),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(fimc2, 7),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.7",
> > >                 .enable         = exynos4_clk_ip_cam_ctrl,
> > >                 .ctrlbit        = (1 << 9),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(fimc3, 8),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.8",
> > >                 .enable         = exynos4_clk_ip_cam_ctrl,
> > >                 .ctrlbit        = (1 << 10),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(fimd0, 10),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.10",
> > >                 .enable         = exynos4_clk_ip_lcd0_ctrl,
> > >                 .ctrlbit        = (1 << 4),
> > >         }
> > > diff --git a/arch/arm/mach-exynos/clock-exynos4210.c
> b/arch/arm/mach-exynos/clock-exynos4210.c
> > > index fed4c26..19af9f7 100644
> > > --- a/arch/arm/mach-exynos/clock-exynos4210.c
> > > +++ b/arch/arm/mach-exynos/clock-exynos4210.c
> > > @@ -26,7 +26,6 @@
> > >  #include <mach/hardware.h>
> > >  #include <mach/map.h>
> > >  #include <mach/regs-clock.h>
> > > -#include <mach/sysmmu.h>
> > >
> > >  #include "common.h"
> > >  #include "clock-exynos4.h"
> > > @@ -129,13 +128,13 @@ static struct clk init_clocks_off[] = {
> > >                 .enable         = exynos4_clk_ip_lcd1_ctrl,
> > >                 .ctrlbit        = (1 << 0),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(2d, 14),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.9",
> > >                 .enable         = exynos4_clk_ip_image_ctrl,
> > >                 .ctrlbit        = (1 << 3),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(fimd1, 11),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.11",
> > >                 .enable         = exynos4_clk_ip_lcd1_ctrl,
> > >                 .ctrlbit        = (1 << 4),
> > >         }, {
> > > diff --git a/arch/arm/mach-exynos/clock-exynos4212.c
> b/arch/arm/mach-exynos/clock-exynos4212.c
> > > index 8fba0b5..529476f 100644
> > > --- a/arch/arm/mach-exynos/clock-exynos4212.c
> > > +++ b/arch/arm/mach-exynos/clock-exynos4212.c
> > > @@ -26,7 +26,6 @@
> > >  #include <mach/hardware.h>
> > >  #include <mach/map.h>
> > >  #include <mach/regs-clock.h>
> > > -#include <mach/sysmmu.h>
> > >
> > >  #include "common.h"
> > >  #include "clock-exynos4.h"
> > > @@ -111,21 +110,31 @@ static struct clksrc_clk clksrcs[] = {
> > >
> > >  static struct clk init_clocks_off[] = {
> > >         {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(2d, 14),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.9",
> > >                 .enable         = exynos4_clk_ip_dmc_ctrl,
> > >                 .ctrlbit        = (1 << 24),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(isp, 9),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.12",
> > >                 .enable         = exynos4212_clk_ip_isp0_ctrl,
> > >                 .ctrlbit        = (7 << 8),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME2,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(isp, 9),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.13",
> > >                 .enable         = exynos4212_clk_ip_isp1_ctrl,
> > >                 .ctrlbit        = (1 << 4),
> > >         }, {
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.14",
> > > +               .enable         = exynos4212_clk_ip_isp0_ctrl,
> > > +               .ctrlbit        = (1 << 11),
> > > +       }, {
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.15",
> > > +               .enable         = exynos4212_clk_ip_isp0_ctrl,
> > > +               .ctrlbit        = (1 << 12),
> > > +       }, {
> > >                 .name           = "flite",
> > >                 .devname        = "exynos-fimc-lite.0",
> > >                 .enable         = exynos4212_clk_ip_isp0_ctrl,
> > > diff --git a/arch/arm/mach-exynos/clock-exynos5.c
> b/arch/arm/mach-exynos/clock-exynos5.c
> > > index 0208c3a..bee2d53 100644
> > > --- a/arch/arm/mach-exynos/clock-exynos5.c
> > > +++ b/arch/arm/mach-exynos/clock-exynos5.c
> > > @@ -24,7 +24,6 @@
> > >
> > >  #include <mach/map.h>
> > >  #include <mach/regs-clock.h>
> > > -#include <mach/sysmmu.h>
> > >
> > >  #include "common.h"
> > >
> > > @@ -869,86 +868,91 @@ static struct clk exynos5_init_clocks_off[] = {
> > >                 .enable         = exynos5_clk_ip_gscl_ctrl,
> > >                 .ctrlbit        = (1 << 3),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(mfc_l, 0),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.1",
> > >                 .enable         = &exynos5_clk_ip_mfc_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 1),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(mfc_r, 1),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.0",
> > >                 .enable         = &exynos5_clk_ip_mfc_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 2),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(tv, 2),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.2",
> > >                 .enable         = &exynos5_clk_ip_disp1_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 9)
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(jpeg, 3),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.3",
> > >                 .enable         = &exynos5_clk_ip_gen_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 7),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(rot, 4),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.4",
> > >                 .enable         = &exynos5_clk_ip_gen_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 6)
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(gsc0, 5),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.5",
> > >                 .enable         = &exynos5_clk_ip_gscl_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 7),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(gsc1, 6),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.6",
> > >                 .enable         = &exynos5_clk_ip_gscl_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 8),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(gsc2, 7),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.7",
> > >                 .enable         = &exynos5_clk_ip_gscl_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 9),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(gsc3, 8),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.8",
> > >                 .enable         = &exynos5_clk_ip_gscl_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 10),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(isp, 9),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.9",
> > >                 .enable         = &exynos5_clk_ip_isp0_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (0x3F << 8),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME2,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(isp, 9),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.10",
> > >                 .enable         = &exynos5_clk_ip_isp1_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (0xF << 4),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(camif0, 12),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.11",
> > > +               .enable         = &exynos5_clk_ip_disp1_ctrl,
> > > +               .ctrlbit        = (1 << 8)
> > > +       }, {
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.12",
> > >                 .enable         = &exynos5_clk_ip_gscl_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 11),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(camif1, 13),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.13",
> > >                 .enable         = &exynos5_clk_ip_gscl_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 12),
> > >         }, {
> > > -               .name           = SYSMMU_CLOCK_NAME,
> > > -               .devname        = SYSMMU_CLOCK_DEVNAME(2d, 14),
> > > +               .name           = "sysmmu",
> > > +               .devname        = "exynos-sysmmu.14",
> > >                 .enable         = &exynos5_clk_ip_acp_ctrl,
> > >                 .ops            = &exynos5_gate_clk_ops,
> > >                 .ctrlbit        = (1 << 7)
> > > diff --git a/arch/arm/mach-exynos/dev-sysmmu.c
> b/arch/arm/mach-exynos/dev-sysmmu.c
> > > deleted file mode 100644
> > > index c5b1ea3..0000000
> > > --- a/arch/arm/mach-exynos/dev-sysmmu.c
> > > +++ /dev/null
> > > @@ -1,274 +0,0 @@
> > > -/* linux/arch/arm/mach-exynos/dev-sysmmu.c
> > > - *
> > > - * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> > > - *             http://www.samsung.com
> > > - *
> > > - * EXYNOS - System MMU support
> > > - *
> > > - * This program is free software; you can redistribute it and/or
> modify
> > > - * it under the terms of the GNU General Public License version 2 as
> > > - * published by the Free Software Foundation.
> > > - */
> > > -
> > > -#include <linux/platform_device.h>
> > > -#include <linux/dma-mapping.h>
> > > -
> > > -#include <plat/cpu.h>
> > > -
> > > -#include <mach/map.h>
> > > -#include <mach/irqs.h>
> > > -#include <mach/sysmmu.h>
> > > -
> > > -static u64 exynos_sysmmu_dma_mask = DMA_BIT_MASK(32);
> > > -
> > > -#define SYSMMU_PLATFORM_DEVICE(ipname, devid)
>  \
> > > -static struct sysmmu_platform_data platdata_##ipname = {
>   \
> > > -       .dbgname = #ipname,
>   \
> > > -};
>   \
> > > -struct platform_device SYSMMU_PLATDEV(ipname) =
>          \
> > > -{
>  \
> > > -       .name           = SYSMMU_DEVNAME_BASE,
>  \
> > > -       .id             = devid,
>  \
> > > -       .dev            = {
>   \
> > > -               .dma_mask               = &exynos_sysmmu_dma_mask,
>  \
> > > -               .coherent_dma_mask      = DMA_BIT_MASK(32),
>   \
> > > -               .platform_data          = &platdata_##ipname,
>   \
> > > -       },
>  \
> > > -}
> > > -
> > > -SYSMMU_PLATFORM_DEVICE(mfc_l,  0);
> > > -SYSMMU_PLATFORM_DEVICE(mfc_r,  1);
> > > -SYSMMU_PLATFORM_DEVICE(tv,     2);
> > > -SYSMMU_PLATFORM_DEVICE(jpeg,   3);
> > > -SYSMMU_PLATFORM_DEVICE(rot,    4);
> > > -SYSMMU_PLATFORM_DEVICE(fimc0,  5); /* fimc* and gsc* exist
> exclusively */
> > > -SYSMMU_PLATFORM_DEVICE(fimc1,  6);
> > > -SYSMMU_PLATFORM_DEVICE(fimc2,  7);
> > > -SYSMMU_PLATFORM_DEVICE(fimc3,  8);
> > > -SYSMMU_PLATFORM_DEVICE(gsc0,   5);
> > > -SYSMMU_PLATFORM_DEVICE(gsc1,   6);
> > > -SYSMMU_PLATFORM_DEVICE(gsc2,   7);
> > > -SYSMMU_PLATFORM_DEVICE(gsc3,   8);
> > > -SYSMMU_PLATFORM_DEVICE(isp,    9);
> > > -SYSMMU_PLATFORM_DEVICE(fimd0,  10);
> > > -SYSMMU_PLATFORM_DEVICE(fimd1,  11);
> > > -SYSMMU_PLATFORM_DEVICE(camif0, 12);
> > > -SYSMMU_PLATFORM_DEVICE(camif1, 13);
> > > -SYSMMU_PLATFORM_DEVICE(2d,     14);
> > > -
> > > -#define SYSMMU_RESOURCE_NAME(core, ipname) sysmmures_##core##_##ipname
> > > -
> > > -#define SYSMMU_RESOURCE(core, ipname)
>  \
> > > -       static struct resource SYSMMU_RESOURCE_NAME(core, ipname)[]
> __initdata =
> > > -
> > > -#define DEFINE_SYSMMU_RESOURCE(core, mem, irq)
>   \
> > > -       DEFINE_RES_MEM_NAMED(core##_PA_SYSMMU_##mem, SZ_4K, #mem),
>  \
> > > -       DEFINE_RES_IRQ_NAMED(core##_IRQ_SYSMMU_##irq##_0, #mem)
> > > -
> > > -#define SYSMMU_RESOURCE_DEFINE(core, ipname, mem, irq)
>   \
> > > -       SYSMMU_RESOURCE(core, ipname) {
>   \
> > > -               DEFINE_SYSMMU_RESOURCE(core, mem, irq)
>  \
> > > -       }
> > > -
> > > -struct sysmmu_resource_map {
> > > -       struct platform_device *pdev;
> > > -       struct resource *res;
> > > -       u32 rnum;
> > > -       struct device *pdd;
> > > -       char *clocknames;
> > > -};
> > > -
> > > -#define SYSMMU_RESOURCE_MAPPING(core, ipname, resname) {
>   \
> > > -       .pdev = &SYSMMU_PLATDEV(ipname),
>  \
> > > -       .res = SYSMMU_RESOURCE_NAME(EXYNOS##core, resname),
>   \
> > > -       .rnum = ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core,
> resname)),\
> > > -       .clocknames = SYSMMU_CLOCK_NAME,
>  \
> > > -}
> > > -
> > > -#define SYSMMU_RESOURCE_MAPPING_MC(core, ipname, resname, pdata) {
>   \
> > > -       .pdev = &SYSMMU_PLATDEV(ipname),
>  \
> > > -       .res = SYSMMU_RESOURCE_NAME(EXYNOS##core, resname),
>   \
> > > -       .rnum = ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core,
> resname)),\
> > > -       .clocknames = SYSMMU_CLOCK_NAME "," SYSMMU_CLOCK_NAME2,
>   \
> > > -}
> > > -
> > > -#ifdef CONFIG_EXYNOS_DEV_PD
> > > -#define SYSMMU_RESOURCE_MAPPING_PD(core, ipname, resname, pd) {
>          \
> > > -       .pdev = &SYSMMU_PLATDEV(ipname),
>  \
> > > -       .res = &SYSMMU_RESOURCE_NAME(EXYNOS##core, resname),
>  \
> > > -       .rnum = ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core,
> resname)),\
> > > -       .clocknames = SYSMMU_CLOCK_NAME,
>  \
> > > -       .pdd = &exynos##core##_device_pd[pd].dev,
>   \
> > > -}
> > > -
> > > -#define SYSMMU_RESOURCE_MAPPING_MCPD(core, ipname, resname, pd,
> pdata) {\
> > > -       .pdev = &SYSMMU_PLATDEV(ipname),
>  \
> > > -       .res = &SYSMMU_RESOURCE_NAME(EXYNOS##core, resname),
>  \
> > > -       .rnum = ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core,
> resname)),\
> > > -       .clocknames = SYSMMU_CLOCK_NAME "," SYSMMU_CLOCK_NAME2,
>   \
> > > -       .pdd = &exynos##core##_device_pd[pd].dev,
>   \
> > > -}
> > > -#else
> > > -#define SYSMMU_RESOURCE_MAPPING_PD(core, ipname, resname, pd)
>  \
> > > -               SYSMMU_RESOURCE_MAPPING(core, ipname, resname)
> > > -#define SYSMMU_RESOURCE_MAPPING_MCPD(core, ipname, resname, pd,
> pdata) \
> > > -               SYSMMU_RESOURCE_MAPPING_MC(core, ipname, resname,
> pdata)
> > > -
> > > -#endif /* CONFIG_EXYNOS_DEV_PD */
> > > -
> > > -#ifdef CONFIG_ARCH_EXYNOS4
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc0, FIMC0,  FIMC0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc1, FIMC1,  FIMC1);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc2, FIMC2,  FIMC2);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc3, FIMC3,  FIMC3);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, jpeg,  JPEG,   JPEG);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, 2d,    G2D,    2D);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, tv,    TV,     TV_M0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, 2d_acp,        2D_ACP, 2D);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, rot,   ROTATOR, ROTATOR);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimd0, FIMD0,  LCD0_M0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimd1, FIMD1,  LCD1_M1);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, flite0,        FIMC_LITE0,
> FIMC_LITE0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, flite1,        FIMC_LITE1,
> FIMC_LITE1);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, mfc_r, MFC_R,  MFC_M0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS4, mfc_l, MFC_L,  MFC_M1);
> > > -SYSMMU_RESOURCE(EXYNOS4, isp) {
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_ISP, FIMC_ISP),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_DRC, FIMC_DRC),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_FD, FIMC_FD),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS4, ISPCPU, FIMC_CX),
> > > -};
> > > -
> > > -static struct sysmmu_resource_map sysmmu_resmap4[] __initdata = {
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, fimc0,    fimc0,  PD_CAM),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, fimc1,    fimc1,  PD_CAM),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, fimc2,    fimc2,  PD_CAM),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, fimc3,    fimc3,  PD_CAM),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, tv,       tv,     PD_TV),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, mfc_r,    mfc_r,  PD_MFC),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, mfc_l,    mfc_l,  PD_MFC),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, rot,      rot,    PD_LCD0),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, jpeg,     jpeg,   PD_CAM),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, fimd0,    fimd0,  PD_LCD0),
> > > -};
> > > -
> > > -static struct sysmmu_resource_map sysmmu_resmap4210[] __initdata = {
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, 2d,       2d,     PD_LCD0),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4, fimd1,    fimd1,  PD_LCD1),
> > > -};
> > > -
> > > -static struct sysmmu_resource_map sysmmu_resmap4212[] __initdata = {
> > > -       SYSMMU_RESOURCE_MAPPING(4,      2d,     2d_acp),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4,   camif0, flite0, PD_ISP),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4,   camif1, flite1, PD_ISP),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(4,   isp,    isp,    PD_ISP),
> > > -};
> > > -#endif /* CONFIG_ARCH_EXYNOS4 */
> > > -
> > > -#ifdef CONFIG_ARCH_EXYNOS5
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, jpeg,  JPEG,   JPEG);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, fimd1, FIMD1,  FIMD1);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, 2d,    2D,     2D);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, rot,   ROTATOR, ROTATOR);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, tv,    TV,     TV);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, flite0,        LITE0,  LITE0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, flite1,        LITE1,  LITE1);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc0,  GSC0,   GSC0);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc1,  GSC1,   GSC1);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc2,  GSC2,   GSC2);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc3,  GSC3,   GSC3);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, mfc_r, MFC_R,  MFC_R);
> > > -SYSMMU_RESOURCE_DEFINE(EXYNOS5, mfc_l, MFC_L,  MFC_L);
> > > -SYSMMU_RESOURCE(EXYNOS5, isp) {
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, ISP, ISP),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, DRC, DRC),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, FD, FD),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, ISPCPU, MCUISP),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, SCALERC, SCALERCISP),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, SCALERP, SCALERPISP),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, ODC, ODC),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, DIS0, DIS0),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, DIS1, DIS1),
> > > -       DEFINE_SYSMMU_RESOURCE(EXYNOS5, 3DNR, 3DNR),
> > > -};
> > > -
> > > -static struct sysmmu_resource_map sysmmu_resmap5[] __initdata = {
> > > -       SYSMMU_RESOURCE_MAPPING(5,      jpeg,   jpeg),
> > > -       SYSMMU_RESOURCE_MAPPING(5,      fimd1,  fimd1),
> > > -       SYSMMU_RESOURCE_MAPPING(5,      2d,     2d),
> > > -       SYSMMU_RESOURCE_MAPPING(5,      rot,    rot),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   tv,     tv,     PD_DISP1),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   camif0, flite0, PD_GSCL),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   camif1, flite1, PD_GSCL),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   gsc0,   gsc0,   PD_GSCL),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   gsc1,   gsc1,   PD_GSCL),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   gsc2,   gsc2,   PD_GSCL),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   gsc3,   gsc3,   PD_GSCL),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   mfc_r,  mfc_r,  PD_MFC),
> > > -       SYSMMU_RESOURCE_MAPPING_PD(5,   mfc_l,  mfc_l,  PD_MFC),
> > > -       SYSMMU_RESOURCE_MAPPING_MCPD(5, isp,    isp,    PD_ISP,
> mc_platdata),
> > > -};
> > > -#endif /* CONFIG_ARCH_EXYNOS5 */
> > > -
> > > -static int __init init_sysmmu_platform_device(void)
> > > -{
> > > -       int i, j;
> > > -       struct sysmmu_resource_map *resmap[2] = {NULL, NULL};
> > > -       int nmap[2] = {0, 0};
> > > -
> > > -#ifdef CONFIG_ARCH_EXYNOS5
> > > -       if (soc_is_exynos5250()) {
> > > -               resmap[0] = sysmmu_resmap5;
> > > -               nmap[0] = ARRAY_SIZE(sysmmu_resmap5);
> > > -               nmap[1] = 0;
> > > -       }
> > > -#endif
> > > -
> > > -#ifdef CONFIG_ARCH_EXYNOS4
> > > -       if (resmap[0] == NULL) {
> > > -               resmap[0] = sysmmu_resmap4;
> > > -               nmap[0] = ARRAY_SIZE(sysmmu_resmap4);
> > > -       }
> > > -
> > > -       if (soc_is_exynos4210()) {
> > > -               resmap[1] = sysmmu_resmap4210;
> > > -               nmap[1] = ARRAY_SIZE(sysmmu_resmap4210);
> > > -       }
> > > -
> > > -       if (soc_is_exynos4412() || soc_is_exynos4212()) {
> > > -               resmap[1] = sysmmu_resmap4212;
> > > -               nmap[1] = ARRAY_SIZE(sysmmu_resmap4212);
> > > -       }
> > > -#endif
> > > -
> > > -       for (j = 0; j < 2; j++) {
> > > -               for (i = 0; i < nmap[j]; i++) {
> > > -                       struct sysmmu_resource_map *map;
> > > -                       struct sysmmu_platform_data *platdata;
> > > -
> > > -                       map = &resmap[j][i];
> > > -
> > > -                       map->pdev->dev.parent = map->pdd;
> > > -
> > > -                       platdata = map->pdev->dev.platform_data;
> > > -                       platdata->clockname = map->clocknames;
> > > -
> > > -                       if (platform_device_add_resources(map->pdev,
> map->res,
> > > -
> map->rnum)) {
> > > -                               pr_err("%s: Failed to add device
> resources for "
> > > -                                               "%s.%d\n", __func__,
> > > -                                               map->pdev->name,
> map->pdev->id);
> > > -                               continue;
> > > -                       }
> > > -
> > > -                       if (platform_device_register(map->pdev)) {
> > > -                               pr_err("%s: Failed to register
> %s.%d\n",
> > > -                                       __func__, map->pdev->name,
> > > -                                               map->pdev->id);
> > > -                       }
> > > -               }
> > > -       }
> > > -
> > > -       return 0;
> > > -}
> > > -arch_initcall(init_sysmmu_platform_device);
> > > diff --git a/arch/arm/mach-exynos/include/mach/sysmmu.h
> b/arch/arm/mach-exynos/include/mach/sysmmu.h
> > > deleted file mode 100644
> > > index 88a4543..0000000
> > > --- a/arch/arm/mach-exynos/include/mach/sysmmu.h
> > > +++ /dev/null
> > > @@ -1,66 +0,0 @@
> > > -/*
> > > - * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
> > > - *             http://www.samsung.com
> > > - *
> > > - * EXYNOS - System MMU support
> > > - *
> > > - * This program is free software; you can redistribute it and/or
> modify
> > > - * it under the terms of the GNU General Public License version 2 as
> > > - * published by the Free Software Foundation.
> > > - */
> > > -
> > > -#ifndef _ARM_MACH_EXYNOS_SYSMMU_H_
> > > -#define _ARM_MACH_EXYNOS_SYSMMU_H_
> > > -
> > > -struct sysmmu_platform_data {
> > > -       char *dbgname;
> > > -       /* comma(,) separated list of clock names for clock gating */
> > > -       char *clockname;
> > > -};
> > > -
> > > -#define SYSMMU_DEVNAME_BASE "exynos-sysmmu"
> > > -
> > > -#define SYSMMU_CLOCK_NAME "sysmmu"
> > > -#define SYSMMU_CLOCK_NAME2 "sysmmu_mc"
> > > -
> > > -#ifdef CONFIG_EXYNOS_DEV_SYSMMU
> > > -#include <linux/device.h>
> > > -struct platform_device;
> > > -
> > > -#define SYSMMU_PLATDEV(ipname) exynos_device_sysmmu_##ipname
> > > -
> > > -extern struct platform_device SYSMMU_PLATDEV(mfc_l);
> > > -extern struct platform_device SYSMMU_PLATDEV(mfc_r);
> > > -extern struct platform_device SYSMMU_PLATDEV(tv);
> > > -extern struct platform_device SYSMMU_PLATDEV(jpeg);
> > > -extern struct platform_device SYSMMU_PLATDEV(rot);
> > > -extern struct platform_device SYSMMU_PLATDEV(fimc0);
> > > -extern struct platform_device SYSMMU_PLATDEV(fimc1);
> > > -extern struct platform_device SYSMMU_PLATDEV(fimc2);
> > > -extern struct platform_device SYSMMU_PLATDEV(fimc3);
> > > -extern struct platform_device SYSMMU_PLATDEV(gsc0);
> > > -extern struct platform_device SYSMMU_PLATDEV(gsc1);
> > > -extern struct platform_device SYSMMU_PLATDEV(gsc2);
> > > -extern struct platform_device SYSMMU_PLATDEV(gsc3);
> > > -extern struct platform_device SYSMMU_PLATDEV(isp);
> > > -extern struct platform_device SYSMMU_PLATDEV(fimd0);
> > > -extern struct platform_device SYSMMU_PLATDEV(fimd1);
> > > -extern struct platform_device SYSMMU_PLATDEV(camif0);
> > > -extern struct platform_device SYSMMU_PLATDEV(camif1);
> > > -extern struct platform_device SYSMMU_PLATDEV(2d);
> > > -
> > > -#ifdef CONFIG_IOMMU_API
> > > -static inline void platform_set_sysmmu(
> > > -                               struct device *sysmmu, struct device
> *dev)
> > > -{
> > > -       dev->archdata.iommu = sysmmu;
> > > -}
> > > -#endif
> > > -
> > > -#else /* !CONFIG_EXYNOS_DEV_SYSMMU */
> > > -#define platform_set_sysmmu(sysmmu, dev) do { } while (0)
> > > -#endif
> > > -
> > > -#define SYSMMU_CLOCK_DEVNAME(ipname, id) (SYSMMU_DEVNAME_BASE "." #id)
> > > -
> > > -#endif /* _ARM_MACH_EXYNOS_SYSMMU_H_ */
> > > diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c
> b/arch/arm/mach-exynos/mach-exynos4-dt.c
> > > index 92757ff..ac09af8 100644
> > > --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> > > +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> > > @@ -80,6 +80,40 @@ static const struct of_dev_auxdata
> exynos4_auxdata_lookup[] __initconst = {
> > >         OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_MDMA1, "dma-pl330.2",
> NULL),
> > >         OF_DEV_AUXDATA("samsung,exynos4210-tmu", EXYNOS4_PA_TMU,
> > >                                 "exynos-tmu", NULL),
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13620000,
> > > +                       "exynos-sysmmu.0", NULL), /* MFC_L */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13630000,
> > > +                       "exynos-sysmmu.1", NULL), /* MFC_R */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13E20000,
> > > +                       "exynos-sysmmu.2", NULL), /* TV */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11A60000,
> > > +                       "exynos-sysmmu.3", NULL), /* JPEG */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x12A30000,
> > > +                       "exynos-sysmmu.4", NULL), /* ROTATOR */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11A20000,
> > > +                       "exynos-sysmmu.5", NULL), /* FIMC0 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11A30000,
> > > +                       "exynos-sysmmu.6", NULL), /* FIMC1 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11A40000,
> > > +                       "exynos-sysmmu.7", NULL), /* FIMC2 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11A50000,
> > > +                       "exynos-sysmmu.8", NULL), /* FIMC3 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x12A20000,
> > > +                       "exynos-sysmmu.9", NULL), /* G2D(4210) */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x10A40000,
> > > +                       "exynos-sysmmu.9", NULL), /* G2D(4x12) */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11E20000,
> > > +                       "exynos-sysmmu.10", NULL), /* FIMD0 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x12220000,
> > > +                       "exynos-sysmmu.11", NULL), /* FIMD1(4210) */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x12260000,
> > > +                       "exynos-sysmmu.12", NULL), /* IS0(4x12) */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x122B0000,
> > > +                       "exynos-sysmmu.13", NULL), /* IS1(4x12) */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x123B0000,
> > > +                       "exynos-sysmmu.14", NULL), /* FIMC-LITE0(4x12)
> */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x123C0000,
> > > +                       "exynos-sysmmu.15", NULL), /* FIMC-LITE1(4x12)
> */
> > >         {},
> > >  };
> > >
> > > diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c
> b/arch/arm/mach-exynos/mach-exynos5-dt.c
> > > index e99d3d8..2671075 100644
> > > --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> > > +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> > > @@ -104,6 +104,36 @@ static const struct of_dev_auxdata
> exynos5250_auxdata_lookup[] __initconst = {
> > >         OF_DEV_AUXDATA("samsung,mfc-v6", 0x11000000, "s5p-mfc-v6",
> NULL),
> > >         OF_DEV_AUXDATA("samsung,exynos5250-tmu", 0x10060000,
> > >                                 "exynos-tmu", NULL),
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11210000,
> > > +                       "exynos-sysmmu.0", "mfc"), /* MFC_L */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11200000,
> > > +                       "exynos-sysmmu.1", "mfc"), /* MFC_R */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x14650000,
> > > +                       "exynos-sysmmu.2", NULL), /* TV */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11F20000,
> > > +                       "exynos-sysmmu.3", "jpeg"), /* JPEG */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x11D40000,
> > > +                       "exynos-sysmmu.4", NULL), /* ROTATOR */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13E80000,
> > > +                       "exynos-sysmmu.5", "gscl"), /* GSCL0 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13E90000,
> > > +                       "exynos-sysmmu.6", "gscl"), /* GSCL1 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13EA0000,
> > > +                       "exynos-sysmmu.7", "gscl"), /* GSCL2 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13EB0000,
> > > +                       "exynos-sysmmu.8", "gscl"), /* GSCL3 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13260000,
> > > +                       "exynos-sysmmu.9", NULL), /* FIMC-IS0 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x132C0000,
> > > +                       "exynos-sysmmu.10", NULL), /* FIMC-IS1 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x14640000,
> > > +                       "exynos-sysmmu.11", NULL), /* FIMD1 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13C40000,
> > > +                       "exynos-sysmmu.12", NULL), /* FIMC-LITE0 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x13C50000,
> > > +                       "exynos-sysmmu.13", NULL), /* FIMC-LITE1 */
> > > +       OF_DEV_AUXDATA("samsung,exynos-sysmmu", 0x10A60000,
> > > +                       "exynos-sysmmu.14", NULL), /* G2D */
> > >         {},
> > >  };
> > >
> > > --
> > > 1.8.0
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
> > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bd756e2d6ba8604e78f0f07
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Sun, Sep 29, 2013 at 8:35 PM, Cho KyongHo <span dir=3D"ltr">&lt;=
<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">pullip.cho@sams=
ung.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, 27 Sep 2013 14:55:=
51 -0400, Sean Paul wrote:<br>
&gt; On Tue, Dec 25, 2012 at 8:54 PM, Cho KyongHo &lt;<a href=3D"mailto:pul=
lip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; This removes System MMU initialization from arch/arm/mach-exynos/=
<br>
&gt; &gt; to move them to DT and the exynos-iommu driver except gating cloc=
k<br>
&gt; &gt; definitions.<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; exynos with iommu support no longer compiles with this patch:<br>
&gt;<br>
&gt; =A0 CC =A0 =A0 =A0drivers/iommu/exynos-iommu.o<br>
&gt; /mnt/host/source/src/third_party/kernel-next/drivers/iommu/exynos-iomm=
u.c:32:25:<br>
&gt; fatal error: mach/sysmmu.h: No such file or directory<br>
&gt; compilation terminated.<br>
&gt; make[3]: *** [drivers/iommu/exynos-iommu.o] Error 1<br>
&gt;<br>
<br>
</div>It is my fault.<br>
I think you need to apply all v6 patches to compile correctly.<br>
<br>
Since v8 patches, I checked that every patch is compiled successfully.<br>
<br></blockquote><div><br></div><div>I&#39;m sorry I don&#39;t think I expl=
ained properly.</div><div><br></div><div>This patch has been merged to main=
line without the rest of the series. As such, mainline with exynos iommu do=
es not currently compile.</div>

<div><br></div><div>Sean</div><div><br></div><div><br></div><div>=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
=A0 iommu/exynos: do not include removed header<br>
patch from v7 patch removes including &#39;mach/sysmmu.h&#39;.<br>
<br>
Thank you.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; Sean<br>
&gt;<br>
&gt;<br>
&gt; &gt; Signed-off-by: KyongHo Cho &lt;<a href=3D"mailto:pullip.cho@samsu=
ng.com">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =A0arch/arm/mach-exynos/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 5 -<br>
&gt; &gt; =A0arch/arm/mach-exynos/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 1 -<br>
&gt; &gt; =A0arch/arm/mach-exynos/clock-exynos4.c =A0 =A0 =A0 | =A041 +++--=
<br>
&gt; &gt; =A0arch/arm/mach-exynos/clock-exynos4210.c =A0 =A0| =A0 9 +-<br>
&gt; &gt; =A0arch/arm/mach-exynos/clock-exynos4212.c =A0 =A0| =A023 ++-<br>
&gt; &gt; =A0arch/arm/mach-exynos/clock-exynos5.c =A0 =A0 =A0 | =A062 ++++-=
--<br>
&gt; &gt; =A0arch/arm/mach-exynos/dev-sysmmu.c =A0 =A0 =A0 =A0 =A0| 274 ---=
--------------------------<br>
&gt; &gt; =A0arch/arm/mach-exynos/include/mach/sysmmu.h | =A066 -------<br>
&gt; &gt; =A0arch/arm/mach-exynos/mach-exynos4-dt.c =A0 =A0 | =A034 ++++<br=
>
&gt; &gt; =A0arch/arm/mach-exynos/mach-exynos5-dt.c =A0 =A0 | =A030 ++++<br=
>
&gt; &gt; =A010 files changed, 137 insertions(+), 408 deletions(-)<br>
&gt; &gt; =A0delete mode 100644 arch/arm/mach-exynos/dev-sysmmu.c<br>
&gt; &gt; =A0delete mode 100644 arch/arm/mach-exynos/include/mach/sysmmu.h<=
br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/=
Kconfig<br>
&gt; &gt; index 91d5b6f..eba6eb5 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/Kconfig<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/Kconfig<br>
&gt; &gt; @@ -103,11 +103,6 @@ config EXYNOS4_SETUP_FIMD0<br>
&gt; &gt; =A0 =A0 =A0 =A0 help<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 Common setup code for FIMD0.<br>
&gt; &gt;<br>
&gt; &gt; -config EXYNOS_DEV_SYSMMU<br>
&gt; &gt; - =A0 =A0 =A0 bool<br>
&gt; &gt; - =A0 =A0 =A0 help<br>
&gt; &gt; - =A0 =A0 =A0 =A0 Common setup code for SYSTEM MMU in EXYNOS plat=
forms<br>
&gt; &gt; -<br>
&gt; &gt; =A0config EXYNOS4_DEV_USB_OHCI<br>
&gt; &gt; =A0 =A0 =A0 =A0 bool<br>
&gt; &gt; =A0 =A0 =A0 =A0 help<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos=
/Makefile<br>
&gt; &gt; index b189881..435757e 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/Makefile<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/Makefile<br>
&gt; &gt; @@ -52,7 +52,6 @@ obj-$(CONFIG_ARCH_EXYNOS4) =A0 =A0 =A0 =A0 =A0 =
=A0+=3D dev-audio.o<br>
&gt; &gt; =A0obj-$(CONFIG_EXYNOS4_DEV_AHCI) =A0 =A0 =A0 =A0 +=3D dev-ahci.o=
<br>
&gt; &gt; =A0obj-$(CONFIG_EXYNOS_DEV_DMA) =A0 =A0 =A0 =A0 =A0 +=3D dma.o<br=
>
&gt; &gt; =A0obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI) =A0 =A0 +=3D dev-ohci.o<br>
&gt; &gt; -obj-$(CONFIG_EXYNOS_DEV_SYSMMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D dev-sysmmu.o<br>
&gt; &gt;<br>
&gt; &gt; =A0obj-$(CONFIG_ARCH_EXYNOS) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D setu=
p-i2c0.o<br>
&gt; &gt; =A0obj-$(CONFIG_EXYNOS4_SETUP_FIMC) =A0 =A0 =A0 +=3D setup-fimc.o=
<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach=
-exynos/clock-exynos4.c<br>
&gt; &gt; index bbcb3de..8a8468d 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/clock-exynos4.c<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/clock-exynos4.c<br>
&gt; &gt; @@ -24,7 +24,6 @@<br>
&gt; &gt;<br>
&gt; &gt; =A0#include &lt;mach/map.h&gt;<br>
&gt; &gt; =A0#include &lt;mach/regs-clock.h&gt;<br>
&gt; &gt; -#include &lt;mach/sysmmu.h&gt;<br>
&gt; &gt;<br>
&gt; &gt; =A0#include &quot;common.h&quot;<br>
&gt; &gt; =A0#include &quot;clock-exynos4.h&quot;<br>
&gt; &gt; @@ -709,53 +708,53 @@ static struct clk exynos4_init_clocks_off[]=
 =3D {<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_peril_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 14),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(mfc_l, 0),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.0&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_mfc_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 1),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(mfc_r, 1),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.1&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_mfc_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 2),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(tv, 2),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.2&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_tv_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 4),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(jpeg, 3),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.3&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_cam_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 11),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(rot, 4),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.4&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_image_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 4),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(fimc0, 5),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.5&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_cam_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 7),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(fimc1, 6),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.6&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_cam_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 8),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(fimc2, 7),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.7&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_cam_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 9),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(fimc3, 8),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.8&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_cam_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 10),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(fimd0, 10),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.10&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_lcd0_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 4),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/clock-exynos4210.c b/arch/arm/m=
ach-exynos/clock-exynos4210.c<br>
&gt; &gt; index fed4c26..19af9f7 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/clock-exynos4210.c<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/clock-exynos4210.c<br>
&gt; &gt; @@ -26,7 +26,6 @@<br>
&gt; &gt; =A0#include &lt;mach/hardware.h&gt;<br>
&gt; &gt; =A0#include &lt;mach/map.h&gt;<br>
&gt; &gt; =A0#include &lt;mach/regs-clock.h&gt;<br>
&gt; &gt; -#include &lt;mach/sysmmu.h&gt;<br>
&gt; &gt;<br>
&gt; &gt; =A0#include &quot;common.h&quot;<br>
&gt; &gt; =A0#include &quot;clock-exynos4.h&quot;<br>
&gt; &gt; @@ -129,13 +128,13 @@ static struct clk init_clocks_off[] =3D {<b=
r>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_lcd1_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 0),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(2d, 14),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.9&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_image_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 3),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(fimd1, 11),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.11&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_lcd1_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 4),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/m=
ach-exynos/clock-exynos4212.c<br>
&gt; &gt; index 8fba0b5..529476f 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/clock-exynos4212.c<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/clock-exynos4212.c<br>
&gt; &gt; @@ -26,7 +26,6 @@<br>
&gt; &gt; =A0#include &lt;mach/hardware.h&gt;<br>
&gt; &gt; =A0#include &lt;mach/map.h&gt;<br>
&gt; &gt; =A0#include &lt;mach/regs-clock.h&gt;<br>
&gt; &gt; -#include &lt;mach/sysmmu.h&gt;<br>
&gt; &gt;<br>
&gt; &gt; =A0#include &quot;common.h&quot;<br>
&gt; &gt; =A0#include &quot;clock-exynos4.h&quot;<br>
&gt; &gt; @@ -111,21 +110,31 @@ static struct clksrc_clk clksrcs[] =3D {<br=
>
&gt; &gt;<br>
&gt; &gt; =A0static struct clk init_clocks_off[] =3D {<br>
&gt; &gt; =A0 =A0 =A0 =A0 {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(2d, 14),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.9&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4_clk_ip_dmc_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 24),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(isp, 9),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.12&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4212_clk_ip_isp0_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (7 &l=
t;&lt; 8),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME2,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(isp, 9),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.13&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4212_clk_ip_isp1_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 4),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.14&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4=
212_clk_ip_isp0_ctrl,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &lt;=
&lt; 11),<br>
&gt; &gt; + =A0 =A0 =A0 }, {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.15&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4=
212_clk_ip_isp0_ctrl,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &lt;=
&lt; 12),<br>
&gt; &gt; + =A0 =A0 =A0 }, {<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &qu=
ot;flite&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot=
;exynos-fimc-lite.0&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s4212_clk_ip_isp0_ctrl,<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach=
-exynos/clock-exynos5.c<br>
&gt; &gt; index 0208c3a..bee2d53 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/clock-exynos5.c<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/clock-exynos5.c<br>
&gt; &gt; @@ -24,7 +24,6 @@<br>
&gt; &gt;<br>
&gt; &gt; =A0#include &lt;mach/map.h&gt;<br>
&gt; &gt; =A0#include &lt;mach/regs-clock.h&gt;<br>
&gt; &gt; -#include &lt;mach/sysmmu.h&gt;<br>
&gt; &gt;<br>
&gt; &gt; =A0#include &quot;common.h&quot;<br>
&gt; &gt;<br>
&gt; &gt; @@ -869,86 +868,91 @@ static struct clk exynos5_init_clocks_off[]=
 =3D {<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exyno=
s5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 3),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(mfc_l, 0),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.1&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_mfc_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 1),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(mfc_r, 1),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.0&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_mfc_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 2),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(tv, 2),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.2&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_disp1_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 9)<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(jpeg, 3),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.3&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gen_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 7),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(rot, 4),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.4&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gen_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 6)<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(gsc0, 5),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.5&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 7),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(gsc1, 6),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.6&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 8),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(gsc2, 7),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.7&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 9),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(gsc3, 8),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.8&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 10),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(isp, 9),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.9&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_isp0_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (0x3F=
 &lt;&lt; 8),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME2,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(isp, 9),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.10&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_isp1_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (0xF =
&lt;&lt; 4),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(camif0, 12),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.11&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;ex=
ynos5_clk_ip_disp1_ctrl,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &lt;=
&lt; 8)<br>
&gt; &gt; + =A0 =A0 =A0 }, {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.12&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 11),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(camif1, 13),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.13&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_gscl_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 12),<br>
&gt; &gt; =A0 =A0 =A0 =A0 }, {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMM=
U_CLOCK_NAME,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_=
CLOCK_DEVNAME(2d, 14),<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot=
;sysmmu&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D &quot;e=
xynos-sysmmu.14&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D &amp;=
exynos5_clk_ip_acp_ctrl,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &=
amp;exynos5_gate_clk_ops,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 &l=
t;&lt; 7)<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/dev-sysmmu.c b/arch/arm/mach-ex=
ynos/dev-sysmmu.c<br>
&gt; &gt; deleted file mode 100644<br>
&gt; &gt; index c5b1ea3..0000000<br>
&gt; &gt; --- a/arch/arm/mach-exynos/dev-sysmmu.c<br>
&gt; &gt; +++ /dev/null<br>
&gt; &gt; @@ -1,274 +0,0 @@<br>
&gt; &gt; -/* linux/arch/arm/mach-exynos/dev-sysmmu.c<br>
&gt; &gt; - *<br>
&gt; &gt; - * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.<br>
&gt; &gt; - * =A0 =A0 =A0 =A0 =A0 =A0 <a href=3D"http://www.samsung.com" ta=
rget=3D"_blank">http://www.samsung.com</a><br>
&gt; &gt; - *<br>
&gt; &gt; - * EXYNOS - System MMU support<br>
&gt; &gt; - *<br>
&gt; &gt; - * This program is free software; you can redistribute it and/or=
 modify<br>
&gt; &gt; - * it under the terms of the GNU General Public License version =
2 as<br>
&gt; &gt; - * published by the Free Software Foundation.<br>
&gt; &gt; - */<br>
&gt; &gt; -<br>
&gt; &gt; -#include &lt;linux/platform_device.h&gt;<br>
&gt; &gt; -#include &lt;linux/dma-mapping.h&gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#include &lt;plat/cpu.h&gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#include &lt;mach/map.h&gt;<br>
&gt; &gt; -#include &lt;mach/irqs.h&gt;<br>
&gt; &gt; -#include &lt;mach/sysmmu.h&gt;<br>
&gt; &gt; -<br>
&gt; &gt; -static u64 exynos_sysmmu_dma_mask =3D DMA_BIT_MASK(32);<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_PLATFORM_DEVICE(ipname, devid) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; -static struct sysmmu_platform_data platdata_##ipname =3D { =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 .dbgname =3D #ipname, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; -}; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \<br>
&gt; &gt; -struct platform_device SYSMMU_PLATDEV(ipname) =3D =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; -{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_DEVNAME_BASE, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D devid, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D { =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<b=
r>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =3D &amp;exynos_sysmmu_dma_mask, =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .coherent_dma_mask =A0 =A0 =A0=3D D=
MA_BIT_MASK(32), =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0 =A0 =A0 =A0 =A0=
=3D &amp;platdata_##ipname, =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(mfc_l, =A00);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(mfc_r, =A01);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(tv, =A0 =A0 2);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(jpeg, =A0 3);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(rot, =A0 =A04);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(fimc0, =A05); /* fimc* and gsc* exist exc=
lusively */<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(fimc1, =A06);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(fimc2, =A07);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(fimc3, =A08);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(gsc0, =A0 5);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(gsc1, =A0 6);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(gsc2, =A0 7);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(gsc3, =A0 8);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(isp, =A0 =A09);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(fimd0, =A010);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(fimd1, =A011);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(camif0, 12);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(camif1, 13);<br>
&gt; &gt; -SYSMMU_PLATFORM_DEVICE(2d, =A0 =A0 14);<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_RESOURCE_NAME(core, ipname) sysmmures_##core##_##=
ipname<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_RESOURCE(core, ipname) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 static struct resource SYSMMU_RESOURCE_NAME(core, i=
pname)[] __initdata =3D<br>
&gt; &gt; -<br>
&gt; &gt; -#define DEFINE_SYSMMU_RESOURCE(core, mem, irq) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_RES_MEM_NAMED(core##_PA_SYSMMU_##mem, SZ_4K,=
 #mem), =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_RES_IRQ_NAMED(core##_IRQ_SYSMMU_##irq##_0, #=
mem)<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_RESOURCE_DEFINE(core, ipname, mem, irq) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE(core, ipname) { =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(core, mem, i=
rq) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 }<br>
&gt; &gt; -<br>
&gt; &gt; -struct sysmmu_resource_map {<br>
&gt; &gt; - =A0 =A0 =A0 struct platform_device *pdev;<br>
&gt; &gt; - =A0 =A0 =A0 struct resource *res;<br>
&gt; &gt; - =A0 =A0 =A0 u32 rnum;<br>
&gt; &gt; - =A0 =A0 =A0 struct device *pdd;<br>
&gt; &gt; - =A0 =A0 =A0 char *clocknames;<br>
&gt; &gt; -};<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_RESOURCE_MAPPING(core, ipname, resname) { =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 .pdev =3D &amp;SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .res =3D SYSMMU_RESOURCE_NAME(EXYNOS##core, resname=
), =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##c=
ore, resname)),\<br>
&gt; &gt; - =A0 =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_RESOURCE_MAPPING_MC(core, ipname, resname, pdata)=
 { =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 .pdev =3D &amp;SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .res =3D SYSMMU_RESOURCE_NAME(EXYNOS##core, resname=
), =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##c=
ore, resname)),\<br>
&gt; &gt; - =A0 =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME &quot;,&quot; SYS=
MMU_CLOCK_NAME2, =A0 =A0 =A0 =A0 \<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_EXYNOS_DEV_PD<br>
&gt; &gt; -#define SYSMMU_RESOURCE_MAPPING_PD(core, ipname, resname, pd) { =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .pdev =3D &amp;SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .res =3D &amp;SYSMMU_RESOURCE_NAME(EXYNOS##core, re=
sname), =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##c=
ore, resname)),\<br>
&gt; &gt; - =A0 =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .pdd =3D &amp;exynos##core##_device_pd[pd].dev, =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_RESOURCE_MAPPING_MCPD(core, ipname, resname, pd, =
pdata) {\<br>
&gt; &gt; - =A0 =A0 =A0 .pdev =3D &amp;SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .res =3D &amp;SYSMMU_RESOURCE_NAME(EXYNOS##core, re=
sname), =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##c=
ore, resname)),\<br>
&gt; &gt; - =A0 =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME &quot;,&quot; SYS=
MMU_CLOCK_NAME2, =A0 =A0 =A0 =A0 \<br>
&gt; &gt; - =A0 =A0 =A0 .pdd =3D &amp;exynos##core##_device_pd[pd].dev, =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; -}<br>
&gt; &gt; -#else<br>
&gt; &gt; -#define SYSMMU_RESOURCE_MAPPING_PD(core, ipname, resname, pd) =
=A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(core, ipnam=
e, resname)<br>
&gt; &gt; -#define SYSMMU_RESOURCE_MAPPING_MCPD(core, ipname, resname, pd, =
pdata) \<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_MC(core, ip=
name, resname, pdata)<br>
&gt; &gt; -<br>
&gt; &gt; -#endif /* CONFIG_EXYNOS_DEV_PD */<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_ARCH_EXYNOS4<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc0, FIMC0, =A0FIMC0);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc1, FIMC1, =A0FIMC1);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc2, FIMC2, =A0FIMC2);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc3, FIMC3, =A0FIMC3);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, jpeg, =A0JPEG, =A0 JPEG);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, 2d, =A0 =A0G2D, =A0 =A02D);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, tv, =A0 =A0TV, =A0 =A0 TV_M0);<b=
r>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, 2d_acp, =A0 =A0 =A0 =A02D_ACP, 2=
D);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, rot, =A0 ROTATOR, ROTATOR);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimd0, FIMD0, =A0LCD0_M0);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimd1, FIMD1, =A0LCD1_M1);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, flite0, =A0 =A0 =A0 =A0FIMC_LITE=
0, FIMC_LITE0);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, flite1, =A0 =A0 =A0 =A0FIMC_LITE=
1, FIMC_LITE1);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, mfc_r, MFC_R, =A0MFC_M0);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS4, mfc_l, MFC_L, =A0MFC_M1);<br>
&gt; &gt; -SYSMMU_RESOURCE(EXYNOS4, isp) {<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_ISP, FIMC_ISP)=
,<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_DRC, FIMC_DRC)=
,<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_FD, FIMC_FD),<=
br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, ISPCPU, FIMC_CX),<b=
r>
&gt; &gt; -};<br>
&gt; &gt; -<br>
&gt; &gt; -static struct sysmmu_resource_map sysmmu_resmap4[] __initdata =
=3D {<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, fimc0, =A0 =A0fimc0, =
=A0PD_CAM),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, fimc1, =A0 =A0fimc1, =
=A0PD_CAM),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, fimc2, =A0 =A0fimc2, =
=A0PD_CAM),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, fimc3, =A0 =A0fimc3, =
=A0PD_CAM),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, tv, =A0 =A0 =A0 tv, =
=A0 =A0 PD_TV),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, mfc_r, =A0 =A0mfc_r, =
=A0PD_MFC),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, mfc_l, =A0 =A0mfc_l, =
=A0PD_MFC),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, rot, =A0 =A0 =A0rot, =
=A0 =A0PD_LCD0),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, jpeg, =A0 =A0 jpeg, =
=A0 PD_CAM),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, fimd0, =A0 =A0fimd0, =
=A0PD_LCD0),<br>
&gt; &gt; -};<br>
&gt; &gt; -<br>
&gt; &gt; -static struct sysmmu_resource_map sysmmu_resmap4210[] __initdata=
 =3D {<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, 2d, =A0 =A0 =A0 2d, =
=A0 =A0 PD_LCD0),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, fimd1, =A0 =A0fimd1, =
=A0PD_LCD1),<br>
&gt; &gt; -};<br>
&gt; &gt; -<br>
&gt; &gt; -static struct sysmmu_resource_map sysmmu_resmap4212[] __initdata=
 =3D {<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(4, =A0 =A0 =A02d, =A0 =A0 2=
d_acp),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, =A0 camif0, flite0, P=
D_ISP),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, =A0 camif1, flite1, P=
D_ISP),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(4, =A0 isp, =A0 =A0isp, =
=A0 =A0PD_ISP),<br>
&gt; &gt; -};<br>
&gt; &gt; -#endif /* CONFIG_ARCH_EXYNOS4 */<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_ARCH_EXYNOS5<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, jpeg, =A0JPEG, =A0 JPEG);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, fimd1, FIMD1, =A0FIMD1);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, 2d, =A0 =A02D, =A0 =A0 2D);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, rot, =A0 ROTATOR, ROTATOR);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, tv, =A0 =A0TV, =A0 =A0 TV);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, flite0, =A0 =A0 =A0 =A0LITE0, =
=A0LITE0);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, flite1, =A0 =A0 =A0 =A0LITE1, =
=A0LITE1);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc0, =A0GSC0, =A0 GSC0);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc1, =A0GSC1, =A0 GSC1);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc2, =A0GSC2, =A0 GSC2);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, gsc3, =A0GSC3, =A0 GSC3);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, mfc_r, MFC_R, =A0MFC_R);<br>
&gt; &gt; -SYSMMU_RESOURCE_DEFINE(EXYNOS5, mfc_l, MFC_L, =A0MFC_L);<br>
&gt; &gt; -SYSMMU_RESOURCE(EXYNOS5, isp) {<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, ISP, ISP),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, DRC, DRC),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, FD, FD),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, ISPCPU, MCUISP),<br=
>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, SCALERC, SCALERCISP=
),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, SCALERP, SCALERPISP=
),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, ODC, ODC),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, DIS0, DIS0),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, DIS1, DIS1),<br>
&gt; &gt; - =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS5, 3DNR, 3DNR),<br>
&gt; &gt; -};<br>
&gt; &gt; -<br>
&gt; &gt; -static struct sysmmu_resource_map sysmmu_resmap5[] __initdata =
=3D {<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(5, =A0 =A0 =A0jpeg, =A0 jpe=
g),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(5, =A0 =A0 =A0fimd1, =A0fim=
d1),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(5, =A0 =A0 =A02d, =A0 =A0 2=
d),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(5, =A0 =A0 =A0rot, =A0 =A0r=
ot),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 tv, =A0 =A0 tv, =
=A0 =A0 PD_DISP1),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 camif0, flite0, P=
D_GSCL),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 camif1, flite1, P=
D_GSCL),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 gsc0, =A0 gsc0, =
=A0 PD_GSCL),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 gsc1, =A0 gsc1, =
=A0 PD_GSCL),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 gsc2, =A0 gsc2, =
=A0 PD_GSCL),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 gsc3, =A0 gsc3, =
=A0 PD_GSCL),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 mfc_r, =A0mfc_r, =
=A0PD_MFC),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_PD(5, =A0 mfc_l, =A0mfc_l, =
=A0PD_MFC),<br>
&gt; &gt; - =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_MCPD(5, isp, =A0 =A0isp, =
=A0 =A0PD_ISP, mc_platdata),<br>
&gt; &gt; -};<br>
&gt; &gt; -#endif /* CONFIG_ARCH_EXYNOS5 */<br>
&gt; &gt; -<br>
&gt; &gt; -static int __init init_sysmmu_platform_device(void)<br>
&gt; &gt; -{<br>
&gt; &gt; - =A0 =A0 =A0 int i, j;<br>
&gt; &gt; - =A0 =A0 =A0 struct sysmmu_resource_map *resmap[2] =3D {NULL, NU=
LL};<br>
&gt; &gt; - =A0 =A0 =A0 int nmap[2] =3D {0, 0};<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_ARCH_EXYNOS5<br>
&gt; &gt; - =A0 =A0 =A0 if (soc_is_exynos5250()) {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 resmap[0] =3D sysmmu_resmap5;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nmap[0] =3D ARRAY_SIZE(sysmmu_resma=
p5);<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nmap[1] =3D 0;<br>
&gt; &gt; - =A0 =A0 =A0 }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_ARCH_EXYNOS4<br>
&gt; &gt; - =A0 =A0 =A0 if (resmap[0] =3D=3D NULL) {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 resmap[0] =3D sysmmu_resmap4;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nmap[0] =3D ARRAY_SIZE(sysmmu_resma=
p4);<br>
&gt; &gt; - =A0 =A0 =A0 }<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 if (soc_is_exynos4210()) {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 resmap[1] =3D sysmmu_resmap4210;<br=
>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nmap[1] =3D ARRAY_SIZE(sysmmu_resma=
p4210);<br>
&gt; &gt; - =A0 =A0 =A0 }<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 if (soc_is_exynos4412() || soc_is_exynos4212()) {<b=
r>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 resmap[1] =3D sysmmu_resmap4212;<br=
>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nmap[1] =3D ARRAY_SIZE(sysmmu_resma=
p4212);<br>
&gt; &gt; - =A0 =A0 =A0 }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 for (j =3D 0; j &lt; 2; j++) {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; nmap[j]; i++) =
{<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_resou=
rce_map *map;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_platf=
orm_data *platdata;<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map =3D &amp;resmap=
[j][i];<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map-&gt;pdev-&gt;de=
v.parent =3D map-&gt;pdd;<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platdata =3D map-&g=
t;pdev-&gt;dev.platform_data;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platdata-&gt;clockn=
ame =3D map-&gt;clocknames;<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (platform_device=
_add_resources(map-&gt;pdev, map-&gt;res,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map-&gt;rnum))=
 {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_=
err(&quot;%s: Failed to add device resources for &quot;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;%s.%d\n&quot;, __func__,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map-&gt;pdev-&gt;name, map-&gt;pdev-&gt;id);<b=
r>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con=
tinue;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (platform_device=
_register(map-&gt;pdev)) {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_=
err(&quot;%s: Failed to register %s.%d\n&quot;,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 __func__, map-&gt;pdev-&gt;name,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map-&gt;pdev-&gt;id);<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; &gt; - =A0 =A0 =A0 }<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 =A0 return 0;<br>
&gt; &gt; -}<br>
&gt; &gt; -arch_initcall(init_sysmmu_platform_device);<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/include/mach/sysmmu.h b/arch/ar=
m/mach-exynos/include/mach/sysmmu.h<br>
&gt; &gt; deleted file mode 100644<br>
&gt; &gt; index 88a4543..0000000<br>
&gt; &gt; --- a/arch/arm/mach-exynos/include/mach/sysmmu.h<br>
&gt; &gt; +++ /dev/null<br>
&gt; &gt; @@ -1,66 +0,0 @@<br>
&gt; &gt; -/*<br>
&gt; &gt; - * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.<br>
&gt; &gt; - * =A0 =A0 =A0 =A0 =A0 =A0 <a href=3D"http://www.samsung.com" ta=
rget=3D"_blank">http://www.samsung.com</a><br>
&gt; &gt; - *<br>
&gt; &gt; - * EXYNOS - System MMU support<br>
&gt; &gt; - *<br>
&gt; &gt; - * This program is free software; you can redistribute it and/or=
 modify<br>
&gt; &gt; - * it under the terms of the GNU General Public License version =
2 as<br>
&gt; &gt; - * published by the Free Software Foundation.<br>
&gt; &gt; - */<br>
&gt; &gt; -<br>
&gt; &gt; -#ifndef _ARM_MACH_EXYNOS_SYSMMU_H_<br>
&gt; &gt; -#define _ARM_MACH_EXYNOS_SYSMMU_H_<br>
&gt; &gt; -<br>
&gt; &gt; -struct sysmmu_platform_data {<br>
&gt; &gt; - =A0 =A0 =A0 char *dbgname;<br>
&gt; &gt; - =A0 =A0 =A0 /* comma(,) separated list of clock names for clock=
 gating */<br>
&gt; &gt; - =A0 =A0 =A0 char *clockname;<br>
&gt; &gt; -};<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_DEVNAME_BASE &quot;exynos-sysmmu&quot;<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_CLOCK_NAME &quot;sysmmu&quot;<br>
&gt; &gt; -#define SYSMMU_CLOCK_NAME2 &quot;sysmmu_mc&quot;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_EXYNOS_DEV_SYSMMU<br>
&gt; &gt; -#include &lt;linux/device.h&gt;<br>
&gt; &gt; -struct platform_device;<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_PLATDEV(ipname) exynos_device_sysmmu_##ipname<br>
&gt; &gt; -<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(mfc_l);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(mfc_r);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(tv);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(jpeg);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(rot);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(fimc0);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(fimc1);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(fimc2);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(fimc3);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(gsc0);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(gsc1);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(gsc2);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(gsc3);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(isp);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(fimd0);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(fimd1);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(camif0);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(camif1);<br>
&gt; &gt; -extern struct platform_device SYSMMU_PLATDEV(2d);<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_IOMMU_API<br>
&gt; &gt; -static inline void platform_set_sysmmu(<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct device *sysmmu, struct device *dev)<br>
&gt; &gt; -{<br>
&gt; &gt; - =A0 =A0 =A0 dev-&gt;archdata.iommu =3D sysmmu;<br>
&gt; &gt; -}<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt; -#else /* !CONFIG_EXYNOS_DEV_SYSMMU */<br>
&gt; &gt; -#define platform_set_sysmmu(sysmmu, dev) do { } while (0)<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt; -#define SYSMMU_CLOCK_DEVNAME(ipname, id) (SYSMMU_DEVNAME_BASE &q=
uot;.&quot; #id)<br>
&gt; &gt; -<br>
&gt; &gt; -#endif /* _ARM_MACH_EXYNOS_SYSMMU_H_ */<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/ma=
ch-exynos/mach-exynos4-dt.c<br>
&gt; &gt; index 92757ff..ac09af8 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/mach-exynos4-dt.c<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c<br>
&gt; &gt; @@ -80,6 +80,40 @@ static const struct of_dev_auxdata exynos4_aux=
data_lookup[] __initconst =3D {<br>
&gt; &gt; =A0 =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;arm,pl330&quot;, EXYNOS4_PA_=
MDMA1, &quot;dma-pl330.2&quot;, NULL),<br>
&gt; &gt; =A0 =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos4210-tmu&quot;=
, EXYNOS4_PA_TMU,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
quot;exynos-tmu&quot;, NULL),<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13620000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.0&quot;, NULL), /* MFC_L */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13630000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.1&quot;, NULL), /* MFC_R */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13E20000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.2&quot;, NULL), /* TV */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11A60000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.3&quot;, NULL), /* JPEG */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x12A30000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.4&quot;, NULL), /* ROTATOR */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11A20000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.5&quot;, NULL), /* FIMC0 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11A30000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.6&quot;, NULL), /* FIMC1 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11A40000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.7&quot;, NULL), /* FIMC2 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11A50000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.8&quot;, NULL), /* FIMC3 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x12A20000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.9&quot;, NULL), /* G2D(4210) */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x10A40000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.9&quot;, NULL), /* G2D(4x12) */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11E20000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.10&quot;, NULL), /* FIMD0 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x12220000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.11&quot;, NULL), /* FIMD1(4210) */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x12260000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.12&quot;, NULL), /* IS0(4x12) */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x122B0000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.13&quot;, NULL), /* IS1(4x12) */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x123B0000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.14&quot;, NULL), /* FIMC-LITE0(4x12) */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x123C0000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.15&quot;, NULL), /* FIMC-LITE1(4x12) */<br>
&gt; &gt; =A0 =A0 =A0 =A0 {},<br>
&gt; &gt; =A0};<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/ma=
ch-exynos/mach-exynos5-dt.c<br>
&gt; &gt; index e99d3d8..2671075 100644<br>
&gt; &gt; --- a/arch/arm/mach-exynos/mach-exynos5-dt.c<br>
&gt; &gt; +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c<br>
&gt; &gt; @@ -104,6 +104,36 @@ static const struct of_dev_auxdata exynos525=
0_auxdata_lookup[] __initconst =3D {<br>
&gt; &gt; =A0 =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,mfc-v6&quot;, 0x1100=
0000, &quot;s5p-mfc-v6&quot;, NULL),<br>
&gt; &gt; =A0 =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos5250-tmu&quot;=
, 0x10060000,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
quot;exynos-tmu&quot;, NULL),<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11210000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.0&quot;, &quot;mfc&quot;), /* MFC_L */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11200000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.1&quot;, &quot;mfc&quot;), /* MFC_R */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x14650000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.2&quot;, NULL), /* TV */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11F20000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.3&quot;, &quot;jpeg&quot;), /* JPEG */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x11D40000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.4&quot;, NULL), /* ROTATOR */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13E80000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.5&quot;, &quot;gscl&quot;), /* GSCL0 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13E90000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.6&quot;, &quot;gscl&quot;), /* GSCL1 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13EA0000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.7&quot;, &quot;gscl&quot;), /* GSCL2 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13EB0000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.8&quot;, &quot;gscl&quot;), /* GSCL3 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13260000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.9&quot;, NULL), /* FIMC-IS0 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x132C0000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.10&quot;, NULL), /* FIMC-IS1 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x14640000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.11&quot;, NULL), /* FIMD1 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13C40000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.12&quot;, NULL), /* FIMC-LITE0 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x13C50000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.13&quot;, NULL), /* FIMC-LITE1 */<br>
&gt; &gt; + =A0 =A0 =A0 OF_DEV_AUXDATA(&quot;samsung,exynos-sysmmu&quot;, 0=
x10A60000,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;exynos-sysmmu=
.14&quot;, NULL), /* G2D */<br>
&gt; &gt; =A0 =A0 =A0 =A0 {},<br>
&gt; &gt; =A0};<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 1.8.0<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe li=
nux-samsung-soc&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; &gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/major=
domo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.htm=
l</a><br>
</div></div></blockquote></div><br></div></div>

--047d7bd756e2d6ba8604e78f0f07--

--===============8591252151621991135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8591252151621991135==--
