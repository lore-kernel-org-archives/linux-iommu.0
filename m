From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv6+ 01/13] of: introduce of_property_for_earch_phandle_with_args()
Date: Wed, 11 Dec 2013 13:28:45 +0000
Message-ID: <20131211132845.5461FC4061A@trevor.secretlab.ca>
References: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>< 1385041249-7705-2-git-send-email-hdoyu@nvidia.com> <20131121.191720. 1487772262083864095.hdoyu@nvidia.com> <528E577C.2050506@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528E577C.2050506-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 21 Nov 2013 11:57:00 -0700, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 11/21/2013 10:17 AM, Hiroshi Doyu wrote:
> > Iterating over a property containing a list of phandles with arguments
> > is a common operation for device drivers. This patch adds a new
> > of_property_for_each_phandle_with_args() macro to make the iteration
> > simpler.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > v6+:
> > Use the description, which Grant Likely proposed, to be full enough
> > that a future reader can figure out why a patch was written.
> >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007062.html
> 
> This new version only addresses one of the concerns that Grant had,
> namely the commit message.
> 
> > diff --git a/include/linux/of.h b/include/linux/of.h
> 
> > +#define of_property_for_each_phandle_with_args(np, list, cells, i, args) \
> > +	for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
> > +
> 
> Grant also wanted the actual implementation fixed so that it wasn't so
> inefficient.
> 
> What this current patch does is basically:
> 
> for every entry in the property:
>     for every entry in the property before the current index:
>         parse the phandle+specifier
> 
> That's roughly O(n^2). (n is # entries in the property)
> 
> Instead, what should happen is:
> 
> for every entry in the property:
>     parse the phandle+specifier
>     yield the result
> 
> That's roughly O(n).
> 
> In other words, an implementation more along the lines of
> include/linux/of.h's:
> 
> #define of_property_for_each_u32(np, propname, prop, p, u)      \
>         for (prop = of_find_property(np, propname, NULL),       \
>                 p = of_prop_next_u32(prop, NULL, &u);           \
>                 p;                                              \
>                 p = of_prop_next_u32(prop, p, &u))
> 
> ... so you'd need functions like of_prop_first_specifier() and
> of_prop_next_specifier(), and perhaps some associated set of state
> variables, perhaps with all the state wrapped into a single struct for
> simplicity.

That's right, I forgot I said that. Yes please fix the implementation.

g.
