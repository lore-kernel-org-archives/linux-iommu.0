From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Thu, 4 Dec 2014 12:43:29 +0000
Message-ID: <CACxGe6s2nfe5ezt58PGkyEsXPf8Y_B4ORcUna+XkyL8ysk_Agg@mail.gmail.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<3152553.esaQuZiCgi@wuerfel> <20141204102127.GF13224@arm.com>
	<5643715.BADzWxcqOQ@wuerfel>
	<CACxGe6v4ZVHHGcc3Lhp8+FgKakyCkJFRAT2ufj-3DGWa=wmGkA@mail.gmail.com>
	<20141204115254.GF14519@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141204115254.GF14519-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 4, 2014 at 11:52 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Thu, Dec 04, 2014 at 11:25:35AM +0000, Grant Likely wrote:
>> On Thu, Dec 4, 2014 at 11:19 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> > On Thursday 04 December 2014 10:21:27 Will Deacon wrote:
>> >> > > Sure, I'll add this to my list of stuff to do for 3.20.
>> >> >
>> >> > Does that mean the we don't get any of the patches for 3.19 despite the
>> >> > Acks?
>> >>
>> >> Hmm, I don't know how useful they are without the get/set ops and I don't
>> >> think I can get those ready for 3.19 given where we currently are.
>> >>
>> >> Grant's suggestion of adding an iommu_ops pointer to device_node would work
>> >> as a temporary hack, but anything more advanced is going to need proper
>> >> review.
>> >
>> > Right. I guess it doesn't hurt much if we put the new pointer inside
>> > #ifdef CONFIG_OF_IOMMU, then at least there is no significant size
>> > increase in most DT based platforms.
>>
>> Yes, I can live with that hack on the proviso that it will be removed by v3.20
>>
>> Oh, and please put an ugly /* */ comment block in the #ifdef
>> CONFIG_OF_IOMMU section that makes it really clear that it is an ugly
>> hack and will be removed in the next release. I don't want anyone
>> getting ideas that adding pointers to struct device_node is a good
>> idea.
>
> Something like the mess below?

Yes... Although it looks like Robin's patch does what is needed
without the hack.

g.

>
> Will
>
> --->8
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 29f0adc5f3e4..6f85c02bc1a6 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -43,6 +43,9 @@ struct property {
>  #if defined(CONFIG_SPARC)
>  struct of_irq_controller;
>  #endif
> +#ifdef CONFIG_OF_IOMMU
> +struct iommu_ops;
> +#endif
>
>  struct device_node {
>         const char *name;
> @@ -65,6 +68,19 @@ struct device_node {
>         unsigned int unique_id;
>         struct of_irq_controller *irq_trans;
>  #endif
> +#ifdef CONFIG_OF_IOMMU
> +/*
> + * HACK! HACK! HACK!
> + *
> + * This is a temporary hack to associate a device_node for an
> + * IOMMU with its set of iommu_ops so that we can probe its upstream DMA
> + * masters on the platform bus by parsing the "iommus" property directly.
> + *
> + * This is going away in 3.20. Please use the of_iommu_{get,set}_ops
> + * functions to get hold of this data.
> + */
> +       struct iommu_ops *__iommu_ops_use_accessors;
> +#endif
>  };
>
>  #define MAX_PHANDLE_ARGS 16
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index d03abbb11c34..392ec5f212db 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -14,6 +14,17 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>  extern void of_iommu_init(void);
>  extern struct iommu_ops *of_iommu_configure(struct device *dev);
>
> +static inline void of_iommu_set_ops(struct device_node *np,
> +                                   const struct iommu_ops *ops)
> +{
> +       np->__iommu_ops_use_accessors = ops;
> +}
> +
> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> +{
> +       return np->__iommu_ops_use_accessors;
> +}
> +
>  #else
>
>  static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> @@ -29,19 +40,15 @@ static inline struct iommu_ops *of_iommu_configure(struct device *dev)
>         return NULL;
>  }
>
> -#endif /* CONFIG_OF_IOMMU */
> -
>  static inline void of_iommu_set_ops(struct device_node *np,
> -                                   const struct iommu_ops *ops)
> -{
> -       np->data = (struct iommu_ops *)ops;
> -}
> -
> +                                   const struct iommu_ops *ops) { }
>  static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>  {
> -       return np->data;
> +       return NULL;
>  }
>
> +#endif /* CONFIG_OF_IOMMU */
> +
>  extern struct of_device_id __iommu_of_table;
>
>  typedef int (*of_iommu_init_fn)(struct device_node *);
