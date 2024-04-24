Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217B13A406
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926855; cv=none; b=Lpg5P9t3F5ZNRUT4L7gBJohtmWTh0xf1n0nLoHmTiUltMhM4tZa33dFaEQEBClQk47XTl0t1wrjbbomZJA/P+ev+EL0SFw11W77rP+t4XNF+23m2v57/MOs5lp4+pZ0aD+EFhLycJwD5SN57bSFShzFDdnjbVMS3ZIFDK3ZGrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926855; c=relaxed/simple;
	bh=+9UFQ7F0kNPXWU5psDxCx9iQ57zcJZT5siNRwuiOyJQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q0zJinlZ3/AGp9w9xRN06JptxE/xemuzl9JmHwiwaSysc+8rrywUw+nPOK/WjQ7+/KaeyFLExdBR6Tr+9iC1D8yKwvIKxX/1Za1QrvZ/7qCYPYvF1CAAEPAIcwXVv9SgM67pFVfLCkH4X2cJvLGhl1jGkSQOw/FjRQdSfJJpq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9OuM49H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9OuM49H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713926853; x=1745462853;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+9UFQ7F0kNPXWU5psDxCx9iQ57zcJZT5siNRwuiOyJQ=;
  b=f9OuM49HoAqnWIGWu43VFooPpL3CspHZEC3y12RRv164oPdfddwaH5LM
   /1KWMBDVC1vCbFeUP0JatiJUtuPXRji1YG8lZKMEFtEjq0aO9wXgr9vwD
   en566Z2hoVHK5IkugtM+ld9CGrw0wkIfBpZShuvGFK5zXu4fT1HwUOyd/
   xY0PgUVbymGS8ZdUc555Iz6b/UoThH5rUzxBOUDOwmKSDD29aaGlfHwVc
   kKHCLNyTaLU5xVnX63KnGOEUGiolVrOWwNcENvtAvM8xI45Bg1+yvhSwc
   vNHZNQnbgxb1KN2RdgAm9M1UsnKl131QUvXV5rUgzZL5sJM6nHgyQDRM1
   Q==;
X-CSE-ConnectionGUID: unBlniv8S6CPmymaYBWkKA==
X-CSE-MsgGUID: dXVA3AbnRneQPX8oCiyL3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12473153"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="12473153"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:47:33 -0700
X-CSE-ConnectionGUID: w/MpCQrWRG6QdETBGVh0CA==
X-CSE-MsgGUID: Iz00bPD7QRu5uiyvlwgPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24449912"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 23 Apr 2024 19:47:30 -0700
Message-ID: <4c8fbcc3-64cf-4add-8d82-9a2ce8dbd39d@linux.intel.com>
Date: Wed, 24 Apr 2024 10:46:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Consolidate domain cache invalidation
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52765F34E1168B538C7CEDFD8C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765F34E1168B538C7CEDFD8C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 5:06 PM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 16, 2024 4:07 PM
>>
>> The IOMMU hardware cache needs to be invalidated whenever the
>> mappings
>> in the domain are changed. Currently, domain cache invalidation is
>> scattered across different places, causing several issues:
>>
>> - IOMMU IOTLB Invalidation: This is done by iterating through the domain
>>    IDs of each domain using the following code:
>>
>>          xa_for_each(&dmar_domain->iommu_array, i, info)
>>                  iommu_flush_iotlb_psi(info->iommu, dmar_domain,
>>                                        start_pfn, nrpages,
>>                                        list_empty(&gather->freelist), 0);
>>
>>    This code could theoretically cause a use-after-free problem because
>>    there's no lock to protect the "info" pointer within the loop.
>>
>> - Inconsistent Invalidation Methods: Different domain types implement
>>    their own cache invalidation methods, making the code difficult to
>>    maintain. For example, the DMA domain, SVA domain, and nested domain
>>    have similar cache invalidation code scattered across different files.
>>
>> - SVA Domain Inconsistency: The SVA domain implementation uses a
>>    completely different data structure to track attached devices compared
>>    to other domains. This creates unnecessary differences and, even
>>    worse, leads to duplicate IOTLB invalidation when an SVA domain is
>>    attached to devices belonging to a same IOMMU.
>>
>> - Nested Domain Dependency: The special overlap between a nested domain
>>    and its parent domain requires a dedicated parent_domain_flush()
>>    helper function to be called everywhere the parent domain's mapping
>>    changes.
>>
>> - Limited Debugging Support: There are currently no debugging aids
>>    available for domain cache invalidation.
>>
>> By consolidating domain cache invalidation into a common location, we
>> can address the issues mentioned above and improve the code's
>> maintainability and debuggability.
>>
> There are several small nits but overall this series looks good to me:
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>

Thanks! I will queue this series to Joerg for wider verification.

Best regards,
baolu
