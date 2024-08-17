Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B310F7
	for <iommu@lists.linux.dev>; Sat, 17 Aug 2024 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723865308; cv=none; b=RORVZFS4Yp56+SVeyGydJbQci/HTu3lUhcHYQaocNCoqMKSN1FOEs5rt8eYlUDLlg42VaevKP3Ba2/6khe3ImwR47/brRUGEw9jytpC2urBZ2sXOqBuw70k74W7/pEYkZyrgI8NYWZDaepFQEZlh8ezJHmbSKBbqP++4cbapDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723865308; c=relaxed/simple;
	bh=jo6iqObDbAcE5ni2ANp2DYWgy8/kgFR88LxGeL0yNLA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=unii1n0U+zT9HHgVSZXFLURYtJ+INzj7tTtnQDcaY50t28S2PbF8H0Hx3mbBwpLqfqDch0ndZsPZ49nU2HbW2Mcq5SU/SNelWDTH79ZEhDxxFhRIRjLeteDVDgIwJzE/6u1UshAuQhnd4yzO2/J5HoLB5ghslOuwvBv8DYxAui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1swl+YN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1swl+YN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723865306; x=1755401306;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jo6iqObDbAcE5ni2ANp2DYWgy8/kgFR88LxGeL0yNLA=;
  b=a1swl+YNwV6bvlJsa3PQVysfoiZhW3BfvI0lKAcUZ5FRHE52sQd8lqCc
   1xtapOXLMHeBMfAlLatNvAI7XcTSniyyARbd8R8jadVZZAIO1/V3yoHSa
   q85wHxsABoNpESdLJLE3pU+B4dSA4Es/aeBNX70BTPLaudKDKvMvJoww2
   d6JTbLwTUeq29rtu5OYGde9PJyXQ+4rQUMJwnulWOYixkvw1ofja/55jK
   uGp1sj8jjWEGGho7mlwntwXsvJ1xqLf2av/EPfXKIbt9et2aezjtsE8Sn
   arWuKXpEavBDv1kMWZQpayIMPWr04VQEtTtWleFbEjeOUSCZDm0XEx7GZ
   w==;
X-CSE-ConnectionGUID: f90yTfU8QbOvskAcoxGzSg==
X-CSE-MsgGUID: 4CrGvb9bRwWFwuN3F9n/jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22024506"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="22024506"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 20:28:25 -0700
X-CSE-ConnectionGUID: s+eqhXEJTte+VifeRiCRYQ==
X-CSE-MsgGUID: JWNLZ3DKTH2b6NTDMEBmDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59484962"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 20:28:24 -0700
Message-ID: <afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
Date: Sat, 17 Aug 2024 11:28:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
To: Jacob Pan <jacob.pan@linux.microsoft.com>,
 Tina Zhang <tina.zhang@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
 <20240815065221.50328-5-tina.zhang@intel.com>
 <20240816093846.40dbd623@DESKTOP-0403QTC.>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240816093846.40dbd623@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/17 0:38, Jacob Pan wrote:
> On Thu, 15 Aug 2024 14:52:21 +0800
> Tina Zhang <tina.zhang@intel.com> wrote:
> 
>> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
>> dmar_domain *domain, struct cache_tag * u64 type = DMA_TLB_PSI_FLUSH;
>>   
>>   	if (domain->use_first_level) {
>> -		qi_flush_piotlb(iommu, tag->domain_id, tag->pasid,
>> addr, pages, ih);
>> +		qi_batch_add_piotlb(iommu, tag->domain_id,
>> tag->pasid, addr,
>> +				    pages, ih, domain->qi_batch);
>>   		return;
>>   	}
>>   
>> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
>> dmar_domain *domain, struct cache_tag * }
>>   
>>   	if (ecap_qis(iommu->ecap))
>> -		qi_flush_iotlb(iommu, tag->domain_id, addr | ih,
>> mask, type);
>> +		qi_batch_add_iotlb(iommu, tag->domain_id, addr | ih,
>> mask, type,
>> +				   domain->qi_batch);
>>   
> If I understand this correctly, IOTLB flush maybe deferred until the
> batch array is full, right? If so, is there a security gap where
> callers think the mapping is gone after the call returns?
No. All related caches are flushed before function return. A domain can
have multiple cache tags. Previously, we sent individual cache
invalidation requests to hardware. This change combines all necessary
invalidation requests into a single batch and raise them to hardware
together to make it more efficient.

Thanks,
baolu
