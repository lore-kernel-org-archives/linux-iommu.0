From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH v7 3/9] iommu/exynos: fix page table maintenance
Date: Mon, 15 Jul 2013 20:21:56 +0900
Message-ID: <009a01ce814d$840b48c0$8c21da40$@samsung.com>
References: <002b01ce797b$44d4ad10$ce7e0730$@samsung.com>
 <1933986.4vddYccClk@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1933986.4vddYccClk@amdc1032>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>
Cc: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Grant Grundler' <grundler@chromium.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Bartlomiej Zolnierkiewicz [mailto:b.zolnierkie@samsung.com]
> Sent: Friday, July 12, 2013 2:38 AM
> 
> Hi,
> 
> Some minor nitpicks below.
> 
> On Friday, July 05, 2013 09:29:18 PM Cho KyongHo wrote:
> > This prevents allocating lv2 page table for the lv1 page table entry
> > that already has 1MB page mapping. In addition some BUG_ON() is
> > changed to WARN_ON().
> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >  drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++++++--------
> >  1 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index e3be3e5..2bfe9fa 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -862,12 +862,14 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
> >  		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
> >  		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
> >  		if (!pent)
> > -			return NULL;
> > +			return ERR_PTR(-ENOMEM);
> >
> >  		*sent = mk_lv1ent_page(__pa(pent));
> >  		*pgcounter = NUM_LV2ENTRIES;
> >  		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
> >  		pgtable_flush(sent, sent + 1);
> > +	} else if (lv1ent_section(sent)) {
> > +		return ERR_PTR(-EADDRINUSE);
> >  	}
> >
> >  	return page_entry(sent, iova);
> > @@ -944,16 +946,16 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		pent = alloc_lv2entry(entry, iova,
> >  					&priv->lv2entcnt[lv1ent_offset(iova)]);
> >
> > -		if (!pent)
> > -			ret = -ENOMEM;
> > +		if (IS_ERR(pent))
> > +			ret = PTR_ERR(pent);
> >  		else
> >  			ret = lv2set_page(pent, paddr, size,
> >  					&priv->lv2entcnt[lv1ent_offset(iova)]);
> >  	}
> >
> >  	if (ret) {
> > -		pr_debug("%s: Failed to map iova 0x%lx/0x%x bytes\n",
> > -							__func__, iova, size);
> > +		pr_err("%s: Failed(%d) to map iova 0x%#x bytes @ %#lx\n",
> > +						__func__, ret, size, iova);
> >  	}
> 
> Intendation is a bit weird, it should be more like:
> 
> 		pr_err("%s: Failed(%d) to map iova 0x%#x bytes @ %#lx\n",
> 			__func__, ret, size, iova);
> 
> to be consistent with the rest of the driver.
> 
> You could have also removed superfluous braces while at it.
> 

Do you think it is better to read the code?
Hmm, I think it is better too.
Thanks.

> >  	spin_unlock_irqrestore(&priv->pgtablelock, flags);
> > @@ -968,6 +970,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> >  	struct sysmmu_drvdata *data;
> >  	unsigned long flags;
> >  	unsigned long *ent;
> > +	size_t err_page;
> >
> >  	BUG_ON(priv->pgtable == NULL);
> >
> > @@ -976,7 +979,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> >  	ent = section_entry(priv->pgtable, iova);
> >
> >  	if (lv1ent_section(ent)) {
> > -		BUG_ON(size < SECT_SIZE);
> > +		if (WARN_ON(size < SECT_SIZE))
> > +			goto err;
> >
> >  		*ent = 0;
> >  		pgtable_flush(ent, ent + 1);
> > @@ -1008,7 +1012,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> >  	}
> >
> >  	/* lv1ent_large(ent) == true here */
> > -	BUG_ON(size < LPAGE_SIZE);
> > +	if (WARN_ON(size < LPAGE_SIZE))
> > +		goto err;
> >
> >  	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
> >  	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
> > @@ -1023,8 +1028,21 @@ done:
> >  		sysmmu_tlb_invalidate_entry(data->dev, iova);
> >  	spin_unlock_irqrestore(&priv->lock, flags);
> >
> > -
> >  	return size;
> > +err:
> > +	spin_unlock_irqrestore(&priv->pgtablelock, flags);
> > +
> > +	err_page = (
> > +		((unsigned long)ent - (unsigned long)priv->pgtable)
> > +			< (NUM_LV1ENTRIES * sizeof(long))
> 
> Maybe you could add LV1TABLE_SIZE define and use it here (there is
> already a LV2TABLE_SIZE define)?

Yes. But, LV2TABLE_SIZE is used in more places than one.
I do not feel that it is needed to define LV1TABLE_SIZE for the single line.

> 
> > +			   ) ?  SECT_SIZE : LPAGE_SIZE;
> 
> It also seems that err_page should be of unsigned long type, no need
> to make it size_t one.
> 

err_page is the page size.
I agree that the name of the variable is not proper to indicate size.

> The above code is quite ugly currently, it could be rewritten into
> something prettier, i.e.:
> 
> 	err_page = (unsigned long)ent - (unsigned long)priv->pgtable;
> 	err_page = (err_page < LV1TABLE_SIZE) ? SECT_SIZE : LPAGE_SIZE;
> 
Ah, this is the reason that you addresses err_page could be unsigned long.
I agree that it is prettier.

> > +	pr_err("%s: Failed due to size(%#lx) @ %#x is"\
> > +		" smaller than page size %#x\n",
> > +		__func__, iova, size, err_page);
> 
> Aren't iova and size arguments interchanged here?
Oh, it is my mistake.

It will should be fixed in the next patchset with the change in
calculation of err_page.
> 
> > +
> > +	       return 0;
> 
> There is an intendation issue here (extra whitespaces).

Yes. Thanks.

> 
> > +
> >  }
> >
> >  static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

Thank you.

Cho KyongHo.
