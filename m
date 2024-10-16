Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19930171A7
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043206; cv=none; b=BWG0JI6+LegojAAC6VrFqOPF2GstK+JkORMwd9Qd5A4QI31MVY/opQ6d222x1ZHzP7iBqB8AyM6AucstQzjRRrwnGU6ItNDVDVkxt+hvi7/mN+L3sdKDiFZgNRKMhupjp7pxcn+Vwa1qhoO6HpdmGekcgqWyGeVNhT6iwplrEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043206; c=relaxed/simple;
	bh=DtloS/fHtuUBmwVdwRaF49SRJd30EqKuOubdjGfKsMo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FN08wbTQAirguf6ZcEWa1owfwU1JA1ei+ceA3hd4q2DKfCInCD8g6B6JYMiOrjQufNk2DkYhAbWDFtToG5AFECC4E6HLygv1ud8gJCayy0eyeFq4vd5VyvE8dnVohbetu4JWzr9KREllOXSX9rK43glCkgCm+kyA61jz0ucOnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjm+ASXF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjm+ASXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729043205; x=1760579205;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DtloS/fHtuUBmwVdwRaF49SRJd30EqKuOubdjGfKsMo=;
  b=bjm+ASXFI+PQykJ2uwt8JstniUrahGdGiHv2cvs6h5lxqCQsHQ8OX9at
   tfq+NmLvN0sOvitMW/WZCAezehyioDbH7DRPNIQRV2vUvO4kuRofa9W6I
   WGdsZn90WlmvFWKF6FkzPVou3s3eG24vQrfv6Lc0Zn9rE6aQjrIQMWOta
   Q6ol482qylx3mazQEl8FoiL+8qZu4ri21BRCO90r921SGLOV+rVNAIy/H
   bGpLbViNnDgzYjiIEl67GlR+EM+QnpX8uLcPQr/0ISIHxI4EcSQ2aB+jp
   BRq4eRepZ2DXI55KbmJ5MVlKrnjF8u16ysnyU8wQdPaOM4Os5x7jBOlNI
   A==;
X-CSE-ConnectionGUID: CbM/LjC+TJCIXxPwQSuBhg==
X-CSE-MsgGUID: vkVJQlOKQWaItikEGD2k6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51011438"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51011438"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:46:44 -0700
X-CSE-ConnectionGUID: E1RQSWoySm6NtqPMisF5cA==
X-CSE-MsgGUID: 6vMwcNpMSrqU8Q1nEmkmMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78421309"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:46:42 -0700
Message-ID: <b85a9fb0-f990-4e23-81e3-36546f62d5db@linux.intel.com>
Date: Wed, 16 Oct 2024 09:46:40 +0800
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
 <a95e8a10-6240-41db-b234-d9f29386694c@linux.intel.com>
 <20241015124849.GJ1825128@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241015124849.GJ1825128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/15 20:48, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 10:52:19AM +0800, Baolu Lu wrote:
>> On 2024/10/15 3:24, Jason Gunthorpe wrote:
>>> On Mon, Oct 14, 2024 at 09:25:03AM +0800, Baolu Lu wrote:
>>>>>> +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
>>>>> It looks like this entire function is already never called for
>>>>> anything but paging?
>>>>>
>>>>> The only three callers are:
>>>>>
>>>>> 	.default_domain_ops = &(const struct iommu_domain_ops) {
>>>>> 		.attach_dev		= intel_iommu_attach_device,
>>>>> 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
>>>>>
>>>>> and
>>>>>
>>>>> static const struct iommu_domain_ops intel_nested_domain_ops = {
>>>>> 	.attach_dev		= intel_nested_attach_dev,
>>>>>
>>>>> And none of those cases can be anything except a paging domain by
>>>>> definition.
>>>> A nested domain is not a paging domain. It represents a user-space page
>>>> table that nested on a parent paging domain. Perhaps I overlooked
>>>> anything?
>>> It only calls it on the s2_parent which is always a paging domain?
>>>
>>> 	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
>> Yea, you are right. I overlooked that part.  I'll remove the 'if'
>> statement and utilize a WARN_ON() function instead.
>>
>> And also, I will rename this function with a meaningful name,some like
>> paging_domain_is_compatible()?
> That sounds good too
> 
> Ultimately you want to try to structure the driver so that there is a
> struct paging_domain that is always the paging domain type and
> everything is easy to understand. Don't re-use the same struct for
> identity/blocked/nested domains.

Yes, agreed!

Thanks,
baolu
