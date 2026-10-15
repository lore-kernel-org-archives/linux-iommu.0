Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C006470117;
	Thu, 15 Oct 2026 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046308; cv=none; b=C2/Cd3EYmZ0LCt9ebY53lue+EEYsgAzZPJ+RABjjOCMLcCZXa21lpJbS0AFNrbwKex1QDSIMIKM2eeeaYgyCyLLo2GLsuxIjOYNSufJRqzYf7tx8hiA8y9wuRkZn589hUctKWrnJQWpLlIE7CwC4U4tDZ4UJEtXTCRVleGV1Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046308; c=relaxed/simple;
	bh=C5S/fcxahP44X6HH95SPiDjS7f7yvFtGXNMyBC8X13E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVEMbzoPkO7A7TCqoPJQ8slvVLIt8XBZhOpESG6790/oX05rWZYfRWLzNEHQZzkz2sxKIjDvyv/FEnSrzKAXA794M5TivETtuEfm81SK5qblqY6NJ97Bfz2lUEy1yTEy5+hZU+Uau1yzwxyPoesDlkUwzrOD0jAE0nUaSvDKFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcRoZ0cr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcRoZ0cr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792046306; x=1823582306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C5S/fcxahP44X6HH95SPiDjS7f7yvFtGXNMyBC8X13E=;
  b=BcRoZ0crPPJx7aXOgVapSj8HUphNyFpaXTJ+9uMV95emb6wbhIOe/Xcl
   bpxi2xINz3uvF4yUp9bw1VSiLo4FBk6kmG5D7ZXvvE00bym/zxx4LFe8H
   Jkj+Od3GEOOcAsOZalr1EzDVLBkkIPwg0oAxmnTgWYnppg9+Z4h3KQpWv
   cYtedHMihCkAD8rgWljwAKLtdAS8vwjdI6gz5lBfbP6ZqO5RDoKbHGQZd
   ORsdRFrW+yxMyvqRS75SBwQUgTS9lpu3hnmJKTAtuiczhhM4k54kU7Sw0
   MrR7OChuuZf+jny+1oX87NStas+OeIJA89yhj6Qjh3BdcPU/0DYnfa5xG
   Q==;
X-CSE-ConnectionGUID: t0HAHxzYQhiICkNrnMGzQw==
X-CSE-MsgGUID: Uoye4k8ERpiDQZvR4iU/KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808739"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808739"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 23:38:26 -0700
X-CSE-ConnectionGUID: EUNteLj8S+C95zjKYbm1yQ==
X-CSE-MsgGUID: XiGxUsyISKOUsloHsSQ10A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1936573"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 14 Oct 2026 23:38:23 -0700
Date: Thu, 15 Oct 2026 14:34:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Message-ID: <atBz5cj0wQZv/fLN@yilunxu-OptiPlex-7050>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015010705.1973284-2-baolu.lu@linux.intel.com>

On Thu, Oct 15, 2026 at 09:07:02AM +0800, Lu Baolu wrote:
> Add SEAMCALL wrappers for TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR.

We need this patch been reviewed by x86 reviewers. x86 convention
doesn't start with the implementation, so remove it.

We can start with a generic description of what the 2 SEAMCALLs are
doing in general and why. Maybe move some of your description in next
paragraph ahead.

> 
> TDH.IOMMU.SETUP transitions an IOMMU and related I/O stack into Secure
> TDX Mode. During this transition, the TDX module validates and protects
> relevant I/O resources from further untrusted host access, providing the
> trusted foundation required before enabling TEE-IO security protocols
> (e.g. SPDM/IDE).
> 
> TDH.IOMMU.CLEAR performs the reverse operation and tears down the Secure
> TDX Mode state for the target IOMMU.
> 
> The caller is responsible for allocating the required pages and
> populating the parameter page in the ABI-defined format.
> 
> See Intel TDX Connect ABI Specification [1], Section 3.2 (TDX Connect
> Host-Side (SEAMCALL) Interface Functions).
> 
> Thanks to Xu Yilun for the initial draft.

Feel free to drop it. Not that important.

> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/858625
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/include/asm/tdx.h  |  2 ++
>  arch/x86/virt/vmx/tdx/tdx.h |  2 ++
>  arch/x86/virt/vmx/tdx/tdx.c | 56 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 89e97d5761d8..8b5411d3eb67 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -176,6 +176,8 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ex
>  u64 tdh_phymem_cache_wb(bool resume);
>  u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
>  u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
> +u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id);
> +u64 tdh_iommu_clear(u64 tdx_iommu_id);
>  #else
>  static inline void tdx_init(void) { }
>  static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index bdfd0e1e337a..d7beb42cf972 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -49,6 +49,8 @@
>  #define TDH_SYS_SHUTDOWN		52
>  #define TDH_SYS_UPDATE			53
>  #define TDH_SYS_DISABLE			69
> +#define TDH_IOMMU_SETUP			128
> +#define TDH_IOMMU_CLEAR			129
>  
>  /*
>   * SEAMCALL leaf:
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 1b9ff749dd8e..5d31c1b0890a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2034,3 +2034,59 @@ void tdx_sys_disable(void)
>  	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
>  		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
>  }
> +
> +/*
> + * Wrapper for TDH.IOMMU.SETUP leaf, which transitions the IOMMU and related
> + * I/O stack into Secure TDX Mode.

Other tdh_*() wrappers don't have the general descriptions. We all know
these are wrappers for some SEAMCALL leafs.

So if there is no special thing to note, remove it.

> + *
> + * The @root page format is defined by the TDX Connect ABI spec (Table 3.35,
> + * Structure of IOMMU_MT Parameter): the first two entries describe the size
> + * and HPA (Host Physical Address) of the two contiguous buffers for the
> + * invalidation queue; the remaining entries provide HPAs of
> + * IOMMU_MT_PAGES_COUNT metadata pages. IOMMU_MT_PAGES_COUNT is obtained from
> + * trusted IOMMU global metadata.
> + */
> +u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id)

IIUC, the void *root is a vague type, no type safty. Is it better we
define an explicit structure that mirrors the in-memory ABI? Something
like:

  struct tdx_iommu_metadata {
	u64 iq1_pa;
	u64 iq2_pa;
	DECLARE_FLEX_ARRAY(u64, mt_pa);
  };

Or,

  struct tdx_iommu_metadata {
	u64 iq1_pa;
	u64 iq2_pa;
	u64 mt_pa[510];
  };

  static_assert(sizeof(struct tdx_iommu_metadata) == 4096);

> +{
> +	struct tdx_module_args args = {
> +		.rcx = reg_base,
> +		.rdx = __pa(root),
> +	};
> +	u64 ret;
> +
> +	/*
> +	 * Don't loop forever:
> +	 *
> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
> +	 *    calls.
> +	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
> +	 *    unchanged.
> +	 */
> +	do {
> +		ret = seamcall_ret(TDH_IOMMU_SETUP, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
> +
> +	*tdx_iommu_id = args.rcx;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_setup, "tdx-host");
> +
> +/*
> + * Wrapper for TDH.IOMMU.CLEAR leaf, which terminates Secure TDX Mode for the
> + * target IOMMU and restores control of related hardware resources to the host.
> + */
> +u64 tdh_iommu_clear(u64 tdx_iommu_id)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = tdx_iommu_id,
> +	};
> +	u64 ret;
> +
> +	do {
> +		ret = seamcall(TDH_IOMMU_CLEAR, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");
> -- 
> 2.43.0
> 
