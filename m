From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [RFC 3/3] iommu/tegra: smmu: Support read-only mapping
Date: Thu, 20 Jun 2013 15:50:14 +0900
Message-ID: <CAH9JG2VUCJErBNwT0_u_9niaSWUza5gJ-+q8OOJhrrdw5D-hUg@mail.gmail.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
	<1371707384-30037-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1371707384-30037-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 20, 2013 at 2:49 PM, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Support read-only mapping via struct dma_attrs.
>
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index fab1f19..3aff4cd 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -862,12 +862,13 @@ static size_t __smmu_iommu_unmap_largepage(struct smmu_as *as, dma_addr_t iova)
>  }
>
>  static int __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
> -                                unsigned long pfn)
> +                               unsigned long pfn, int prot)
Can you find 'prot' is used at other arch? In previous patch, you cast
it as 'int' but below code cast it as 'struct dma_attr' again.
doesn't it better to use 'struct dma_attr' as parameter to avoid
double cast? Of course you have to modify existing APIs to use 'struct
dma_attr'.

Thank you,
Kyungmin Park
>  {
>         struct smmu_device *smmu = as->smmu;
>         unsigned long *pte;
>         unsigned int *count;
>         struct page *page;
> +       int attrs = as->pte_attr;
>
>         pte = locate_pte(as, iova, true, &page, &count);
>         if (WARN_ON(!pte))
> @@ -875,7 +876,11 @@ static int __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
>
>         if (*pte == _PTE_VACANT(iova))
>                 (*count)++;
> -       *pte = SMMU_PFN_TO_PTE(pfn, as->pte_attr);
> +
> +       if (dma_get_attr(DMA_ATTR_READ_ONLY, (struct dma_attrs *)prot))
> +               attrs &= ~_WRITABLE;
> +
> +       *pte = SMMU_PFN_TO_PTE(pfn, attrs);
>         FLUSH_CPU_DCACHE(pte, page, sizeof(*pte));
>         flush_ptc_and_tlb(smmu, as, iova, pte, page, 0);
>         put_signature(as, iova, pfn);
> @@ -883,23 +888,27 @@ static int __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
>  }
>
>  static int __smmu_iommu_map_page(struct smmu_as *as, dma_addr_t iova,
> -                                phys_addr_t pa)
> +                                phys_addr_t pa, int prot)
>  {
>         unsigned long pfn = __phys_to_pfn(pa);
>
> -       return __smmu_iommu_map_pfn(as, iova, pfn);
> +       return __smmu_iommu_map_pfn(as, iova, pfn, prot);
>  }
>
>  static int __smmu_iommu_map_largepage(struct smmu_as *as, dma_addr_t iova,
> -                                phys_addr_t pa)
> +                                phys_addr_t pa, int prot)
>  {
>         unsigned long pdn = SMMU_ADDR_TO_PDN(iova);
>         unsigned long *pdir = (unsigned long *)page_address(as->pdir_page);
> +       int attrs = _PDE_ATTR;
>
>         if (pdir[pdn] != _PDE_VACANT(pdn))
>                 return -EINVAL;
>
> -       pdir[pdn] = SMMU_ADDR_TO_PDN(pa) << 10 | _PDE_ATTR;
> +       if (dma_get_attr(DMA_ATTR_READ_ONLY, (struct dma_attrs *)prot))
> +               attrs &= ~_WRITABLE;
> +
> +       pdir[pdn] = SMMU_ADDR_TO_PDN(pa) << 10 | attrs;
>         FLUSH_CPU_DCACHE(&pdir[pdn], as->pdir_page, sizeof pdir[pdn]);
>         flush_ptc_and_tlb(as->smmu, as, iova, &pdir[pdn], as->pdir_page, 1);
>
> @@ -912,7 +921,8 @@ static int smmu_iommu_map(struct iommu_domain *domain, unsigned long iova,
>         struct smmu_as *as = domain->priv;
>         unsigned long flags;
>         int err;
> -       int (*fn)(struct smmu_as *as, dma_addr_t iova, phys_addr_t pa);
> +       int (*fn)(struct smmu_as *as, dma_addr_t iova, phys_addr_t pa,
> +                 int prot);
>
>         dev_dbg(as->smmu->dev, "[%d] %08lx:%08x\n", as->asid, iova, pa);
>
> @@ -929,7 +939,7 @@ static int smmu_iommu_map(struct iommu_domain *domain, unsigned long iova,
>         }
>
>         spin_lock_irqsave(&as->lock, flags);
> -       err = fn(as, iova, pa);
> +       err = fn(as, iova, pa, prot);
>         spin_unlock_irqrestore(&as->lock, flags);
>         return err;
>  }
> @@ -943,6 +953,10 @@ static int smmu_iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>         unsigned long *pdir = page_address(as->pdir_page);
>         int err = 0;
>         bool flush_all = (total > SZ_512) ? true : false;
> +       int attrs = as->pte_attr;
> +
> +       if (dma_get_attr(DMA_ATTR_READ_ONLY, (struct dma_attrs *)prot))
> +               attrs &= ~_WRITABLE;
>
>         spin_lock_irqsave(&as->lock, flags);
>
> @@ -977,8 +991,7 @@ static int smmu_iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>                         if (*pte == _PTE_VACANT(iova + i * PAGE_SIZE))
>                                 (*rest)++;
>
> -                       *pte = SMMU_PFN_TO_PTE(page_to_pfn(pages[i]),
> -                                              as->pte_attr);
> +                       *pte = SMMU_PFN_TO_PTE(page_to_pfn(pages[i]), attrs);
>                 }
>
>                 pte = &ptbl[ptn];
> @@ -1010,6 +1023,10 @@ static int smmu_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>         bool flush_all = (nents * PAGE_SIZE > SZ_512) ? true : false;
>         struct smmu_as *as = domain->priv;
>         struct smmu_device *smmu = as->smmu;
> +       int attrs = as->pte_attr;
> +
> +       if (dma_get_attr(DMA_ATTR_READ_ONLY, (struct dma_attrs *)prot))
> +               attrs &= ~_WRITABLE;
>
>         for (count = 0, s = sgl; count < nents; s = sg_next(s)) {
>                 phys_addr_t phys = page_to_phys(sg_page(s));
> @@ -1053,7 +1070,7 @@ static int smmu_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>                                         (*rest)++;
>                                 }
>
> -                               *pte = SMMU_PFN_TO_PTE(pfn + i, as->pte_attr);
> +                               *pte = SMMU_PFN_TO_PTE(pfn + i, attrs);
>                         }
>
>                         pte = &ptbl[ptn];
> @@ -1191,7 +1208,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
>                 struct page *page;
>
>                 page = as->smmu->avp_vector_page;
> -               __smmu_iommu_map_pfn(as, 0, page_to_pfn(page));
> +               __smmu_iommu_map_pfn(as, 0, page_to_pfn(page), 0);
>
>                 pr_debug("Reserve \"page zero\" \
>                         for AVP vectors using a common dummy\n");
> --
> 1.8.1.5
>
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
