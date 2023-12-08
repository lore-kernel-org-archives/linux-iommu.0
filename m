Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8D5662
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0lNu5y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702039563; x=1733575563;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bu4e0kS+eTFh8LO/rxI+3py26OcsItsVKKRs07FwizA=;
  b=L0lNu5y/ORfws7waVHN1LBC1pWYUmjnDtWwMmbzELMAsVS+Hvv4FlSCw
   2ZtVdFhj4Zd3JqoNgj0yXxv0vgDyiuvHWdvZ8nmMLGPqqiS/CdCHw7G9k
   al7d/3S8Nt7o6raokGjR4VXKeHRoGG41PgtRI0oVChC4fWyJlQLZ9pB73
   0HPNJxP12aGf0p5+1tGvGpeRvDGaEcAJ8R30wNV/YGTMIQ8A6iJ4Ertmg
   hUJ3Lai3xMwdwnuU9nLi+Ge4ooXq7P2QT362YnAO7Swjjrq0rKdq5wHBi
   fdvPeu/a5q5xSKD/ngq63B03z9cO4XxCCZGWKAq0Abr0HjRhZMvZ7rsyU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460877115"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="460877115"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 04:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="801107227"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="801107227"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.238]) ([10.255.31.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 04:46:00 -0800
Message-ID: <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
Date: Fri, 8 Dec 2023 20:45:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/8 17:09, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, December 5, 2023 9:22 AM
>>
>> Older VT-d hardware implementations did not support pass-through
>> translation mode. The iommu driver relied on a DMA domain with all
>> physical memory addresses identically mapped to the same IOVA to
>> simulate pass-through translation.
>>
>> This workaround is no longer necessary due to the evolution of iommu
>> core. The core has introduced def_domain_type op, allowing the iommu
>> driver to specify its capabilities. Additionally, the identity domain
>> has become a static system domain with "never fail" attach semantics.
> 
> I'm not sure above explains the reason for removing the identity support
> on older hardware. Looks the reason is simply that continuing to maintain
> that debt prevents intel-iommu driver from catching up  with iommu core
> evolution so we decide to remove it.

It is not that simple. I should put more words here.

Generally speaking, hardware lacking passthrough translation support,
but the iommu driver fakes it by using a DMA domain with 1:1 mappings,
makes no sense because it doesn't mitigate any hardware overheads.

If the device driver uses the kernel DMA API to do DMA, it does not need
to care about the DMA translation type. This is a user-decided policy.
The iommu subsystem has already provided this support to users through
kernel build options, kernel boot commands, and sysfs nodes.

If the device driver doesn't use kernel API for DMA. While we discourage
this behavior, the iommu subsystem provides the DMA ownership mechanism.
This allows the driver to take over the DMA ownership, allocate and
manage its own domain, and replace it with the default domain, as the
iommu default domain is only designed for kernel DMA with the DMA API.

In summary, whether or not to use a DMA domain with 1:1 mappings should
be a design decision made in the device driver, not a common behavior
for a modern iommu driver.

> 
>>
>> Eliminate support for the 1:1 mapping domain on older hardware and
>> removes the unused code that created the 1:1 page table. This paves a
>> way for the implementation of a global static identity domain.
> 
> Do you know how old such hardware is?

I am not sure, but I have a desktop that is over 10 years old and
supports passthrough translation. :-)

> 
>> @@ -2311,6 +2257,13 @@ static int device_def_domain_type(struct device
>> *dev)
>>   			return IOMMU_DOMAIN_IDENTITY;
>>   	}
>>
>> +	/*
>> +	 * Hardware does not support the passthrough translation mode.
>> +	 * Always use a dynamaic mapping domain.
>> +	 */
>> +	if (!ecap_pass_through(iommu->ecap))
>> +		return IOMMU_DOMAIN_DMA;
>> +
>>   	return 0;
> 
> there are two cases above which mandates IDENTITY. Have you confirmed
> that those platforms support hardware passthrough? otherwise this change
> is broken.

Those two cases should be hardware quirks for SoC-integrated devices. It
makes no reason that a quirk requires IOMMU passthrough translation, but
the hardware doesn't support it.

If, unfortunately, those quirks turn out to be workarounds for a poorly
designed device driver, we should remove those quirks and request the
device driver to utilize the DMA ownership framework to achieve the same
functionality within the driver itself.

Best regards,
baolu

