Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E8217F31
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755707; cv=none; b=uPEhPHXfAhwK2B/6Uz1DM7K8J+pnwiAdvuuOwpttTrVlPwhhSqXHLj+Q7YfH4EA7I76OTX5IcX16PMKtv6No39WQCR+VN0rYsIXwMffwxshXMJf2J5X0QiG70BHwOyeGqDgppvPxqxEBDwfCKzY+mlxou5xbMheAINlkUinm8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755707; c=relaxed/simple;
	bh=tEp8HH2rBzZ9bHQxIDQ0t/JriZ4BYmHaJTITiE1LyPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7+gRNFuuvkVX+YsufuJN32oe3yQwOvpDjI4Z3U87L2J16oOoefSRz7JLOLMwiBcgrgWta66pU4eudEZzFww9dI5KcNktPEtHrunsOKxIVh1lOvz82/adteCjhVXwjZopj8EVPWx+myZUcs+7iaHPX+QcDrJUN2LbYrvjfMWgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8Xz2aIa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8Xz2aIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755706; x=1792291706;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tEp8HH2rBzZ9bHQxIDQ0t/JriZ4BYmHaJTITiE1LyPQ=;
  b=U8Xz2aIaB+fM6JvKZbp4NSaUREW9nqiVfIKjiT4CCC+NZEzy/J/ylmms
   bz/rHwkngJhvrsPYjqoK2kB1F7Lt6XmVv79UhSnRQWZasA1lkAgmXXwSe
   a7Qqak0Tx+1A+NnflEjJTCi2adoD8MfYwhfn40sniLwvFZ+LAxT6lIVZn
   L3/nv0gQh5N1YfQ0VRi7KkJDIb1m5/9ktPUY8fo5ABAPsUYi8EnpWLt/p
   oliUfL417a6jylJ5G5g+r4AINaKmWMxfB+epOQFrEnJh+pt54mfXA7rFD
   ZjHkUazlosrT4ju3R/nZA50Ut+UXbELI5ZEUPsiNL0akZ0ObdGSmQpqCw
   w==;
X-CSE-ConnectionGUID: E9mUqdzxRRy587EkcKKpmg==
X-CSE-MsgGUID: byFKEbfbST2kh915RgSiiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="66611755"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="66611755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:48:25 -0700
X-CSE-ConnectionGUID: NoGyMQ7ZTdSUCMLtUYDo0g==
X-CSE-MsgGUID: DQPBNYLuTRa+xl2lmWU85A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="182495563"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.108.63])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 11:26:03 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Kevin
 Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Alistair Popple
 <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau
 Rezki <urezki@gmail.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Andy
 Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R
 .
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, iommu@lists.linux.dev, security@kernel.org,
 x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Jiang,
 Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
In-Reply-To: <c3eee56a-7fe3-454c-878f-cff37467fb7e@intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
 <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
 <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
 <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
 <20251017140101.GM3901471@nvidia.com>
 <c3eee56a-7fe3-454c-878f-cff37467fb7e@intel.com>
Date: Fri, 17 Oct 2025 11:26:02 -0700
Message-ID: <87zf9pjsg5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Dave Hansen <dave.hansen@intel.com> writes:

> On 10/17/25 07:01, Jason Gunthorpe wrote:
>>>> The other alternative is to have arch_vmap_pmd_supported() return false
>>>> when SVA is active, or maybe when it's supported on the platform.
>>>>
>>>> Either of those are 10-ish lines of code and easy to backport.
>>> Hi iommu folks, any insights on this?
>> IDK, the only SVA user on x86 I know is IDXD, so if you do the above
>> plan you break IDXD in all stable kernels. Doesn't sound OK?
>
> Vinicius, any thoughts on this?
>

This won't break IDXD exactly/totally, it would cause it to be
impossible for users to create shared DSA/IAA workqueues (which are the
nicer ones to use), and it will cause the driver to print some not happy
messages in the kernel logs. The in-kernel users of IDXD (iaa_crypto for
zswap, for example) will continue to work.

In short, I am not happy, but I think it's workable, even better if
there are alternatives in case people complain.

> I'm thinking that even messing with arch_vmap_pmd_supported() would be
> suboptimal. The easiest thing is to just stick the attached patch in
> stable kernels and disable SVA at compile time.
>
> There just aren't enough SVA users out in the wild to justify more
> complexity than this.
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index c9103a6fa06e..0b0e0283994f 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -124,7 +124,8 @@ bool emulate_vsyscall(unsigned long error_code,
>  	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>  		return false;
>  
> -	if (!(error_code & X86_PF_INSTR)) {
> +	/* Avoid emulation unless userspace was executing from vsyscall page: */
> +	if (address != regs->ip) {
>  		/* Failed vsyscall read */
>  		if (vsyscall_mode == EMULATE)
>  			return false;
> @@ -136,13 +137,16 @@ bool emulate_vsyscall(unsigned long error_code,
>  		return false;
>  	}
>  
> +
> +	/* X86_PF_INSTR is only set when NX is supported: */
> +	if (cpu_feature_enabled(X86_FEATURE_NX))
> +		WARN_ON_ONCE(!(error_code & X86_PF_INSTR));
> +
>  	/*
>  	 * No point in checking CS -- the only way to get here is a user mode
>  	 * trap to a high address, which means that we're in 64-bit user code.
>  	 */
>  
> -	WARN_ON_ONCE(address != regs->ip);
> -
>  	if (vsyscall_mode == NONE) {
>  		warn_bad_vsyscall(KERN_INFO, regs,
>  				  "vsyscall attempted with vsyscall=none");
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..e3ce9b0b2447 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -665,6 +665,7 @@ static unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
>  static void cond_mitigation(struct task_struct *next)
>  {
>  	unsigned long prev_mm, next_mm;
> +	bool userspace_needs_ibpb = false;
>  
>  	if (!next || !next->mm)
>  		return;
> @@ -722,7 +723,7 @@ static void cond_mitigation(struct task_struct *next)
>  		 */
>  		if (next_mm != prev_mm &&
>  		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
> -			indirect_branch_prediction_barrier();
> +			userspace_needs_ibpb = true;
>  	}
>  
>  	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
> @@ -732,9 +733,11 @@ static void cond_mitigation(struct task_struct *next)
>  		 * last on this CPU.
>  		 */
>  		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) != (unsigned long)next->mm)
> -			indirect_branch_prediction_barrier();
> +			userspace_needs_ibpb = true;
>  	}
>  
> +	this_cpu_write(x86_ibpb_exit_to_user, userspace_needs_ibpb);
> +
>  	if (static_branch_unlikely(&switch_mm_cond_l1d_flush)) {
>  		/*
>  		 * Flush L1D when the outgoing task requested it and/or
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index f2f538c70650..a5d66bfd9e50 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -48,7 +48,10 @@ config INTEL_IOMMU_DEBUGFS
>  
>  config INTEL_IOMMU_SVM
>  	bool "Support for Shared Virtual Memory with Intel IOMMU"
> -	depends on X86_64
> +	# The kernel does not invalidate IOTLB entries when freeing
> +	# kernel page tables. This can lead to IOMMUs walking (and
> +	# writing to) CPU page tables after they are freed.
> +	depends on BROKEN
>  	select MMU_NOTIFIER
>  	select IOMMU_SVA
>  	help

-- 
Vinicius
