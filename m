From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC][PATCHv6+++ 01/13] of: introduce of_property_for_earch_phandle_with_args()
Date: Sun, 01 Dec 2013 12:00:09 -0700
Message-ID: <529B8739.60701@wwwdotorg.org>
References: <20131121.191720.1487772262083864095.hdoyu@nvidia.com><528E577C.2050506@wwwdotorg.org><20131128.145818.1345100874304396564.hdoyu@nvidia.com> <20131129.134625.431945240074254704.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131129.134625.431945240074254704.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/29/2013 04:46 AM, Hiroshi Doyu wrote:
...
> Iterating over a property containing a list of phandles with arguments
> is a common operation for device drivers. This patch adds a new
> of_property_for_each_phandle_with_args() macro to make the iteration
> simpler.
> 
> Introduced a new struct "of_phandle_iter" to keep the state when
> iterating over the list.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v6+++:

Surely that's v9; "+++" is rather unusual.

> diff --git a/drivers/of/base.c b/drivers/of/base.c

> +void of_phandle_iter_next(struct of_phandle_iter *iter,
> +			  struct of_phandle_args *out_args)
> +{
> +	phandle phandle;
> +	struct device_node *dn;
> +	int i, count = iter->cell_count;
> +
> +	iter->err = -EINVAL;
> +	if (!iter->cells_name && !iter->cell_count)
> +		return;

Wasn't that already checked in _start()?

Why not set err = -EINVAL inside the if, rather than setting it to an
error value here by default, then having to over-write it at the end of
the function?

> +static void __of_phandle_iter_set(struct of_phandle_iter *iter,

This is only used in one place; why not simply inline this into
of_phandle_iter_start()? It would make the code simpler.

> +void of_phandle_iter_start(struct of_phandle_iter *iter,

> +	iter->cells_name = cells_name;
> +	iter->cell_count = cell_count;

Why not pass these values into of_phandle_iter_next() instead? There's
no need to pass them just to _start() so they can be read by _next()
instead.

> diff --git a/include/linux/of.h b/include/linux/of.h

> +/*
> + * keep the state at iterating a list of phandles with variable number
> + * of args
> + */
> +struct of_phandle_iter {
> +	int		err;
> +	const __be32	*cur;		/* current phandle */
> +	const __be32	*end;		/* end of the last phandle */

Can't you detect an error case by e.g. (cur == NULL) and thus avoid
requiring an explicit err field?

Together with removing:

> +	const char	*cells_name;
> +	int		cell_count;

... then you'd only be left with cur/end, so I think you could get away
without a struct at all, but simply "cur" as the iterator variable, plus
"end" as the one temp variable.
