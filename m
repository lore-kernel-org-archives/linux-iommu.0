From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: iommu/arm-smmu: Regression (sleeping function called from
	invalid context)
Date: Fri, 31 Jan 2014 09:46:23 +0100
Message-ID: <20140131084623.GN13543@alberich>
References: <20140130235552.GL13543@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140130235552.GL13543@alberich>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 31, 2014 at 12:55:52AM +0100, Andreas Herrmann wrote:
> Hi Will,
> 
> Seems that commit a44a9791e778d9ccda50d5534028ed4057a9a45b
> (iommu/arm-smmu: use mutex instead of spinlock for locking page tables)
> introduced a regression.
> 
> At least I've hit
> 
>   BUG: scheduling while atomic: ksoftirqd/0/3/0x00000100
>...

>   BUG: sleeping function called from invalid context at mm/page_alloc.c:2679
>   in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.13.0-00016-g6e90346 #413
>   [<c0014740>] (unwind_backtrace+0x0/0xf8) from [<c00115b0>] (show_stack+0x10/0x14)
>   [<c00115b0>] (show_stack+0x10/0x14) from [<c057ea24>] (dump_stack+0x74/0xa8)
>   [<c057ea24>] (dump_stack+0x74/0xa8) from [<c00acc1c>] (__alloc_pages_nodemask+0x174/0x930)
>   [<c00acc1c>] (__alloc_pages_nodemask+0x174/0x930) from [<c042a250>] (arm_smmu_handle_mapping+0x470/0x66c)
>   [<c042a250>] (arm_smmu_handle_mapping+0x470/0x66c) from [<c0428e74>] (iommu_map+0xf0/0x148)
>   [<c0428e74>] (iommu_map+0xf0/0x148) from [<c001935c>] (__map_sg_chunk+0x198/0x2d4)
>...

> Maybe that was the reason why the offending commit was introduced(?).
> 
> I think with the current code "atomic allocations" should be used when
> IO page tables are created. With below patch I've not triggered above
> errors.

I think allocating memory with GFP_KERNEL in this dma-mapping path
doesn't seem to be a good idea. What if the DMA operation for which we
modify IO page tables was triggered to free pages (page cache, swap)?


Andreas
