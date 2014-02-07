From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: Remove driver
Date: Fri, 7 Feb 2014 21:44:48 +0900
Message-ID: <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
	<CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3208926973726350077=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3208926973726350077==
Content-Type: multipart/alternative; boundary=089e013c6f9cf2a6e704f1d05a29

--089e013c6f9cf2a6e704f1d05a29
Content-Type: text/plain; charset=ISO-8859-1

On Friday, February 7, 2014, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> 2014-02-07 Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org <javascript:;>>:
> > The driver has been unbuildable due to unfulfilled dependencies since
> > 3.11, and even if enabled it won't build due to build breakage. Emails
> > about status on this have gone unanswered, and fixes seem to have been
> > abandoned.
> >
> > It's obvious that nobody cares about it, so let's remove it.
>
> Wait, we are going to fix up this module. It seems that KyoungHo,
> original author, is busy with some works related to product.
>
> we can care about it if KyoungHo cannot afford to care for the time being.
>
> Any volunteers?
Marek or Bartek, how do you think?

Before that it makes orphan or unsupported at maintainer file first and
change it to new volunteers.

Thank you,
Kyungmin Park


Thanks,
> Inki Dae
>
> >
> > Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > ---
> >  drivers/iommu/Kconfig        |   21 -
> >  drivers/iommu/Makefile       |    1 -
> >  drivers/iommu/exynos-iommu.c | 1035
> ------------------------------------------
> >  3 files changed, 1057 deletions(-)
> >  delete mode 100644 drivers/iommu/exynos-iommu.c
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 79bbc21..b893367 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -176,27 +176,6 @@ config TEGRA_IOMMU_SMMU
> >           space through the SMMU (System Memory Management Unit)
> >           hardware included on Tegra SoCs.
> >
> > -config EXYNOS_IOMMU
> > -       bool "Exynos IOMMU Support"
> > -       depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> > -       select IOMMU_API
> > -       help
> > -         Support for the IOMMU(System MMU) of Samsung Exynos application
> > -         processor family. This enables H/W multimedia accellerators to
> see
> > -         non-linear physical memory chunks as a linear memory in their
> > -         address spaces
> > -
> > -         If unsure, say N here.
> > -
> > -config EXYNOS_IOMMU_DEBUG
> > -       bool "Debugging log for Exynos IOMMU"
> > -       depends on EXYNOS_IOMMU
> > -       help
> > -         Select this to see the detailed log message that shows what
> > -         happens in the IOMMU driver
> > -
> > -         Say N unless you need kernel log message for IOMMU debugging
> > -
> >  config SHMOBILE_IPMMU
> >         bool
> >
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 5d58bf1..de6c909 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -14,7 +14,6 @@ obj-$(CONFIG_OMAP_IOVMM) += omap-iovmm.o
> >  obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
> >  obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
> >  obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
> > -obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
> >  obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
> >  obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
> >  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > deleted file mode 100644
> > index 0740189..0000000
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ /dev/null
> > @@ -1,1035 +0,0 @@
> > -/* linux/drivers/iommu/exynos_iommu.c
> > - *
> > - * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > - *             http://www.samsung.com
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - */
> > -
> > -#ifdef CONFIG_EXYNOS_IOMMU_DEBUG
> > -#define DEBUG
> > -#endif
> > -
> > -#include <linux/io.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/slab.h>
> > -#include <linux/pm_runtime.h>
> > -#include <linux/clk.h>
> > -#include <linux/err.h>
> > -#include <linux/mm.h>
> > -#include <linux/iommu.h>
> > -#include <linux/errno.h>
> > -#include <linux/list.h>
> > -#include <linux/memblock.h>
> > -#include <linux/export.h>
> > -
> > -#include <asm/cacheflush.h>
> > -#include <asm/pgtable.h>
> > -
> > -#include <mach/sysmmu.h>
> > -
> > -/* We does not consider super section mapping (16MB) */
> > -#define SECT_ORDER 20
> > -#define LPAGE_ORDER 16
> > -#define SPAGE_ORDER 12
> > -
> > -#define SECT_SIZE (1 << SECT_ORDER)
> > -#define LPAGE_SIZE (1 << LPAGE_ORDER)
> > -#define SPAGE_SIZE (1 << SPAGE_ORDER)
> > -
> > -#define SECT_MASK (~(SECT_SIZE - 1))
>

--089e013c6f9cf2a6e704f1d05a29
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, February 7, 2014, Inki Dae &lt;<a href=3D"mailto:inki.da=
e@samsung.com">inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
2014-02-07 Olof Johansson &lt;<a href=3D"javascript:;" onclick=3D"_e(event,=
 &#39;cvml&#39;, &#39;olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org&#39;)">olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org</a>&gt;:<br>
&gt; The driver has been unbuildable due to unfulfilled dependencies since<=
br>
&gt; 3.11, and even if enabled it won&#39;t build due to build breakage. Em=
ails<br>
&gt; about status on this have gone unanswered, and fixes seem to have been=
<br>
&gt; abandoned.<br>
&gt;<br>
&gt; It&#39;s obvious that nobody cares about it, so let&#39;s remove it.<b=
r>
<br>
Wait, we are going to fix up this module. It seems that KyoungHo,<br>
original author, is busy with some works related to product.<br>
<br>
we can care about it if KyoungHo cannot afford to care for the time being.<=
br>
<br></blockquote><div>Any volunteers?=A0</div><div>Marek or=A0Bartek, how d=
o you think?</div><div><br></div><div>Before that it makes orphan or unsupp=
orted at maintainer file first and change it to new volunteers.</div><div>
<br></div><div>Thank you,=A0</div><div>Kyungmin Park</div><div><br></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Inki Dae<br>
<br>
&gt;<br>
&gt; Signed-off-by: Olof Johansson &lt;<a>olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/iommu/Kconfig =A0 =A0 =A0 =A0| =A0 21 -<br>
&gt; =A0drivers/iommu/Makefile =A0 =A0 =A0 | =A0 =A01 -<br>
&gt; =A0drivers/iommu/exynos-iommu.c | 1035 -------------------------------=
-----------<br>
&gt; =A03 files changed, 1057 deletions(-)<br>
&gt; =A0delete mode 100644 drivers/iommu/exynos-iommu.c<br>
&gt;<br>
&gt; diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig<br>
&gt; index 79bbc21..b893367 100644<br>
&gt; --- a/drivers/iommu/Kconfig<br>
&gt; +++ b/drivers/iommu/Kconfig<br>
&gt; @@ -176,27 +176,6 @@ config TEGRA_IOMMU_SMMU<br>
&gt; =A0 =A0 =A0 =A0 =A0 space through the SMMU (System Memory Management U=
nit)<br>
&gt; =A0 =A0 =A0 =A0 =A0 hardware included on Tegra SoCs.<br>
&gt;<br>
&gt; -config EXYNOS_IOMMU<br>
&gt; - =A0 =A0 =A0 bool &quot;Exynos IOMMU Support&quot;<br>
&gt; - =A0 =A0 =A0 depends on ARCH_EXYNOS &amp;&amp; EXYNOS_DEV_SYSMMU<br>
&gt; - =A0 =A0 =A0 select IOMMU_API<br>
&gt; - =A0 =A0 =A0 help<br>
&gt; - =A0 =A0 =A0 =A0 Support for the IOMMU(System MMU) of Samsung Exynos =
application<br>
&gt; - =A0 =A0 =A0 =A0 processor family. This enables H/W multimedia accell=
erators to see<br>
&gt; - =A0 =A0 =A0 =A0 non-linear physical memory chunks as a linear memory=
 in their<br>
&gt; - =A0 =A0 =A0 =A0 address spaces<br>
&gt; -<br>
&gt; - =A0 =A0 =A0 =A0 If unsure, say N here.<br>
&gt; -<br>
&gt; -config EXYNOS_IOMMU_DEBUG<br>
&gt; - =A0 =A0 =A0 bool &quot;Debugging log for Exynos IOMMU&quot;<br>
&gt; - =A0 =A0 =A0 depends on EXYNOS_IOMMU<br>
&gt; - =A0 =A0 =A0 help<br>
&gt; - =A0 =A0 =A0 =A0 Select this to see the detailed log message that sho=
ws what<br>
&gt; - =A0 =A0 =A0 =A0 happens in the IOMMU driver<br>
&gt; -<br>
&gt; - =A0 =A0 =A0 =A0 Say N unless you need kernel log message for IOMMU d=
ebugging<br>
&gt; -<br>
&gt; =A0config SHMOBILE_IPMMU<br>
&gt; =A0 =A0 =A0 =A0 bool<br>
&gt;<br>
&gt; diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile<br>
&gt; index 5d58bf1..de6c909 100644<br>
&gt; --- a/drivers/iommu/Makefile<br>
&gt; +++ b/drivers/iommu/Makefile<br>
&gt; @@ -14,7 +14,6 @@ obj-$(CONFIG_OMAP_IOVMM) +=3D omap-iovmm.o<br>
&gt; =A0obj-$(CONFIG_OMAP_IOMMU_DEBUG) +=3D omap-iommu-debug.o<br>
&gt; =A0obj-$(CONFIG_TEGRA_IOMMU_GART) +=3D tegra-gart.o<br>
&gt; =A0obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o<br>
&gt; -obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o<br>
&gt; =A0obj-$(CONFIG_SHMOBILE_IOMMU) +=3D shmobile-iommu.o<br>
&gt; =A0obj-$(CONFIG_SHMOBILE_IPMMU) +=3D shmobile-ipmmu.o<br>
&gt; =A0obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o<br>
&gt; diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu=
.c<br>
&gt; deleted file mode 100644<br>
&gt; index 0740189..0000000<br>
&gt; --- a/drivers/iommu/exynos-iommu.c<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,1035 +0,0 @@<br>
&gt; -/* linux/drivers/iommu/exynos_iommu.c<br>
&gt; - *<br>
&gt; - * Copyright (c) 2011 Samsung Electronics Co., Ltd.<br>
&gt; - * =A0 =A0 =A0 =A0 =A0 =A0 <a href=3D"http://www.samsung.com" target=
=3D"_blank">http://www.samsung.com</a><br>
&gt; - *<br>
&gt; - * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; - * it under the terms of the GNU General Public License version 2 as<=
br>
&gt; - * published by the Free Software Foundation.<br>
&gt; - */<br>
&gt; -<br>
&gt; -#ifdef CONFIG_EXYNOS_IOMMU_DEBUG<br>
&gt; -#define DEBUG<br>
&gt; -#endif<br>
&gt; -<br>
&gt; -#include &lt;linux/io.h&gt;<br>
&gt; -#include &lt;linux/interrupt.h&gt;<br>
&gt; -#include &lt;linux/platform_device.h&gt;<br>
&gt; -#include &lt;linux/slab.h&gt;<br>
&gt; -#include &lt;linux/pm_runtime.h&gt;<br>
&gt; -#include &lt;linux/clk.h&gt;<br>
&gt; -#include &lt;linux/err.h&gt;<br>
&gt; -#include &lt;linux/mm.h&gt;<br>
&gt; -#include &lt;linux/iommu.h&gt;<br>
&gt; -#include &lt;linux/errno.h&gt;<br>
&gt; -#include &lt;linux/list.h&gt;<br>
&gt; -#include &lt;linux/memblock.h&gt;<br>
&gt; -#include &lt;linux/export.h&gt;<br>
&gt; -<br>
&gt; -#include &lt;asm/cacheflush.h&gt;<br>
&gt; -#include &lt;asm/pgtable.h&gt;<br>
&gt; -<br>
&gt; -#include &lt;mach/sysmmu.h&gt;<br>
&gt; -<br>
&gt; -/* We does not consider super section mapping (16MB) */<br>
&gt; -#define SECT_ORDER 20<br>
&gt; -#define LPAGE_ORDER 16<br>
&gt; -#define SPAGE_ORDER 12<br>
&gt; -<br>
&gt; -#define SECT_SIZE (1 &lt;&lt; SECT_ORDER)<br>
&gt; -#define LPAGE_SIZE (1 &lt;&lt; LPAGE_ORDER)<br>
&gt; -#define SPAGE_SIZE (1 &lt;&lt; SPAGE_ORDER)<br>
&gt; -<br>
&gt; -#define SECT_MASK (~(SECT_SIZE - 1))<br>
</blockquote>

--089e013c6f9cf2a6e704f1d05a29--

--===============3208926973726350077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3208926973726350077==--
