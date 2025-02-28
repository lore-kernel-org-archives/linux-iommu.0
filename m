Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9501DDC35
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713565; cv=none; b=bicSiSQeerUTaDqA7xNzxU4VIy4SBRw0mgG9UlsRyBJwRKzBzx0OQ6Fw8gJv0bAsh1Q+9s/imNCmMjrOcwIpbl9Xe5aQ8MxQS7h9P/cUhbuxNlWCnCnI7LGzBueGcz+m7v16//9DGTCydw8AWVnljTrME8xIJOdEEo/CuJ0NJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713565; c=relaxed/simple;
	bh=O7zRYrsqSiJgycIUYDKf3/11DN1UQDub9iFMRmiysKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5VqRXe7UD2Ag+/UvGjJ6xvlaF5iTIK4MUQmbHfiDtRpLTScu1p7Yc8Nn+tWg4T/xXboaxDXIIeAfUnkDd/D1lcW6PwKjHd41aKfWRuKhaRvIN0nU/1oQF8M2tGD/4xdphmL7+IWl7AtvVSulX2b/n5dbiI/eoITDhSX3srpYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EI9aQ5NP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI9aQ5NP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740713564; x=1772249564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O7zRYrsqSiJgycIUYDKf3/11DN1UQDub9iFMRmiysKU=;
  b=EI9aQ5NPrtriNU5EnmjKIT1kSL+oXMBympOIha2tJ8gEK7Vq2nymry8d
   yI4/6UWxb8/21sBoNQn4JMR7i3fcniS3fy6GZ8uSXwvJwHk56V04rgryJ
   KzD8Onoj+haIryEsTn4j/T5iLVWfHxZPJjkV0R8IHIKee5DfBS8ClY85O
   2yJSbKE7maWA80V6XAigTJZ/uI4AXWIOx2vPk1bMzLXHySwG24hcv6PZ1
   3eY+mBfN+ofzVMySyPMreCaVf1E9WFh93Bx7wMmxmVwZXrG4s0nQqRFaB
   cntKWPuLDFP1tx7XY6wyD6fBfOVEmCrB5fwpVCN6FQHidAczdgTT2v5B9
   A==;
X-CSE-ConnectionGUID: yqCGiW9iTgioSksUhYsrbQ==
X-CSE-MsgGUID: 9VNh2JrbReytOrQ3awT+Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51837284"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="51837284"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:32:44 -0800
X-CSE-ConnectionGUID: +FmaSdlySDiIKdS3zqDvQw==
X-CSE-MsgGUID: fYtp9uDKTBSQRUhMIvO4yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121345743"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:32:42 -0800
Message-ID: <cbf58625-e9f3-4822-9bcb-ccaadeea47bf@linux.intel.com>
Date: Fri, 28 Feb 2025 11:29:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu: Add private_data_owner to iommu_domain
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com,
 joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
 <f6d0fcb1-b974-440f-9208-257422bc01a6@linux.intel.com>
 <Z8EsN/Vg2SVeChTp@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z8EsN/Vg2SVeChTp@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 11:23, Nicolin Chen wrote:
> On Fri, Feb 28, 2025 at 11:13:23AM +0800, Baolu Lu wrote:
>> On 2/28/25 09:31, Nicolin Chen wrote:
>>> Steal two bits from the 32-bit "type" in struct iommu_domain to store a
>>> new tag for private data owned by either dma-iommu or iommufd.
>>>
>>> Set the domain->private_data_owner in dma-iommu and iommufd. These will
>>> be used to replace the sw_msi function pointer.
>>>
>>> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
>>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>>> ---
>>>    include/linux/iommu.h                | 7 ++++++-
>>>    drivers/iommu/dma-iommu.c            | 2 ++
>>>    drivers/iommu/iommufd/hw_pagetable.c | 3 +++
>>>    3 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index e93d2e918599..4f2774c08262 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -209,8 +209,13 @@ struct iommu_domain_geometry {
>>>    #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>>>    #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
>>> +#define IOMMU_DOMAIN_DATA_OWNER_NONE (0U)
>>> +#define IOMMU_DOMAIN_DATA_OWNER_DMA (1U)
>>> +#define IOMMU_DOMAIN_DATA_OWNER_IOMMUFD (2U)
>>> +
>>>    struct iommu_domain {
>>> -	unsigned type;
>>> +	u32 type : 30;
>>> +	u32 private_data_owner : 2;
>> Is there any special consideration for reserving only 2 bits for the
>> private data owner? Is it possible to allocate more bits so that it
>> could be more extensible for the future?
> It could. This "2" is copied from Jason's suggestion:
> https://lore.kernel.org/linux-iommu/20250227194749.GJ39591@nvidia.com/
> 
>> For example, current iommu core allows a kernel device driver to
>> allocate a paging domain and replace the default domain for kernel DMA.
>> This suggests the private data owner bits may be needed beyond iommu-dma
>> and iommufd.
> What's the potential "private data" in this case?

I have no idea, just feeling that we could leave room for tomorrow.
