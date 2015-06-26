From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Fri, 26 Jun 2015 15:30:06 +0800
Message-ID: <1435303806.17055.93.camel@mhfsdcap03>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
	<1431683009-18158-4-git-send-email-yong.wu@mediatek.com>
	<20150605131201.GF1198@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150605131201.GF1198-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.>
List-Id: iommu@lists.linux-foundation.org

Hi Will,
   Thanks very much for your review.
   Sorry for reply so late, I need some time to test the split.
   I will improve in next version following your suggestion.
   There are some place please help check my comment.

On Fri, 2015-06-05 at 14:12 +0100, Will Deacon wrote:
> Hello,
> 
> Thanks for the patch, it's good to see another user of the generic
> IO page-table code. However, I have quite a lot of comments on the code.
> 
> On Fri, May 15, 2015 at 10:43:26AM +0100, Yong Wu wrote:
> > This patch is for ARM Short Descriptor Format.It has 2-levels
> > pagetable and the allocator supports 4K/64K/1M/16M.
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/iommu/Kconfig                |   7 +
> >  drivers/iommu/Makefile               |   1 +
> >  drivers/iommu/io-pgtable-arm-short.c | 490 +++++++++++++++++++++++++++++++++++
> >  drivers/iommu/io-pgtable.c           |   4 +
> >  drivers/iommu/io-pgtable.h           |   6 +
> >  5 files changed, 508 insertions(+)
> >  create mode 100644 drivers/iommu/io-pgtable-arm-short.c
> 
> For some reason, I ended up reviewing this back-to-front (i.e. starting
> with the init code), so apologies if the comments feel like they were
> written in reverse.
> 
[snip]
> > +typedef u32 arm_short_iopte;
> > +
> > +struct arm_short_io_pgtable {
> > +       struct io_pgtable       iop;
> > +       struct kmem_cache       *ptekmem;
> > +       size_t                  pgd_size;
> > +       void                    *pgd;
> > +};
> > +
> > +#define io_pgtable_short_to_data(x)                            \
> > +       container_of((x), struct arm_short_io_pgtable, iop)
> > +
> > +#define io_pgtable_ops_to_pgtable(x)                           \
> > +       container_of((x), struct io_pgtable, ops)
> > +
> > +#define io_pgtable_short_ops_to_data(x)                                \
> > +       io_pgtable_short_to_data(io_pgtable_ops_to_pgtable(x))
> > +
> 
> These are private macros, so I think you can drop the "short" part to,
> err, keep them short.

I will delete "short" in the definitions.

And io_pgtable_ops_to_pgtable is same with the one in LPAE.
How about move it to alongside the definition of struct io_pgtable in
io-pgtable.h and also delete it in io-pgtable-arm.c?.


> > +#define ARM_SHORT_MAX_ADDR_BITS                        32
> > +
> > +#define ARM_SHORT_PGDIR_SHIFT                  20
> > +#define ARM_SHORT_PAGE_SHIFT                   12
> > +#define ARM_SHORT_PTRS_PER_PTE                 256
> > +#define ARM_SHORT_BYTES_PER_PTE                        1024
> 
> Isn't that ARM_SHORT_PTRS_PER_PTE * sizeof(arm_short_iopte)?
> 
> > +/* 1 level pagetable */
> > +#define ARM_SHORT_F_PGD_TYPE_PAGE              (0x1)
> 
> I think you're using PAGE and PGTABLE interchangeably, which is really
> confusing to read.
> 
> > +#define ARM_SHORT_F_PGD_TYPE_PAGE_MSK          (0x3)
> 
> This is the TYPE mask.
> 
> > +#define ARM_SHORT_F_PGD_TYPE_SECTION           (0x2)
> > +#define ARM_SHORT_F_PGD_TYPE_SUPERSECTION      (0x2 | (1 << 18))
> 
> Are you sure this is correct? afaict, bit 0 is PXN, so you should actually
> be using bit 18 to distinguihs sections and supersections.
Thanks.
I will change all like this, is it ok?
//===
#define ARM_SHORT_PGD_TYPE_PGTABLE		BIT(0)
#define ARM_SHORT_PGD_TYPE_SECTION		BIT(1)
#define ARM_SHORT_PGD_B_BIT			BIT(2)
#define ARM_SHORT_PGD_C_BIT			BIT(3)
#define ARM_SHORT_PGD_NS_PGTABLE_BIT		BIT(3)
#define ARM_SHORT_PGD_IMPLE_BIT			BIT(9)
#define ARM_SHORT_PGD_TEX0_BIT			BIT(12)
#define ARM_SHORT_PGD_S_BIT			BIT(16)
#define ARM_SHORT_PGD_SUPERSECTION_BIT		BIT(18)
#define ARM_SHORT_PGD_NS_SECTION_BIT		BIT(19)

#define ARM_SHORT_PGD_TYPE_SUPERSECTION		\
	(ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_SUPERSECTION_BIT)
#define ARM_SHORT_PGD_PGTABLE_MSK		(0x3)
#define ARM_SHORT_PGD_SECTION_MSK		\
	(ARM_SHORT_PGD_PGTABLE_MSK | ARM_SHORT_PGD_SUPERSECTION_BIT)
//=====

> > +#define ARM_SHORT_F_PGD_TYPE_SECTION_MSK       (0x3 | (1 << 18))
> > +#define ARM_SHORT_F_PGD_TYPE_IS_PAGE(pgd)      (((pgd) & 0x3) == 1)
> 
> Use your TYPE mask here.
> 
> > +#define ARM_SHORT_F_PGD_TYPE_IS_SECTION(pgd)           \
> > +       (((pgd) & ARM_SHORT_F_PGD_TYPE_SECTION_MSK)     \
> > +               == ARM_SHORT_F_PGD_TYPE_SECTION)
> > +#define ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(pgd)      \
> > +       (((pgd) & ARM_SHORT_F_PGD_TYPE_SECTION_MSK)     \
> > +               == ARM_SHORT_F_PGD_TYPE_SUPERSECTION)
> > +
> > +#define ARM_SHORT_F_PGD_B_BIT                  BIT(2)
> > +#define ARM_SHORT_F_PGD_C_BIT                  BIT(3)
> > +#define ARM_SHORT_F_PGD_IMPLE_BIT              BIT(9)
> > +#define ARM_SHORT_F_PGD_S_BIT                  BIT(16)
> > +#define ARM_SHORT_F_PGD_NG_BIT                 BIT(17)
> > +#define ARM_SHORT_F_PGD_NS_BIT_PAGE            BIT(3)
> > +#define ARM_SHORT_F_PGD_NS_BIT_SECTION         BIT(19)
> > +
> > +#define ARM_SHORT_F_PGD_PA_PAGETABLE_MSK       0xfffffc00
> > +#define ARM_SHORT_F_PGD_PA_SECTION_MSK         0xfff00000
> > +#define ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK    0xff000000
> > +
[snip]
> > +static int _arm_short_check_free_pte(struct arm_short_io_pgtable *data,
> > +                                    arm_short_iopte *pgd)
> > +{
> > +       arm_short_iopte *pte;
> > +       int i;
> > +
> > +       pte = ARM_SHORT_GET_PTE_VA(*pgd);
> > +
> > +       for (i = 0; i < ARM_SHORT_PTRS_PER_PTE; i++) {
> > +               if (pte[i] != 0)
> > +                       return 1;
> 
> -EEXIST?
> 
> > +       }
> > +
> > +       /* Free PTE */
> > +       kmem_cache_free(data->ptekmem, pte);
> > +       *pgd = 0;
> 
> I don't think this is safe, as there's a window where the page table
> walker can see the freed pte memory.

   Sorry, this function read badly. Originally I expected this function
could check all the ptes in the level-2 pagetable.
   I prepare to change the function name and the return type like below,
if all the pte is 0, then free whole the level-2 pagetable and return
true, if there are some other pte remain who isn't unmapped, it return
false.
static bool arm_short_free_wholepte(struct arm_short_io_pgtable *data,
				    arm_short_iopte *pgd)

> > +
> > +       return 0;
> > +}
> > +
> > +static int arm_short_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> > +                          size_t size)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       arm_short_iopte *pgd;
> > +       unsigned long iova_start = iova;
> > +       unsigned long long end_plus_1 = iova + size;
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       void *cookie = data->iop.cookie;
> > +       int ret;
> > +
> > +       do {
> > +               pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
> > +
> > +               if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> > +                       arm_short_iopte *pte;
> > +                       unsigned int pte_offset;
> > +                       unsigned int num_to_clean;
> > +
> > +                       pte_offset = ARM_SHORT_PTE_IDX(iova);
> > +                       num_to_clean =
> > +                           min((unsigned int)((end_plus_1 - iova) / PAGE_SIZE),
> > +                               (ARM_SHORT_PTRS_PER_PTE - pte_offset));
> > +
> > +                       pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +
> > +                       memset(pte, 0, num_to_clean * sizeof(arm_short_iopte));
> > +
> > +                       ret = _arm_short_check_free_pte(data, pgd);
> > +                       if (ret == 1)/* pte is not freed, need to flush pte */
> > +                               tlb->flush_pgtable(
> > +                                       pte,
> > +                                       num_to_clean * sizeof(arm_short_iopte),
> > +                                       cookie);
> > +                       else
> > +                               tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> > +                                                  cookie);
> 
> Hopefully this can be cleaned up when you remove the outer loop and you
> can use the size parameter to figure out which level to unmap.
> 
> > +                       iova += num_to_clean << PAGE_SHIFT;
> > +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SECTION(*pgd)) {
> > +                       *pgd = 0;
> > +
> > +                       tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> > +                                          cookie);
> > +                       iova += SZ_1M;
> 
> Again, these sizes can be derived from other page table properties that
> you have.
> 
> > +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> > +                       arm_short_iopte *start;
> > +
> > +                       start = arm_short_supersection_start(pgd);
> > +                       if (unlikely(start != pgd))
> > +                               pr_warn("%s:suppersection start isn't aligned.iova=0x%lx,pgd=0x%x\n",
> > +                                       __func__, iova, *pgd);
> > +
> > +                       memset(start, 0, 16 * sizeof(arm_short_iopte));
> > +
> > +                       tlb->flush_pgtable(start, 16 * sizeof(arm_short_iopte),
> > +                                          cookie);
> > +
> > +                       iova = (iova + SZ_16M) & (~(SZ_16M - 1));
> 
> See later, but I think supersections should not be assumed by default.
> 
> > +               } else {
> > +                       break;
> > +               }
> > +       } while (iova < end_plus_1 && iova);
> 
> I don't think you need this loop -- unmap will be called in page-sized
> chunks (where page-size refers to units as advertised in your IOMMU's
> pgsize_bitmap). The tricky part is when somebody unmaps a subset of a
> previous mapping that ended up using something like a section. You need
> to handle that here by splitting blocks at level 1 into a table and
> allocating a level 2.

 I will delete the loop and get the size from the pagetable properties.
 About the split, I have a question,
 There are some lines in the self test of LPAE:
        //====
	/* Partial unmap */
	size = 1UL << __ffs(cfg->pgsize_bitmap);
	if (ops->unmap(ops, SZ_1G + size, size) != size)
		return __FAIL(ops, i);
        //====
 If it is changed to:
      if (ops->unmap(ops, SZ_1G + 3*size, size) != size)
 or 
      if (ops->unmap(ops, SZ_1G + size, 3*size) != size)
 It seems don't work. I think it may be never happened if the map and
unmap is from iommu_map and iommu_unmap, I don't know whether somebody
will unmap subset of a previous mapping randomly like above. so I am
sure whether I should cover this two cases in short-descriptor.

> 
> > +
> > +       tlb->tlb_add_flush(iova_start, size, true, cookie);
> > +
> > +       return 0;
> 
> You need to return the size of the region that you managed to unmap, so
> 0 isn't right here.
> 
> > +}
> > +
> > +static arm_short_iopte __arm_short_pte_port(unsigned int prot, bool large)
> > +{
> > +       arm_short_iopte pteprot;
> > +
> > +       pteprot = ARM_SHORT_F_PTE_S_BIT;
> > +
> > +       pteprot |= large ? ARM_SHORT_F_PTE_TYPE_LARGE :
> > +                               ARM_SHORT_F_PTE_TYPE_SMALL;
> > +
> > +       if (prot & IOMMU_CACHE)
> > +               pteprot |=  ARM_SHORT_F_PTE_B_BIT | ARM_SHORT_F_PTE_C_BIT;
> 
> Where do you set TEX[0] for write-allocate?
I will add:
	if (prot & IOMMU_WRITE)
		pteprot |= ARM_SHORT_PTE_TEX0_BIT;
> 
> > +       return pteprot;
> > +}
> > +
> > +static arm_short_iopte __arm_short_pgd_port(int prot, bool super)
> > +{
> > +       arm_short_iopte pgdprot;
> > +
> > +       pgdprot = ARM_SHORT_F_PGD_S_BIT;
> > +       pgdprot |= super ? ARM_SHORT_F_PGD_TYPE_SUPERSECTION :
> > +                               ARM_SHORT_F_PGD_TYPE_SECTION;
> > +       if (prot & IOMMU_CACHE)
> > +               pgdprot |= ARM_SHORT_F_PGD_C_BIT | ARM_SHORT_F_PGD_B_BIT;
> > +
> > +       return pgdprot;
> > +}
> > +
> > +static int _arm_short_map_page(struct arm_short_io_pgtable *data,
> > +                              unsigned int iova, phys_addr_t pa,
> > +                              unsigned int prot, bool largepage)
> > +{
> > +       arm_short_iopte *pgd = data->pgd;
> > +       arm_short_iopte *pte;
> > +       arm_short_iopte pgdprot, pteprot;
> > +       arm_short_iopte mask = largepage ? ARM_SHORT_F_PTE_PA_LARGE_MSK :
> > +                                               ARM_SHORT_F_PTE_PA_SMALL_MSK;
> > +       int i, ptenum = largepage ? 16 : 1;
> > +       bool ptenew = false;
> > +       void *pte_new_va;
> > +       void *cookie = data->iop.cookie;
> > +
> > +       if ((iova | pa) & (~mask)) {
> > +               pr_err("IOVA|PA Not Aligned(iova=0x%x pa=0x%pa type=%s)\n",
> > +                      iova, &pa, largepage ? "large page" : "small page");
> > +               return -EINVAL;
> > +       }
> > +
> > +       pgdprot = ARM_SHORT_F_PGD_TYPE_PAGE;
> > +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> > +               pgdprot |= ARM_SHORT_F_PGD_NS_BIT_PAGE;
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       if (!(*pgd)) {
> > +               pte_new_va = kmem_cache_zalloc(data->ptekmem, GFP_KERNEL);
> > +               if (unlikely(!pte_new_va)) {
> > +                       pr_err("Failed to alloc pte\n");
> > +                       return -ENOMEM;
> > +               }
> > +
> > +               /* Check pte alignment -- must 1K align */
> > +               if (unlikely((unsigned long)pte_new_va &
> > +                            (ARM_SHORT_BYTES_PER_PTE - 1))) {
> > +                       pr_err("The new pte is not aligned! (va=0x%p)\n",
> > +                              pte_new_va);
> > +                       kmem_cache_free(data->ptekmem, (void *)pte_new_va);
> > +                       return -ENOMEM;
> > +               }
> 
> How are you enforcing this alignment?

I will delete this.

> 
> > +               ptenew = true;
> > +               *pgd = virt_to_phys(pte_new_va) | pgdprot;
> > +               kmemleak_ignore(pte_new_va);
> 
> Maybe you should be using alloc_pages instead of your kmem_cache (I mention
> this again later on).
> 
> > +               data->iop.cfg.tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> > +                                                cookie);
> > +       } else {
> > +               /* Someone else may have allocated for this pgd */
> > +               if (((*pgd) & (~ARM_SHORT_F_PGD_PA_PAGETABLE_MSK)) != pgdprot) {
> > +                       pr_err("The prot of old pgd is not Right!iova=0x%x pgd=0x%x pgprot=0x%x\n",
> > +                              iova, (*pgd), pgdprot);
> 
> You can probably just WARN here, as I do in the LPAE code. It shows a bug
> in the caller of the API.
Sorry, I don't see it in LPAE, Do you mean these lines in LPAE?
        //====
	/* We require an unmap first */
	if (iopte_leaf(*ptep, lvl)) {
		WARN_ON(!selftest_running);
		return -EEXIST;
	}
        //====
It may be not the same. Here we only check whether the prot of the old
pgd is same with the current pgd.
I will change it to WARN_ON(1) too.
> 
> > +                       return -EEXIST;
> > +               }
> > +       }
> > +
> > +       pteprot = (arm_short_iopte)pa;
> > +       pteprot |= __arm_short_pte_port(prot, largepage);
> > +
> > +       pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +
> > +       pr_debug("iova:0x%x,pte:0x%p(0x%x),prot:0x%x-%s\n",
> > +                iova, pte, ARM_SHORT_PTE_IDX(iova), pteprot,
> > +                largepage ? "large page" : "small page");
> > +
> > +       for (i = 0; i < ptenum; i++) {
> > +               if (pte[i]) {
> > +                       pr_err("The To-Map pte exists!(iova=0x%x pte=0x%x i=%d)\n",
> > +                              iova, pte[i], i);
> > +                       goto err_out;
I will change to WARN_ON(1) here too.
> > +               }
> > +               pte[i] = pteprot;
> > +       }
> 
> I don't think you need this loop; you should only be given a page size,
> like with unmap.

   I am not sure I follow your meaning.The ptenum here is only 1 or 16.
It is 1 while current is small page and section. It is 16 while current
is large page or super section.
Because the descriptor should be repeated 16 consecutive, I use a loop
here.
> 
> > +
> > +       data->iop.cfg.tlb->flush_pgtable(pte, ptenum * sizeof(arm_short_iopte),
> > +                                        cookie);
> > +       return 0;
> > +
> > + err_out:
> > +       for (i--; i >= 0; i--)
> > +               pte[i] = 0;
> > +       if (ptenew)
> > +               kmem_cache_free(data->ptekmem, pte_new_va);
> > +       return -EEXIST;
> > +}
> > +
> > +static int _arm_short_map_section(struct arm_short_io_pgtable *data,
> > +                                 unsigned int iova, phys_addr_t pa,
> > +                                 int prot, bool supersection)
> > +{
> > +       arm_short_iopte pgprot;
> > +       arm_short_iopte mask = supersection ?
> > +                               ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK :
> > +                               ARM_SHORT_F_PGD_PA_SECTION_MSK;
> > +       arm_short_iopte *pgd = data->pgd;
> > +       int i;
> > +       unsigned int pgdnum = supersection ? 16 : 1;
> > +
> > +       if ((iova | pa) & (~mask)) {
> > +               pr_err("IOVA|PA Not Aligned(iova=0x%x pa=0x%pa type=%s)\n",
> > +                      iova, &pa, supersection ? "supersection" : "section");
> > +               return -EINVAL;
> > +       }
> > +
> > +       pgprot = (arm_short_iopte)pa;
> > +
> > +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> > +               pgprot |= ARM_SHORT_F_PGD_NS_BIT_SECTION;
> > +
> > +       pgprot |= __arm_short_pgd_port(prot, supersection);
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       pr_debug("iova:0x%x,pgd:0x%p(0x%p+0x%x),value:0x%x-%s\n",
> > +                iova, pgd, data->pgd, ARM_SHORT_PGD_IDX(iova),
> > +                pgprot, supersection ? "supersection" : "section");
> > +
> > +       for (i = 0; i < pgdnum; i++) {
> > +               if (unlikely(*pgd)) {
> > +                       pr_err("The To-Map pdg exists!(iova=0x%x pgd=0x%x i=%d)\n",
> > +                              iova, pgd[i], i);
> > +                       goto err_out;
> > +               }
> > +               pgd[i] = pgprot;
> > +       }
> 
> Similar comments here.
   I will merge _arm_short_map_page and _arm_short_map_section into one
function named _arm_short_map.
> 
> > +       data->iop.cfg.tlb->flush_pgtable(pgd,
> > +                                        pgdnum * sizeof(arm_short_iopte),
> > +                                        data->iop.cookie);
> > +       return 0;
> > +
> > + err_out:
> > +       for (i--; i >= 0; i--)
> > +               pgd[i] = 0;
> > +       return -EEXIST;
> > +}
> > +
> > +static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
> > +                        phys_addr_t paddr, size_t size, int prot)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       int ret;
> > +
> > +       if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> > +               return -EINVAL;
> 
> Why? You could have (another) quirk to select the access model and you
> should be able to implement read+write, read-only no-exec and no-access.

If I follow it in LAPE like below. is it ok?
//======
	/* If no access, then nothing to do */
	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
		return 0;
//=====
> 
> > +       if (size == SZ_4K) {/* most case */
> > +               ret = _arm_short_map_page(data, iova, paddr, prot, false);
> > +       } else if (size == SZ_64K) {
> > +               ret = _arm_short_map_page(data, iova, paddr, prot, true);
> > +       } else if (size == SZ_1M) {
> > +               ret = _arm_short_map_section(data, iova, paddr, prot, false);
> > +       } else if (size == SZ_16M) {
> > +               ret = _arm_short_map_section(data, iova, paddr, prot, true);
> > +       } else {
> > +               ret = -EINVAL;
> > +       }
> 
> Use a switch statement here?
> 
> > +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> > +       return ret;
> > +}
> > +
> > +static struct io_pgtable *
> > +arm_short_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +       struct arm_short_io_pgtable *data;
> > +
> > +       if (cfg->ias != 32)
> > +               return NULL;
> 
> I think you just need to check '>'; VAs smaller than 32-bit can still
> be translated.
> 
> > +       if (cfg->oas > ARM_SHORT_MAX_ADDR_BITS)
> > +               return NULL;
> 
> What benefit does ARM_SHORT_MAX_ADDR_BITS offer? Why not just '32'?
> 
> > +
> > +       cfg->pgsize_bitmap &= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
> 
> We can't support supersections unconditionally. Please add a quirk for
> this, as it relies on IOMMU support.
> 
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return NULL;
> > +
> > +       data->pgd_size = SZ_16K;
> > +
> > +       data->pgd = alloc_pages_exact(data->pgd_size, GFP_KERNEL | __GFP_ZERO);
> > +       if (!data->pgd)
> > +               goto out_free_data;
> > +
> > +       cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
> 
> We may as well postpone this flush to the end of the function, given that
> we can still fail at this point.
> 
> > +       /* kmem for pte */
> > +       data->ptekmem = kmem_cache_create("short-descriptor-pte",
> 
> A better name would be "io-pgtable-arm-short", however, why can't you
> just use GFP_ATOMIC in your pte allocations and do away with the cache
> altogether? Also, what happens if you try to allocate multiple caches
> with the same name?
   I will add GFP_ATOMIC in pte allocation, It is a bug Daniel has help
to fix it.
   And I am sorry. I don't know what is wrong if using kmem_cache here.
   The main reason is the size. the size of level-2 pgtable is 1KB, and
the alloc_page_exact will be 4KB. so I use kmem_cache here.
> 
> > +                                          ARM_SHORT_BYTES_PER_PTE,
> > +                                          ARM_SHORT_BYTES_PER_PTE,
> > +                                          0, NULL);
> > +
> > +       if (IS_ERR_OR_NULL(data->ptekmem)) {
> 
> I think you just need a NULL check here.
> 
> > +               pr_err("Failed to Create cached mem for PTE %ld\n",
> > +                      PTR_ERR(data->ptekmem));
> 
> I don't think this error is particularly useful.
> 
> > +               goto out_free_pte;
> > +       }
> > +
> > +       /* TTBRs */
> > +       cfg->arm_short_cfg.ttbr[0] = virt_to_phys(data->pgd);
> > +       cfg->arm_short_cfg.ttbr[1] = 0;
> > +
> > +       cfg->arm_short_cfg.tcr = 0;
> > +
> > +       data->iop.ops = (struct io_pgtable_ops) {
> > +               .map            = arm_short_map,
> > +               .unmap          = arm_short_unmap,
> > +               .iova_to_phys   = arm_short_iova_to_phys,
> > +       };
> > +
> > +       return &data->iop;
> > +
> > +out_free_pte:
> > +       free_pages_exact(data->pgd, data->pgd_size);
> > +out_free_data:
> > +       kfree(data);
> > +       return NULL;
> > +}
> > +
> > +static void arm_short_free_pgtable(struct io_pgtable *iop)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_to_data(iop);
> > +
> > +       kmem_cache_destroy(data->ptekmem);
> > +       free_pages_exact(data->pgd, data->pgd_size);
> > +       kfree(data);
> > +}
> > +
> > +struct io_pgtable_init_fns io_pgtable_arm_short_init_fns = {
> > +       .alloc  = arm_short_alloc_pgtable,
> > +       .free   = arm_short_free_pgtable,
> > +};
> > +
> > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > index 6436fe2..14a9b3a 100644
> > --- a/drivers/iommu/io-pgtable.c
> > +++ b/drivers/iommu/io-pgtable.c
> > @@ -28,6 +28,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
> >  extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
> >  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
> >  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
> > +extern struct io_pgtable_init_fns io_pgtable_arm_short_init_fns;
> >
> >  static const struct io_pgtable_init_fns *
> >  io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
> > @@ -38,6 +39,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
> >         [ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
> >         [ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
> >  #endif
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_SHORT
> > +       [ARM_SHORT_DESC] = &io_pgtable_arm_short_init_fns,
> > +#endif
> >  };
> >
> >  struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index 10e32f6..47efaab 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -9,6 +9,7 @@ enum io_pgtable_fmt {
> >         ARM_32_LPAE_S2,
> >         ARM_64_LPAE_S1,
> >         ARM_64_LPAE_S2,
> > +       ARM_SHORT_DESC,
> >         IO_PGTABLE_NUM_FMTS,
> >  };
> >
> > @@ -62,6 +63,11 @@ struct io_pgtable_cfg {
> >                         u64     vttbr;
> >                         u64     vtcr;
> >                 } arm_lpae_s2_cfg;
> > +
> > +               struct {
> > +                       u64     ttbr[2];
> > +                       u64     tcr;
> > +               } arm_short_cfg;
> 
> I appreciate that you're not using TEX remapping, but could we include
> the NMRR and PRRR registers here (we can just zero them) too, please?
> That makes it easier to support a TEX_REMAP quick later on and also sets
> them to a known value.
I will add them and set 0 to them.
	u32	ttbr[2];
	u32	tcr;
+	u32	nmrr;
+	u32	prrr;
   And According to Robin's suggestion, I will change to u32 in
short-descriptor.
> 
> Also, any chance of some self-tests?
> 
> Will
