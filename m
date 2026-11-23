Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428333;
	b=DI2swdjl+ygLmiEgPkDX/Y/P899d0NrwGtTmcNBF6U9jt38EiBvSSh6m8BeFT/+P4ywV
	 1YiOkrpOkQsGHANCgJFeC6WkQMYn9nTlVjhslnDvB5JmaU7i+LQAtPYbp+pFx7BdGQf2J
	 AlhWVcDVNFsw5GubXSZ2D2MO/LkAJqQWq84kuXWBw6Q3GFP+e+uCDpjDYpseRsQ5sK2MZ
	 MpLOpp7pyGpEg9VOwPtZJ+rQinBZETjjcjNW9gBVubX3demBxqW0xj8ctu1d5ORoGSO+f
	 ZkztnmDaektioD+mZR3riKRkPx/xxseo54V2Zllkq38D4//Ku8fZAOncJRBgBYEtJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428333;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=y/HSexjMmo/WIYccGb61Tikt056TyM/xZd6TbhFwre4=;
	b=eTXUX3ZIk5HFoKHzbPFO8NEN5j5PT9KxF/aDRpKLJzyj1HoPtBclwgvHDe7UkUIMjObm
	 DJP9KNmTdqtwc8HhgktsZyMhN+E1pBHWNLhcdmJ0+xL+6s8sPnQZZj6cA0Tjev1q1s0gS
	 MtLzW1oZBuQ+Lhnfh1/juw/h2N0Ra3PTjIA6FTHQzXflYBaL5Qhd6c3Fsw9M6iiIbRqD8
	 Gw2tcE74rPg3LZKK9NcVr83dADfnJmfzsFzfEWrIW1KcS+MpQiEdzjEhsCxo5ulZN6Kr1
	 owRXmIwvq186XG81mprmdzO7tV9sYOENAdrINypyY44hhcx3GLvdvCd6PnHeFLDOh1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Hpllc/Z2";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BA606A32A;
	Mon, 23 Nov 2026 10:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 235BA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hpllc/Z2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795428333; x=1826964333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9wbQxTRNwsiyK5ikQ7Oil1SwRKlOTy7gU93ZVXmlF4=;
  b=Hpllc/Z2advHSvHVUQXY1CjZ3BvY4sh13eT3NUizM3u4QnXJs7YN1F4Y
   Wn6I+MZEH8O9Yp48t8eWWVVU1kz1bCiy8Nv1EQqZ9Vp/qg62yMHujrLXn
   rEISxTkoRrIJG5gedlcdH1euwLKYL3b2Ko6QUoPNbKbpsUiiKN+rKC3Fg
   XIE2BtS80bCawmTR0Oo1ZBb+oZN5MtZsAxbxAcK/tbOZXtpkv7mOYhiAQ
   awEGyKLcDNBTdIsk+udkJfhxyVAX20NLxvbi51CbR+tALGqAVrjeXMp7n
   wl+r7RpV3JpThNkT1SaSFGgYvDx92rOnLU7o92CCezM7n/C6VdUnV0diM
   A==;
X-CSE-ConnectionGUID: NVRl4pKJQYKHXED7NKVggQ==
X-CSE-MsgGUID: F4sr8hvjQCu+x8V+MTA2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4210437"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4210437"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:05:32 -0800
X-CSE-ConnectionGUID: NVyJ/2V+SYGZ3ZFiptzs3w==
X-CSE-MsgGUID: tzZd5xu0QwyVbTEiakQ8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11144445"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 02:05:30 -0800
Date: Mon, 23 Nov 2026 17:55:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Message-ID: <awQNpgjgIlwhXrqT@yilunxu-OptiPlex-7050>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112043054.2664857-2-baolu.lu@linux.intel.com>

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 4cce77b6a31f..a1f35188a272 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2567,3 +2567,56 @@ void tdx_sys_disable(void)
>  	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
>  		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
>  }
> +
> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs. */
> +u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,

param is too general, name it iommu_mt, is it better?

> +		    u64 *tdx_iommu_id)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = reg_base,
> +		.rdx = __pa(param),
> +	};
> +	u64 ret;
> +
> +	/*
> +	 * Retry only on TDX_INTERRUPTED_RESUMABLE:
> +	 *
> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
> +	 *    calls.
> +	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
> +	 *    unchanged.
> +	 *
> +	 * The ABI spec also allows retrying on TDX_OPERAND_BUSY, but that
> +	 * status doesn't guarantee forward progress, so retrying could spin
> +	 * forever. The host serializes all TDH.IOMMU.SETUP and
> +	 * TDH.IOMMU.CLEAR calls for an IOMMU, so the TDX module should never
> +	 * report the operand as busy.

Many SEAMCALLs return TDX_OPERAND_BUSY, and this is the generally expected
handling. I don't think we don't need the comment if nothing special.

> +	 */
> +	do {
> +		ret = seamcall_ret(TDH_IOMMU_SETUP, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
> +
> +	*tdx_iommu_id = args.rcx;

I remember there was an internal debate about whether to only assign the
output upon success.

There are several examples in tdx.c that assign the output regardless.
But all of them holds error information, which makes total sense to
assign on error.

This rcx output however doesn't hold info on error. So I think early
exit is the right choice. Also see tdh_phymem_pamt_remove()

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_setup, "tdx-host");
> +
> +u64 tdh_iommu_clear(u64 tdx_iommu_id)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = tdx_iommu_id,
> +	};
> +	u64 ret;
> +
> +	/*
> +	 * Don't retry on TDX_OPERAND_BUSY. See the comment in
> +	 * tdh_iommu_setup().
> +	 */

ditto

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
