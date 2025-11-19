Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD65A322A21
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537381; cv=none; b=AXYtRb+J9+ZVwWY4SYHBNa81cxWx92rmMoFbirw32U+tddlXxDH7ESBm25LGegyh9A4N3lrrYKGlw2XLeovhSgjROVqBjt+l/nXifBGkZAL/onsqBx/x3zlO4Uz76wHu83whukV/O44easwXTeNiM62ikLn7sxoOLxYdtetmrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537381; c=relaxed/simple;
	bh=wgEbgeqX72fTdb4/kRazDvRL9cpIZZD4T9OBtOF+2J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph8InXo8ULzM8oIzH9a5r/vA6Nfx6NqyRyB1FCx9KbfbyQTTbygMRaqPc1w4Oc5VpAfxw24DlFXKc6hr21J+HJMUAWtaQIJSi62Rmt1P2NW9geI/HIwQeP7sByYp010h9z1BS1yDMkQt5b69ibR9voRS9aJi/dW91K5kNlJvvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtWnTQxq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtWnTQxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763537379; x=1795073379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgEbgeqX72fTdb4/kRazDvRL9cpIZZD4T9OBtOF+2J8=;
  b=mtWnTQxqx8jjlnfKGl22Rwk2ZdLzaL8oKWWppI//NWuz0WXqlC3F3b9P
   i4Qy65Pur+vI+HbNpHeRtXu9+oUw8Ci1/aMFhEcEHM6zi7FDmuFLayx6F
   YMTbuHIp9pWYTOnLKG3dnZbYo3GlAcACHo50XtpZgX0zvyyAVD7BERHbh
   u9LmBvqfVrZ9ETIPaRQWo0LUCiYx9oFHHNBCbtaSwHusNawyXwKsTHopM
   hnnxXvRiuGVO4NwpvqiGpqsJLkZba9KGYLPIYt2tmy3tF27H4i81p0ayT
   k2cgmXrHQAS7cB0n0x/Y7mQCdFVPilzqNKhrwy9p0xdI3XD46WvnJHY5h
   w==;
X-CSE-ConnectionGUID: 51NGwoOPRBWBD56zrCupFA==
X-CSE-MsgGUID: o/paI1qPReWWc1Aifl9Fzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64768314"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64768314"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 23:29:38 -0800
X-CSE-ConnectionGUID: +QfW77J3RY61eD3lFTixlw==
X-CSE-MsgGUID: h+HfEz/gQKuhhopAzlBxmg==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 23:29:35 -0800
Message-ID: <ecea594c-4463-44d4-9577-50dc92f654ed@linux.intel.com>
Date: Wed, 19 Nov 2025 15:25:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION on linux-next (next-20251106)
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "De Marchi, Lucas" <lucas.demarchi@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com>
 <20251118012944.GA60885@nvidia.com>
 <BN9PR11MB5276C5F6D952CFFEC7CBF0D68CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5ec170fa-d5e1-473d-a7b8-8d1737efb241@linux.intel.com>
 <BN9PR11MB5276323D350AEB5C5C3308228CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1843821d-c3ca-480d-909c-2331521f6932@linux.intel.com>
 <20251118123513.GJ10864@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251118123513.GJ10864@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 20:35, Jason Gunthorpe wrote:
> On Tue, Nov 18, 2025 at 07:29:22PM +0800, Baolu Lu wrote:
>> On 11/18/2025 3:47 PM, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, November 18, 2025 2:24 PM
>>>>
>>>> On 11/18/25 12:04, Tian, Kevin wrote:
>>>>>> 46 bits is not particularly big... Hmm, I wonder if we have some issue
>>>>>> with the sign-extend? iommupt does that properly and IIRC the old code
>>>>>> did not. Which of the page table formats is this using second stage or
>>>>>> first stage?
>>>>> Assume it's first stage for kernel IOVA, if available in hw
>>>>
>>>> It's the first stage (x86_64 fmt) according to the PASID entry setup:
>>>>
>>>> IOMMU dmar0: Root Table Address: 0x105a82000
>>>> B.D.F	Root_entry				Context_entry
>>>> 		PASID	PASID_table_entry
>>>> 00:02.0	0x0000000000000000:0x0000000105a85001
>>>> 0x0000000000000000:0x0000000105a84405	0
>>>> 0x0000000105a86000:0x0000000000000002:0x0000000000000049
>>>>
>>>
>>> so the 3rd experiment (if the former two doesn't show difference) is
>>> to force using second stage to see whether it's caused by the
>>> sign-extend logic.
>>
>> I hardcoded the driver to always use the second stage for paging domain
>> translation, and it works now.
>>
>> IOMMU dmar0: Root Table Address: 0x1049b6000
>> B.D.F	Root_entry				Context_entry				PASID	PASID_table_entry
>> 00:02.0	0x0000000000000000:0x00000001049ba001
>> 0x0000000000000000:0x00000001049b9405	0
>> 0x0000000000000000:0x0000000000000002:0x00000001049bb089
> 
> Okay, that is a great finding!
> 
> So either it is something about the sign extend or something about
> x86_64. Given the similarity of vtdss all the code around cache/iotlb
> flushing is the same so we can say that is working.
> 
> 1) Can you run the test with CONFIG_DEBUG_GENERIC_PT=y? Lets see if
>     pt_check_install_leaf_args() fails?

No. It doesn't trigger any PT_WARN_ON() in pt_check_install_leaf_args().

> 2) Lets try to disabling the sign extend function:
> 
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2818,8 +2818,7 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
>          else
>                  cfg.common.hw_max_vasz_lg2 = 48;
>          cfg.common.hw_max_oasz_lg2 = 52;
> -       cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
> -                             BIT(PT_FEAT_FLUSH_RANGE);
> +       cfg.common.features = BIT(PT_FEAT_FLUSH_RANGE);
>          /* First stage always uses scalable mode */
>          if (!ecap_smpwc(iommu->ecap))
>                  cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);

This doesn't make any difference.

> 3) Let's validate the mapping:
> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2572,6 +2572,21 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>          else
>                  trace_map(orig_iova, orig_paddr, orig_size);
>   
> +       if (!ret) {
> +               paddr = orig_paddr;
> +               for (iova = orig_iova; iova < orig_iova + orig_size; iova += PAGE_SIZE) {
> +                       phys_addr_t pt_paddr = ops->iova_to_phys(domain, iova);
> +
> +                       if (pt_paddr != paddr) {
> +                               pr_warn("mapping: Bad physical storage %lx != %lx at %lx\n",
> +                                       (unsigned long)paddr,
> +                                       (unsigned long)pt_paddr, iova);
> +                               break;
> +                       }
> +                       paddr += PAGE_SIZE;
> +               }
> +       }
> +
> 
>    Maybe the physical is getting truncated for some reason?

The pr_warn() in above code hasn't been triggered.

> 4) Please collect the map/unmap traces, including the return code

I only run a typical test case named gem_exec_gttfill. The trace provide
by Chaitanya is more reasonable.

Thanks,
baolu
