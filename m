From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Don't register as BUS IOMMU if
	machine doesn't have IPMMU-VMSA
Date: Mon, 27 Aug 2018 16:20:26 +0200
Message-ID: <CAMuHMdXdpnezLAB=ksrETYY1GxbWZBxBaea4n+E4wjSh1ntdmw@mail.gmail.com>
References: <20180726211916.10264-1-digetx@gmail.com>
	<2725801.tsBI9ZhLPt@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2725801.tsBI9ZhLPt@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Fri, Jul 27, 2018 at 11:09 AM Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> (CC'ing Geert and Magnus)
>
> Thank you for the patch.
>
> On Friday, 27 July 2018 00:19:16 EEST Dmitry Osipenko wrote:
> > This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
> > a multiplatform configuration and IPMMU-VMSA driver is enabled.
> >
> > Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.20+
> > Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 9e8495762bc8..78c50db9cd71 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -1109,12 +1109,19 @@ static struct platform_driver ipmmu_driver = {
> >
> >  static int __init ipmmu_init(void)
> >  {
> > +     struct device_node *np;
> >       static bool setup_done;
> >       int ret;
> >
> >       if (setup_done)
> >               return 0;
> >
> > +     np = of_find_matching_node(NULL, ipmmu_of_ids);
> > +     if (!np)
> > +             return 0;
> > +
> > +     of_node_put(np);
> > +
>
> While functionally correct, this will add some unnecessary overhead when
> iommu_init() is called from IOMMU_OF_DECLARE(). I'm OK with this fix as a
> temporary measure to solve your problem, but we need to address the underlying
> issue properly.
>
> Geert, Magnus, the ipmmu-vmsa driver is a bit of a mess. We should brush it up
> and start using IOMMU_OF_DECLARE() on all platforms (and eventually get rid of
> bus_set_iommu() completely...). Do you have plans to address this ? If not,
> could you please add it to your to-do list ?

On the contrary: IOMMU_OF_DECLARE() has been removed.

>
> >       ret = platform_driver_register(&ipmmu_driver);
> >       if (ret < 0)
> >               return ret;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
