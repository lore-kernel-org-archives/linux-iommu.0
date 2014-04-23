From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dma-mapping: Fix mapping size value
Date: Wed, 23 Apr 2014 10:53:24 +0200
Message-ID: <53577F84.1080101@samsung.com>
References: <1398062847-5770-1-git-send-email-ritesh.harjani@gmail.com>
	<1398062847-5770-2-git-send-email-ritesh.harjani@gmail.com>
	<20140422085307.GB5747@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140422085307.GB5747-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mp.vikram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <mp.vikram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "menon.vinayak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <menon.vinayak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-04-22 10:53, Will Deacon wrote:
> On Mon, Apr 21, 2014 at 07:47:27AM +0100, Ritesh Harjani wrote:
> > 68efd7d2fb("arm: dma-mapping: remove order parameter from
> > arm_iommu_create_mapping()") is causing kernel panic
> > because it wrongly sets the value of mapping->size:
> >
> > Unable to handle kernel NULL pointer dereference at virtual
> > address 000000a0
> > pgd = e7a84000
> > [000000a0] *pgd=00000000
> > ...
> > PC is at bitmap_clear+0x48/0xd0
> > LR is at __iommu_remove_mapping+0x130/0x164
> >
> > Fix it by correcting mapping->size value.
> >
> > Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> >  arch/arm/mm/dma-mapping.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index f62aa06..6b00be1 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1963,8 +1963,8 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
> >  	mapping->nr_bitmaps = 1;
> >  	mapping->extensions = extensions;
> >  	mapping->base = base;
> > -	mapping->size = bitmap_size << PAGE_SHIFT;
> >  	mapping->bits = BITS_PER_BYTE * bitmap_size;
> > +	mapping->size = mapping->bits << PAGE_SHIFT;
>
> Ok, but given that mapping->size is derived from mapping->bits, do we really
> need both of these fields in struct dma_iommu_mapping?

You are right. I didn't notice this while I was refactoring the code. 
Ritesh,
could you update your patch and simply replace all references of 
mapping->size
with (mapping->bits << PAGE_SHIFT), probably with some temporary variable to
make the code easier to understand? I've didn't apply your patch yet.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
