From: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 2 Dec 2015 11:56:20 +0100
Message-ID: <565ECE54.5080706@profitbricks.com>
References: <564EFF6A.2050709@profitbricks.com>
	<564F051E.9010703@profitbricks.com> <20151125150806.GG2064@8bytes.org>
	<5655D072.1000901@profitbricks.com> <565EC9F4.2050401@profitbricks.com>
	<CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On 12/02/2015 11:52 AM, Catalin Marinas wrote:
[snip]
>>
>> Is there any more concern? actually we just want to get rid of this
>> annoying report on obj won't leak, if you're going to create obj for
>> 'irq_lookup_table' that's also fine for us, or will you pick this patch?
> 
> My preference (from a kmemleak perspective) is to tell kmemleak about
> the irq_lookup_table. Untested:

I'm fine with both solution, will leave the decision to maintainer :-)

BTW, could you please send a formal patch with descriptions?

Regards,
Michael Wang

> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 013bdfff2d4d..c41609f71cbe 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -27,6 +27,7 @@
>  #include <linux/amd-iommu.h>
>  #include <linux/export.h>
>  #include <linux/iommu.h>
> +#include <linux/kmemleak.h>
>  #include <asm/pci-direct.h>
>  #include <asm/iommu.h>
>  #include <asm/gart.h>
> @@ -1692,6 +1693,7 @@ static struct syscore_ops amd_iommu_syscore_ops = {
> 
>  static void __init free_on_init_error(void)
>  {
> + kmemleak_free(irq_lookup_table);
>   free_pages((unsigned long)irq_lookup_table,
>     get_order(rlookup_table_size));
> 
> @@ -1906,6 +1908,7 @@ static int __init early_amd_iommu_init(void)
>   irq_lookup_table = (void *)__get_free_pages(
>   GFP_KERNEL | __GFP_ZERO,
>   get_order(rlookup_table_size));
> + kmemleak_alloc(irq_lookup_table, rlookup_table_size, 1, GFP_KERNEL);
>   if (!irq_lookup_table)
>   goto out;
>   }
> 
