From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv6+ 01/13] of: introduce
	of_property_for_earch_phandle_with_args()
Date: Sat, 14 Dec 2013 16:51:15 +0100
Message-ID: <20131214.175115.1251935659998248370.hdoyu@nvidia.com>
References: <20131211.153338.2186623380643957232.hdoyu@nvidia.com><20131212113417.BDCD0C40637@trevor.secretlab.ca><20131212.141404.684884000513445038.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131212.141404.684884000513445038.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Thu, 12 Dec 2013 14:14:04 +0200 (EET):

> > > From 8f7c0404aa68f0e8dbe0babc240590f6528ecc1f Mon Sep 17 00:00:00 2001
> > > From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > Date: Fri, 15 Nov 2013 10:52:53 +0200
> > > Subject: [PATCH] of: introduce of_property_for_each_phandle_with_args()
> > >
> > > Iterating over a property containing a list of phandles with arguments
> > > is a common operation for device drivers. This patch adds a new
> > > of_property_for_each_phandle_with_args() macro to make the iteration
> > > simpler.
> > >
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
....
> > > ---
> > >  drivers/of/base.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of.h | 32 ++++++++++++++++++++++++++++++++
> > >  2 files changed, 78 insertions(+)
> > >
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index f807d0e..cd4ab05 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -1201,6 +1201,52 @@ void of_print_phandle_args(const char *msg, const struct of_phandle_args *args)
> > >       printk("\n");
> > >  }
> > >
> > > +const __be32 *of_phandle_iter_next(const char *cells_name, int cell_count,
> > > +                                const __be32 *cur, const __be32 *end,
> > > +                                struct of_phandle_args *out_args)
> > 
> > Having to pass in cells_name, cell_count, cur and end each time seems a
> > little odd. Can a state structure be used instead?
> > 
> > struct of_phandle_iter_state {
> >         const char *cells_name;
> >         int cells_count;
> >         const __be32 *cur;
> >         const __be32 *end;
> >         struct of_phandle_args out_args;
> > }
> > 
> > Make the caller provide one of those and fill it in with the init
> > function.
> 
> I rewrote this a few times and so now I have a few version of this
> implementations :-) The above proposal is similar to the version v6+++
> mentioned in the above patch note:
> 
> > > v6+++:
> > > Introduced a new struct "of_phandle_iter" to keep the state when
> > > iterating over the list.
> 
> which is:
> 
>   [RFC][PATCHv6+++ 01/13] of: introduce of_property_for_earch_phandle_with_args()
>     http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007087.html
> 
> Stephen seemed to prefer the version without state struct. I like the
> idea to not pass the same arguments repeatly. Instead, wrapping them
> in a struct with state may look better.
> 
> So if Stephen agrees, I'll rewrite the version with state struct
> again.

Stephen, let me know what you think.
