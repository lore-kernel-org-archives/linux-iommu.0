From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 01/16] iommu/exynos: do not include removed header
Date: Fri, 09 Aug 2013 13:01:33 +0900
Message-ID: <20130809130133.fea18aa350c831ece07188e3@samsung.com>
References: <002501ce941a$e3d87f40$ab897dc0$@samsung.com>
	<21505674.fdNgPGp76O@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <21505674.fdNgPGp76O@amdc1227>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 08 Aug 2013 15:42:24 +0200, Tomasz Figa wrote:
> Hi KyongHo,
> 
> On Thursday 08 of August 2013 18:37:25 Cho KyongHo wrote:
> > This commit remove <mach/sysmmu.h> which is removed.
> 
> I would prefer a more meaningful commit message, something among following 
> lines:
> 
> 8<---
> Commit 25e9d28d92 (ARM: EXYNOS: remove system mmu initialization from 
> exynos tree) removed arch/arm/mach-exynos/mach/sysmmu.h header without 
> removing remaining use of it from exynos-iommu driver, thus causing a 
> compilation error.
> 
> This patch fixes the error by removing respective include line from exynos-
> iommu.c.
> --->8
> 

Ok.

> Also a sentence explaining why linux/kernel.h header must be included would 
> be nice.
> 
> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Please note that as far as I'm aware of, tags should be made using western 
> name writing convention, i.e. starting with first name.
> 

Oh, I didn't think that the order of family/given names are the matter.
I don't care about changing the order.

Thanks.

KyongHo.

> Best regards,
> Tomasz
> 
> > ---
> >  drivers/iommu/exynos-iommu.c |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 3f32d64..233f382 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -12,6 +12,7 @@
> >  #define DEBUG
> >  #endif
> > 
> > +#include <linux/kernel.h>
> >  #include <linux/io.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> > @@ -29,8 +30,6 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/pgtable.h>
> > 
> > -#include <mach/sysmmu.h>
> > -
> >  /* We does not consider super section mapping (16MB) */
> >  #define SECT_ORDER 20
> >  #define LPAGE_ORDER 16
