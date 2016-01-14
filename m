From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
 support
Date: Thu, 14 Jan 2016 21:05:04 +0800
Message-ID: <1452776704.15636.59.camel@mhfsdcap03>
References: <cover.1450383740.git.robin.murphy@arm.com>
 <ddfe960ef1da22e5264811bfcafeb412fa976f4a.1450383740.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ddfe960ef1da22e5264811bfcafeb412fa976f4a.1450383740.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, srv_heupstream@mediatek.com, joro@8bytes.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, mitchelh@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-12-17 at 20:50 +0000, Robin Murphy wrote:
> Add a nearly-complete ARMv7 short descriptor implementation, omitting
> only a few legacy and CPU-centric aspects which shouldn't be necessary
> for IOMMU API use anyway.

[...]

> +
> +#define ARM_V7S_BLOCK_SIZE(lvl)		(1UL << ARM_V7S_LVL_SHIFT(lvl))
> +#define ARM_V7S_LVL_MASK(lvl)		((u32)(~0U << ARM_V7S_LVL_SHIFT(lvl)))
> +#define ARM_V7S_TABLE_MASK		((u32)(~0U << ARM_V7S_TABLE_SHIFT))
> +#define _ARM_V7S_IDX_MASK(lvl)		(ARM_V7S_PTES_PER_LVL(lvl) - 1)
> +#define ARM_V7S_LVL_IDX(addr, lvl)	({				\
> +	int _l = lvl;							\
> +	((u32)(addr) >> ARM_V7S_LVL_SHIFT(_l)) & _ARM_V7S_IDX_MASK(_l); \
> +})

lvl here is not a function, it is 1 or 2, Could we use for simple?

#define ARM_V7S_LVL_IDX(addr, lvl)		\
	((u32)(addr) >> ARM_V7S_LVL_SHIFT(lvl)) & _ARM_V7S_IDX_MASK(lvl)


> +static arm_v7s_iopte arm_v7s_cont_to_pte(arm_v7s_iopte pte, int lvl)
> +{
> +	if (lvl == 1) {
> +		pte &= ~ARM_V7S_CONT_SECTION;
> +	} else if (lvl == 2) {
> +		arm_v7s_iopte xn = pte & BIT(ARM_V7S_CONT_PAGE_XN_SHIFT);
> +		arm_v7s_iopte tex = pte & (ARM_V7S_CONT_PAGE_TEX_MASK <<
> +					   ARM_V7S_CONT_PAGE_TEX_SHIFT);
> +
> +		pte ^= xn | tex;
> +		pte |= (xn >> ARM_V7S_CONT_PAGE_XN_SHIFT) |
> +		       (tex >> ARM_V7S_CONT_PAGE_TEX_SHIFT);
> +		pte ^= ARM_V7S_PTE_TYPE_PAGE | ARM_V7S_PTE_TYPE_CONT_PAGE;

    If XN bit is 1, We may lost XN bit for small page here.
    
    We could runs ok as we have IO_PGTABLE_QUIRK_NO_PERMS.

    Maybe this is enough: pte ^= ARM_V7S_PTE_TYPE_PAGE;

> +	}
> +	return pte;
> +}
> +
> +static bool arm_v7s_pte_is_cont(arm_v7s_iopte pte, int lvl)
> +{
> +	if (lvl == 1 && !ARM_V7S_PTE_IS_TABLE(pte, lvl))
> +		return pte & ARM_V7S_CONT_SECTION;
> +	else if (lvl == 2)
> +		return !(pte & ARM_V7S_PTE_TYPE_PAGE);
> +	return false;
> +}
> +
> +static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *, unsigned long,
> +			   size_t, int, arm_v7s_iopte *);
> +
> +static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
> +			    unsigned long iova, phys_addr_t paddr, int prot,
> +			    int lvl, int num_entries, arm_v7s_iopte *ptep)
> +{
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	arm_v7s_iopte pte = arm_v7s_prot_to_pte(prot, lvl, cfg);
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++)
> +		if (ARM_V7S_PTE_IS_TABLE(ptep[i], lvl)) {

   If somebody abuse the mapping, He map 4K firstly, then map 1M in the
same iova address(don't unmap the 4K before), then it will also enter
here to free the existed lvl2 pagetable silently. Should we add a
checking whether the existed pagetable is empty? if the pagetable is not
empty, return a warning.

> +			/*
> +			 * We need to unmap and free the old table before
> +			 * overwriting it with a block entry.
> +			 */
> +			arm_v7s_iopte *tblp;
> +			size_t sz = ARM_V7S_BLOCK_SIZE(lvl);
> +
> +			tblp = ptep + i - ARM_V7S_LVL_IDX(iova, lvl);
> +			if (WARN_ON(__arm_v7s_unmap(data, iova, sz, lvl, tblp)
> +					!= sz))

    if "i" isn't 0 here(There is a pgtable item in a supersection), it
seems not right. Maybe:
        
    tblp = ptep + i - ARM_V7S_LVL_IDX(iova + i * sz, lvl);
    if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz, sz, lvl, tblp)
		!= sz))

> +				return -EINVAL;
> +		} else if (ptep[i]) {
> +			/* We require an unmap first */
> +			WARN_ON(!selftest_running);
> +			return -EEXIST;
> +		}
> +

[...]

> +static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
> +				   unsigned long iova, size_t size,
> +				   arm_v7s_iopte *ptep)
> +{
> +	unsigned long blk_start, blk_end, blk_size;
> +	phys_addr_t blk_paddr;
> +	arm_v7s_iopte table = 0;
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	int prot = arm_v7s_pte_to_prot(*ptep, 1);
> +
> +	blk_size = ARM_V7S_BLOCK_SIZE(1);
> +	blk_start = iova & ARM_V7S_LVL_MASK(1);
> +	blk_end = blk_start + ARM_V7S_BLOCK_SIZE(1);
> +	blk_paddr = *ptep & ARM_V7S_LVL_MASK(1);
> +
> +	for (; blk_start < blk_end; blk_start += size, blk_paddr += size) {
> +		arm_v7s_iopte *tablep;
> +
> +		/* Unmap! */
> +		if (blk_start == iova)
> +			continue;
> +
> +		/* __arm_v7s_map expects a pointer to the start of the table */
> +		tablep = &table - ARM_V7S_LVL_IDX(blk_start, 1);

   The "table" seems not be initialized here. (LPAE too.) maybe I don't
get it here.

   If we would like to get the start of the table, maybe :

   tablep = ptep - ARM_V7S_LVL_IDX(blk_start, 1);

    Even though we change "tablep" here, it will also fail in the
__arm_v7s_map since there is a value in current ptep(the pa of the
section), then it will call iopte_deref instread of creating a new
pgtable in the __arm_v7s_map below, then it will abort.

so maybe we need unmap the ptep before this "for" loop.
__arm_v7s_set_pte(ptep, 0, 1, cfg);

> +		if (__arm_v7s_map(data, blk_start, blk_paddr, size, prot, 1,
> +				  tablep) < 0) {
> +			if (table) {
> +				/* Free the table we allocated */
> +				tablep = iopte_deref(table, 1);
> +				__arm_v7s_free_table(tablep, 2, data);

Following Will's quesion before, do we need flush tlb here?

> +			}
> +			return 0; /* Bytes unmapped */
> +		}
> +	}
> +
> +	__arm_v7s_set_pte(ptep, table, 1, cfg);

    Is this in order to update the lvl2 pgtable base address? why it's
not updated in __arm_v7s_map which create a lvl2 pgtable?

> +	iova &= ~(blk_size - 1);
> +	cfg->tlb->tlb_add_flush(iova, blk_size, blk_size, true, data->iop.cookie);
> +	return size;
> +}
> +

All the others looks good for me. Thanks.

[...]
