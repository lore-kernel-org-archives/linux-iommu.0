From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
	support
Date: Fri, 15 Jan 2016 15:13:48 +0000
Message-ID: <56990CAC.5020606@arm.com>
References: <cover.1450383740.git.robin.murphy@arm.com>
	<ddfe960ef1da22e5264811bfcafeb412fa976f4a.1450383740.git.robin.murphy@arm.com>
	<1452776704.15636.59.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1452776704.15636.59.camel@mhfsdcap03>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/01/16 13:05, Yong Wu wrote:
> On Thu, 2015-12-17 at 20:50 +0000, Robin Murphy wrote:
>> Add a nearly-complete ARMv7 short descriptor implementation, omitting
>> only a few legacy and CPU-centric aspects which shouldn't be necessary
>> for IOMMU API use anyway.
>
> [...]
>
>> +
>> +#define ARM_V7S_BLOCK_SIZE(lvl)		(1UL << ARM_V7S_LVL_SHIFT(lvl))
>> +#define ARM_V7S_LVL_MASK(lvl)		((u32)(~0U << ARM_V7S_LVL_SHIFT(lvl)))
>> +#define ARM_V7S_TABLE_MASK		((u32)(~0U << ARM_V7S_TABLE_SHIFT))
>> +#define _ARM_V7S_IDX_MASK(lvl)		(ARM_V7S_PTES_PER_LVL(lvl) - 1)
>> +#define ARM_V7S_LVL_IDX(addr, lvl)	({				\
>> +	int _l = lvl;							\
>> +	((u32)(addr) >> ARM_V7S_LVL_SHIFT(_l)) & _ARM_V7S_IDX_MASK(_l); \
>> +})
>
> lvl here is not a function, it is 1 or 2, Could we use for simple?
>
> #define ARM_V7S_LVL_IDX(addr, lvl)		\
> 	((u32)(addr) >> ARM_V7S_LVL_SHIFT(lvl)) & _ARM_V7S_IDX_MASK(lvl)

I did actually start off with that, but evaluating macro arguments twice 
isn't the best thing in general, and here specifically it doesn't end 
well in arm_v7s_iova_to_phys(). It seemed more consistent to keep this 
as a macro defined in terms of the other macros, and nicer to make it 
robust rather than just hide the problem by massaging the call sites.

>> +static arm_v7s_iopte arm_v7s_cont_to_pte(arm_v7s_iopte pte, int lvl)
>> +{
>> +	if (lvl == 1) {
>> +		pte &= ~ARM_V7S_CONT_SECTION;
>> +	} else if (lvl == 2) {
>> +		arm_v7s_iopte xn = pte & BIT(ARM_V7S_CONT_PAGE_XN_SHIFT);
>> +		arm_v7s_iopte tex = pte & (ARM_V7S_CONT_PAGE_TEX_MASK <<
>> +					   ARM_V7S_CONT_PAGE_TEX_SHIFT);
>> +
>> +		pte ^= xn | tex;
>> +		pte |= (xn >> ARM_V7S_CONT_PAGE_XN_SHIFT) |
>> +		       (tex >> ARM_V7S_CONT_PAGE_TEX_SHIFT);
>> +		pte ^= ARM_V7S_PTE_TYPE_PAGE | ARM_V7S_PTE_TYPE_CONT_PAGE;
>
>      If XN bit is 1, We may lost XN bit for small page here.
>
>      We could runs ok as we have IO_PGTABLE_QUIRK_NO_PERMS.
>
>      Maybe this is enough: pte ^= ARM_V7S_PTE_TYPE_PAGE;

Ah, you're right - the logic of pte_to_cont doesn't quite work in 
reverse as I seem to have assumed here; we need to flip the type bits to 
clear bit 0 _before_ inserting xn.

>> +	}
>> +	return pte;
>> +}
>> +
>> +static bool arm_v7s_pte_is_cont(arm_v7s_iopte pte, int lvl)
>> +{
>> +	if (lvl == 1 && !ARM_V7S_PTE_IS_TABLE(pte, lvl))
>> +		return pte & ARM_V7S_CONT_SECTION;
>> +	else if (lvl == 2)
>> +		return !(pte & ARM_V7S_PTE_TYPE_PAGE);
>> +	return false;
>> +}
>> +
>> +static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *, unsigned long,
>> +			   size_t, int, arm_v7s_iopte *);
>> +
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
>
>     If somebody abuse the mapping, He map 4K firstly, then map 1M in the
> same iova address(don't unmap the 4K before), then it will also enter
> here to free the existed lvl2 pagetable silently. Should we add a
> checking whether the existed pagetable is empty? if the pagetable is not
> empty, return a warning.

Hmm, seems that's just a consequence of how unmap works. Looks like you 
could conversely also map one page, unmap that page, then bogusly unmap 
the corresponding section and have that succeed by hitting the empty table.

It's nice to have simple sanity-checks where they naturally fit in, but 
I'm less convinced of the value of going out of our way purely to 
validate broken callers - it's maybe not too big a deal in this case, 
but the worst-case scenario under LPAE would have such a check recursing 
through 262,144 entries over 2 levels of tables. From a quick look 
through other IOMMU drivers, nobody else who makes use of 
intermediate-level block mappings seems to bother with such a check either.

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
>
>      if "i" isn't 0 here(There is a pgtable item in a supersection), it
> seems not right. Maybe:
>
>      tblp = ptep + i - ARM_V7S_LVL_IDX(iova + i * sz, lvl);
>      if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz, sz, lvl, tblp)
> 		!= sz))

Ugh, yes. It looks like we would still end up unmapping the right 
entries through keeping the index constant and incrementing the table 
pointer instead (!?), but that doesn't save us from TLBI'ing the same 
IOVA 16 times and missing the rest. Oops.

>> +				return -EINVAL;
>> +		} else if (ptep[i]) {
>> +			/* We require an unmap first */
>> +			WARN_ON(!selftest_running);
>> +			return -EEXIST;
>> +		}
>> +
>
> [...]
>
>> +static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
>> +				   unsigned long iova, size_t size,
>> +				   arm_v7s_iopte *ptep)
>> +{
>> +	unsigned long blk_start, blk_end, blk_size;
>> +	phys_addr_t blk_paddr;
>> +	arm_v7s_iopte table = 0;
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>> +	int prot = arm_v7s_pte_to_prot(*ptep, 1);
>> +
>> +	blk_size = ARM_V7S_BLOCK_SIZE(1);
>> +	blk_start = iova & ARM_V7S_LVL_MASK(1);
>> +	blk_end = blk_start + ARM_V7S_BLOCK_SIZE(1);
>> +	blk_paddr = *ptep & ARM_V7S_LVL_MASK(1);
>> +
>> +	for (; blk_start < blk_end; blk_start += size, blk_paddr += size) {
>> +		arm_v7s_iopte *tablep;
>> +
>> +		/* Unmap! */
>> +		if (blk_start == iova)
>> +			continue;
>> +
>> +		/* __arm_v7s_map expects a pointer to the start of the table */
>> +		tablep = &table - ARM_V7S_LVL_IDX(blk_start, 1);
>
>     The "table" seems not be initialized here. (LPAE too.) maybe I don't
> get it here.

It took me about 2 hours of staring at the original code to fully get my 
head round it, too ;) The comment would perhaps be better worded as 
"__arm_v7s_map expects a pointer to the start of *a* table". What we're 
doing is building up the whole level 2 table (with the relevant pages 
mapped) in advance _before_ touching the live level 1 table. Since 
__arm_v7s_map() is going to take the table pointer we pass and write an 
entry for the new level 2 table at the relevant index, we construct 
_just that entry_ ("arm_v7s_iopte table = 0;") and fake up a 
corresponding 'level 1 table pointer' - chances are that tablep itself 
is dangling way off the bottom of the stack somewhere, but the only 
entry in that 'table' that's going to be dereferenced is the one backed 
by the local variable.

>     If we would like to get the start of the table, maybe :
>
>     tablep = ptep - ARM_V7S_LVL_IDX(blk_start, 1);
>
>      Even though we change "tablep" here, it will also fail in the
> __arm_v7s_map since there is a value in current ptep(the pa of the
> section), then it will call iopte_deref instread of creating a new
> pgtable in the __arm_v7s_map below, then it will abort.
>
> so maybe we need unmap the ptep before this "for" loop.
> __arm_v7s_set_pte(ptep, 0, 1, cfg);
>
>> +		if (__arm_v7s_map(data, blk_start, blk_paddr, size, prot, 1,
>> +				  tablep) < 0) {
>> +			if (table) {
>> +				/* Free the table we allocated */
>> +				tablep = iopte_deref(table, 1);
>> +				__arm_v7s_free_table(tablep, 2, data);
>
> Following Will's quesion before, do we need flush tlb here?

No; this is just cleaning up the uncommitted preparatory work if map 
failure left a partially-created next-level table - in fact, now that I 
look at it, with only two levels the only way that can happen is if we 
allocate a new empty table but find nonzero entries when installing the 
PTEs, and that suggests a level of system corruption I'm not sure it's 
even worth trying to handle.

Anyway, from the IOMMU's perspective, at this point it knows nothing 
about the new table and the section mapping is still live...

>> +			}
>> +			return 0; /* Bytes unmapped */
>> +		}
>> +	}
>> +
>> +	__arm_v7s_set_pte(ptep, table, 1, cfg);
>
>      Is this in order to update the lvl2 pgtable base address? why it's
> not updated in __arm_v7s_map which create a lvl2 pgtable?

...until here, when we drop the table entry over the top of the section 
entry and TLBI the section, for an atomic valid->valid transition.

>> +	iova &= ~(blk_size - 1);
>> +	cfg->tlb->tlb_add_flush(iova, blk_size, blk_size, true, data->iop.cookie);
>> +	return size;
>> +}
>> +
>
> All the others looks good for me. Thanks.

Cool, thanks. I'll send out a proper v3 once everyone's finished with 
merge window stuff, but below is the local diff I now have.

Robin.

---->8----
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c 
b/drivers/iommu/io-pgtable-arm-v7s.c
index 0b9fea5..d39a021 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -296,10 +296,10 @@ static arm_v7s_iopte 
arm_v7s_pte_to_cont(arm_v7s_iopte pte, int lvl)
  		arm_v7s_iopte xn = pte & ARM_V7S_ATTR_XN(lvl);
  		arm_v7s_iopte tex = pte & ARM_V7S_CONT_PAGE_TEX_MASK;

-		pte ^= xn | tex;
+		pte ^= xn | tex | ARM_V7S_PTE_TYPE_PAGE;
  		pte |= (xn << ARM_V7S_CONT_PAGE_XN_SHIFT) |
-		       (tex << ARM_V7S_CONT_PAGE_TEX_SHIFT);
-		pte ^= ARM_V7S_PTE_TYPE_PAGE | ARM_V7S_PTE_TYPE_CONT_PAGE;
+		       (tex << ARM_V7S_CONT_PAGE_TEX_SHIFT) |
+		       ARM_V7S_PTE_TYPE_CONT_PAGE;
  	}
  	return pte;
  }
@@ -313,10 +313,10 @@ static arm_v7s_iopte 
arm_v7s_cont_to_pte(arm_v7s_iopte pte, int lvl)
  		arm_v7s_iopte tex = pte & (ARM_V7S_CONT_PAGE_TEX_MASK <<
  					   ARM_V7S_CONT_PAGE_TEX_SHIFT);

-		pte ^= xn | tex;
+		pte ^= xn | tex | ARM_V7S_PTE_TYPE_CONT_PAGE;
  		pte |= (xn >> ARM_V7S_CONT_PAGE_XN_SHIFT) |
-		       (tex >> ARM_V7S_CONT_PAGE_TEX_SHIFT);
-		pte ^= ARM_V7S_PTE_TYPE_PAGE | ARM_V7S_PTE_TYPE_CONT_PAGE;
+		       (tex >> ARM_V7S_CONT_PAGE_TEX_SHIFT) |
+		       ARM_V7S_PTE_TYPE_PAGE;
  	}
  	return pte;
  }
@@ -350,9 +350,9 @@ static int arm_v7s_init_pte(struct 
arm_v7s_io_pgtable *data,
  			arm_v7s_iopte *tblp;
  			size_t sz = ARM_V7S_BLOCK_SIZE(lvl);

-			tblp = ptep + i - ARM_V7S_LVL_IDX(iova, lvl);
-			if (WARN_ON(__arm_v7s_unmap(data, iova, sz, lvl, tblp)
-					!= sz))
+			tblp = ptep - ARM_V7S_LVL_IDX(iova, lvl);
+			if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz,
+						    sz, lvl, tblp) != sz))
  				return -EINVAL;
  		} else if (ptep[i]) {
  			/* We require an unmap first */
