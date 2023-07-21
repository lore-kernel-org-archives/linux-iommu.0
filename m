Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B41FB50
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 18:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C769C433C9;
	Fri, 21 Jul 2023 18:25:27 +0000 (UTC)
Date: Fri, 21 Jul 2023 19:25:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, ajd@linux.ibm.com, fbarrat@linux.ibm.com,
	iommu@lists.linux.dev, jgg@ziepe.ca, jhubbard@nvidia.com,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, nicolinc@nvidia.com, npiggin@gmail.com,
	robin.murphy@arm.com, seanjc@google.com, will@kernel.org,
	x86@kernel.org, zhi.wang.linux@gmail.com, sj@kernel.org
Subject: Re: [PATCH v3 3/5] mmu_notifiers: Call invalidate_range() when
 invalidating TLBs
Message-ID: <ZLrNlgLZvtubFTiy@arm.com>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <86a0bf86394f1765fcbf9890bbabb154ba8dd980.1689842332.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a0bf86394f1765fcbf9890bbabb154ba8dd980.1689842332.git-series.apopple@nvidia.com>

On Thu, Jul 20, 2023 at 06:39:25PM +1000, Alistair Popple wrote:
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 3456866..a99349d 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -13,6 +13,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/mm_types.h>
>  #include <linux/sched.h>
> +#include <linux/mmu_notifier.h>
>  #include <asm/cputype.h>
>  #include <asm/mmu.h>
>  
> @@ -252,6 +253,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>  	__tlbi(aside1is, asid);
>  	__tlbi_user(aside1is, asid);
>  	dsb(ish);
> +	mmu_notifier_invalidate_range(mm, 0, -1UL);
>  }
>  
>  static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
> @@ -263,6 +265,8 @@ static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>  	addr = __TLBI_VADDR(uaddr, ASID(mm));
>  	__tlbi(vale1is, addr);
>  	__tlbi_user(vale1is, addr);
> +	mmu_notifier_invalidate_range(mm, uaddr & PAGE_MASK,
> +						(uaddr & PAGE_MASK) + PAGE_SIZE);

Nitpick: we have PAGE_ALIGN() for this.

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
