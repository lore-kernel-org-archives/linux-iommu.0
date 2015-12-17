From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu/io-pgtable: Add ARMv7 short descriptor support
Date: Thu, 17 Dec 2015 20:12:09 +0000
Message-ID: <56731719.3080005@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
	<3c72de1e8caa28cbfd423de41c6cba812db4e7db.1449246988.git.robin.murphy@arm.com>
	<1449565091.14761.32.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1449565091.14761.32.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/12/15 08:58, Yong Wu wrote:
> Hi Robin,
>
>     Thanks very much for your rewriting. It looks more pretty.
>
>     This works well in my selftest. and I will push to our chrome branch
> and request our video/display to test more.

Great, thanks.

>     Only a little comment below.
>
> On Fri, 2015-12-04 at 17:53 +0000, Robin Murphy wrote:
>> Add a nearly-complete ARMv7 short descriptor implementation, omitting
>> only a few legacy and CPU-centric aspects which shouldn't be necessary
>> for IOMMU API use anyway.
>>
>> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
> [...]
>> +/* PTE type bits: these are all mixed up with XN/PXN bits in most cases */
>> +#define ARM_V7S_PTE_TYPE_TABLE		0x1
>> +#define ARM_V7S_PTE_TYPE_PAGE		0x2
>> +#define ARM_V7S_PTE_TYPE_CONT_PAGE	0x1
>
>  From the spec, This is Large page, Do we need add a comment for
> readable?
> /* Large page */
>
> and add /* Supersection */ for CONT_SECTION too.

Sure, I've added a comment that explains the use of "cont" for 
clarification.

>> +
>> +#define ARM_V7S_PTE_IS_VALID(pte)	(((pte) & 0x3) != 0)
>> +#define ARM_V7S_PTE_IS_TABLE(pte, lvl)	(lvl < 2 && ((pte) & ARM_V7S_PTE_TYPE_TABLE))
>> +
>> +/* Page table bits */
>> +#define ARM_V7S_ATTR_XN(lvl)		BIT(4 * (2 - (lvl)))
>> +#define ARM_V7S_ATTR_B			BIT(2)
>> +#define ARM_V7S_ATTR_C			BIT(3)
>> +#define ARM_V7S_ATTR_NS_TABLE		BIT(3)
>> +#define ARM_V7S_ATTR_NS_SECTION		BIT(19)
>> +
>> +#define ARM_V7S_CONT_SECTION		BIT(18)
>> +#define ARM_V7S_CONT_PAGE_XN_SHIFT	15
>> +
> [...]
>> +static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>> +				   struct arm_v7s_io_pgtable *data)
>> +{
>> +	struct device *dev = data->iop.cfg.iommu_dev;
>> +	dma_addr_t dma;
>> +	size_t size = ARM_V7S_TABLE_SIZE(lvl);
>> +	void *table = NULL;
>> +
>> +	if (lvl == 1)
>> +		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
>> +	else if (lvl == 2)
>> +		table = kmem_cache_zalloc(data->l2_tables, gfp);
>> +	if (table && !selftest_running) {
>> +		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
>> +		if (dma_mapping_error(dev, dma))
>> +			goto out_free;
>> +		/*
>> +		 * We depend on the IOMMU being able to work with any physical
>> +		 * address directly, so if the DMA layer suggests otherwise by
>> +		 * translating or truncating them, that bodes very badly...
>> +		 */
>> +		if (dma != virt_to_phys(table))
>> +			goto out_unmap;
>> +	}
>
> There is some special while we use kmem_cache, we save the physical
> address into the pagetable, then get the virtual address via
> phys_to_virt, then free it.
> It isn't same with the normal case that saving the va and free the va.
> Do we need add kmemleak_ignore here?

Indeed you're right; fixed. With only 2-level tables it might be 
feasible to keep track of all the VAs as well, and break the strict 
dma==phys dependency, but since things work OK as-is I'll put that idea 
aside for a slow day...

>> +	return table;
>> +
>> +out_unmap:
>> +	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
>> +	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
>> +out_free:
>> +	if (lvl == 1)
>> +		free_pages((unsigned long)table, get_order(size));
>> +	else
>> +		kmem_cache_free(data->l2_tables, table);
>> +	return NULL;
>> +}
>> +
> [...]
>> +static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
>> +			    unsigned long iova, phys_addr_t paddr, int prot,
>> +			    int lvl, int num_entries, arm_v7s_iopte *ptep)
>> +{
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>> +	arm_v7s_iopte pte = arm_v7s_prot_to_pte(prot, lvl, cfg);
>> +	int i;
>> +
>> +	for (i = 0; i < num_entries; i++)
>> +		if (ARM_V7S_PTE_IS_TABLE(ptep[i], lvl)) {
>> +			/*
>> +			 * We need to unmap and free the old table before
>> +			 * overwriting it with a block entry.
>> +			 */
>> +			arm_v7s_iopte *tblp;
>> +			size_t sz = ARM_V7S_BLOCK_SIZE(lvl);
>> +
>> +			tblp = ptep + i - ARM_V7S_LVL_IDX(iova, lvl);
>> +			if (WARN_ON(__arm_v7s_unmap(data, iova, sz, lvl, tblp)
>> +					!= sz))
>> +				return -EINVAL;
>
> Here it may come from Will's "iommu/io-pgtable-arm: Unmap and free table
> when overwriting with block".
>
> But if we have IO_PGTABLE_QUIRK_TLBI_ON_MAP, the condition(1) in that
> comment don't exist.  So we don't need take care whether the exist one
> is a pgtable or not, we could always return -EEXIST here?

So if you map 4K, unmap it, then try to map 1MB of your now-free IOVA 
space over a pointer to an empty level 2 table, that always 
unconditionally fails? I'm pretty sure you don't want that ;)

With TLBI_ON_MAP you might not have hit the TLB conflict which revealed 
the bug in the first place, but the rest of that patch still very much 
applies (i.e. not leaking the table).

>> +		} else if (ptep[i]) {
>> +			/* We require an unmap first */
>> +			WARN_ON(!selftest_running);
>> +			return -EEXIST;
>> +		}
>> +
>
> [...]
>
>> +static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
>> +			    unsigned long iova, size_t size, int lvl,
>> +			    arm_v7s_iopte *ptep)
>> +{
>> +	arm_v7s_iopte pte[ARM_V7S_CONT_PAGES];
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>> +	const struct iommu_gather_ops *tlb = cfg->tlb;
>> +	void *cookie = data->iop.cookie;
>> +	int idx, i = 0, num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
>> +
>> +	/* Something went horribly wrong and we ran out of page table */
>> +	if (WARN_ON(lvl > 2))
>> +		return 0;
>> +
>> +	idx = ARM_V7S_LVL_IDX(iova, lvl);
>> +	ptep += idx;
>> +	do {
>> +		if (WARN_ON(!ARM_V7S_PTE_IS_VALID(ptep[i])))
>> +			return 0;
>> +		pte[i] = ptep[i];
>> +	} while (++i < num_entries);
>> +
>> +	/*
>> +	 * If we've hit a contiguous 'large page' entry at this level, it
>> +	 * needs splitting first, unless we're unmapping the whole lot.
>> +	 */
>> +	if (num_entries <= 1 && arm_v7s_pte_is_cont(pte[0], lvl))
>> +		arm_v7s_split_cont(data, iova, idx, lvl, ptep);
>> +
>> +	/* If the size matches this level, we're in the right place */
>> +	if (num_entries) {
>> +		size_t blk_size = ARM_V7S_BLOCK_SIZE(lvl);
>> +
>> +		__arm_v7s_set_pte(ptep, 0, num_entries, cfg);
>> +
>> +		for (i = 0; i < num_entries; i++) {
>> +			if (ARM_V7S_PTE_IS_TABLE(pte[i], lvl)) {
>> +				/* Also flush any partial walks */
>> +				tlb->tlb_add_flush(iova, blk_size,
>> +						   ARM_V7S_BLOCK_SIZE(2),
>> +						   false, cookie);
>> +				tlb->tlb_sync(cookie);
>
> MTK iommu driver will get a warning here in my test.
>
> There is a tlb_sync here, and in arm_v7s_unmap, there is another one.
> then the flow is:
>
>   tlb->tlb_add_flush(xxx)
>   tlb->tlb_sync()
>   tlb->tlb_sync()
>
>
> In MTK tlb_sync, The code is:
>
> static void mtk_iommu_tlb_sync(void *cookie)
> {
> 	struct mtk_iommu_data *data = cookie;
> 	int ret;
> 	u32 tmp;
>
> 	ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE, tmp,
> 					tmp != 0, 10, 100000);
> 	if (ret) {
> 		dev_warn(data->dev,
> 			 "Partial TLB flush timed out, falling back to full flush\n");
> 		mtk_iommu_tlb_flush_all(cookie);
> 	}
> 	/* Clear the CPE status */
> 	writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
> }
>
> In the end of this function, We have to write 0 to clear the CPE status,
> then the HW could check the status in the next time.
>
> So if we call tlb_sync twice continually. It will time out in the second
> time, then we can see this log:
>
> Partial TLB flush timed out, falling back to full flush
>
> I don't know whether it is our HW special behavior, is this case ok in
> the arm-smmu.c?
> Is there some suggestion about this?

In the case of the SMMU it's probably a needless performance hit but 
it's not going to cause any errors. I've come up with an idea to try 
optimising out redundant syncs as generally undesirable, which I'll 
post, but if back-to-back syncs are really a problem for your hardware 
then it's probably worth making the driver specifically detect and avoid 
that condition.

>> +				ptep = iopte_deref(pte[i], lvl);
>> +				__arm_v7s_free_table(ptep, lvl + 1, data);
>> +			} else {
>> +				tlb->tlb_add_flush(iova, blk_size, blk_size,
>> +						   true, cookie);
>> +			}
>> +			iova += blk_size;
>> +		}
>> +		return size;
>> +	} else if (lvl == 1 && !ARM_V7S_PTE_IS_TABLE(pte[0], lvl)) {
>> +		/*
>> +		 * Insert a table at the next level to map the old region,
>> +		 * minus the part we want to unmap
>> +		 */
>> +		return arm_v7s_split_blk_unmap(data, iova, size, ptep);
>> +	}
>> +
>> +	/* Keep on walkin' */
>> +	ptep = iopte_deref(pte[0], lvl);
>> +	return __arm_v7s_unmap(data, iova, size, lvl + 1, ptep);
>> +}
>> +
>> +static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>> +			 size_t size)
>> +{
>> +	size_t unmapped;
>> +	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
>> +	struct io_pgtable *iop = &data->iop;
>> +
>> +	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
>> +	if (unmapped)
>> +		iop->cfg.tlb->tlb_sync(iop->cookie);
>> +
>> +	return unmapped;
>> +}
>> +
>> +static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
>> +					unsigned long iova)
>> +{
>> +	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
>> +	arm_v7s_iopte *ptep = data->pgd, pte = ARM_V7S_PTE_TYPE_TABLE;
>> +	int lvl = 0;
>> +	u32 mask;
>> +
>> +	while (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
>> +		pte = ptep[ARM_V7S_LVL_IDX(iova, ++lvl)];
>> +		ptep = iopte_deref(pte, lvl);
>> +	}
>
> If we would like it always enter this while.
> Could we use do{}while? then we don't need initialize the pte.

OK, now I'm embarrassed for missing that, given the time I spent 
obsessively rewriting this bit about 20 times just because I was sure it 
was possible to do without any ifs, breaks, or repetitions :D

> And in this file, the valid lvl should be 1 or 2. but here the "lvl" is
> initialized to 0. Do we need add a enum for the lvl for more safe and
> readable?

Since "1" and "2" are used to represent the values 1 and 2, plus we use 
the level directly in arithmetic all over the place, I don't think an 
enum is really semantically appropriate or necessary. The lvl variable 
is only initialised to 0 in this one case because of the aforementioned 
obsessively-clean loop requiring the increment at the start of each 
iteration. With your change to the loop I can put ARM_V7S_PTE_IS_TABLE 
back to being predicated on lvl == 1 specifically, and get rid of this 
last trace of the whole "pretend TTBRn is a 'level 0' entry" bad idea 
that I had at one point.

Robin.

>> +	if (!ARM_V7S_PTE_IS_VALID(pte))
>> +		return 0;
>> +
>> +	mask = ARM_V7S_LVL_MASK(lvl);
>> +	if (arm_v7s_pte_is_cont(pte, lvl))
>> +		mask *= ARM_V7S_CONT_PAGES;
>> +	return (pte & mask) | (iova & ~mask);
>> +}
>> +
> [...]
>
>
