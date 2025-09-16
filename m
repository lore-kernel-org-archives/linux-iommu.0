Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659618E1F
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988068; cv=none; b=nWfAgKHr/gYqLdOuRI1aa8dO4Bw2t0pe2eMohU4nnbXj7lfpdOb93OmAveK8/HUR3/7buanpAgIzowAgaWMLePROvE6WRR3jKJDPkIGYjh7jb2sKmqxM4ZSbdF8pq3BmoB0VegSVTB7xXMru9Z7DVIDAqv8GYUX+TXzGRmEQ8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988068; c=relaxed/simple;
	bh=N3ekorPE4U8jUsbUsyW48hGrILNymwESEO1sxT6bGF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5ML/DIpikkfhz/Vi46qyWvjmUJ9MDSxvzil+ohhzvpMmTAI2ZSLzR8YxwpbnIYaFr87S52JB7evUzAwmgH3uHO2f8GzGxU1uz4fdvCMMajwD49tyY5O59Te08AmWe+ib167jlaT/erOroKkjFE3eROPwD3mmH3lDAh/8dH8WWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpx003Rb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpx003Rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757988066; x=1789524066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3ekorPE4U8jUsbUsyW48hGrILNymwESEO1sxT6bGF0=;
  b=dpx003Rb8m4Gbbs9I4INSRsHSng9NTzcOIDgpnD4rHTTvzxmbOD9Sdxy
   AbfQoVH1H7Zntng3c1Mif97nuISXIPuQLyI9/2PVvEH1vyJhJg6olp4I6
   eLbkRtkxYSGSiDpr3FRtY3cuA2IsR/qohX9WqzOlYmSJ5yDoDLT3VPq3F
   rmFGKwrs4x2aBBhwkymzz43ZDiUWSyjiUv4iT58iKP9KPWqYiOw28DHx5
   0NIMa6qY+wh52dR3e3b4RftdtslDzKedCiJSPQy+3jQmlVNmKF1pFIm2+
   T7lOZP9pUYmo9evN9FXIPjLEnwranGoFYrKlob3Lt88f6poS/Oogs7zGA
   g==;
X-CSE-ConnectionGUID: Y5mEb4FoSsyLIhztA0jgmQ==
X-CSE-MsgGUID: xmPSl9SNSTatdfbG+Cc3gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71356685"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="71356685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 19:01:06 -0700
X-CSE-ConnectionGUID: 4QPu+EFKT9iaiNk3xa2aSw==
X-CSE-MsgGUID: pN/9pcT3TAerhiX0mOH7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="174619852"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 19:01:03 -0700
Message-ID: <3d633e85-04fd-4077-9bf8-92fb487f89fb@linux.intel.com>
Date: Tue, 16 Sep 2025 09:58:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: PRS isn't usable if PDS isn't supported
To: Joel Granados <joel.granados@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250915062946.120196-1-baolu.lu@linux.intel.com>
 <zkgvbw42g25a47nyydehxismaup6eh4kygqbdw7fk54kxze7j3@lrczardwx2ma>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <zkgvbw42g25a47nyydehxismaup6eh4kygqbdw7fk54kxze7j3@lrczardwx2ma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 19:30, Joel Granados wrote:
> On Mon, Sep 15, 2025 at 02:29:46PM +0800, Lu Baolu wrote:
>> The specification, Section 7.10, "Software Steps to Drain Page Requests &
>> Responses," requires software to submit an Invalidation Wait Descriptor
>> (inv_wait_dsc) with the Page-request Drain (PD=1) flag set, along with
>> the Invalidation Wait Completion Status Write flag (SW=1). It then waits
>> for the Invalidation Wait Descriptor's completion.
>>
>> However, the PD field in the Invalidation Wait Descriptor is optional, as
>> stated in Section 6.5.2.9, "Invalidation Wait Descriptor":
>>
>> "Page-request Drain (PD): Remapping hardware implementations reporting
>>   Page-request draining as not supported (PDS = 0 in ECAP_REG) treat this
>>   field as reserved."
>>
>> This implies that if the IOMMU doesn't support the PDS capability, software
>> can't drain page requests and group responses as expected.
>>
>> Do not enable PCI/PRI if the IOMMU doesn't support PDS.
> 
> After giving the spec another look, this is probably the way to go.
> However the PDS also mentions that DT must be set. Should we check
> ecap_dev_iotlb_support(iommu->ecap)  as well?

It has already been checked.

>>
>> Reported-by: Joel Granados <joel.granados@kernel.org>
>> Closes: https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org
>> Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 9c3ab9d9f69a..92759a8f8330 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3812,7 +3812,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>   			}
>>   
>>   			if (info->ats_supported && ecap_prs(iommu->ecap) &&
>> -			    pci_pri_supported(pdev))
>> +			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
> Should this be
>   +			    ecap_dev_iotlb_support(iommu->ecap) && ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
> 
> ???

ecap_dev_iotlb_support() has already been checked as it's part of the
info->ats_supported check. The dependency chain is:
ecap_dev_iotlb_support() -> ats_support -> pri_support.

Thanks,
baolu
