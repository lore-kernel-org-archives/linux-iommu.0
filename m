From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for kmemleak
Date: Wed, 2 Dec 2015 10:52:02 +0000
Message-ID: <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
References: <564EFF6A.2050709@profitbricks.com> <564F051E.9010703@profitbricks.com>
 <20151125150806.GG2064@8bytes.org> <5655D072.1000901@profitbricks.com> <565EC9F4.2050401@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <565EC9F4.2050401@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <yun.wang@profitbricks.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 2 December 2015 at 10:37, Michael Wang <yun.wang@profitbricks.com> wrote:
> On 11/25/2015 04:14 PM, Michael Wang wrote:
>> On 11/25/2015 04:08 PM, Joerg Roedel wrote:
> [snip]
>>>> This is caused by the 'irq_lookup_table' was allocated with
>>>> __get_free_pages() which won't create kmemleak object, thus it's
>>>> pointers won't be count as referencing 'irq_remap_table' in
>>>> kmemleak scan.
>>>
>>> Isn't it better to allocate the kmemleak object manually instead of
>>> ignoring all irq-table pointers? With this patch we might not notice any
>>> real leak of irq-tables.
>>
>> We've considered that too, but found that the irq-tables is not
>> dynamically alloc/free, they won't be freed once initialized, so there
>> is no leaking for such object :-)
>
> Is there any more concern? actually we just want to get rid of this
> annoying report on obj won't leak, if you're going to create obj for
> 'irq_lookup_table' that's also fine for us, or will you pick this patch?

My preference (from a kmemleak perspective) is to tell kmemleak about
the irq_lookup_table. Untested:

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdfff2d4d..c41609f71cbe 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -27,6 +27,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/kmemleak.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -1692,6 +1693,7 @@ static struct syscore_ops amd_iommu_syscore_ops = {

 static void __init free_on_init_error(void)
 {
+ kmemleak_free(irq_lookup_table);
  free_pages((unsigned long)irq_lookup_table,
    get_order(rlookup_table_size));

@@ -1906,6 +1908,7 @@ static int __init early_amd_iommu_init(void)
  irq_lookup_table = (void *)__get_free_pages(
  GFP_KERNEL | __GFP_ZERO,
  get_order(rlookup_table_size));
+ kmemleak_alloc(irq_lookup_table, rlookup_table_size, 1, GFP_KERNEL);
  if (!irq_lookup_table)
  goto out;
  }

-- 
Catalin
