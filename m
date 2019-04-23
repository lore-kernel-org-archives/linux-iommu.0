From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Date: Tue, 23 Apr 2019 17:01:42 +0200
Message-ID: <CAMuHMdUXK_TKJuWwuJ0XCPNK-gQo1bY4OPGB674hH3nTc2hTxg@mail.gmail.com>
References: <20190403182148.18058-1-geert+renesas@glider.be>
	<20190403182148.18058-2-geert+renesas@glider.be>
	<20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
	<20190411081214.pgdztqdlud5ta466@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190411081214.pgdztqdlud5ta466-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

On Thu, Apr 11, 2019 at 10:12 AM Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Thu, Apr 11, 2019 at 10:10:28AM +0200, Simon Horman wrote:
> > On Wed, Apr 03, 2019 at 08:21:43PM +0200, Geert Uytterhoeven wrote:
> > > As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> > > iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> > > /sys/class/iommus/, but their "devices" subdirectories are empty.
> >
> > Should the path be /sys/class/iommu/ (no trailing 's') ?

Yes it does, thanks. Will fix.

> > > Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> > >
> > > Make sure all links are created, on both arm32 and arm64.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > > ---
> > > v2:
> > >   - Add Reviewed-by.
> > > ---
> > >  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > > index 9a380c10655e182d..9f2b781e20a0eba6 100644
> > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
> > >
> > >  static int ipmmu_add_device(struct device *dev)
> > >  {
> > > +   struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> > >     struct iommu_group *group;
> > > +   int ret;
> > >
> > >     /*
> > >      * Only let through devices that have been verified in xlate()
> > >      */
> > > -   if (!to_ipmmu(dev))
> > > +   if (!mmu)
> > >             return -ENODEV;
> > >
> > > -   if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> > > -           return ipmmu_init_arm_mapping(dev);
> > > +   if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> > > +           ret = ipmmu_init_arm_mapping(dev);
> > > +           if (ret)
> > > +                   return ret;
> > > +   } else {
> > > +           group = iommu_group_get_for_dev(dev);
> > > +           if (IS_ERR(group))
> > > +                   return PTR_ERR(group);
> > >
> > > -   group = iommu_group_get_for_dev(dev);
> > > -   if (IS_ERR(group))
> > > -           return PTR_ERR(group);
> > > +           iommu_group_put(group);
> > > +   }
> > >
> > > -   iommu_group_put(group);
> > > +   iommu_device_link(&mmu->iommu, dev);
>
> Also, is there any value in propagating the return value
> of iommu_device_link() ?

I don't think so.  Sysfs information is not super-critical, and most
drivers just
ignore such return values.  Also, the sysfs cleanup code handles cleanup
after failed setup fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
