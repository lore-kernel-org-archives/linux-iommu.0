Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573437B
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728867238; cv=none; b=imR/UpG3xSnR8N+DhMb5vX0CehoykEyOills8ZQ0JrwGsDQQ98sIE9DpsBK877qrmGHRLmxHrWNJh7DLDeDOsKxWA460A/Wn9f3dAN5hzm6j5RBjrPAcpoNf2G4KeJLmwAicWjAWiRmQrWYRSKMWFacavk3o/08WqxRbhI7KZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728867238; c=relaxed/simple;
	bh=tvdjtp+Xnx1kD3Mp10OKWBEyWKfiORomy9/EsUTbXVo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F55Wa+l9s6VDBjLRsOhlmLa0HEwu7SdGD6B0cWnfeodqA2elJ9ooA7efM27kBrH35doXxhCkphrHgAZgRIueGzi3RzlVp5t8RbmBcbDLkYq5Bd1kFDRs31RxVgjQlC6Ykh3x6Jaj4eoZqk65mBtiqWhQ5qSLxNdtgzCZVPC45IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oA2eLbcN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oA2eLbcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728867237; x=1760403237;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tvdjtp+Xnx1kD3Mp10OKWBEyWKfiORomy9/EsUTbXVo=;
  b=oA2eLbcNB603Ldwv2NXE3DpqNvHkVljGhPszIH0xtp1VACg1x/q7dYDE
   3KEgBlcnTfiOqOvtKKj/oB2T+6aoe/Xx1fUc/ZUZGU4/qqpOqRjpVbFHt
   CtN/Jq7imjiz8LvqcbjvLVQ7WhcnX2ZOnQrXu6MmtG8BRT4Jx8WphEg+m
   ztNM0qjSmwpkVCitplSdqDmwJgI3Ze2vVJUiEPJsmnKtFc751QC1cKJC0
   oQdmnt7fVun/h0xmk9T+rYHsudGG+uMkz9NeQls0RaWWF54Jq/KMUFd6e
   m/JCK5n4i4t/7YAkj5FsQ505Hw+x2jbWIuGsmvT072UzUmsNnYerJBvkU
   w==;
X-CSE-ConnectionGUID: SE+TAiGXRN67NjbrKOHjmQ==
X-CSE-MsgGUID: r0OaeCNFQcuDIpJww3yE+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="39586809"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="39586809"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 17:53:56 -0700
X-CSE-ConnectionGUID: P6TlyDfiSLeoxzqQAhzZzw==
X-CSE-MsgGUID: 6jX5D+mwSx+g1AvqEqinSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="77753768"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 17:53:54 -0700
Message-ID: <b2926672-216c-49cf-abea-9848aa52f109@linux.intel.com>
Date: Mon, 14 Oct 2024 08:53:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
 <20241011132252.GJ762027@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241011132252.GJ762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/11 21:22, Jason Gunthorpe wrote:
> On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:
> 
>> +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	struct dmar_domain *dmar_domain;
>> +	bool first_stage;
>> +
>> +	first_stage = first_level_by_default(0);
>> +	dmar_domain = paging_domain_alloc(dev, first_stage);
>> +	if (IS_ERR(dmar_domain))
>> +		return ERR_CAST(dmar_domain);
>> +
>> +	return &dmar_domain->domain;
>> +}
> With the direction that Vasant's series is going in, I think this
> should be skipped and instead your other patch to make
> domain_alloc_user (which we will rename) a full functional replacement
> is the right thing.

I think it's too early to remove domain_alloc_paging from the iommu
driver. Vasant's series makes most of the paging domain allocation go
through domain_alloc_user ops, but for those that are non-PASID related,
it still goes through domain_alloc_paging. So perhaps we can clean up
after both series are merged.

Thanks,
baolu
