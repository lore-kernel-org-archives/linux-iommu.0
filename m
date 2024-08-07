Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9E6BFA3
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009749; cv=none; b=PRQfFD4FWTr/T3GdTftKsl1DylX5Zchlg7dChLePLUXH3gZoexe7QJyU5Nx89amLlMKaClGlXwzWUp+HfDsZmvn9pPA7JygyXntQsIBNZ3kuOg0DQjHidehq89Gk/qUg6cT5QQ4iahWkcI5Tj7ip/j8/dS4yxqJRCb5fb5N/5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009749; c=relaxed/simple;
	bh=1OIzgPNYiZvJxBJfXBI8GThuYljiHissF+zEmvnuJJ8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EJFC1vQ2eP0aU/ySQdQNUmv5OmPLMHnQQsLfOhReNdChPRETeexMkngSyVEkyN20wKrjVycgwLNSuaGlGithLexl8UKRUuVRno6ZOrOEFumqQznq+wCdRIJEXqKqhAMRQ7bGHp7d3Bf28E5EC1NBW3ySXunCr8/scxoSoh6U2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nayJrVcf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nayJrVcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723009747; x=1754545747;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1OIzgPNYiZvJxBJfXBI8GThuYljiHissF+zEmvnuJJ8=;
  b=nayJrVcfhdt7012Lo+C9Nn8GvxCh3DWChyCQW6SrIDWwXHMq9lLTdgV0
   VasJVQJMS5coeQScC9Rx0T0/VmdrBqUcZHdHO4sYlcnFmzmY/UkLWGppP
   /RwqugYIJOq83Qxd2MeI5hX5Pt8vFxkcL1hCKkcXwK8bmkOdVGOgVcrmZ
   jaXTJWgKXxn/OIBFsRP8lya8KUP4BuqcPVPYY0cOaunkIg5Vd7T3Kqq2u
   e2lEdjefeQEXN4iDMHAZ+tBJdVY7FExk0j3N7iQfJaKqKfPTQXOxuF/kx
   Qs+aLXVn8ibXJtW3J4bUPJo84Sx4AGJAIVKzKwpQlhGFyhGK+YztKMtwS
   w==;
X-CSE-ConnectionGUID: t1afustWRey2k7H1AXauUQ==
X-CSE-MsgGUID: qIKlqwC9Ry6XTcycmDAvxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31689517"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="31689517"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 22:49:06 -0700
X-CSE-ConnectionGUID: lruvOyKBSueecvc+vvxZrA==
X-CSE-MsgGUID: YCqG1rDsQhS88Te/zrX0Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56700578"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 22:49:05 -0700
Message-ID: <2c537d82-c511-4367-8a5c-29122745326d@linux.intel.com>
Date: Wed, 7 Aug 2024 13:49:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 yi.l.liu@intel.com
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240806173230.GS676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 1:32, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 08:11:19PM +0530, Vasant Hegde wrote:
> 
>> I only have issue with allocating right page table for UNMANAGED domain. In this
>> case just 'dev' param is not sufficient. Ops should send some sort of indication
>> that its UNMANAGED domain (like its non DMA API domain). Otherwise AMD driver
>> cannot allocate right page table.
> Be specific, you mean when VFIO allocates it because VFIO is almost
> the exclusive user of UNMANAGED domains on x86 hardware.
> 
>> My understanding is we essentially have two modes for device passthrough.
>>    1 - Existing interface where vfio driver manages page table (call
>> iommu_paging_domain_alloc()). No PASID support in this mode.
>>    With this RFC I am trying to solve this scenario.
> Honestly I'd prefer you change VFIO type 1 to call domain_alloc_user()
> instead of hacking domain_alloc_paging().
> 
> This is a lot more explicit than trying to push new meaning onto
> UNMANAGED which is trying to get itself removed.
> 
>>    2 - via iommufd - It will use domain_alloc_user() ops. This is the interface
>> where we want to support PASID w/ passthrough device.
>>
>>     This is where you/Yi suggested to start discussing with Alex on Yi's PASID
>> support series. I am running behind. I will start looking into Yi's thread soon.
>>
>> Is my understanding correct?
> Broadly, but I'd rather VFIO exclusively use domain_alloc_user() and
> it can accomodate both cases. So add a flag to indicate if PASID
> should be enabled.
> 
> It makes sense to me that type 1 would just always disable PASID
> support, it should just be done explicitly without the word
> "UNMANAGED".

Convert paging domain to user domain allocation appears to be a
reasonable solution. But I think it's not VFIO-only, vhost-vdpa is
another case, right?

Thanks,
baolu
