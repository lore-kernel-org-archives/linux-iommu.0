Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0011A28C
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425967; cv=none; b=Zgq+s/bP4SkdvPltTdo0IzV/COc8GICrCjYdCvjOcqLDkxZirVyX6HxkbktB0qrpbNEgd+El5IhYneu6u/G6ueu0C4r6/wfII79PpO5+3s9Cx2+/Fu/a5gG3nbxn+kiRw8E6eKeDpNCevOWb3SNhUsFuTiOFPeY5E1yGhBLO/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425967; c=relaxed/simple;
	bh=MR5coTTBS81+55XGLMbJDMP4Kkx+HEO23KDK9m6tUwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIvl0dIrVS/ipTmFK4rGYcjeKXl/D/LSFUZWC/eDv+81MPs7l8aWZfWR5MZZmvAlsfR4bs/5SEhTz7+4v9Ih03ZnKuyF/wrs6qtpFBdlE0vdhUbPWE5mkYvxmyOVnxCaMgUP0UqGDyeVSDxaqhgsjvfBYlWq80JaCcplLatzXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuFkmTSX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuFkmTSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730425961; x=1761961961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MR5coTTBS81+55XGLMbJDMP4Kkx+HEO23KDK9m6tUwk=;
  b=PuFkmTSXeV6jfH0eqhB8/NXgxMuwk3Yi+aJlU9hzkRbuQGs00cyfS3NA
   J66J875m6SOfTqd4AzHes86cLtzhhRzbtzn+g1FeHvC93dFRfaBQqUzEz
   HvlsHfZrQeCV05q/nSaZMPnYSHG6fpUr2QzCtJR+0fvMS3Zf2HNS/EB1e
   Zx5WGN362BYjM9UxGF110XAcLro2tlefh51Gd82KdYvkqtmi5DRi/UzkV
   kr5xgFJ/r3qdhEPJy2rOMJ6WQZz7RGb0Np+ilpuZ88ih0gcllZaCowOEx
   emF4QRuLjYSctUzvS9HuL2BD5kdnX0efaGbV7w90xOn6dZAdD/zeBIwN9
   w==;
X-CSE-ConnectionGUID: whcfwSRtRAqhCx32CY8SVA==
X-CSE-MsgGUID: Hv107O6sSfe9bNYLBuurOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="40767988"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="40767988"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 18:52:40 -0700
X-CSE-ConnectionGUID: v+wwihtsSRSYIOlC8lz/+Q==
X-CSE-MsgGUID: 75S53kfgT4mWvJ2NwHMH/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="113605723"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 18:52:38 -0700
Message-ID: <b9867c71-921a-4c31-9433-31e7efe4cb35@linux.intel.com>
Date: Fri, 1 Nov 2024 09:51:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Drain PRQs when domain removed from RID
To: Joel Granados <joel.granados@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, linux-kernel@vger.kernel.org
References: <20241031095139.44220-1-baolu.lu@linux.intel.com>
 <oaho6355qyb7mjs7taturs6dkvtqhv2xlhoc6wgike7uodjbia@k5k6qltfhigi>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <oaho6355qyb7mjs7taturs6dkvtqhv2xlhoc6wgike7uodjbia@k5k6qltfhigi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/24 22:56, Joel Granados wrote:
> On Thu, Oct 31, 2024 at 05:51:39PM +0800, Lu Baolu wrote:
>> As this iommu driver now supports page faults for requests without
>> PASID, page requests should be drained when a domain is removed from
>> the RID2PASID entry.
>>
>> This results in the intel_iommu_drain_pasid_prq() call being moved to
>> intel_pasid_tear_down_entry(). This indicates that when a translation
>> is removed from any PASID entry and the PRI has been enabled on the
>> device, page requests are flushed in the domain detachment path.
>>
>> The intel_iommu_drain_pasid_prq() helper has been modified to support
>> sending device TLB invalidation requests for both PASID and non-PASID
>> cases.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c |  1 -
>>   drivers/iommu/intel/pasid.c |  1 +
>>   drivers/iommu/intel/prq.c   | 22 +++++++---------------
>>   3 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 87a3563dfe54..3878f35be09d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4069,7 +4069,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>>   	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>   	kfree(dev_pasid);
>>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>> -	intel_iommu_drain_pasid_prq(dev, pasid);
>>   }
>>   
>>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 7e76062a7ad2..31665fb62e1c 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>>   		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>>   
>>   	devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> +	intel_iommu_drain_pasid_prq(dev, pasid);
>>   }
>>   
>>   /*
>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>> index 3c50c848893f..ae7f6f34462f 100644
>> --- a/drivers/iommu/intel/prq.c
>> +++ b/drivers/iommu/intel/prq.c
>> @@ -66,12 +66,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>>   	struct pci_dev *pdev;
>>   	int head, tail;
>>   	u16 sid, did;
>> -	int qdep;
>>   
>>   	info = dev_iommu_priv_get(dev);
>> -	if (WARN_ON(!info || !dev_is_pci(dev)))
> You do this on purpose because
> 1. It is not possible to go through this path without an iommu set in
>     the device
> 2. PRI within the intel driver is only relevant for PCI
> 3. There will always be a struct device_domain_info related to the
>     device iommu when doing PRI.
> right?

Yes.

--
baolu
