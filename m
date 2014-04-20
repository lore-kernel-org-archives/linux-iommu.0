From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] arm: dma-mapping: Fix mapping size value
Date: Mon, 21 Apr 2014 00:36:18 +0200
Message-ID: <1874836.zxC6fKeeQv@avalon>
References: <CAD15aga8DTuzYrPfHF3X=ZvCuCQxfx1nOTk90DdwdxeZvV5tdA@mail.gmail.com>
	<CAD15agbgOhK2b4WaWM4g45iiT7yH8HPYu=GmsOs7BkCnVvjcsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAD15agbgOhK2b4WaWM4g45iiT7yH8HPYu=GmsOs7BkCnVvjcsw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ritesh,

On Saturday 19 April 2014 16:55:30 Ritesh Harjani wrote:
> In explaining the issue below, made a mistake of taking PAGE_SIZE
> instead of PAGE_SHIFT (mistake mentioned inline).
> Although numerical values and patch is correct.

I was about to send the same patch, so, provided you fix the commit message,

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> On Sat, Apr 19, 2014 at 4:49 PM, Ritesh Harjani
> 
> <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > I am finding an oops after following commit. I am on 3.10.30 kernel but
> > applied all the latest patches from arch/arm/mm/dma-mapping.c
> > 
> > I added some debug logs to see what is the error, on which I found that we
> > are incorrectly setting mapping->size value.
> > Please take a look at this and correct me if I am wrong here.
> > 
> > FAULTY COMMIT:
> > commit 68efd7d2fb32c2606f1da318b6a851
> > d933813f27
> > Author: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Date:   Tue Feb 25 13:01:09 2014 +0100
> > 
> >     arm: dma-mapping: remove order parameter from
> >     arm_iommu_create_mapping()
> > 
> > OOPS LOGS:
> > [26.898145] __alloc_iova#LINE: 1097 start = 0x3500
> > [26.898159] __alloc_iova#LINE:1136 iova = 0x53500000
> > [26.898170] __alloc_iova#LINE:1138 mapping->base= 0x50000000
> > [26.898181] __alloc_iova#LINE:1140 mapping->size = 0x1000000, i = 0
> > [26.924442] __free_iova, bitmap_index = 3
> > 
> > [Ritesh]: bitmap_index should be 0 for address 0x53500000. see in
> > alloc_iova above.
> > 
> > [26.924454] __free_iova,addr = 0x53500000
> > [26.924463] __free_iova,mapping->base = 0x50000000
> > [26.924472] __free_iova,mapping->size = 0x1000000
> > [26.924482] __free_iova,bitmap_base = 0x53000000
> > [26.924490] __free_iova, start = 0x500
> > 
> > [Ritesh]: start should be 0x3500 for address 0x53500000. see in alloc_iova
> > above.
> > 
> > [26.924533] Unable to handle kernel NULL pointer dereference at virtual
> > address 000000a0
> > [26.924543] pgd = e7a84000
> > [26.924558] [000000a0] *pgd=00000000
> > [26.924572] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> > [26.924598] Modules linked in:
> > [26.924613] CPU: 1 PID: 2263 Comm: BufferLiberator Not tainted 3.10.30+
> > #144
> > [26.924624] task: e7370a40 ti: e6e06000 task.ti: e6e06000
> > [26.924644] PC is at bitmap_clear+0x48/0xd0
> > [26.924659] LR is at __iommu_remove_mapping+0x130/0x164
> > [26.924673] pc : [<c02d0814>]    lr : [<c001bd30>]    psr: 20000093
> > [26.924673] sp : e6e07e20  ip : ffffffff  fp : e6e07e3c
> > [26.924682] r10: 00000500  r9 : c1333ea8  r8 : 80000013
> > [26.924692] r7 : ffffffff  r6 : 00000321  r5 : 000000a0  r4 : 00000028
> > [26.924707] r3 : 00000000  r2 : 00000341  r1 : 00000500  r0 : 00000000
> > [26.924730] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment
> > user
> > [26.924742] Control: 10c5387d  Table: 77a8406a  DAC: 00000015
> > 
> > 
> > See below on how this is wrong:
> > 
> > here iova_base = 0x50000000
> > iova_size = 0x20000000
> > => bits needed to map = 131072.
> > 
> >         => bitmap_size = 0x4000
> >         since bitmap_size > PAGE_SIZE
> >         => bitmap_size = PAGE_SIZE,  extensions = 4;
> > 
> > Now, mapping->size is currently set as bitmap_size << PAGE_SHIFT.
> > 
> >         =>mapping->size = 0x1000000.
> > 
> > mapping->size is the IOVA size, which one bitmap can address.
> > 
> > Now mapping->size * extensions should be size (0x20000000).
> > which is not true, => our bitmap_size is set wrong.
> > 
> > it should be (mapping->bits << PAGE_SIZE) or say
> 
> It should be PAGE_SHIFT here.
> 
> > (BITS_PER_BYTE * bitmap_size << PAGE_SIZE)
> 
> It should be PAGE_SHIFT here.
> 
> >         => (8 * 0x1000) << 12) = 0x8000000
> > 
> > With this IOVA_SIZE = extensions * mapping->size = 0x20000000
> > 
> > 
> > 
> > PATCH:
> > 
> > Currently mapping->size is wrongly set resulting
> > in OOPS (atleast we see OOPS with extension 4).
> > 
> > Fix this.
> > 
> > Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > 
> >  arch/arm/mm/dma-mapping.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index f62aa06..d1701a2 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1963,8 +1963,8 @@ arm_iommu_create_mapping(struct bus_type *bus,
> > dma_addr_t base, size_t size)
> >         mapping->nr_bitmaps = 1;
> >         mapping->extensions = extensions;
> >         mapping->base = base;
> > -       mapping->size = bitmap_size << PAGE_SHIFT;
> >         mapping->bits = BITS_PER_BYTE * bitmap_size;
> > +       mapping->size = mapping->bits << PAGE_SHIFT;
> > 
> >         spin_lock_init(&mapping->lock);
> > 

-- 
Regards,

Laurent Pinchart
