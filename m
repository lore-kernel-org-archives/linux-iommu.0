From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
	support
Date: Mon, 18 Jan 2016 15:22:40 +0800
Message-ID: <1453101760.10698.4.camel@mhfsdcap03>
References: <cover.1450383740.git.robin.murphy@arm.com>
	<ddfe960ef1da22e5264811bfcafeb412fa976f4a.1450383740.git.robin.murphy@arm.com>
	<1452776704.15636.59.camel@mhfsdcap03> <56990CAC.5020606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56990CAC.5020606-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2016-01-15 at 15:13 +0000, Robin Murphy wrote:
> On 14/01/16 13:05, Yong Wu wrote:
> > On Thu, 2015-12-17 at 20:50 +0000, Robin Murphy wrote:
> >> Add a nearly-complete ARMv7 short descriptor implementation, omitting
> >> only a few legacy and CPU-centric aspects which shouldn't be necessary
> >> for IOMMU API use anyway.

[...]

> >> +static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
> >> +				   unsigned long iova, size_t size,
> >> +				   arm_v7s_iopte *ptep)
> >> +{
> >> +	unsigned long blk_start, blk_end, blk_size;
> >> +	phys_addr_t blk_paddr;
> >> +	arm_v7s_iopte table = 0;
> >> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> >> +	int prot = arm_v7s_pte_to_prot(*ptep, 1);
> >> +
> >> +	blk_size = ARM_V7S_BLOCK_SIZE(1);
> >> +	blk_start = iova & ARM_V7S_LVL_MASK(1);
> >> +	blk_end = blk_start + ARM_V7S_BLOCK_SIZE(1);
> >> +	blk_paddr = *ptep & ARM_V7S_LVL_MASK(1);
> >> +
> >> +	for (; blk_start < blk_end; blk_start += size, blk_paddr += size) {
> >> +		arm_v7s_iopte *tablep;
> >> +
> >> +		/* Unmap! */
> >> +		if (blk_start == iova)
> >> +			continue;
> >> +
> >> +		/* __arm_v7s_map expects a pointer to the start of the table */
> >> +		tablep = &table - ARM_V7S_LVL_IDX(blk_start, 1);
> >
> >     The "table" seems not be initialized here. (LPAE too.) maybe I don't
> > get it here.
> 
> It took me about 2 hours of staring at the original code to fully get my 
> head round it, too ;) The comment would perhaps be better worded as 
> "__arm_v7s_map expects a pointer to the start of *a* table". What we're 
> doing is building up the whole level 2 table (with the relevant pages 
> mapped) in advance _before_ touching the live level 1 table. Since 
> __arm_v7s_map() is going to take the table pointer we pass and write an 
> entry for the new level 2 table at the relevant index, we construct 
> _just that entry_ ("arm_v7s_iopte table = 0;") and fake up a 
> corresponding 'level 1 table pointer' - chances are that tablep itself 
> is dangling way off the bottom of the stack somewhere, but the only 
> entry in that 'table' that's going to be dereferenced is the one backed 
> by the local variable.

(Resend since some words are wrong.)

Thanks for this comment, I get it.

It works well but I still don't think "tablep" is safe here. Currently
it must rely on "ptep += ARM_V7S_LVL_IDX(iova, lvl)" in the
__arm_v7s_map. this may be dangerous if __arm_v7s_map is changed in the
future. and at least it is not readable, 2 hours is needed even though
it's you;).

And the lvl is always 1 in the __arm_v7s_map below, so "tablep" is
expected to be the start of the lvl1 table rather than the start of *a*
table.

> 
> >     If we would like to get the start of the table, maybe :
> >
> >     tablep = ptep - ARM_V7S_LVL_IDX(blk_start, 1);
> >
> >      Even though we change "tablep" here, it will also fail in the
> > __arm_v7s_map since there is a value in current ptep(the pa of the
> > section), then it will call iopte_deref instread of creating a new
> > pgtable in the __arm_v7s_map below, then it will abort.
> >
> > so maybe we need unmap the ptep before this "for" loop.
> > __arm_v7s_set_pte(ptep, 0, 1, cfg);
> >
> >> +		if (__arm_v7s_map(data, blk_start, blk_paddr, size, prot, 1,
> >> +				  tablep) < 0) {
> >> +			if (table) {
> >> +				/* Free the table we allocated */
> >> +				tablep = iopte_deref(table, 1);
> >> +				__arm_v7s_free_table(tablep, 2, data);
> >
> > Following Will's quesion before, do we need flush tlb here?
> 
> No; this is just cleaning up the uncommitted preparatory work if map 
> failure left a partially-created next-level table - in fact, now that I 
> look at it, with only two levels the only way that can happen is if we 
> allocate a new empty table but find nonzero entries when installing the 
> PTEs, and that suggests a level of system corruption I'm not sure it's 
> even worth trying to handle.
> 
> Anyway, from the IOMMU's perspective, at this point it knows nothing 
> about the new table and the section mapping is still live...
> 
> >> +			}
> >> +			return 0; /* Bytes unmapped */
> >> +		}
> >> +	}
> >> +
> >> +	__arm_v7s_set_pte(ptep, table, 1, cfg);
> >
> >      Is this in order to update the lvl2 pgtable base address? why it's
> > not updated in __arm_v7s_map which create a lvl2 pgtable?
> 
> ...until here, when we drop the table entry over the top of the section 
> entry and TLBI the section, for an atomic valid->valid transition.
> 
> >> +	iova &= ~(blk_size - 1);
> >> +	cfg->tlb->tlb_add_flush(iova, blk_size, blk_size, true, data->iop.cookie);
> >> +	return size;
> >> +}
> >> +
> >
> > All the others looks good for me. Thanks.
> 
> Cool, thanks. I'll send out a proper v3 once everyone's finished with 
> merge window stuff, but below is the local diff I now have.
> 
> Robin.
[...]
