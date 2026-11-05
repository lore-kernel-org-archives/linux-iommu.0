Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858796;
	b=PoaNWlzfpN3gcfKgixRBDAXlExCgva1PiOD2g0jFSlGitdZflnsKp7btcUtl3uuE9ERN
	 Iy12CvIMqXAng4LA9v8pBZa26D3t7xTFxtTRBiqAQTrTFtuh8IpHey1kVCqZ1MtASnlaZ
	 m9KLsCOx4GAxcSDqzNSOC/DhVMEIt50Jjr911Hn8skRHmnUJI5b8b03I75sJCs0Bqf6ho
	 Fgi5gCSrmAQThE9OZ8YJhjpbOaHf/OZoaRFp4hgAey+qZfd2f103dazc3E8SKQ7KWagl9
	 20Z0Fi6Q0cWM4IUrJ6uDw9poGgcUUT6eShfyarHR6EDeprApSTpsJYCuZn+TW/qaMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858796;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hlm+rn+oysNQEGjSF8tAU2VzC9EojVXk66lwsMDmr7U=;
	b=spfNmQShEtuzix2cPfJGFoDoWZRD7QO3cy8co9BbKpH+aaaLSgwdcDli9wl/M8AZgcG2
	 M0nmJmhdzmuAjVIJT40CObZG+c0/WCaViLcG7iJTtxts3cKq9PfxB6NWqb1HbqKsEkTcK
	 lXkhNMVjLNhyjITnvRZsi3lv0Y1boMOB7+LX0Oo8HIDC+J+tLokhh8Pf9JEp7EbQOq38a
	 sH0E2sPkd+dRNxzJHqfjXD/D+EGC5mfvItF0HooK5E6bCo1TsYR0+G1QRHv3BalXXm3Cy
	 6LXgisAzUoeYvgjKB+ZTmka/kWJX3M+A15OZOOFxUKQBpsqAM7Xldk/SiME3Kuw37cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sqj84r+D;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7C606A31B;
	Thu,  5 Nov 2026 06:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sqj84r+D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793858795; x=1825394795;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1Atk2ZmfPf0LeQVA4o58INUz/taOCt0EIF6/hjQxu8=;
  b=Sqj84r+DxXe7/Nj4F6lVzK7c5MN1epEYaNy/+g1RU63ncMonWVW/er2G
   wHmgMNCjXAGJHY4w4GDqRd6HU9dnjcX16lXWESyKzB2DQKgsRhUCr72t8
   Wb8GLSInCQyGmm1h97e1VjTIluG/HCl0S0B0vt6RK9nMhbUq+IeAtz/yN
   30NNLXgGyRaD4ETteHni5pjSNUpaTs9KKyLX/jAu42r08/zh/vaWV1XLe
   VqoZT93wTXLrpg/ZHqw/8zQcLQEpWVx+0gRrB7u02ZrPao8S+7oZIlo7Z
   yWpqM4lj2udWkug58b6BUq2avSXLk0UE6ASvQ5fbiMh/tJiIb8P+4Ngon
   g==;
X-CSE-ConnectionGUID: Lp+kl8i9S0elbmv0zRdKcg==
X-CSE-MsgGUID: 6C4tKEAhQBCZNZA19w6mAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2628742"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2628742"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:06:35 -0800
X-CSE-ConnectionGUID: cl2az8UQR/ar1xXQbOTzxA==
X-CSE-MsgGUID: biV5YcuiTEaTHjQdSSRgUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8688050"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:06:31 -0800
Message-ID: <d52dba58-5f8a-4980-b9d0-0b1e0df48f82@linux.intel.com>
Date: Thu, 5 Nov 2026 14:06:27 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
 Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: Xu Yilun <yilun.xu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-2-baolu.lu@linux.intel.com>
 <atBz5cj0wQZv/fLN@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <atBz5cj0wQZv/fLN@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/2026 2:34 PM, Xu Yilun wrote:
> On Thu, Oct 15, 2026 at 09:07:02AM +0800, Lu Baolu wrote:
>> Add SEAMCALL wrappers for TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR.
> 
> We need this patch been reviewed by x86 reviewers. x86 convention
> doesn't start with the implementation, so remove it.
> 
> We can start with a generic description of what the 2 SEAMCALLs are
> doing in general and why. Maybe move some of your description in next
> paragraph ahead.

Agreed.

> 
>>
>> TDH.IOMMU.SETUP transitions an IOMMU and related I/O stack into Secure
>> TDX Mode. During this transition, the TDX module validates and protects
>> relevant I/O resources from further untrusted host access, providing the
>> trusted foundation required before enabling TEE-IO security protocols
>> (e.g. SPDM/IDE).
>>
>> TDH.IOMMU.CLEAR performs the reverse operation and tears down the Secure
>> TDX Mode state for the target IOMMU.
>>
>> The caller is responsible for allocating the required pages and
>> populating the parameter page in the ABI-defined format.
>>
>> See Intel TDX Connect ABI Specification [1], Section 3.2 (TDX Connect
>> Host-Side (SEAMCALL) Interface Functions).
>>
>> Thanks to Xu Yilun for the initial draft.
> 
> Feel free to drop it. Not that important.

Dropped.

> 
>>
>> [1] https://cdrdv2.intel.com/v1/dl/getContent/858625
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   arch/x86/include/asm/tdx.h  |  2 ++
>>   arch/x86/virt/vmx/tdx/tdx.h |  2 ++
>>   arch/x86/virt/vmx/tdx/tdx.c | 56 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 60 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index 89e97d5761d8..8b5411d3eb67 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -176,6 +176,8 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ex
>>   u64 tdh_phymem_cache_wb(bool resume);
>>   u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
>>   u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
>> +u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id);
>> +u64 tdh_iommu_clear(u64 tdx_iommu_id);
>>   #else
>>   static inline void tdx_init(void) { }
>>   static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
>> index bdfd0e1e337a..d7beb42cf972 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.h
>> +++ b/arch/x86/virt/vmx/tdx/tdx.h
>> @@ -49,6 +49,8 @@
>>   #define TDH_SYS_SHUTDOWN		52
>>   #define TDH_SYS_UPDATE			53
>>   #define TDH_SYS_DISABLE			69
>> +#define TDH_IOMMU_SETUP			128
>> +#define TDH_IOMMU_CLEAR			129
>>   
>>   /*
>>    * SEAMCALL leaf:
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 1b9ff749dd8e..5d31c1b0890a 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -2034,3 +2034,59 @@ void tdx_sys_disable(void)
>>   	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
>>   		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
>>   }
>> +
>> +/*
>> + * Wrapper for TDH.IOMMU.SETUP leaf, which transitions the IOMMU and related
>> + * I/O stack into Secure TDX Mode.
> 
> Other tdh_*() wrappers don't have the general descriptions. We all know
> these are wrappers for some SEAMCALL leafs.
> 
> So if there is no special thing to note, remove it.

Removed for both wrappers.

> 
>> + *
>> + * The @root page format is defined by the TDX Connect ABI spec (Table 3.35,
>> + * Structure of IOMMU_MT Parameter): the first two entries describe the size
>> + * and HPA (Host Physical Address) of the two contiguous buffers for the
>> + * invalidation queue; the remaining entries provide HPAs of
>> + * IOMMU_MT_PAGES_COUNT metadata pages. IOMMU_MT_PAGES_COUNT is obtained from
>> + * trusted IOMMU global metadata.
>> + */
>> +u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id)
> 
> IIUC, the void *root is a vague type, no type safty. Is it better we
> define an explicit structure that mirrors the in-memory ABI? Something
> like:
> 
>    struct tdx_iommu_metadata {
> 	u64 iq1_pa;
> 	u64 iq2_pa;
> 	DECLARE_FLEX_ARRAY(u64, mt_pa);
>    };
> 
> Or,
> 
>    struct tdx_iommu_metadata {
> 	u64 iq1_pa;
> 	u64 iq2_pa;
> 	u64 mt_pa[510];
>    };
> 
>    static_assert(sizeof(struct tdx_iommu_metadata) == 4096);

Good point. I updated the code with the following:

   #define TDX_IOMMU_MT_IQ_NR	2
   #define TDX_IOMMU_MT_MAX_PAGES	(PAGE_SIZE / sizeof(u64) - 
TDX_IOMMU_MT_IQ_NR)

   /* IOMMU_MT parameter page for TDH.IOMMU.SETUP (ABI spec Table 3.35). */
   struct tdx_iommu_mt_param {
       u64 iq[TDX_IOMMU_MT_IQ_NR];	/* HPA | number of 4K pages */
       u64 mt[TDX_IOMMU_MT_MAX_PAGES];	/* HPA of each metadata page */
   };
   static_assert(sizeof(struct tdx_iommu_mt_param) == PAGE_SIZE);

   u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
               u64 *tdx_iommu_id);

> 
>> +{
>> +	struct tdx_module_args args = {
>> +		.rcx = reg_base,
>> +		.rdx = __pa(root),
>> +	};
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Don't loop forever:
>> +	 *
>> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
>> +	 *    calls.
>> +	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
>> +	 *    unchanged.
>> +	 */
>> +	do {
>> +		ret = seamcall_ret(TDH_IOMMU_SETUP, &args);
>> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
>> +
>> +	*tdx_iommu_id = args.rcx;
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_setup, "tdx-host");
>> +
>> +/*
>> + * Wrapper for TDH.IOMMU.CLEAR leaf, which terminates Secure TDX Mode for the
>> + * target IOMMU and restores control of related hardware resources to the host.
>> + */
>> +u64 tdh_iommu_clear(u64 tdx_iommu_id)
>> +{
>> +	struct tdx_module_args args = {
>> +		.rcx = tdx_iommu_id,
>> +	};
>> +	u64 ret;
>> +
>> +	do {
>> +		ret = seamcall(TDH_IOMMU_CLEAR, &args);
>> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");
>> -- 
>> 2.43.0
>>

Thanks,
baolu
