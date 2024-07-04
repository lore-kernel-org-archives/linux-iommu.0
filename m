Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AD195395
	for <iommu@lists.linux.dev>; Thu,  4 Jul 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078360; cv=none; b=jrI22NqToyE3H4Q8reDb6OjOGK1fCKHzYUQRXLBZf9XBKq5oZnXWaN2SaBcBeJR20x7zqATEZ/brmzb4V4Dp3ZSFnceHNXgxF3FJJhfJi9RqRuN53Lv/0wr9Nzjlm4FUAo2xkCY90LMdco5hnoR0pPmuD6L/0zpUIyBDx27G+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078360; c=relaxed/simple;
	bh=8HlmpJMCXUdLQJpNWUAEVrqJS0MrfXPhDJstgMIWOsw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mz3jF5O02YqMgu5XCTilvIvAOSFpVFEyEQ3xpaRrkA7mA0uf7ALy27hRwa3kr6cJH4PTSdwKN5khCOKQy+YqdUseFVY0EcIXeaZEr9QEnNSi1hFy5yqNaNWgF3aNntoh6x/OaK8zdKSM2A7JV3nIygV2+KFU/buRH1yqBQ2zxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPhCciv8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPhCciv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720078359; x=1751614359;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8HlmpJMCXUdLQJpNWUAEVrqJS0MrfXPhDJstgMIWOsw=;
  b=BPhCciv8qsnY17RK1ZM9i06lnazFs/zd3s+eo/uItNMrcWIpC+RId3Pt
   JPQfKpECmT4nVUcL6v7koj/ScqLVqvi0Hs4MeK4X2vPpNE+D3+rsUz2C6
   tVkolUWCKtKVr+Rq4AwcpiESNJfYdeEe9tL5+++0fFNuNydSXei7kFMiG
   X9Kx0N1u59jDWpeI+D1RGD0nBwg9O92bhJ9sQC1zFQ+vUSrTauS1GZ1Fn
   ZDm69UDTf7X2VZfLrE9St5/bd+ebAn0LiwqenP8cWp4DGbdbeQsJd56on
   U5FYMdqRhdN4d0QGm/Xtjp6h55/lZiJi385lJGzCPhbkBHsLlo25NVKwc
   Q==;
X-CSE-ConnectionGUID: jg+2AcubQtum8jdz8ik8Hw==
X-CSE-MsgGUID: ygm8aF80RDqXJSL/k3ZODg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17476681"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17476681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:32:39 -0700
X-CSE-ConnectionGUID: hdEgb+MBQFOD37NcQY3N4w==
X-CSE-MsgGUID: H+fHHzmfRBq+AaDMDklizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47166851"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:32:35 -0700
Message-ID: <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
Date: Thu, 4 Jul 2024 15:32:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/4 14:37, Tian, Kevin wrote:
>> From: Nicolin Chen<nicolinc@nvidia.com>
>> Sent: Thursday, July 4, 2024 1:36 PM
>>
>> On Thu, Jul 04, 2024 at 10:59:45AM +0800, Baolu Lu wrote:
>>>> On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
>>>>
>>>> +enum iommu_fault_type {
>>>> +     IOMMU_FAULT_TYPE_HWPT_IOPF,
>>>> +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
>>>> +};
>>>>
>>>>    struct iommu_fault_alloc {
>>>>        __u32 size;
>>>>        __u32 flags;
>>>> +     __u32 type;  /* enum iommu_fault_type */
>>>>        __u32 out_fault_id;
>>>>        __u32 out_fault_fd;
> and need a new reserved field for alignment.
> 
>>>>    };
>>>>
>>>> I understand that this is already v8. So, maybe we can, for now,
>>>> apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF
>> type
>>>> check in the ioctl handler. And a decoupling for the iopf fops in
>>>> the ioctl handler can come later in the viommu series:
>>>>        switch (type) {
>>>>        case IOMMU_FAULT_TYPE_HWPT_IOPF:
>>>>                filep = anon_inode_getfile("[iommufd-pgfault]",
>>>>                                           &iommufd_fault_fops_iopf);
>>>>        case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
>>>>                filep = anon_inode_getfile("[iommufd-viommu-irq]",
>>>>                                           &iommufd_fault_fops_viommu);
>>>>        default:
>>>>                return -EOPNOSUPP;
>>>>        }
>>>>
>>>> Since you are the designer here, I think you have a better 10000
>>>> foot view -- maybe I am missing something here implying that the
>>>> fault object can't be really reused by viommu.
>>>>
>>>> Would you mind sharing some thoughts here?
>>> I think this is a choice between "two different objects" vs. "same
>>> object with different FD interfaces". If I understand it correctly, your
>>> proposal of unrecoverable fault delivery is not limited to vcmdq, but
>>> generic to all unrecoverable events that userspace should be aware of
>>> when the passed-through device is affected.
>> It's basically IRQ forwarding, not confined to unrecoverable
>> faults. For example, a VCMDQ used by the guest kernel would
>> raise an HW IRQ if the guest kernel issues an illegal command
>> to the HW Queue assigned to it. The host kernel will receive
>> the IRQ, so it needs a way to forward it to the VM for guest
>> kernel to recover the HW queue.
>>
>> The way that we define the structure can follow what we have
>> for hwpt_alloc/invalidate uAPIs, i.e. driver data/event. And
>> such an event can carry unrecoverable translation faults too.
>> SMMU at least reports DMA translation faults using an eventQ
>> in its own native language.
>>
>>>  From a hardware architecture perspective, the interfaces for
>>> unrecoverable events don't always match the page faults. For example,
>>> VT-d architecture defines a PR queue for page faults, but uses a
>>> register set to report unrecoverable events. The 'reason', 'request id'
>>> and 'pasid' fields of the register set indicate what happened on the
>>> hardware. New unrecoverable events will not be reported until the
>>> previous one has been fetched.
>> Understood. I don't think we can share the majority pieces in
>> the fault.c. Just the "IOMMU_FAULT_QUEUE_ALLOC" ioctl itself
>> looks way too general to be limited to page-fault usage only.
>> So, I feel we can share, for example:
>>      IOMMU_FAULT_QUEUE_ALLOC (type=hwpt_iopf) -> fault_id=1
>>      IOMMU_HWPT_ALLOC (fault_id=1) -> hwpt_id=2
>>      IOMMU_FAULT_QUEUE_ALLOC (type=viommu_irq) -> fault_id=3
>>      IOMMU_VIOMMU_ALLOC (fault_id=2) -> viommu_id=4
>> The handler will direct to different fops as I drafted in my
>> previous mail.
>>
>>> With the above being said, I have no strong opinions between these two
>>> choices. Jason and Kevin should have more insights.
>> Thanks. Jason is out of office this week, so hopefully Kevin
>> may shed some light. I personally feel that we don't need to
>> largely update this series until we add VIOMMU. Yet, it would
>> be convenient if we add a "type" in the uAPI with this series.
>>
> This is ok to me.

So

Nicolin, perhaps can you please cook an additional patch on top of this
series and post it for further review?

Thanks,
baolu
