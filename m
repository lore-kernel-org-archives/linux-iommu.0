From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] of: Implement iterator for phandles
Date: Fri, 18 Mar 2016 10:54:57 -0500
Message-ID: <CAL_JsqKjaB_YK3JY053BvcDpfr5pMg4-f53L4QYupuP=kQsLuw@mail.gmail.com>
References: <1458146527-1133-1-git-send-email-joro@8bytes.org> <1458146527-1133-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458146527-1133-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 16, 2016 at 11:42 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> Getting the arguments of phandles is somewhat limited at the
> moement, because the number of arguments supported by core
> code is limited to MAX_PHANDLE_ARGS, which is set to 16
> currently.
>
> In case of the arm smmu this is not enough, as the 128
> supported stream-ids are encoded in device-tree with
> arguments to phandles. On some systems with more than 16
> stream-ids this causes a WARN_ON being triggered at boot and
> an incomplete initialization of the smmu.
>
> This patch-set implements an iterator interface over
> phandles which allows to parse out arbitrary numbers of
> arguments per phandle. The existing function for parsing
> them, __of_parse_phandle_with_args(), is converted to make
> use of the iterator.

This mostly looks fine to me, but it is kind of a lot of functions
just for this one thing. For example, I think the caller can track the
index themselves if they care about it. I'd also like to see a more
standard style for_each type iterator define rather than open coded
while loops.

Some minor style comments below.

> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/of/base.c  | 219 ++++++++++++++++++++++++++++++-----------------------
>  include/linux/of.h |  95 +++++++++++++++++++++++
>  2 files changed, 220 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 017dd94..9a5f199 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1439,119 +1439,150 @@ void of_print_phandle_args(const char *msg, const struct of_phandle_args *args)
>         printk("\n");
>  }
>
> -static int __of_parse_phandle_with_args(const struct device_node *np,
> -                                       const char *list_name,
> -                                       const char *cells_name,
> -                                       int cell_count, int index,
> -                                       struct of_phandle_args *out_args)
> +int of_phandle_iterator_init(struct of_phandle_iterator *it,
> +                            const struct device_node *np,
> +                            const char *list_name,
> +                            const char *cells_name,
> +                            int cell_count)
>  {
> -       const __be32 *list, *list_end;
> -       int rc = 0, size, cur_index = 0;
> -       uint32_t count = 0;
> -       struct device_node *node = NULL;
> -       phandle phandle;
> +       const __be32 *list;
> +       int size;
>
>         /* Retrieve the phandle list property */
>         list = of_get_property(np, list_name, &size);
>         if (!list)
>                 return -ENOENT;
> -       list_end = list + size / sizeof(*list);
>
> -       /* Loop over the phandles until all the requested entry is found */
> -       while (list < list_end) {
> -               rc = -EINVAL;
> -               count = 0;
> +       it->np          = np;
> +       it->node        = NULL;
> +       it->list        = list;
> +       it->phandle_end = list;
> +       it->list_end    = list + size / sizeof(*list);
> +       it->cells_name  = cells_name;
> +       it->cell_count  = cell_count;
> +       it->cur_index   = -1;
>
> -               /*
> -                * If phandle is 0, then it is an empty entry with no
> -                * arguments.  Skip forward to the next entry.
> -                */
> -               phandle = be32_to_cpup(list++);
> -               if (phandle) {
> -                       /*
> -                        * Find the provider node and parse the #*-cells
> -                        * property to determine the argument length.
> -                        *
> -                        * This is not needed if the cell count is hard-coded
> -                        * (i.e. cells_name not set, but cell_count is set),
> -                        * except when we're going to return the found node
> -                        * below.
> -                        */
> -                       if (cells_name || cur_index == index) {
> -                               node = of_find_node_by_phandle(phandle);
> -                               if (!node) {
> -                                       pr_err("%s: could not find phandle\n",
> -                                               np->full_name);
> -                                       goto err;
> -                               }
> -                       }
> +       return 0;
> +}
>
> -                       if (cells_name) {
> -                               if (of_property_read_u32(node, cells_name,
> -                                                        &count)) {
> -                                       pr_err("%s: could not get %s for %s\n",
> -                                               np->full_name, cells_name,
> -                                               node->full_name);
> -                                       goto err;
> -                               }
> -                       } else {
> -                               count = cell_count;
> -                       }
> +int of_phandle_iterator_next(struct of_phandle_iterator *it)
> +{
> +       phandle phandle = 0;
> +       uint32_t count = 0;
>
> -                       /*
> -                        * Make sure that the arguments actually fit in the
> -                        * remaining property data length
> -                        */
> -                       if (list + count > list_end) {
> -                               pr_err("%s: arguments longer than property\n",
> -                                        np->full_name);
> -                               goto err;
> -                       }
> +       if (it->phandle_end >= it->list_end)
> +               return -ENOENT;
> +
> +       if (it->node) {
> +               of_node_put(it->node);
> +               it->node = NULL;
> +       }
> +
> +       it->list         = it->phandle_end;
> +       it->cur_index   += 1;

it->cur_index++;

> +       phandle          = be32_to_cpup(it->list++);

Please, just <space>=<space>.

> +
> +       if (phandle) {
> +               if (it->cells_name) {
> +                       it->node = of_find_node_by_phandle(phandle);
> +                       if (!it->node)
> +                               goto no_node;

All these goto's are pretty pointless and can just be printk and return.

> +
> +                       if (of_property_read_u32(it->node,
> +                                                it->cells_name,
> +                                                &count))
> +                               goto no_property;
> +               } else {
> +                       count = it->cell_count;
>                 }
>
> -               /*
> -                * All of the error cases above bail out of the loop, so at
> -                * this point, the parsing is successful. If the requested
> -                * index matches, then fill the out_args structure and return,
> -                * or return -ENOENT for an empty entry.
> -                */
> +               if (it->list + count > it->list_end)
> +                       goto too_many_args;
> +       }
> +
> +       it->phandle_end = it->list + count;
> +       it->cur_count   = count;
> +       it->phandle     = phandle;

single space.

> +
> +       return 0;
> +
> +no_node:
> +       pr_err("%s: could not find phandle\n", it->np->full_name);
> +
> +       return -EINVAL;
> +
> +no_property:
> +       pr_err("%s: could not get %s for %s\n", it->np->full_name,
> +              it->cells_name, it->node->full_name);
> +
> +       return -EINVAL;
> +
> +too_many_args:
> +       pr_err("%s: arguments longer than property\n", it->np->full_name);
> +
> +       return -EINVAL;
> +}
> +
> +int of_phandle_iterator_args(struct of_phandle_iterator *it,
> +                            uint32_t *args,
> +                            int size)
> +{
> +       int i, count;
> +
> +       count = it->cur_count;
> +
> +       if (WARN_ON(size < count))
> +               count = size;
> +
> +       for (i = 0; i < count; i++)
> +               args[i] = be32_to_cpup(it->list++);
> +
> +       return count;
> +}
> +
> +static int __of_parse_phandle_with_args(const struct device_node *np,
> +                                       const char *list_name,
> +                                       const char *cells_name,
> +                                       int cell_count, int index,
> +                                       struct of_phandle_args *out_args)
> +{
> +       struct of_phandle_iterator it;
> +       int rc;
> +
> +       rc = of_phandle_iterator_init(&it, np, list_name,
> +                                     cells_name, cell_count);
> +       if (rc)
> +               return rc;
> +
> +       while ((rc = of_phandle_iterator_next(&it)) == 0) {
> +               uint32_t count;
> +               int cur_index;
> +
> +               count     = of_phandle_iterator_count(&it);
> +               cur_index = of_phandle_iterator_index(&it);
> +
>                 rc = -ENOENT;
>                 if (cur_index == index) {
> -                       if (!phandle)
> -                               goto err;
> -
> -                       if (out_args) {
> -                               int i;
> -                               if (WARN_ON(count > MAX_PHANDLE_ARGS))
> -                                       count = MAX_PHANDLE_ARGS;
> -                               out_args->np = node;
> -                               out_args->args_count = count;
> -                               for (i = 0; i < count; i++)
> -                                       out_args->args[i] = be32_to_cpup(list++);
> -                       } else {
> -                               of_node_put(node);
> -                       }
> +                       if (!of_phandle_iterator_phandle(&it))
> +                               break;
> +
> +                       rc = 0;
>
>                         /* Found it! return success */
> -                       return 0;
> -               }
> +                       if (!out_args)
> +                               break;
>
> -               of_node_put(node);
> -               node = NULL;
> -               list += count;
> -               cur_index++;
> +                       out_args->np         = of_phandle_iterator_node(&it);
> +                       out_args->args_count = of_phandle_iterator_args(&it,
> +                                                                       out_args->args,
> +                                                                       MAX_PHANDLE_ARGS);
> +
> +                       break;
> +               }
>         }
>
> -       /*
> -        * Unlock node before returning result; will be one of:
> -        * -ENOENT : index is for empty phandle
> -        * -EINVAL : parsing error on data
> -        * [1..n]  : Number of phandle (count mode; when index = -1)
> -        */
> -       rc = index < 0 ? cur_index : -ENOENT;
> - err:
> -       if (node)
> -               of_node_put(node);
> +       of_phandle_iterator_destroy(&it);
> +
>         return rc;
>  }
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index dc6e396..31e6ee9 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -75,6 +75,19 @@ struct of_phandle_args {
>         uint32_t args[MAX_PHANDLE_ARGS];
>  };
>
> +struct of_phandle_iterator {
> +       const struct device_node *np;
> +       const __be32 *list;
> +       const __be32 *list_end;
> +       const __be32 *phandle_end;
> +       phandle phandle;
> +       struct device_node *node;

np and node? If you need both, name them based on what they point to.

> +       const char *cells_name;
> +       int cell_count;
> +       int cur_index;
> +       uint32_t cur_count;
> +};
> +
>  struct of_reconfig_data {
>         struct device_node      *dn;
>         struct property         *prop;
> @@ -334,6 +347,50 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
>  extern int of_count_phandle_with_args(const struct device_node *np,
>         const char *list_name, const char *cells_name);
>
> +/* phandle iterator functions */
> +extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
> +                                   const struct device_node *np,
> +                                   const char *list_name,
> +                                   const char *cells_name,
> +                                   int cell_count);
> +
> +static inline void of_phandle_iterator_destroy(struct of_phandle_iterator *it)
> +{
> +       if (it->node)
> +               of_node_put(it->node);
> +}
> +
> +extern int of_phandle_iterator_next(struct of_phandle_iterator *it);
> +
> +static inline int of_phandle_iterator_index(const struct of_phandle_iterator *it)
> +{
> +       return it->cur_index;
> +}
> +
> +static inline uint32_t of_phandle_iterator_count(const struct of_phandle_iterator *it)
> +{
> +       return it->cur_count;
> +}
> +
> +static inline uint32_t of_phandle_iterator_phandle(const struct of_phandle_iterator *it)
> +{
> +       return it->phandle;
> +}
> +
> +static inline struct device_node *of_phandle_iterator_node(struct of_phandle_iterator *it)
> +{
> +       if (!it->node)
> +               it->node = of_find_node_by_phandle(it->phandle);
> +
> +       if (it->node)
> +               of_node_get(it->node);

The above function may have already done the get. Not sure offhand.

> +
> +       return it->node;
> +}
> +
> +extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
> +                                   uint32_t *args,
> +                                   int size);
>  extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
>  extern int of_alias_get_id(struct device_node *np, const char *stem);
>  extern int of_alias_get_highest_id(const char *stem);
> @@ -608,6 +665,44 @@ static inline int of_count_phandle_with_args(struct device_node *np,
>         return -ENOSYS;
>  }
>
> +static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
> +                                          const struct device_node *np,
> +                                          const char *list_name,
> +                                          const char *cells_name,
> +                                          int cell_count)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline void of_phandle_iterator_destroy(struct of_phandle_iterator *it)
> +{
> +}
> +
> +static inline int of_phandle_iterator_next(struct of_phandle_iterator *it)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int of_phandle_iterator_index(const struct of_phandle_iterator *it)
> +{
> +       return -1;
> +}
> +
> +static inline uint32_t of_phandle_iterator_count(const struct of_phandle_iterator *it)
> +{
> +       return 0;
> +}
> +
> +static inline uint32_t of_phandle_iterator_phandle(const struct of_phandle_iterator *it)
> +{
> +       return 0;
> +}
> +
> +static inline struct device_node *of_phandle_iterator_node(struct of_phandle_iterator *it)
> +{
> +       return NULL;
> +}
> +
>  static inline int of_alias_get_id(struct device_node *np, const char *stem)
>  {
>         return -ENOSYS;
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
