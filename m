Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51634372ECC
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030719; cv=none; b=Jl0zQZZFp/jwuxXaw5Jn+3qNMvLHUrAezH39aebxXH5qQTVunOGP50Q0feLjr6ExtuBQ2AIurkxMeENzjCX5GiBMd8HQ2oydt+z+GLkoZW6Iiu6wLrU+mGFWnIyVvk4uFO1hwYUhqRkgaQtlNyHZ/tuWiWOgBVK81yBM57E+hCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030719; c=relaxed/simple;
	bh=zBHlnDjsv1u9qv+kLLafGJjNhDB3l67AWW5OoKHmZ/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESFAWEzUPqIMur8gc/uu5fOWGm9pWQ9d2V5HVAE5fG51kgYDC1758oCA3sdC723PoierA63UsXYGM5pCKOiq5tvVNPpX/wZdnovZUVTM6Twre7OAWNQSZGhX3KKhWI+a6Jn5smz2GdPKMP26SLFqpEBz8NvQ1QlBJauwt8PbRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aiB2qFQM; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aiB2qFQM"
Received: from [192.168.31.31] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39202ed86;
	Wed, 1 Apr 2026 15:59:52 +0800 (GMT+08:00)
Message-ID: <b046ad1c-9cfc-4399-a8df-e4fffff434f9@rock-chips.com>
Date: Wed, 1 Apr 2026 15:59:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/rockchip: Drop global rk_ops in favor of
 per-device ops
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>
References: <20260310084812.126082-1-xxm@rock-chips.com>
 <20260310105303.128859-1-xxm@rock-chips.com>
 <a586dd60-5b9c-4044-3bb1-903df863b587@rock-chips.com>
From: Simon Xue <xxm@rock-chips.com>
In-Reply-To: <a586dd60-5b9c-4044-3bb1-903df863b587@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d480e54be03ackunmd1c762ac2a903b9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhNHVYeSEsfQhgaTE1OSUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=aiB2qFQMkBGb1dStT//KY8NZODb/t+dcf5HA909jLw3APgMEBxqKcAKCjFzPqyzG0myZNldbhel9oH528N812yPuOFKdh12YxNzlCLn1w/l6lqpiJBVIWM3H4RvvwngEquuOy8WWffyPQ5WVKA/7gR6wlISqYIfmr+D04TrX4Cc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wBenShtp3JxSvc7NBfSYeMEQTo7nbS/NWHgiOkthdpA=;
	h=date:mime-version:subject:message-id:from;

Hi all,

A gentle ping on this patch.

在 2026/3/13 17:32, Shawn Lin 写道:
> 在 2026/03/10 星期二 18:53, Simon Xue 写道:
>> The driver currently uses a global rk_ops pointer, forcing all IOMMU
>> instances to share the same operations. This restricts the driver from
>> supporting SoCs that might integrate different versions of IOMMU 
>> hardware.
>>
>> Since the IOMMU framework passes the master device information to
>> iommu_paging_domain_alloc(), the global variable is no longer needed.
>>
>> Fix this by moving rk_ops into struct rk_iommu and struct 
>> rk_iommu_domain.
>> Initialize it per-device during probe via of_device_get_match_data(),
>> and replace all global references with the instance-specific pointers.
>>
>
> Thanks for the patch, Simon. I've tested it on the RK3576 EVB1 with
> PCIe1 + IOMMU. NVMe works fine on it, and I also verified the IOVA
> allocated in the NVMe driver, they look correct as I manually limited
> the memblock to under 2GB, so here it is:
>
> nvme 0001:21:00.0: cq_dma_addr: 0x00000000f7fc7000
>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> ---
>> v2:
>>   - Remove the one-time-used 'ops' variable in rk_iommu_probe()
>>
>>   drivers/iommu/rockchip-iommu.c | 71 ++++++++++++++++------------------
>>   1 file changed, 33 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c 
>> b/drivers/iommu/rockchip-iommu.c
>> index 0013cf196c57..4da80136933c 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -82,6 +82,14 @@
>>     */
>>   #define RK_IOMMU_PGSIZE_BITMAP 0x007ff000
>>   +struct rk_iommu_ops {
>> +    phys_addr_t (*pt_address)(u32 dte);
>> +    u32 (*mk_dtentries)(dma_addr_t pt_dma);
>> +    u32 (*mk_ptentries)(phys_addr_t page, int prot);
>> +    u64 dma_bit_mask;
>> +    gfp_t gfp_flags;
>> +};
>> +
>>   struct rk_iommu_domain {
>>       struct list_head iommus;
>>       u32 *dt; /* page directory table */
>> @@ -89,6 +97,7 @@ struct rk_iommu_domain {
>>       spinlock_t iommus_lock; /* lock for iommus list */
>>       spinlock_t dt_lock; /* lock for modifying page directory table */
>>       struct device *dma_dev;
>> +    const struct rk_iommu_ops *rk_ops;
>>         struct iommu_domain domain;
>>   };
>> @@ -98,14 +107,6 @@ static const char * const rk_iommu_clocks[] = {
>>       "aclk", "iface",
>>   };
>>   -struct rk_iommu_ops {
>> -    phys_addr_t (*pt_address)(u32 dte);
>> -    u32 (*mk_dtentries)(dma_addr_t pt_dma);
>> -    u32 (*mk_ptentries)(phys_addr_t page, int prot);
>> -    u64 dma_bit_mask;
>> -    gfp_t gfp_flags;
>> -};
>> -
>>   struct rk_iommu {
>>       struct device *dev;
>>       void __iomem **bases;
>> @@ -117,6 +118,7 @@ struct rk_iommu {
>>       struct iommu_device iommu;
>>       struct list_head node; /* entry in rk_iommu_domain.iommus */
>>       struct iommu_domain *domain; /* domain to which iommu is 
>> attached */
>> +    const struct rk_iommu_ops *rk_ops;
>>   };
>>     struct rk_iommudata {
>> @@ -124,7 +126,6 @@ struct rk_iommudata {
>>       struct rk_iommu *iommu;
>>   };
>>   -static const struct rk_iommu_ops *rk_ops;
>>   static struct iommu_domain rk_identity_domain;
>>     static inline void rk_table_flush(struct rk_iommu_domain *dom, 
>> dma_addr_t dma,
>> @@ -510,7 +511,7 @@ static int rk_iommu_force_reset(struct rk_iommu 
>> *iommu)
>>        * and verifying that upper 5 (v1) or 7 (v2) nybbles are read 
>> back.
>>        */
>>       for (i = 0; i < iommu->num_mmu; i++) {
>> -        dte_addr = rk_ops->pt_address(DTE_ADDR_DUMMY);
>> +        dte_addr = iommu->rk_ops->pt_address(DTE_ADDR_DUMMY);
>>           rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dte_addr);
>>             if (dte_addr != rk_iommu_read(iommu->bases[i], 
>> RK_MMU_DTE_ADDR)) {
>> @@ -551,7 +552,7 @@ static void log_iova(struct rk_iommu *iommu, int 
>> index, dma_addr_t iova)
>>       page_offset = rk_iova_page_offset(iova);
>>         mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
>> -    mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
>> +    mmu_dte_addr_phys = iommu->rk_ops->pt_address(mmu_dte_addr);
>>         dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
>>       dte_addr = phys_to_virt(dte_addr_phys);
>> @@ -560,14 +561,14 @@ static void log_iova(struct rk_iommu *iommu, 
>> int index, dma_addr_t iova)
>>       if (!rk_dte_is_pt_valid(dte))
>>           goto print_it;
>>   -    pte_addr_phys = rk_ops->pt_address(dte) + (pte_index * 4);
>> +    pte_addr_phys = iommu->rk_ops->pt_address(dte) + (pte_index * 4);
>>       pte_addr = phys_to_virt(pte_addr_phys);
>>       pte = *pte_addr;
>>         if (!rk_pte_is_page_valid(pte))
>>           goto print_it;
>>   -    page_addr_phys = rk_ops->pt_address(pte) + page_offset;
>> +    page_addr_phys = iommu->rk_ops->pt_address(pte) + page_offset;
>>       page_flags = pte & RK_PTE_PAGE_FLAGS_MASK;
>>     print_it:
>> @@ -663,13 +664,13 @@ static phys_addr_t rk_iommu_iova_to_phys(struct 
>> iommu_domain *domain,
>>       if (!rk_dte_is_pt_valid(dte))
>>           goto out;
>>   -    pt_phys = rk_ops->pt_address(dte);
>> +    pt_phys = rk_domain->rk_ops->pt_address(dte);
>>       page_table = (u32 *)phys_to_virt(pt_phys);
>>       pte = page_table[rk_iova_pte_index(iova)];
>>       if (!rk_pte_is_page_valid(pte))
>>           goto out;
>>   -    phys = rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
>> +    phys = rk_domain->rk_ops->pt_address(pte) + 
>> rk_iova_page_offset(iova);
>>   out:
>>       spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
>>   @@ -730,7 +731,7 @@ static u32 *rk_dte_get_page_table(struct 
>> rk_iommu_domain *rk_domain,
>>       if (rk_dte_is_pt_valid(dte))
>>           goto done;
>>   -    page_table = iommu_alloc_pages_sz(GFP_ATOMIC | rk_ops->gfp_flags,
>> +    page_table = iommu_alloc_pages_sz(GFP_ATOMIC | 
>> rk_domain->rk_ops->gfp_flags,
>>                         SPAGE_SIZE);
>>       if (!page_table)
>>           return ERR_PTR(-ENOMEM);
>> @@ -742,13 +743,13 @@ static u32 *rk_dte_get_page_table(struct 
>> rk_iommu_domain *rk_domain,
>>           return ERR_PTR(-ENOMEM);
>>       }
>>   -    dte = rk_ops->mk_dtentries(pt_dma);
>> +    dte = rk_domain->rk_ops->mk_dtentries(pt_dma);
>>       *dte_addr = dte;
>>         rk_table_flush(rk_domain,
>>                  rk_domain->dt_dma + dte_index * sizeof(u32), 1);
>>   done:
>> -    pt_phys = rk_ops->pt_address(dte);
>> +    pt_phys = rk_domain->rk_ops->pt_address(dte);
>>       return (u32 *)phys_to_virt(pt_phys);
>>   }
>>   @@ -790,7 +791,7 @@ static int rk_iommu_map_iova(struct 
>> rk_iommu_domain *rk_domain, u32 *pte_addr,
>>           if (rk_pte_is_page_valid(pte))
>>               goto unwind;
>>   -        pte_addr[pte_count] = rk_ops->mk_ptentries(paddr, prot);
>> +        pte_addr[pte_count] = rk_domain->rk_ops->mk_ptentries(paddr, 
>> prot);
>>             paddr += SPAGE_SIZE;
>>       }
>> @@ -812,7 +813,7 @@ static int rk_iommu_map_iova(struct 
>> rk_iommu_domain *rk_domain, u32 *pte_addr,
>>                   pte_count * SPAGE_SIZE);
>>         iova += pte_count * SPAGE_SIZE;
>> -    page_phys = rk_ops->pt_address(pte_addr[pte_count]);
>> +    page_phys = rk_domain->rk_ops->pt_address(pte_addr[pte_count]);
>>       pr_err("iova: %pad already mapped to %pa cannot remap to phys: 
>> %pa prot: %#x\n",
>>              &iova, &page_phys, &paddr, prot);
>>   @@ -849,7 +850,7 @@ static int rk_iommu_map(struct iommu_domain 
>> *domain, unsigned long _iova,
>>       pte_index = rk_iova_pte_index(iova);
>>       pte_addr = &page_table[pte_index];
>>   -    pte_dma = rk_ops->pt_address(dte_index) + pte_index * 
>> sizeof(u32);
>> +    pte_dma = rk_domain->rk_ops->pt_address(dte_index) + pte_index * 
>> sizeof(u32);
>>       ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
>>                   paddr, size, prot);
>>   @@ -887,7 +888,7 @@ static size_t rk_iommu_unmap(struct 
>> iommu_domain *domain, unsigned long _iova,
>>           return 0;
>>       }
>>   -    pt_phys = rk_ops->pt_address(dte);
>> +    pt_phys = rk_domain->rk_ops->pt_address(dte);
>>       pte_addr = (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iova);
>>       pte_dma = pt_phys + rk_iova_pte_index(iova) * sizeof(u32);
>>       unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma, 
>> size);
>> @@ -945,7 +946,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>         for (i = 0; i < iommu->num_mmu; i++) {
>>           rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>> - rk_ops->mk_dtentries(rk_domain->dt_dma));
>> + iommu->rk_ops->mk_dtentries(rk_domain->dt_dma));
>>           rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
>>           rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 
>> RK_MMU_IRQ_MASK);
>>       }
>> @@ -1068,17 +1069,19 @@ static struct iommu_domain 
>> *rk_iommu_domain_alloc_paging(struct device *dev)
>>       if (!rk_domain)
>>           return NULL;
>>   +    iommu = rk_iommu_from_dev(dev);
>> +    rk_domain->rk_ops = iommu->rk_ops;
>> +
>>       /*
>>        * rk32xx iommus use a 2 level pagetable.
>>        * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
>>        * Allocate one 4 KiB page for each table.
>>        */
>> -    rk_domain->dt = iommu_alloc_pages_sz(GFP_KERNEL | 
>> rk_ops->gfp_flags,
>> +    rk_domain->dt = iommu_alloc_pages_sz(GFP_KERNEL | 
>> rk_domain->rk_ops->gfp_flags,
>>                            SPAGE_SIZE);
>>       if (!rk_domain->dt)
>>           goto err_free_domain;
>>   -    iommu = rk_iommu_from_dev(dev);
>>       rk_domain->dma_dev = iommu->dev;
>>       rk_domain->dt_dma = dma_map_single(rk_domain->dma_dev, 
>> rk_domain->dt,
>>                          SPAGE_SIZE, DMA_TO_DEVICE);
>> @@ -1117,7 +1120,7 @@ static void rk_iommu_domain_free(struct 
>> iommu_domain *domain)
>>       for (i = 0; i < NUM_DT_ENTRIES; i++) {
>>           u32 dte = rk_domain->dt[i];
>>           if (rk_dte_is_pt_valid(dte)) {
>> -            phys_addr_t pt_phys = rk_ops->pt_address(dte);
>> +            phys_addr_t pt_phys = rk_domain->rk_ops->pt_address(dte);
>>               u32 *page_table = phys_to_virt(pt_phys);
>>               dma_unmap_single(rk_domain->dma_dev, pt_phys,
>>                        SPAGE_SIZE, DMA_TO_DEVICE);
>> @@ -1197,7 +1200,6 @@ static int rk_iommu_probe(struct 
>> platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct rk_iommu *iommu;
>>       struct resource *res;
>> -    const struct rk_iommu_ops *ops;
>>       int num_res = pdev->num_resources;
>>       int err, i;
>>   @@ -1211,16 +1213,9 @@ static int rk_iommu_probe(struct 
>> platform_device *pdev)
>>       iommu->dev = dev;
>>       iommu->num_mmu = 0;
>>   -    ops = of_device_get_match_data(dev);
>> -    if (!rk_ops)
>> -        rk_ops = ops;
>> -
>> -    /*
>> -     * That should not happen unless different versions of the
>> -     * hardware block are embedded the same SoC
>> -     */
>> -    if (WARN_ON(rk_ops != ops))
>> -        return -EINVAL;
>> +    iommu->rk_ops = of_device_get_match_data(dev);
>> +    if (!iommu->rk_ops)
>> +        return -ENOENT;
>>         iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
>>                       GFP_KERNEL);
>> @@ -1286,7 +1281,7 @@ static int rk_iommu_probe(struct 
>> platform_device *pdev)
>>               goto err_pm_disable;
>>       }
>>   -    dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
>> +    dma_set_mask_and_coherent(dev, iommu->rk_ops->dma_bit_mask);
>>         err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, 
>> dev_name(dev));
>>       if (err)
>>
>
