Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68646AB8
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960746; cv=none; b=Vezq2HX6luZg/BB0iHUKOlwnyr+b0pZls0QwxJRrHagAjIhZt3rmtK/KmISFuzLP4FLGCPgB8pspwE4KMN7P28XXl5qpGH+mYS3t/MWHwqeZIMdohimK517jbDP95U/fUMAdAdj7zzWk+j90M/1guDWJZc+IhZZ6924gCm0wv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960746; c=relaxed/simple;
	bh=79H2QjsjtvXf3dJkXoGSjOxOcJofOiPirAO1+Uyw+vg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dy1I35d6/cP4KJcuWIeysEGFYCYBTEef7Atzz8prjeLF0h4I0U52lkSEZB3B671+cweuF1SZmglzwXdHCCUMsWlZaMfdRmyrhtlO+ZDvwvaOWDKGfCXognVGh7bZrqjpT0FsI4k6CpG/LxWChBhjBVAQlD9lFK+f8RjWeitbTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioIkWJxd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioIkWJxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728960745; x=1760496745;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=79H2QjsjtvXf3dJkXoGSjOxOcJofOiPirAO1+Uyw+vg=;
  b=ioIkWJxdEs9+KSMnqScoLeCw125kopVSn6Wq5JCMUpQyqljqndKTCjf4
   suiqjlv5vF+I5tf8jmVxV98wZxcFt6XTOhWW87QddNxUcEbJdaNA8GK4h
   4b+OmyuaJis60/gsSzOsV3CVOJ9xBbk3FbeYr1kEUEQ7OGKkFK1L7Aljx
   jnTh007eM9GsXkjCDu+JjiPtL8XAt0n2T3RUt/3GA2RndkIYMyOyBdad7
   QOgWgWgDWgQHNtzcVKnQlsVKp3xSSxRbfPflXM97tFdQ7hGNUB4cqEsVX
   DTSlzQJ0q8Jj58JfBJB8XQRk+5pufCA84tLugS5FGu7HvfHcO1jP7VC7S
   g==;
X-CSE-ConnectionGUID: Ikdo92fUR3yr2+IiCXlh1Q==
X-CSE-MsgGUID: 96hVPcIOS52pukdRZ57yJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28121041"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28121041"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 19:52:24 -0700
X-CSE-ConnectionGUID: 9LH1pEz4Tj2xDXPBFWwL7Q==
X-CSE-MsgGUID: fdNCDooUSvaqHJ7/E9wmrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82530036"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 19:52:22 -0700
Message-ID: <a95e8a10-6240-41db-b234-d9f29386694c@linux.intel.com>
Date: Tue, 15 Oct 2024 10:52:19 +0800
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
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
 <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
 <20241014192436.GD1825128@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241014192436.GD1825128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/15 3:24, Jason Gunthorpe wrote:
> On Mon, Oct 14, 2024 at 09:25:03AM +0800, Baolu Lu wrote:
>>>> +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
>>> It looks like this entire function is already never called for
>>> anything but paging?
>>>
>>> The only three callers are:
>>>
>>> 	.default_domain_ops = &(const struct iommu_domain_ops) {
>>> 		.attach_dev		= intel_iommu_attach_device,
>>> 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
>>>
>>> and
>>>
>>> static const struct iommu_domain_ops intel_nested_domain_ops = {
>>> 	.attach_dev		= intel_nested_attach_dev,
>>>
>>> And none of those cases can be anything except a paging domain by
>>> definition.
>> A nested domain is not a paging domain. It represents a user-space page
>> table that nested on a parent paging domain. Perhaps I overlooked
>> anything?
> It only calls it on the s2_parent which is always a paging domain?
> 
> 	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);

Yea, you are right. I overlooked that part.  I'll remove the 'if'
statement and utilize a WARN_ON() function instead.

And also, I will rename this function with a meaningful name,some like
paging_domain_is_compatible()?

Thanks,
baolu
