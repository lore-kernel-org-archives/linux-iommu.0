Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFDA175BF
	for <iommu@lists.linux.dev>; Wed, 25 Dec 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110792; cv=none; b=uOtlW/5ZNOMGyS+41XiFv5tPEk5OXdQs2sxsZNbZ5KxPgQPlpgBh8DdQeMd8JpA6zieB0dfyECjB1umtgP+1rZ/3MGgiTCu8m8VWRokDKUPxZSFEnvjgEpu7Ze+Fi0ktTe7RkYoNKFEmVcbEEZ3QFaIlkg213AjH+qf9l5UcUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110792; c=relaxed/simple;
	bh=6zBRm3R9WqOLT7S2y6DnCZo95YdaIrMH/l+HqqsSoZ0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dqyVd98qeHBwZ/PF6YcrrsAf9vYSoNgV35vEQ7anTnp777fPjKk+63LtCQzG2pLYeANjtJv5CA8ilKerF2ePU61wHJ2Su8T39uQLVqR034JoigUdtSMo+xS89bx57T1fe029j785FbAUXVds6qCHkT6F+/9ROjgl1qrFk4u0GSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3+k2m/H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3+k2m/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735110791; x=1766646791;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6zBRm3R9WqOLT7S2y6DnCZo95YdaIrMH/l+HqqsSoZ0=;
  b=K3+k2m/HDw4Z/ZdFp22W4Gr57m5HRwQbgUNz+EQYdcUxPVCqlXvd2GVR
   lyrYjQyjrO+4n4mdn6+EkkY7Q+bNgupzONcK0K2THpJ/8kH4F1bzHuklb
   Wab6aVcHNemKzU2wr4QQmkCfmcBaF57QQtnO+VNp/21a1CNFC2aAtzA+m
   WX1hPxEoQtlJ4uAYMYv5QsMnOeQFHzmb0ZwK9E0XArY695w3xt/IR4a89
   xhedKaDenc4aHSCBMowdc2GReTNHJnztNRmZVpAtpcwtc3amITZhEia5J
   JCnlabpZGMqTcq6MWiDaSpeHJjuYH7ZJ9dkqbY/0arbCx+N4+n5cFFxX1
   A==;
X-CSE-ConnectionGUID: v03uKtZySQqVumQN259Geg==
X-CSE-MsgGUID: KvcKtjf+RoSp+z8gQLLy0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="52968916"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="52968916"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 23:13:10 -0800
X-CSE-ConnectionGUID: tjJ4oGq/TxiAlYu70foCSg==
X-CSE-MsgGUID: DIwt8VzPQ9uD3XWL2Y6U6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="99515422"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.34]) ([10.124.241.34])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 23:13:07 -0800
Message-ID: <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
Date: Wed, 25 Dec 2024 15:13:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev, vasant.hegde@amd.com,
 will@kernel.org
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/25 12:30, Yi Liu wrote:
> On 2024/12/25 09:02, Baolu Lu wrote:
>> On 12/24/24 19:35, Yi Liu wrote:
>>>> Another related consideration is the support for page faults in nested
>>>> domains once PASID is available in user space. Would it be 
>>>> reasonable to
>>>> support page faults for nested domains?
>>>
>>> yeah, it's good to discuss it.
>>>
>>>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>>>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
>>>
>>> IMHO, the PRQ support for nested domains requires some more facility. 
>>> PRQ
>>> can happen at either stage-1 or stage-2, iommu driver may need to tell
>>> it and forward to the correct domain (nested domain or parent 
>>> domain). Or
>>> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, 
>>> any PRQ
>>> happens under nested translation should be due to stage-1.
>>
>> The parent domain is currently always pinned and does not yet support
>> page faults. Therefore, when a page fault occurs within a nested domain,
>> it apparently should be routed to user space...
>>
>> If we decide to support page faults on the stage-2 domain in the future,
>> we will need to figure out the correct destination of each page fault
>> and route it accordingly, either to the parent domain or the user space
>> nested domain. Hardware assistance would be beneficial, otherwise the
>> software may need to traverse the parent domain, which is not
>> performance friendly.
> 
> this is my question. Is it still true the parent domain is always pinned
> after the below series? If yes, then it's fine to enable IOPF for nested
> domain.
> 
> https://lore.kernel.org/linux-iommu/20241015-jag-iopfv8-v4-0- 
> b696ca89ba29@kernel.org/

Then, perhaps we could enforce this in iommufd for a short-term purpose?

When allocating a hwpt in iommufd, we should enforce that the flags
IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_FAULT_ID_VALID cannot be set
at the same time.

---
baolu
