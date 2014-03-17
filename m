From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 01/27] iommu/exynos: do not include removed header
Date: Mon, 17 Mar 2014 09:26:46 +0900
Message-ID: <20140317092646.b696d2245fb95ea8835cbd2e@samsung.com>
References: <20140314140129.68a41cc1bd9e0a48a198ca13@samsung.com>
	<CAK9yfHzRasE3jroDUZgAa=DN5N=2ZDAxgNiHDCip+f2868BAVQ@mail.gmail.com>
	<000e01cf3f7b$6edcdfd0$4c969f70$@samsung.com>
	<CAK9yfHyGfdP+0RKtdSCdU4tO=PX8GbQRQ7ar=ST5B2RenZMMsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CAK9yfHyGfdP+0RKtdSCdU4tO=PX8GbQRQ7ar=ST5B2RenZMMsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 14 Mar 2014 17:29:36 +0530, Sachin Kamat wrote:
> On 14 March 2014 17:19, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> >> From: Sachin Kamat [mailto:sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
> >> Sent: Friday, March 14, 2014 7:00 PM
> >>
> >> On 14 March 2014 10:31, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> >> > Commit 25e9d28d92 (ARM: EXYNOS: remove system mmu initialization from
> >> > exynos tree) removed arch/arm/mach-exynos/mach/sysmmu.h header without
> >> > removing remaining use of it from exynos-iommu driver, thus causing a
> >> > compilation error.
> >> >
> >> > This patch fixes the error by removing respective include line
> >> > from exynos-iommu.c.
> >> >
> >> > CC: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> > ---
> >> >  drivers/iommu/exynos-iommu.c |    3 +--
> >> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> >> > index 0740189..4876d35 100644
> >> > --- a/drivers/iommu/exynos-iommu.c
> >> > +++ b/drivers/iommu/exynos-iommu.c
> >> > @@ -12,6 +12,7 @@
> >> >  #define DEBUG
> >> >  #endif
> >> >
> >> > +#include <linux/kernel.h>
> >>
> >> This change doesn't look related to the patch subject/description.
> >>
> > Yes. But it is simply added without any side-effect.
> > Do you think it should be in a separate patch?.
> > Actually, the added line is a redundant.
> 
> If it is redundant, then you shouldn't be adding it. If it is
> required, then please
> mention about the need in the commit description if not a separate patch.
> 

Ok.

Thanks for the advice.

KyongHo
