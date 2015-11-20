From: Michael Wang <yun.wang@profitbricks.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Fri, 20 Nov 2015 13:31:36 +0100
Message-ID: <564F12A8.5030702@profitbricks.com>
References: <564EFF6A.2050709@profitbricks.com>
 <564F051E.9010703@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564F051E.9010703@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 11/20/2015 12:33 PM, Michael Wang wrote:
> The kmemleak testing on 3.18.24 show:
> 
> unreferenced object 0xffff880233ff9010 (size 16):
>   comm "swapper/0", pid 1, jiffies 4294937440 (age 2010.490s)
>   hex dump (first 16 bytes):
>     0a 0a 00 00 20 00 00 00 00 44 fb 33 02 88 ff ff  .... ....D.3....
>   backtrace:
>     [<ffffffff8118192d>] create_object+0x10d/0x2d0
>     [<ffffffff815c2d4b>] kmemleak_alloc+0x5b/0xc0
>     [<ffffffff8116dd19>] kmem_cache_alloc_trace+0xb9/0x160
>     [<ffffffff814ffe51>] get_irq_table+0x151/0x380
> 
> This is caused by the 'irq_lookup_table' was allocated with
> __get_free_pages() which won't create kmemleak object, thus it's
> pointers won't be count as referencing 'irq_remap_table' in
> kmemleak scan.
> 
> The 'irq_remap_table' won't be freed after initialized, doesn't
> make sense to check it's leaking.
> 
> This patch mark the 'irq_remap_table' object as 'gray' to stop
> the 'false positives' report.
> 
> Signed-off-by: Michael Wang <yun.wang@profitbricks.com>

Reported-by: Danil Kipnis <danil.kipnis@profitbricks.com>

Regards,
Michael Wang

> ---
> v2:
>   Use kmemleak_not_leak() instead of kmemleak_ignore() since
>   the 'irq_remap_table' itself also contain pointer.
> 
>  drivers/iommu/amd_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8b2be1e..87a1a88 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3603,6 +3603,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
>  	}
>  
>  	irq_lookup_table[devid] = table;
> +	kmemleak_not_leak(table);
>  	set_dte_irq_entry(devid, table);
>  	iommu_flush_dte(iommu, devid);
>  	if (devid != alias) {
> 
