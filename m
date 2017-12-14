From: Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] mm: Add kernel MMU notifier to manage IOTLB/DEVTLB
Date: Thu, 14 Dec 2017 11:10:28 +0800
Message-ID: <a98903c2-e67c-a0cc-3ad1-60b9aa4e4c93@huawei.com>
References: <1513213366-22594-1-git-send-email-baolu.lu@linux.intel.com>
	<1513213366-22594-2-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1513213366-22594-2-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Alex
	Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Huang Ying <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <willy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Paul E . McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Kirill A . Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2017/12/14 9:02, Lu Baolu wrote:
> From: Huang Ying <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Shared Virtual Memory (SVM) allows a kernel memory mapping to be
> shared between CPU and and a device which requested a supervisor
> PASID. Both devices and IOMMU units have TLBs that cache entries
> from CPU's page tables. We need to get a chance to flush them at
> the same time when we flush the CPU TLBs.
> 
> We already have an existing MMU notifiers for userspace updates,
> however we lack the same thing for kernel page table updates. To

Sorry, I didn't get which situation need this notification.
Could you please describe the full scenario?

Thanks,
Liubo

> implement the MMU notification mechanism for the kernel address
> space, a kernel MMU notifier chain is defined and will be called
> whenever the CPU TLB is flushed for the kernel address space.
> 
> As consumer of this notifier, the IOMMU SVM implementations will
> register callbacks on this notifier and manage the cache entries
> in both IOTLB and DevTLB.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> Cc: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> Cc: Kirill A. Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Matthew Wilcox <willy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>
> Cc: Paul E. McKenney <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Cc: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Cc: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
> 
> Tested-by: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Huang Ying <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  arch/x86/mm/tlb.c            |  2 ++
>  include/linux/mmu_notifier.h | 33 +++++++++++++++++++++++++++++++++
>  mm/mmu_notifier.c            | 27 +++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 3118392cd..5ff104f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -6,6 +6,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/export.h>
>  #include <linux/cpu.h>
> +#include <linux/mmu_notifier.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -567,6 +568,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  		info.end = end;
>  		on_each_cpu(do_kernel_range_flush, &info, 1);
>  	}
> +	kernel_mmu_notifier_invalidate_range(start, end);
>  }
>  
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index b25dc9d..44d7c06 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -408,6 +408,25 @@ extern void mmu_notifier_call_srcu(struct rcu_head *rcu,
>  				   void (*func)(struct rcu_head *rcu));
>  extern void mmu_notifier_synchronize(void);
>  
> +struct kernel_mmu_address_range {
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +/*
> + * Before the virtual address range managed by kernel (vmalloc/kmap)
> + * is reused, That is, remapped to the new physical addresses, the
> + * kernel MMU notifier will be called with KERNEL_MMU_INVALIDATE_RANGE
> + * and struct kernel_mmu_address_range as parameters.  This is used to
> + * manage the remote TLB.
> + */
> +#define KERNEL_MMU_INVALIDATE_RANGE		1
> +extern int kernel_mmu_notifier_register(struct notifier_block *nb);
> +extern int kernel_mmu_notifier_unregister(struct notifier_block *nb);
> +
> +extern int kernel_mmu_notifier_invalidate_range(unsigned long start,
> +						unsigned long end);
> +
>  #else /* CONFIG_MMU_NOTIFIER */
>  
>  static inline int mm_has_notifiers(struct mm_struct *mm)
> @@ -474,6 +493,20 @@ static inline void mmu_notifier_mm_destroy(struct mm_struct *mm)
>  #define pudp_huge_clear_flush_notify pudp_huge_clear_flush
>  #define set_pte_at_notify set_pte_at
>  
> +static inline int kernel_mmu_notifier_register(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int kernel_mmu_notifier_unregister(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline void kernel_mmu_notifier_invalidate_range(unsigned long start,
> +							unsigned long end)
> +{
> +}
>  #endif /* CONFIG_MMU_NOTIFIER */
>  
>  #endif /* _LINUX_MMU_NOTIFIER_H */
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 96edb33..52f816a 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -393,3 +393,30 @@ void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
>  	mmdrop(mm);
>  }
>  EXPORT_SYMBOL_GPL(mmu_notifier_unregister_no_release);
> +
> +static ATOMIC_NOTIFIER_HEAD(kernel_mmu_notifier_list);
> +
> +int kernel_mmu_notifier_register(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_register(&kernel_mmu_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(kernel_mmu_notifier_register);
> +
> +int kernel_mmu_notifier_unregister(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_unregister(&kernel_mmu_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(kernel_mmu_notifier_unregister);
> +
> +int kernel_mmu_notifier_invalidate_range(unsigned long start,
> +					 unsigned long end)
> +{
> +	struct kernel_mmu_address_range range = {
> +		.start	= start,
> +		.end	= end,
> +	};
> +
> +	return atomic_notifier_call_chain(&kernel_mmu_notifier_list,
> +					  KERNEL_MMU_INVALIDATE_RANGE,
> +					  &range);
> +}
> 
