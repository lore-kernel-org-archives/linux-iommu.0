Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F310A12
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973889; cv=none; b=VkQIEuaK4SDs+jKYa3JWjqeb/COWYbJx4wOfE9JEk8X0bAQ8lNGKNdSvOvSjHKZ21tRr7dnQLl5y1d+M7JUpUdq1qAhqxKZtc+0F58I4VYToJycCzvS3HQ10IBy6RlYaYb3beheewi7TQllomPNlvGFsdn8nZKHY9GP7BPmWUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973889; c=relaxed/simple;
	bh=PkRWzhD4ZHZuLqr/KwvjT3cha8rhH5UVB60H2MKe1fE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EJuQ95PcIR0jWqH7PsZGpnETY3999vyHIZe/9lLx9uLIiaOWBu1lzwNOdnaiIi5M0wmmk9M70JvEWKc6vSxMNNagAksTOj4tHzMmBRehA8LmLtsrTqAopMDzlV7WZf46GGv/l0owBliMlDVkdX6+uB/zSwoacqi5kTDsU0sM5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a67ENVpe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a67ENVpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719973888; x=1751509888;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PkRWzhD4ZHZuLqr/KwvjT3cha8rhH5UVB60H2MKe1fE=;
  b=a67ENVpePRP/GbH5MojCt0GfCws3q2ZT8SJioflhwkXKcWgjSip4kcg4
   XFsBUfwlpoetnp4ecL/rBLYEr3wDU7mc6opHGjWs7uGF13wyZezP6E6fO
   WBWipryEKXAkaR7gbaeufyUP6vLUqFAIUzOWmvapzCKVL9Vc5urIUSpEG
   Yjcb8Df22cGrpIxQWZwRmdZp7SaElM2muC9cZt5C4XWUnJXRkC9Vi22nP
   0k2Dk0u6zyTQzI4Gfdkn4xQW/v2Bx0T3pZs46M40aTUVvujCWHd25mok8
   vjMVqKq3DpR4sRRhw9folvPDY4iUuRN5FRNJRqJJk6mMj/4VH4sZuzcfl
   A==;
X-CSE-ConnectionGUID: /mAiNsO4RKybLXv1HUbYYA==
X-CSE-MsgGUID: 9079CvuVRRWLlHumFIZZRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21053564"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="21053564"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:31:28 -0700
X-CSE-ConnectionGUID: YQAa88tATdmwSfFN9imJhQ==
X-CSE-MsgGUID: UTFM61tnRA6w6uHwROAJyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50552204"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jul 2024 19:31:26 -0700
Message-ID: <2107dc15-c669-44b9-b967-b75fc6c977e8@linux.intel.com>
Date: Wed, 3 Jul 2024 10:28:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: lack of permission checking with intel-iommu?
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org> <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
 <ZoO5ZeYtA6qLIs21@infradead.org>
 <0d0c9d4b-b233-4ac8-9a46-9da24f1c5536@linux.intel.com>
 <BN9PR11MB52761AAFB5C2E2A42E24B9B38CDD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761AAFB5C2E2A42E24B9B38CDD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 8:56 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 2, 2024 5:13 PM
>>
>> On 2024/7/2 16:25, Christoph Hellwig wrote:
>>> On Tue, Jul 02, 2024 at 04:22:25PM +0800, Baolu Lu wrote:
>>>> Is it about IOMMU blocking "device reading from buffer" or "device
>>>> writing to buffer"?
>>>>
>>>> The intel iommu driver might use first-stage translation for kernel DMA.
>>>> It seems not to block the "device reading from buffer" if I remember it
>>>> correctly.
>>> This is about device reading from buffer it is only supposed to write
>>> to (but doesn't).
>>
>> In this case, Intel IOMMU doesn't block device reading as the first-
>> stage page table only grants two types of permissions: Read-only or
>> Read-write. Write-only permission is not available.
>>
>> Do you have a functional requirement for Write-only permission? If so,
>> we can choose the second-stage page table.
>>
> 
> Note there could be configurations (e.g. vIOMMU) which only supports
> 1st-stage. So there is no guarantee that write-only permission can be
> always enforced on Intel.
> 
> btw according to current code looks write-only even doesn't work on
> 2nd-stage:
> 
> __domain_mapping()
> {
> 	...
> 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
> 	attr |= DMA_FL_PTE_PRESENT;
> 	if (domain->use_first_level) {
>                  		...
> 	}
> 	...
> }
> 
> DMA_FL_PTE_PRESENT and DMA_PTE_READ are both bit-0, so
> READ is always set in 2nd-stage. That line should be done only
> for domain->use_first_level==true

This is intended to make the permission consistent between first and
second stage.

Thanks,
baolu
