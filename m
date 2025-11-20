Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35842D3221
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623929; cv=none; b=ttcPSvcCF//8KHhvuz1GewI2Z2esDurUN+1NhSGcnwFUeEEb0POJPaYW9cHtUYB2yqmw01rhl0m0ibV0tx23yW0lReUBXAdaSRwGf2u0IKLxyas34BxWfHeAocveDm14+JLYqjQaQpF/kFWTnLdWR8lcZknz3u7Bjm9OqDmhXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623929; c=relaxed/simple;
	bh=Hpo3HhsoWTrb0YC201I01MRv6sZ+Tu37Hx3+TmRShLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCQ/XKqaYuo4Mzp7QYcDmZtICQjiX77gt8eleHMPru7cEnh33AEG1UxdWxgReglBF6DRWJtOnDR1kIm/W62D28Ykf4BwfEgb8ehG6vWYONctxTpeVTBRcsWD7pXONlpCtidvY+YdlLVUFYh7iaiwhrZf8CJI2ovRIqNhb1VmxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADzr0Lh/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADzr0Lh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763623928; x=1795159928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hpo3HhsoWTrb0YC201I01MRv6sZ+Tu37Hx3+TmRShLw=;
  b=ADzr0Lh/9GL0uHcXRHv4hRLE+yajevYsZrQbYQKtKdCwXia7XT1U7FL5
   S0+D4gLS+sg+9d4fwOKTqTiWF1DM/qLq11QfRH5m/UXLjqc5tFg5jB5J4
   c7JNWSb/mQz0yzAlr16TuE7CLZEAfUG1MlWdcjb5YhowbA2vfYxCinFuK
   NKwaQ8EOMSORN6ZMMj+HLG82uXD+KQgjkWbfZ6/mcBW6zqbNdpv75V3us
   1XO3ACfHpTCjftzYOhNlUmGwUR9Hf81P3wnh/2UrGYfyZzA3vxBcR94nb
   JwzN/xu20HNSJEvWbpbztm4zSzsH/PvpNPfOOE4sp1oWesbNByY0c+jB0
   A==;
X-CSE-ConnectionGUID: pkkcl0PmSsOK25MqdwaYqA==
X-CSE-MsgGUID: 7mAJWvNdQvumWHo5rN1xjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="77041403"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="77041403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:32:06 -0800
X-CSE-ConnectionGUID: KQk7NUhxTjSlh1kCpSrWtQ==
X-CSE-MsgGUID: KE0ZSN6oQV2vXkzIZUVMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191414338"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:32:03 -0800
Message-ID: <94ae0210-734b-41cb-b8a8-657b76324aba@linux.intel.com>
Date: Thu, 20 Nov 2025 15:27:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION on linux-next (next-20251106)
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "De Marchi, Lucas" <lucas.demarchi@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com>
 <20251118012944.GA60885@nvidia.com>
 <a79fe616-52c7-4fa5-906c-382b5ff2226c@intel.com>
 <20251118161341.GC90703@nvidia.com>
 <0c3cd494-e42a-4607-896c-4c341f90c270@intel.com>
 <BN9PR11MB52760A6BE22F89D29685690F8CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251119185119.GP120075@nvidia.com>
 <BN9PR11MB52764557ECAEF2200054070D8CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251120021831.GT120075@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251120021831.GT120075@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 10:18, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 11:56:16PM +0000, Tian, Kevin wrote:
>>> So we should be using dmar->width to constrain the first stage and
>>> expect that mgaw is less than dmar->width ?
>>>
>> dmar->width is the host address width, i.e. for OA. so it's irrelevant
>> to the input iova here.
> Oh that makes sense!
> 
> In that case we should probably pedantically have:
> 
> 	cfg.common.hw_max_oasz_lg2 = dmar->width;
> 
> ?
> 
> However we get dmar into that function?
> 
>> "
>> 3.6 First-Stage Translation
>>
>> First-stage translation restricts the input-address to a canonical address
>> (i.e., address bits 63:N have the same value as address bit [N-1], where
>> N is 48 bits with 4-level paging and 57 bits with 5-level paging). Requests
>> subject to first-stage translation by remapping hardware are subject to
>> canonical address checking as a pre-condition for first-stage translation,
>> and a violation is treated as a translation-fault.
>>
>> Software using first-stage translation structures to translate an IO Virtual
>> Address (IOVA) must use canonical addresses. Additionally, software
>> must limit addresses to less than the minimum of MGAW and the lower
>> canonical address width implied by FSPM (i.e., 47-bit when FSPM is 4-level
>> and 56-bit when FSPM is 5-level)
>> "
> That seems very clear, indeed. OK! Easy to fix then! Balou can you
> take it? I think something like this?

A fix patch was posted here:

https://lore.kernel.org/linux-iommu/20251120072524.3218282-1-baolu.lu@linux.intel.com/

Thanks,
baolu
