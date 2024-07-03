Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88C567D
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975127; cv=none; b=gOG7aXBHh8wyN9ueib096dyAW7yFqkF4UrqzzGhi0IrUXUb5JL/P7Ax02iwbWG+ghfTjqYU5VS/6KRGIfHjICe2YUsunzrBBYfpMa515LpY8kcAlWlF5tL8c8qwH+w0odGiT1AmiemeMzzKfMmZkX2J00PDyWnxWWxoUTqL02Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975127; c=relaxed/simple;
	bh=NFD4UwPkMJlbGSUZ3lEdU4F/FGE0YyiIOPRe6GgX/xY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k5qqadOJZx6BR4An/umICY7i7cFj2sYF47B4BOsGMbYG7nv+kKhB9jLGfuEh9AJxMRrHld5PQkvZcTo/CCWt67VoqtoJuI+gnehE3L3jm1lYES0PVrVzEPLE8JjgiyYKtwYJUDAP3Pcth+LSn65n5J0K4091MCkY1+PjOI2Ccg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLlKJKBj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLlKJKBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719975126; x=1751511126;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NFD4UwPkMJlbGSUZ3lEdU4F/FGE0YyiIOPRe6GgX/xY=;
  b=VLlKJKBjlfCN9VP89rSkNAB9SIl3aqhLfSEHBY9SSV7rP1M5cj1oQprD
   9CBtECsiPTT4wT783Dkej9rPzopYBoPqwoZ0IVpaGtJgbwbGdiMNVNZ20
   9FTpgNWtIejJhruQFmSCnF+1B0ZhdA8Uv3W/C0Zvx15MXvMCaRa4WkwML
   Prnoj3U22Oq0c60+g/FphEJA0mgURbCh09sqKHVpmT5D6fxknlpV580u1
   xu+WseATugQIQnP8IShJ4G9iJy+CrGi1BxIAiiIpOesmV5czhvlS2nUHx
   dbAz395c6EbvGhfRo66+YAgsSvmGMvOyKuIE3VaNSEaGutIFJ2m/zl9hW
   w==;
X-CSE-ConnectionGUID: KIOeyYEBTYOfT/slJPPKQw==
X-CSE-MsgGUID: CLvUCnBPQWK7g9WfPdG2gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21054670"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="21054670"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:52:05 -0700
X-CSE-ConnectionGUID: kjENvLodTu28YyGtLdNaSA==
X-CSE-MsgGUID: ArDfYqUZReOr4+DLjt/LdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50556300"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jul 2024 19:52:03 -0700
Message-ID: <1a2f66a2-a867-4203-8a76-dbced80bfeff@linux.intel.com>
Date: Wed, 3 Jul 2024 10:49:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <20240701214128.5523a1ea@jacob-builder>
 <28ade99a-13ad-4b01-aff2-711c006856fd@linux.intel.com>
 <20240702085749.2e2bbea5@jacob-builder>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240702085749.2e2bbea5@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:57 PM, Jacob Pan wrote:
> On Tue, 2 Jul 2024 12:43:41 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 2024/7/2 12:41, Jacob Pan wrote:
>>> On Mon,  1 Jul 2024 19:23:16 +0800, Lu Baolu<baolu.lu@linux.intel.com>
>>> wrote:
>>>    
>>>> +	if (flush_domains) {
>>>> +		/*
>>>> +		 * If the IOMMU is running in scalable mode and there
>>>> might
>>>> +		 * be potential PASID translations, the caller should
>>>> hold
>>>> +		 * the lock to ensure that context changes and cache
>>>> flushes
>>>> +		 * are atomic.
>>>> +		 */
>>>> +		assert_spin_locked(&iommu->lock);
>>>> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
>>>> +			pte = intel_pasid_get_entry(info->dev, i);
>>>> +			if (!pte || !pasid_pte_is_present(pte))
>>>> +				continue;
>>> Is it worth going through 1M PASIDs just to skip the PASID cache
>>> invalidation? Or just do the flush on all used DIDs unconditionally.
>> Currently we don't track all domains attached to a device. If such
>> optimization is necessary, perhaps we can add it later.
> I think it is necessary, because without tracking domain IDs, the code
> above would have duplicated invalidations.
> For example: a device PASID table has the following entries
> 	PASID	DomainID
> -------------------------
> 	100	1
> 	200	1
> 	300	2
> -------------------------
> When a present context entry changes, we need to do:
> qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);
> qi_flush_pasid_cache(iommu, 2, QI_PC_ALL_PASIDS, 0);
> 
> With this code, we do
> qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);
> qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);//duplicated!
> qi_flush_pasid_cache(iommu, 2, QI_PC_ALL_PASIDS, 0);

Yes, this is likely. But currently enabling and disabling PRI happens in
driver's probe and release paths. Therefore such duplicate is not so
critical.

For long term, I have a plan to abstract the domain id into an object so
that domains attached to different PASIDs of a device could share a
domain id. With that done, we could improve this code by iterating the
domain id objects for a device and performing cache invalidation
directly.

Thanks,
baolu
