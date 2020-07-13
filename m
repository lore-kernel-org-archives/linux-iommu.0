Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED77C433E5
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 15:46:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C26E207D4
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y7GY53LC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C26E207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D147287534;
	Mon, 13 Jul 2020 15:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2P7YpVj6k_x; Mon, 13 Jul 2020 15:46:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA5348716C;
	Mon, 13 Jul 2020 15:46:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C462EC0888;
	Mon, 13 Jul 2020 15:46:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8FD1C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D18818716C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMSHf5mVvuCD for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 15:46:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E5F1286B7A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:46:28 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4FA292075B;
 Mon, 13 Jul 2020 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594655188;
 bh=AWz0IUKjAyAfwH8K+vt3e9DJTUwMGqFviY1hA78IOPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y7GY53LCe0pNRgHpCliakxgqpsfMRMeWu+oXbRwADcqADr5bRoh4OHDGiRzd48T7Z
 a+WfkHnoLoP0YNMlYLT3N2nMVJBORq4m8TdFj94xlFB/1EpPY3SPMl1VsvkyHie5zr
 BVynKpOOXssIKowdbqWS9Zv1bh37VhMzYzRAalDE=
Date: Mon, 13 Jul 2020 16:46:23 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v8 04/12] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Message-ID: <20200713154622.GC3072@willie-the-truck>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-5-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618155125.1548969-5-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, zhengxiang9@huawei.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 18, 2020 at 05:51:17PM +0200, Jean-Philippe Brucker wrote:
> To enable address space sharing with the IOMMU, introduce mm_context_get()
> and mm_context_put(), that pin down a context and ensure that it will keep
> its ASID after a rollover. Export the symbols to let the modular SMMUv3
> driver use them.
> 
> Pinning is necessary because a device constantly needs a valid ASID,
> unlike tasks that only require one when running. Without pinning, we would
> need to notify the IOMMU when we're about to use a new ASID for a task,
> and it would get complicated when a new task is assigned a shared ASID.
> Consider the following scenario with no ASID pinned:
> 
> 1. Task t1 is running on CPUx with shared ASID (gen=1, asid=1)
> 2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
> 3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
>    We would now have to immediately generate a new ASID for t1, notify
>    the IOMMU, and finally enable task tn. We are holding the lock during
>    all that time, since we can't afford having another CPU trigger a
>    rollover. The IOMMU issues invalidation commands that can take tens of
>    milliseconds.
> 
> It gets needlessly complicated. All we wanted to do was schedule task tn,
> that has no business with the IOMMU. By letting the IOMMU pin tasks when
> needed, we avoid stalling the slow path, and let the pinning fail when
> we're out of shareable ASIDs.
> 
> After a rollover, the allocator expects at least one ASID to be available
> in addition to the reserved ones (one per CPU). So (NR_ASIDS - NR_CPUS -
> 1) is the maximum number of ASIDs that can be shared with the IOMMU.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  arch/arm64/include/asm/mmu.h         |  1 +
>  arch/arm64/include/asm/mmu_context.h | 11 +++-
>  arch/arm64/mm/context.c              | 95 +++++++++++++++++++++++++++-
>  3 files changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 68140fdd89d6b..bbdd291e31d59 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -19,6 +19,7 @@
>  
>  typedef struct {
>  	atomic64_t	id;
> +	unsigned long	pinned;

bool?

>  	void		*vdso;
>  	unsigned long	flags;
>  } mm_context_t;
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index b0bd9b55594c5..7b0e0f6cb7e87 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -177,7 +177,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  #define destroy_context(mm)		do { } while(0)
>  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>  
> -#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
> +static inline int
> +init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> +{
> +	atomic64_set(&mm->context.id, 0);
> +	mm->context.pinned = 0;
> +	return 0;
> +}
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  static inline void update_saved_ttbr0(struct task_struct *tsk,
> @@ -250,6 +256,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  void verify_cpu_asid_bits(void);
>  void post_ttbr_update_workaround(void);
>  
> +unsigned long mm_context_get(struct mm_struct *mm);
> +void mm_context_put(struct mm_struct *mm);
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* !__ASM_MMU_CONTEXT_H */
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index d702d60e64dab..d0ddd413f5645 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -27,6 +27,10 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
>  static DEFINE_PER_CPU(u64, reserved_asids);
>  static cpumask_t tlb_flush_pending;
>  
> +static unsigned long max_pinned_asids;
> +static unsigned long nr_pinned_asids;
> +static unsigned long *pinned_asid_map;
> +
>  #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
>  #define ASID_FIRST_VERSION	(1UL << asid_bits)
>  
> @@ -74,6 +78,9 @@ void verify_cpu_asid_bits(void)
>  
>  static void set_kpti_asid_bits(void)
>  {
> +	unsigned int k;
> +	u8 *dst = (u8 *)asid_map;
> +	u8 *src = (u8 *)pinned_asid_map;
>  	unsigned int len = BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(unsigned long);
>  	/*
>  	 * In case of KPTI kernel/user ASIDs are allocated in
> @@ -81,7 +88,8 @@ static void set_kpti_asid_bits(void)
>  	 * is set, then the ASID will map only userspace. Thus
>  	 * mark even as reserved for kernel.
>  	 */
> -	memset(asid_map, 0xaa, len);
> +	for (k = 0; k < len; k++)
> +		dst[k] = src[k] | 0xaa;

Can you use __bitmap_replace() here? I think it would be clearer to use the
bitmap API wherever possible, since casting 'unsigned long *' to 'u8 *'
just makes me worry about endianness issues (although in this case I don't
hink it's a problem).

>  }
>  
>  static void set_reserved_asid_bits(void)
> @@ -89,7 +97,7 @@ static void set_reserved_asid_bits(void)
>  	if (arm64_kernel_unmapped_at_el0())
>  		set_kpti_asid_bits();
>  	else
> -		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
> +		bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
>  }
>  
>  #define asid_gen_match(asid) \
> @@ -165,6 +173,14 @@ static u64 new_context(struct mm_struct *mm)
>  		if (check_update_reserved_asid(asid, newasid))
>  			return newasid;
>  
> +		/*
> +		 * If it is pinned, we can keep using it. Note that reserved
> +		 * takes priority, because even if it is also pinned, we need to
> +		 * update the generation into the reserved_asids.
> +		 */
> +		if (mm->context.pinned)
> +			return newasid;
> +
>  		/*
>  		 * We had a valid ASID in a previous life, so try to re-use
>  		 * it if possible.
> @@ -254,6 +270,68 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
>  		cpu_switch_mm(mm->pgd, mm);
>  }
>  
> +unsigned long mm_context_get(struct mm_struct *mm)
> +{
> +	unsigned long flags;
> +	u64 asid;
> +
> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +
> +	asid = atomic64_read(&mm->context.id);
> +
> +	if (mm->context.pinned) {
> +		mm->context.pinned++;
> +		asid &= ~ASID_MASK;
> +		goto out_unlock;
> +	}
> +
> +	if (nr_pinned_asids >= max_pinned_asids) {
> +		asid = 0;
> +		goto out_unlock;
> +	}
> +
> +	if (!asid_gen_match(asid)) {
> +		/*
> +		 * We went through one or more rollover since that ASID was
> +		 * used. Ensure that it is still valid, or generate a new one.
> +		 */
> +		asid = new_context(mm);
> +		atomic64_set(&mm->context.id, asid);
> +	}
> +
> +	asid &= ~ASID_MASK;
> +
> +	nr_pinned_asids++;
> +	__set_bit(asid2idx(asid), pinned_asid_map);
> +	mm->context.pinned++;
> +
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);

Maybe stick the & ~ASID_MASK here so it's easier to read?

> +	/* Set the equivalent of USER_ASID_BIT */
> +	if (asid && IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> +		asid |= 1;
> +
> +	return asid;
> +}
> +EXPORT_SYMBOL_GPL(mm_context_get);

That's quite a generic symbol name to export... maybe throw 'arm64_' in
front of it?

> +
> +void mm_context_put(struct mm_struct *mm)
> +{
> +	unsigned long flags;
> +	u64 asid = atomic64_read(&mm->context.id) & ~ASID_MASK;

I don't think you need the masking here.

> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +
> +	if (--mm->context.pinned == 0) {
> +		__clear_bit(asid2idx(asid), pinned_asid_map);
> +		nr_pinned_asids--;
> +	}
> +
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(mm_context_put);

Same naming comment here.

>  /* Errata workaround post TTBRx_EL1 update. */
>  asmlinkage void post_ttbr_update_workaround(void)
>  {
> @@ -303,6 +381,13 @@ static int asids_update_limit(void)
>  	WARN_ON(num_available_asids - 1 <= num_possible_cpus());
>  	pr_info("ASID allocator initialised with %lu entries\n",
>  		num_available_asids);
> +
> +	/*
> +	 * We assume that an ASID is always available after a rollover. This
> +	 * means that even if all CPUs have a reserved ASID, there still is at
> +	 * least one slot available in the asid map.
> +	 */
> +	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;

Is it worth checking that assumption, rather than setting max_pinned_asids
to a massive value?

>  	return 0;
>  }
>  arch_initcall(asids_update_limit);
> @@ -317,6 +402,12 @@ static int asids_init(void)
>  		panic("Failed to allocate bitmap for %lu ASIDs\n",
>  		      NUM_USER_ASIDS);
>  
> +	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS),
> +				  sizeof(*pinned_asid_map), GFP_KERNEL);
> +	if (!pinned_asid_map)
> +		panic("Failed to allocate pinned ASID bitmap\n");

Why can't we continue in this case without support for pinned ASIDs?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
