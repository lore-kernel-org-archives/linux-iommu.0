Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAF14D432
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907439; cv=none; b=oZHrxZstuDIj5aeRVzAz2paPneN7ZVmbFBye1kUJsFPi4z+Vxujz/R9+yQ6a5hsqkjgULC4vANIs+OxMl1ILA3aQ7+hBPIMDHHks8Fu9roP+5JoU9Dl69k53XQUpwUNu3Rob1bcu4+IIbElvmB3oWCBdKy5XPXlioTQcbr8leBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907439; c=relaxed/simple;
	bh=BLATCcZunJMuWQskmbq05AkOa771ckVFro+aPNDMnzk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gr/eygL9e4KMkrQa4v57GUeRa/MaC3gszfmmzYYK9758UDFDj81K7oCLtv/j9dzLfqUPyQBSZ4CZmzWtRZjCsWEp+d3Neyt12ybssrqRkfvbdbpS4kqxBiWoI5/LQAhLehQcI8Ey+9R/lfVvAdDL7Rx8+XnU4dasmiIfgDOalR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPYootUi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPYootUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719907437; x=1751443437;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BLATCcZunJMuWQskmbq05AkOa771ckVFro+aPNDMnzk=;
  b=HPYootUilc+WlH0c6Q6iWhPvX5t1v4RDgT1HyMmzHc8tP+8I1uGop4DW
   sInm4oLDxhdAZMm7Q0/3gc7FAOFAvfuUbfwBHOtJtEiOEsx8L9nCyVnZc
   yBsMu9BNd8jZtJsvqCAdUfZbMrcCaHm/Wi/Gl4NulKFf7cg2ITZyRvHml
   MOgAKie+gruqczDuJfDknmN1JMadZ7UwaMo2lkVnYRLM15FfGf8kf0xSX
   gqa1C3vVOGTruJ2zKQcYfC9ImpxsW5+MSLijgekh65z3yonSCa4ne/eue
   l22h1gCU67q0q+QGZDXBO/vygZ0+d5M355nuovL60hIVpqGdawwQPnCRT
   g==;
X-CSE-ConnectionGUID: jjUQrFDyTsaxTGZmTvBK9A==
X-CSE-MsgGUID: kUhM0yipS1Gzh+cgURstPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17198555"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17198555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 01:03:33 -0700
X-CSE-ConnectionGUID: wI+JXXO9R9isoazwCCiJGQ==
X-CSE-MsgGUID: rvX362nuSZKr4OFyfkRl6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45888762"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 01:03:30 -0700
Message-ID: <ccdd9e99-2734-4826-828c-4816dba883a0@linux.intel.com>
Date: Tue, 2 Jul 2024 16:03:28 +0800
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
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <14a7db3a-663a-4e3f-b29c-a733e98efc32@linux.intel.com>
 <5a8802e3-feda-49bf-b11b-2ba6c236305e@linux.intel.com>
 <1c9204d9-d9da-4785-b375-368b5ba9ec78@linux.intel.com>
 <d74b2f95-2105-4e25-8c86-b5d5204798f6@intel.com>
 <BN9PR11MB52763B19F02E0481FB3B7EFD8CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763B19F02E0481FB3B7EFD8CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/2 14:39, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, July 2, 2024 2:25 PM
>>
>> On 2024/7/2 12:51, Baolu Lu wrote:
>>> On 2024/7/2 10:43, Baolu Lu wrote:
>>>> On 7/2/24 9:47 AM, Baolu Lu wrote:
>>>>> On 7/2/24 9:11 AM, Tian, Kevin wrote:
>>>>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>>>>> Sent: Monday, July 1, 2024 7:23 PM
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * For scalable mode:
>>>>>>> +     * - Domain-selective PASID-cache invalidation to affected domains
>>>>>>> +     * - Domain-selective IOTLB invalidation to affected domains
>>>>>>> +     * - Global Device-TLB invalidation to affected functions
>>>>>>> +     */
>>>>>>> +    if (flush_domains) {
>>>>>>> +        /*
>>>>>>> +         * If the IOMMU is running in scalable mode and there might
>>>>>>> +         * be potential PASID translations, the caller should hold
>>>>>>> +         * the lock to ensure that context changes and cache flushes
>>>>>>> +         * are atomic.
>>>>>>> +         */
>>>>>>> +        assert_spin_locked(&iommu->lock);
>>>>>>> +        for (i = 0; i < info->pasid_table->max_pasid; i++) {
>>>>>>> +            pte = intel_pasid_get_entry(info->dev, i);
>>>>>>> +            if (!pte || !pasid_pte_is_present(pte))
>>>>>>> +                continue;
>>>>>>> +
>>>>>>> +            did = pasid_get_domain_id(pte);
>>>>>>> +            qi_flush_pasid_cache(iommu, did,
>>>>>>> QI_PC_ALL_PASIDS, 0);
>>>>>>> +            iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>>>>> DMA_TLB_DSI_FLUSH);
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    __context_flush_dev_iotlb(info);
>>>>>>> +}
>>>>>> this only invalidates devtlb w/o PASID. We miss a pasid devtlb
>>>>>> invalidation
>>>>>> with global bit set.
>>>>>
>>>>> I am not sure about this. The spec says "Global Device-TLB invalidation
>>>>> to affected functions", I am not sure whether this implies any PASID-
>>>>> based-Device-TLB invalidation.
>>>>
>>>> I just revisited the spec, Device-TLB invalidation only covers caches
>>>> for requests-without-PASID. If pasid translation is affected while
>>>> updating the context entry, we should also take care of the caches for
>>>> requests-with-pasid.
>>>>
>>
>> hmmm. "Table 25. Guidance to Software for Invalidations" only mentions
>> global devTLB invalidation. 10.3.8 PASID and Global Invalidate of PCIe 6.2
>> spec has below definition.
>>
>> For Invalidation Requests that do not have a PASID, the ATC shall:
>> • Invalidate ATC entries within the indicate memory range that were
>> requested without a PASID value.
>> • Invalidate ATC entries at all addresses that were requested with any
>> PASID value.
>>
>> AFAIK. A devTLB invalidate descriptor submitted to VT-d should be converted
>> to be a PCIe ATC invalidation request without PASID prefix. So it may be
>> subjected to the above definition. If so, no need to have a PASID-based
>> devTLB invalidation descriptor.
>>
> 
> You are correct. The wording in VT-d spec is a bit confusing on saying
> that devtlb invalidation descriptor is only for request w/o PASID. 😉

Okay, so I will remove the line of pasid-based-dev-iotlb invalidation.

Thank you Yi, for the clarification.

Best regards,
baolu
