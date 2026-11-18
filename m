Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976156;
	b=qXEjcD25pxKfHT5nL4tsT94J4Vb75qegekoYSBmXEMIKjsELD+2P404Jw/VYbygneWnv
	 rFg2iM1rImPGNsKrIfGHJRdajSIXPvuaNvcT5ACIDtX/WCVTKoxMlNRO8baXYsbzJB4cE
	 rHG2ihnkEMIyvzsxyhzf2T+m+zW5qdIpNTS1igEJhwk1rrr+vJDhQu3l/6+8a6s1QFESU
	 rCChCi6+gHtYwg0DbEsaR3qiW5nD6CLljSU0y6S2ufodIgwsiXaHe7ztTEfXFN+AaQJd/
	 ecqfPRq7kTdWkE/6O38GIOQmFj8eBAig8i+qLDymlrOkwN5t1NXGKXZynWCtBn9Gztw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=A02J3X3O1g4aC45xLZlyoNo28vIOlVQORrvvwYUfHIw=;
	b=SPKZtZYSYn0udcsa0cXQcyVmKS9cVmyosBWhqU/1lzXa4ZPuf26fbSB2oPimG9OnsoFj
	 BWsyDlB4SKcowdx9nvOwt0iGSNC5fnU2YPXjDPG2B4o+WOTnN/W14+4715dkt9uRU82Ul
	 jPMFNVYX6/118gqC6a0B/ezZZNRB86Ud0vcnLR2G/NbZEkhpVGcvq1zXmcH5dhQeMwP4s
	 6oNmLYQv7MIjNX97OFQluQPJHuBI1y/ePKz4fpkMdfxMsit9swSVdsyccJyU9p1GQtYEh
	 XVflyuCv2DipK8Wst2Q55f/ZhdIWQ7sBCcDxf6qRiUTWXewGTZmGM0YmRnTk8IucBwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TFRYZSuZ;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B8606A325
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F4B8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TFRYZSuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794976155; x=1826512155;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ciBMg2encgEkPWPqE1Lanzqyw71q/2dV81N6WR/JNBw=;
  b=TFRYZSuZCy3UMrovEVkkUuTXkK4O+4XGH6eJSR+hyHLecjrbWFU73WUy
   GVOWjqZ2bQOiIu9KC/Yb/PZkeXR48gbMEn3MpBhipMaJA8uLe9Cqnv7HY
   16Ud3QCJWV+284E+v6PI8nNaDPamX7E2GhdZ/ngx70vqePXKBdCZGWJU7
   zb5Pw+61VC0ZuJmQb8wQiglBGFSK7hS16EyNy7pIQocMOiLtRnsazi1Ov
   0+Z/S4zoSD7uxijtN3BPHH9y59GnLRrdXbdOqZz0WxyhwQNVwyFUfyLpo
   7nc+QJ4g1I/bzWNO6ffLa/GcUZWFi3DimS7ERnibUwxzvc6+zAHoHn2Z9
   A==;
X-CSE-ConnectionGUID: 4aKn7WBIS5OXZBdgA+mR2g==
X-CSE-MsgGUID: K9HWbJ4bRq2ha2/V5sG2VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3796858"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3796858"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 20:29:15 -0800
X-CSE-ConnectionGUID: l2p3QlFCRIm6kgYbCeMUAA==
X-CSE-MsgGUID: rHboymlPQPeAJl+b1hVu6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9937595"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 20:29:13 -0800
Message-ID: <f9b9ab9e-949a-421a-a6fd-1c01c12bacde@linux.intel.com>
Date: Wed, 18 Nov 2026 12:29:10 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry
 with fault_ignore
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
 <20261104051059.1345010-2-baolu.lu@linux.intel.com>
 <87o6c3uedj.fsf@intel.com>
 <7f86b03e-1c99-44ed-8d07-3502a21821fc@linux.intel.com>
 <CO1PR11MB48355713BC88BEA8794279E18C702@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB48355713BC88BEA8794279E18C702@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2026 1:58 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, November 9, 2026 3:35 PM
>>
>> On 11/6/2026 6:01 AM, Vinicius Costa Gomes wrote:
>>> Lu Baolu<baolu.lu@linux.intel.com> writes:
>>>
>>>>    static void
>>>>    pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>>>>    				    u16 did, u32 pasid)
>>>> @@ -253,7 +238,6 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu, struct device *dev,
>>>>
>>>>    	if (!pasid_pte_is_present(pte)) {
>>>>    		if (!pasid_pte_is_fault_disabled(pte)) {
>>>> -			WARN_ON(READ_ONCE(pte->val[0]) != 0);
>>>>    			spin_unlock(&iommu->lock);
>>>>    			return;
>>>>    		}
>>>> @@ -266,6 +250,8 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu, struct device *dev,
>>>>    		 */
>>>>    		pasid_clear_entry(pte);
>>>>    		spin_unlock(&iommu->lock);
>>>> +		if (!ecap_coherent(iommu->ecap))
>>>> +			clflush_cache_range(pte, sizeof(*pte));
>>>>    		intel_iommu_drain_pasid_prq(dev, pasid);
>>>>
>>> I think it's worth documenting in the commit message why both of these
>>> are needed, removing the warning and adding the flush.
>>
>> Yes. I will add the following to the commit message:
>>
>>    Also drop the WARN_ON() for a non-present entry without FPD. Since
>>    commit 75ed00055c05 a concurrent teardown can see such an entry before
>>    it is zeroed. Flush the cache after clearing an FPD-only entry, as
>>    other PASID entry updates do on non-coherent hardware.
>>
> 
> hmm is it a separate fix?

I have added "Fixes: 75ed00055c05" to this patch.

Thanks,
baolu
