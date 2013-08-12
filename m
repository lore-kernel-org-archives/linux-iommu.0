From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 04/16] iommu/exynos: allocate lv2 page table from own
	slab
Date: Mon, 12 Aug 2013 10:59:57 +0900
Message-ID: <20130812105957.918cc24dc835034365525cbc@samsung.com>
References: <002801ce941a$fb6369e0$f22a3da0$@samsung.com>
	<2101296.S6JDU5igl3@flatron>
	<20130809175156.c7ffc68b865e4bca48ef47dd@samsung.com>
	<12183506.4f14O99EfL@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <12183506.4f14O99EfL@amdc1227>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 09 Aug 2013 11:35:20 +0200, Tomasz Figa wrote:
> On Friday 09 of August 2013 17:51:56 Cho KyongHo wrote:
> > On Fri, 09 Aug 2013 09:55:30 +0200, Tomasz Figa wrote:
> > > Hi KyongHo,
> > > 
> > > On Friday 09 of August 2013 14:58:49 Cho KyongHo wrote:
> > > > On Thu, 08 Aug 2013 16:00:18 +0200, Tomasz Figa wrote:
> > > > > On Thursday 08 of August 2013 18:38:04 Cho KyongHo wrote:
> > > > > > Since kmalloc() does not guarantee that the allignment of 1KiB
> > > > > > when
> > > > > > it
> > > > > > allocates 1KiB, it is required to allocate lv2 page table from
> > > > > > own
> > > > > > slab that guarantees alignment of 1KiB
> > > > > > 
> > > > > > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > > > > ---
> > > > > > 
> > > > > >  drivers/iommu/exynos-iommu.c |   24 ++++++++++++++++++++----
> > > > > >  1 files changed, 20 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/exynos-iommu.c
> > > > > > b/drivers/iommu/exynos-iommu.c index d90e6fa..a318049 100644
> > > > > > --- a/drivers/iommu/exynos-iommu.c
> > > > > > +++ b/drivers/iommu/exynos-iommu.c
> > > > > > @@ -100,6 +100,8 @@
> > > > > > 
> > > > > >  #define REG_PB1_SADDR		0x054
> > > > > >  #define REG_PB1_EADDR		0x058
> > > > > > 
> > > > > > +static struct kmem_cache *lv2table_kmem_cache;
> > > > > > +
> > > > > > 
> > > > > >  static unsigned long *section_entry(unsigned long *pgtable,
> > > > > >  unsigned
> > > > > > 
> > > > > > long iova) {
> > > > > > 
> > > > > >  	return pgtable + lv1ent_offset(iova);
> > > > > > 
> > > > > > @@ -765,7 +767,8 @@ static void
> > > > > > exynos_iommu_domain_destroy(struct
> > > > > > iommu_domain *domain)
> > > > > > 
> > > > > >  	for (i = 0; i < NUM_LV1ENTRIES; i++)
> > > > > >  	
> > > > > >  		if (lv1ent_page(priv->pgtable + i))
> > > > > > 
> > > > > > -			kfree(__va(lv2table_base(priv->pgtable + i)));
> > > > > > +			kmem_cache_free(lv2table_kmem_cache,
> > > > > > +					__va(lv2table_base(priv->pgtable +
> > > 
> > > i)));
> > > 
> > > > > >  	free_pages((unsigned long)priv->pgtable, 2);
> > > > > >  	free_pages((unsigned long)priv->lv2entcnt, 1);
> > > > > > 
> > > > > > @@ -861,7 +864,7 @@ static unsigned long *alloc_lv2entry(unsigned
> > > > > > long
> > > > > > *sent, unsigned long iova, if (lv1ent_fault(sent)) {
> > > > > > 
> > > > > >  		unsigned long *pent;
> > > > > > 
> > > > > > -		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
> > > > > > +		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
> > > > > > 
> > > > > >  		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
> > > > > >  		if (!pent)
> > > > > >  		
> > > > > >  			return ERR_PTR(-ENOMEM);
> > > > > > 
> > > > > > @@ -881,7 +884,7 @@ static int lv1set_section(unsigned long
> > > > > > *sent,
> > > > > > phys_addr_t paddr, short *pgcnt)
> > > > > > 
> > > > > >  	if (lv1ent_page(sent)) {
> > > > > >  	
> > > > > >  		BUG_ON(*pgcnt != NUM_LV2ENTRIES);
> > > > > > 
> > > > > > -		kfree(page_entry(sent, 0));
> > > > > > +		kmem_cache_free(lv2table_kmem_cache, page_entry(sent, 0));
> > > > > > 
> > > > > >  		*pgcnt = 0;
> > > > > >  	
> > > > > >  	}
> > > > > > 
> > > > > > @@ -1082,10 +1085,23 @@ static int __init exynos_iommu_init(void)
> > > > > > 
> > > > > >  {
> > > > > >  
> > > > > >  	int ret;
> > > > > > 
> > > > > > +	lv2table_kmem_cache =
> > > > > > kmem_cache_create("exynos-iommu-lv2table",
> > > > > > +				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
> > > > > > +	if (!lv2table_kmem_cache) {
> > > > > > +		pr_err("%s: Failed to create kmem cache\n", __func__);
> > > > > > +		return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > > 
> > > > > >  	ret = platform_driver_register(&exynos_sysmmu_driver);
> > > > > >  	
> > > > > >  	if (ret == 0)
> > > > > > 
> > > > > > -		bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
> > > > > > +		ret = bus_set_iommu(&platform_bus_type,
> > > 
> > > &exynos_iommu_ops);
> > > 
> > > > > > +
> > > > > > +	if (ret) {
> > > > > > +		pr_err("%s: Failed to register exynos-iommu driver.\n",
> > > > > > +								__func__);
> > > > > > +		kmem_cache_destroy(lv2table_kmem_cache);
> > > > > > +	}
> > > > > 
> > > > > What about making the return value handling here cleaner? For 
> example:
> > > > > 	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
> > > > > 	
> > > > > 				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
> > > > > 	
> > > > > 	if (!lv2table_kmem_cache) {
> > > > > 	
> > > > > 		...
> > > > > 		return -ENOMEM;
> > > > > 	
> > > > > 	}
> > > > > 	
> > > > > 	ret = platform_driver_register(&exynos_sysmmu_driver);
> > > > > 	if (ret) {
> > > > > 	
> > > > > 		...
> > > > > 		goto err_destroy_kmem_cache;
> > > > > 	
> > > > > 	}
> > > > > 	
> > > > > 	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
> > > > > 	if (ret) {
> > > > > 	
> > > > > 		...
> > > > > 		goto err_platform_unregister;
> > > > > 	
> > > > > 	}
> > > > > 	
> > > > > 	return 0;
> > > > > 
> > > > > err_platform_unregister:
> > > > > 	...
> > > > > 
> > > > > err_destroy_kmem_cache:
> > > > > 	...
> > > > > 	return ret;
> > > > > 
> > > > > }
> > > > 
> > > > Thank you for suggestion.
> > > > I think you are worrying about missing the information who makes
> > > > 'ret'
> > > > non-zero.
> > > 
> > > Oh, this is a valid point, but it was more a nitpick about the coding
> > > style. Single path error handling (with goto) is widely used in the
> > > kernel in cases when more than one thing has to be undone and so I
> > > suggested this method of error handling here as well.
> > > 
> > > > Ok. I will process it separately.
> > > 
> > > Since this patch adds most of the error handling to this function, I
> > > think it should be fine to do it as a part of this patch.
> > 
> > I meant 'separately' that checking all return values each.
> > I think it can be simpler without goto.
> >
> > There are just 2 cases to rollback previous changes in that function.
> 
> It might end up with less lines, but having roll back in single place is 
> more readable. That's why it's the preferred error handling way in Linux 
> kernel, if you have more than one action to undo on your error path.
> 

I fully understand what you are concerning about and I also agree.
Actually it is simple choice without any side effect.
It is just a preference.
I will change it into 'goto'.
Then we can determine what looks better :) 

Thank you.

KyongHo.

> Best regards,
> Tomasz
> 
