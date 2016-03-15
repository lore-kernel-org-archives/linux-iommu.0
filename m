From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 04/06] iommu/ipmmu-vmsa: Rework interrupt code and use
 bitmap for context
Date: Tue, 15 Mar 2016 11:36:32 +0900
Message-ID: <CANqRtoTEhxuiOk4frUyLA3uPa9eqcMoF-AE__qY85U14g3=hrw@mail.gmail.com>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
	<20151215120249.26216.25148.sendpatchset@little-apple>
	<2341043.PcEjBaApc7@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2341043.PcEjBaApc7@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, SH-Linux <linux-sh@vger.kernel.org>, joro <joro@8bytes.org>, linux-kernel <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Tue, Dec 29, 2015 at 9:14 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.

Thanks for your feedback!

> On Tuesday 15 December 2015 21:02:49 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Introduce a bitmap for context handing and convert the
>> interrupt routine to go handle all registered contexts.
>>
>> At this point the number of contexts are still limited.
>
> That's all nice, but without seeing support for multiple contexts it's hard to
> tell if the implementation is correct for multiple context purpose.
>
>> The purpose of this patch is to remove the use of the
>> ARM specific mapping variable from ipmmu_irq().
>
> Why do you want to do that ?

The purpose of this series is to be able to use the IPMMU driver on
other architectures than 32-bit ARM. The main goal is to use the
driver on 64-bit ARM where the mapping variable does not exist.

>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  drivers/iommu/ipmmu-vmsa.c |   37 ++++++++++++++++++++++++++-----------
>>  1 file changed, 26 insertions(+), 11 deletions(-)
>>
>> --- 0007/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c   2015-12-15 13:14:35.540513000 +0900
>> @@ -8,6 +8,7 @@
>>   * the Free Software Foundation; version 2 of the License.
>>   */
>>
>> +#include <linux/bitmap.h>
>>  #include <linux/delay.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/err.h>
>> @@ -26,12 +27,16 @@
>>
>>  #include "io-pgtable.h"
>>
>> +#define IPMMU_CTX_MAX 1
>> +
>>  struct ipmmu_vmsa_device {
>>       struct device *dev;
>>       void __iomem *base;
>>       struct list_head list;
>>
>>       unsigned int num_utlbs;
>> +     DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>
> We have up to 4 context on Gen2 and 8 on Gen3, a bitmap might be slightly
> overkill.

Maybe so, but I'd rather use something standard than rolling my own.
Can you think of a better data structure?

>> +     struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>>
>>       struct dma_iommu_mapping *mapping;
>>  };
>> @@ -319,6 +324,7 @@ static struct iommu_gather_ops ipmmu_gat
>>  static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>>  {
>>       phys_addr_t ttbr;
>> +     int ret;
>>
>>       /*
>>        * Allocate the page table operations.
>> @@ -348,10 +354,16 @@ static int ipmmu_domain_init_context(str
>>               return -EINVAL;
>>
>>       /*
>> -      * TODO: When adding support for multiple contexts, find an unused
>> -      * context.
>> +      * Find an unused context.
>
> We need to support multiple devices per context or we will very soon run out
> of contexts. How to pick a proper context is a topic that needs to be
> researched, I believe IOMMU groups might come into play.

The experimental 64-bit ARM patches for this driver (on top of this
series) that I've posted makes use of IOMMU groups.

>>        */
>> -     domain->context_id = 0;
>> +     ret = bitmap_find_free_region(domain->mmu->ctx, IPMMU_CTX_MAX, 0);
>> +     if (ret < 0) {
>> +             free_io_pgtable_ops(domain->iop);
>> +             return ret;
>> +     }
>> +
>> +     domain->context_id = ret;
>> +     domain->mmu->domains[ret] = domain;
>
> This requires locking to protect against races with the interrupt handler.

Hm, it seems that I mistakenly assumed that bitmap_find_free_region()
was built on top of atomic set_bit() and managed the bitmap in an
atomic way. I believe you are correct that locking is needed. Will
fix.

>>
>>       /* TTBR0 */
>>       ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
>> @@ -395,6 +407,8 @@ static int ipmmu_domain_init_context(str
>>
>>  static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
>>  {
>> +     bitmap_release_region(domain->mmu->ctx, domain->context_id, 0);
>> +
>>       /*
>>        * Disable the context. Flush the TLB as required when modifying the
>>        * context registers.
>> @@ -460,16 +474,16 @@ static irqreturn_t ipmmu_domain_irq(stru
>>  static irqreturn_t ipmmu_irq(int irq, void *dev)
>>  {
>>       struct ipmmu_vmsa_device *mmu = dev;
>> -     struct iommu_domain *io_domain;
>> -     struct ipmmu_vmsa_domain *domain;
>> -
>> -     if (!mmu->mapping)
>> -             return IRQ_NONE;
>> +     irqreturn_t status = IRQ_NONE;
>> +     unsigned int k;
>
> i is a perfectly fine loop counter :-)
>
>> -     io_domain = mmu->mapping->domain;
>> -     domain = to_vmsa_domain(io_domain);
>> +     /* Check interrupts for all active contexts */
>> +     for (k = find_first_bit(mmu->ctx, IPMMU_CTX_MAX);
>> +          k < IPMMU_CTX_MAX && status == IRQ_NONE;
>> +          k = find_next_bit(mmu->ctx, IPMMU_CTX_MAX, k))
>
> You can just loop over mmu->domains and skip NULL entries.

You are right, that may be easier!

>> +             status = ipmmu_domain_irq(mmu->domains[k]);
>
> Only the status of the last domain is taken into account.

Will fix, thanks!

/ magnus
