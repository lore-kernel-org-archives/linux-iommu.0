Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDD24BBFD
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429448; cv=none; b=XwpgeOuVfROLagzjiPOsfA4yJ8z/pv7m4s3M8pDZUBLmkQ2Q6gegHqhG+20Ihrn5ViUe2RNSSqt9SnvbD/oyphqTziZMGqwDNj0h4lJG63olLu5k7IXmMZcENKWH/lVrN6gNJkMcbjc8pWflYqOdlssYXg6tZoJxk0tYWSiQPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429448; c=relaxed/simple;
	bh=XmYMmZ36Bm+ldZfBHIbwjcaaq/9h9+v7Ro2i+3h/lzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl5+ib+8I+QBV60hM7Q5DdVc7Agt6ALpoveKAI9lWsRKeWEuJNdV0Ay3mghsBDGYUInnigP25glsT4rf+hTvR0KPlSKxqFKuN7lvVctPEcgsrFMLgcBhkyINByczp8ucIoGa0jSTZr9qmOXTRDem9O3zmjlTcUyQbuM3UKvQ2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtdOgWXT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtdOgWXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765429446; x=1796965446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XmYMmZ36Bm+ldZfBHIbwjcaaq/9h9+v7Ro2i+3h/lzs=;
  b=mtdOgWXTXCv9pi+uQM9pQxmJPo4UlKJkMDIppD6HrNvyOifbOleMX6pz
   Q8sgoE5DgCiaJmwgvItNPYG4Ipu9Yp/huOTtKK6DcaZgcuLIH4WbxnBlI
   aMRS13+QGI/1ZLUCN8ZXcBM2J38YKvlmFiPC2zADwTPt3ZfwMUFZOR0ss
   vu5AG73V5jP2h9pFr2JIYftIrEmp1ylTTiGCyT0Ba48fbDee6huLnPWUj
   UnyQ/EsEsD9aItjDRcCDxl59jUipbTdW7cANmH9r/9a6aGgVFI0hFM4as
   uLe4ewg/yKOKJLIjaoAghwNx6nh9+/yxcHDsCA4CKLKNVY7sicLKdmmDY
   Q==;
X-CSE-ConnectionGUID: V1G/AOg6TOCmGPEDx9zLpQ==
X-CSE-MsgGUID: eyFCrhhVTiyenO3FTqpjYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="85014225"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="85014225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 21:04:06 -0800
X-CSE-ConnectionGUID: Z9XB+gknRQe/OCFykEFMcw==
X-CSE-MsgGUID: iU0eGyecRAm0kVMK5zR/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="200867803"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 21:04:05 -0800
Message-ID: <bfdc356b-7670-4942-a359-9393090468f3@linux.intel.com>
Date: Thu, 11 Dec 2025 12:59:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible
 PCIe device without scalable mode
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, will@kernel.org
References: <98a2a099-0b90-4837-a20c-742c883e8eea@linux.intel.com>
 <20251211041741.2132-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251211041741.2132-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 12:17, Jinhui Guo wrote:
> On Thu, Dec 11, 2025 10:10:52AM +0800, Baolu Lu wrote:
>>> Since __context_flush_dev_iotlb() is only called on
>>> {attach,release}_dev paths (not hot), add pci_device_is_present()
>>> there to skip inaccessible devices and avoid the hard-lock.
>>>
>>> Fixes: 37764b952e1b ("iommu/vt-d: Global devTLB flush when present context entry changed")
>>> Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
>> Cc:stable@vger.kernel.org
>>
>>> Signed-off-by: Jinhui Guo<guojinhui.liam@bytedance.com>
>>> ---
>>>    drivers/iommu/intel/pasid.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>> index 3e2255057079..b1e8eb6a6504 100644
>>> --- a/drivers/iommu/intel/pasid.c
>>> +++ b/drivers/iommu/intel/pasid.c
>>> @@ -1099,9 +1099,20 @@ int intel_pasid_setup_sm_context(struct device *dev)
>>>     */
>>>    static void __context_flush_dev_iotlb(struct device_domain_info *info)
>>>    {
>>> +	struct pci_dev *pdev;
>>> +
>>>    	if (!info->ats_enabled)
>>>    		return;
>>>    
>>> +	/*
>>> +	 * Skip dev-IOTLB flush for inaccessible PCIe devices to prevent the
>>> +	 * Intel IOMMU from waiting indefinitely for an ATS invalidation that
>>> +	 * cannot complete.
>>> +	 */
>>> +	pdev = dev_is_pci(info->dev) ? to_pci_dev(info->dev) : NULL;
>>> +	if (pdev && !pci_device_is_present(pdev))
>>> +		return;
>> Could simply be
>>
>> 	if (dev_is_pci(info->dev) &&
>> 	    !pci_device_is_present(to_pci_dev(info->dev)))
>> 		return;
>>
>> ?
>>
>>> +
>>>    	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
>>>    			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
>>>    
>> Thanks,
>> baolu
> Hi, baolu
> 
> Thanks for your time and suggestions.
> 
> I’ve sent v2 (https://lore.kernel.org/all/20251211035946.2071-1- 
> guojinhui.liam@bytedance.com/)
> with the following changes:
> 
> 1. Simplified the pci_device_is_present() check in __context_flush_dev_iotlb().
> 2. Added Cc:stable@vger.kernel.org to both patches.

Thanks! I would suggest not updating the patch versions so frequently
next time. It is important to provide the reviewers with more time to
comment on your submissions. :-)

Thanks,
baolu
