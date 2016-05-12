From: =?UTF-8?B?SG9uZ2h1aSBaaGFuZyAo5byg5rSq6L6JKQ==?=
	<honghui.zhang@mediatek.com>
Subject: Re: [PATCH 4/5] iommu/mediatek: add support for mtk iommu generation
 one HW
Date: Thu, 12 May 2016 19:26:36 +0800
Message-ID: <bf2077e7-da8f-ba27-4f75-999c007f36b4@mediatek.com>
References: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
 <1462780816-5288-5-git-send-email-honghui.zhang@mediatek.com>
 <5731B7D8.8040304@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B7D8.8040304@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, treding@nvidia.com, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, youlin.pei@mediatek.com, yingjoe.chen@mediatek.com, devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, kernel@pengutronix.de, arnd@arndb.de, tfiga@google.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, pebolle@tiscali.nl, srv_heupstream@mediatek.com, erin.lo@mediatek.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, djkurtz@google.com, p.zabel@pengutronix.de, l.stach@pengutronix.de
List-Id: iommu@lists.linux-foundation.org

hi, Robin, thanks very much for your comments.

On 5/10/2016 6:28 PM, Robin Murphy wrote:
> On 09/05/16 09:00, honghui.zhang@mediatek.com wrote:
> [...]
>> +static void *mtk_iommu_alloc_pgt(struct device *dev, size_t size, gfp_t gfp)
>> +{
>> +    dma_addr_t dma;
>> +    void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
>> +
>> +    if (!pages)
>> +        return NULL;
>> +
>> +    dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>> +    if (dma_mapping_error(dev, dma))
>> +        goto out_free;
>> +    /*
>> +     * We depend on the IOMMU being able to work with any physical
>> +     * address directly, so if the DMA layer suggests otherwise by
>> +     * translating or truncating them, that bodes very badly...
>> +     */
>> +    if (dma != virt_to_phys(pages))
>> +        goto out_unmap;
> 
> Given that you've only got a single table to allocate, and at 4MB it has a fair chance of failing beyond early boot time, just use dma_alloc_coherent() - you don't need to care about the dma <-> phys relationship because you don't have multi-level tables to walk. That way, you can get rid of all the awkward streaming DMA stuff, and also benefit from CMA to avoid allocation failures.
> 

thanks, use dma_alloc_coherent is good for me.

>> +    kmemleak_ignore(pages);
>> +    return pages;
>> +
>> +out_unmap:
>> +    dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
>> +    dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
>> +out_free:
>> +    free_pages_exact(pages, size);
>> +    return NULL;
>> +
>> +}
>> +
>> +static void mtk_iommu_free_pgt(struct device *dev, void *pages, size_t size)
>> +{
>> +    dma_unmap_single(dev, (dma_addr_t)virt_to_phys(pages),
>> +             size, DMA_TO_DEVICE);
>> +    free_pages_exact(pages, size);
>> +}
>> +
>> +static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
>> +{
>> +    struct mtk_iommu_domain *dom = data->m4u_dom;
>> +
>> +    spin_lock_init(&dom->pgtlock);
>> +
>> +    dom->pgt_va = mtk_iommu_alloc_pgt(data->dev,
>> +                dom->pgt_size, GFP_KERNEL);
>> +    if (!dom->pgt_va)
>> +        return -ENOMEM;
>> +
>> +    dom->pgt_pa = virt_to_phys(dom->pgt_va);
>> +
>> +    writel(dom->pgt_pa, data->base + REG_MMU_PT_BASE_ADDR);
>> +
>> +    dom->cookie = (void *)data;
>> +
>> +    return 0;
>> +}
>> +
>> +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
>> +{
>> +    struct mtk_iommu_domain *dom;
>> +
>> +    if (type != IOMMU_DOMAIN_UNMANAGED)
>> +        return NULL;
>> +
>> +    dom = kzalloc(sizeof(*dom), GFP_KERNEL);
>> +    if (!dom)
>> +        return NULL;
>> +
>> +    /*
>> +     * MTK m4u support 4GB iova address space, and oly support 4K page
>> +     * mapping. So the pagetable size should be exactly as 4M.
>> +     */
>> +    dom->pgt_size = SZ_4M;
> 
> If the table size is fixed, then why bother having a variable at all?
> 
>> +    return &dom->domain;
>> +}
>> +
>> +static void mtk_iommu_domain_free(struct iommu_domain *domain)
>> +{
>> +    kfree(to_mtk_domain(domain));
>> +}
>> +
> 
> [...]
> 
>> +static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
>> +             phys_addr_t paddr, size_t size, int prot)
>> +{
>> +    struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>> +    struct mtk_iommu_data *data = dom->cookie;
>> +    unsigned int page_num = size >> MTK_IOMMU_PAGE_SHIFT;
> 
> Since you only advertise a single page size, this will always be 1, so you could either get rid of the loop here...
> 

I would prefer your following advise to change the pgsize_bitmap. 
I would follow your advise in the next version.
Thanks very much.

>> +    unsigned long flags;
>> +    unsigned int i;
>> +    u32 *pgt_base_iova;
>> +    u32 pabase = (u32)paddr;
>> +    int map_size = 0;
>> +
>> +    spin_lock_irqsave(&dom->pgtlock, flags);
>> +    pgt_base_iova = dom->pgt_va + (iova  >> MTK_IOMMU_PAGE_SHIFT);
>> +    for (i = 0; i < page_num; i++) {
>> +        pgt_base_iova[i] = pabase | F_DESC_VALID | F_DESC_NONSEC;
>> +        pabase += MTK_IOMMU_PAGE_SIZE;
>> +        map_size += MTK_IOMMU_PAGE_SIZE;
>> +    }
>> +    dma_sync_single_for_device(data->dev,
>> +            dom->pgt_pa + (iova >> MTK_IOMMU_PAGE_SHIFT),
>> +            (size >> MTK_IOMMU_PAGE_SHIFT) * sizeof(u32),
>> +            DMA_TO_DEVICE);
>> +    spin_unlock_irqrestore(&dom->pgtlock, flags);
>> +
>> +    mtk_iommu_tlb_flush_range(data, iova, size);
>> +
>> +    return map_size;
>> +}
> 
> [...]
> 
>> +static struct iommu_ops mtk_iommu_ops = {
>> +    .domain_alloc    = mtk_iommu_domain_alloc,
>> +    .domain_free    = mtk_iommu_domain_free,
>> +    .attach_dev    = mtk_iommu_attach_device,
>> +    .detach_dev    = mtk_iommu_detach_device,
>> +    .map        = mtk_iommu_map,
>> +    .unmap        = mtk_iommu_unmap,
>> +    .map_sg        = default_iommu_map_sg,
>> +    .iova_to_phys    = mtk_iommu_iova_to_phys,
>> +    .add_device    = mtk_iommu_add_device,
>> +    .remove_device    = mtk_iommu_remove_device,
>> +    .device_group    = mtk_iommu_device_group,
>> +    .pgsize_bitmap    = MTK_IOMMU_PAGE_SIZE,
>> +};
> 
> ...or perhaps advertise .pgsize_bitmap = ~0UL << MTK_IOMMU_PAGE_SHIFT here, so you actually can handle multiple entries at once for larger mappings - given how simple the page table format is that doesn't seem too unreasonable, especially since it should give you a big efficiency win in terms of TLB maintenance.
> 
> Robin.
> 
