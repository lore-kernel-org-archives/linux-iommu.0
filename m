Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380822AD17
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726292991; cv=none; b=glS6OP0ZwP99Y9C3S1muYqzLYGW7oz2+Z+iFElnLrKzW48GT45GeDVvsrzOXAGG+k6oXNBJKKOT2pV3PVFIFPoOLs7RWvBufCC8Vmxnw0HxsHwqvqoXzRpi78VO+CdnmLBkvBEJxbbux6HdWnpItauXnJI+7v7jK+ZklW3eZAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726292991; c=relaxed/simple;
	bh=aKFWUQ404h4zm3qUo72pHpV2BdBq+aBjiSEvde1qQgQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KbU1ohPK0BaEuImc/lK+QY+RCukOn5hh0PLEhtaTmpYjaLdR0ctJxCSOID+8lu8OMBUGAOg1mq62RGDJMzm9qleyfwzuybd+0YVq/5WoEBCK8qlcROrfrWlkof27WKzxrHCQijAIfY3LnXfILdJxgDuhe2nBovPrAS/f0n12EMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahyj0j+7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahyj0j+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726292990; x=1757828990;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aKFWUQ404h4zm3qUo72pHpV2BdBq+aBjiSEvde1qQgQ=;
  b=ahyj0j+7H+L1GHFIu+02yRmpDuO2bMN8q5XdwWMDZ48K1+fyGKljWeNO
   HOQrLiJ77LWNvd55wIFnczLDJPQlhDgJNjPbs2PLafX2Xlx3F1s103PTl
   hc7QnCe2jI/KBA45FVSu5PXT1GDBUoA3V20cyV87PPhSzoEJPzTXKTee5
   ZRUW8yJrDAmmET31m8uzQsOl7cIPHWXtDY0TBbNfXYvNwjKbqT7LueMzx
   TbnPlcUjbJ3GxOFocu34P3O5jmDqUgypJYt4/rJwsUSfA6b9WkyukS7vA
   bI20a38KdtMCr/tAYJvvSQfvHocsOgMQXfxnWnDAxwb8X+s6HwNQJkIT1
   A==;
X-CSE-ConnectionGUID: eKU40+JnT9ugLW92Q4AH2Q==
X-CSE-MsgGUID: RfJopdpRTZi5jbzynb4lDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42678200"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="42678200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 22:49:49 -0700
X-CSE-ConnectionGUID: z4VUWwPCRu+A4afkSfh01Q==
X-CSE-MsgGUID: WoIvm360SSyqmoBCE3/E5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="72434791"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 22:49:47 -0700
Message-ID: <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
Date: Sat, 14 Sep 2024 13:49:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/14 10:53, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Saturday, September 14, 2024 9:18 AM
>>
>> On 9/14/24 8:52 AM, Tian, Kevin wrote:
>>>> From: Joel Granados via B4 Relay
>>>> <devnull+j.granados.samsung.com@kernel.org>
>>>>
>>>> From: Joel Granados<j.granados@samsung.com>
>>>>
>>>> IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
>>>> Move
>>>> all Page Request Queue (PRQ) functions that handle prq events to a new
>>>> file in drivers/iommu/intel/prq.c. The page_req_des struct is now
>>>> declared in drivers/iommu/intel/prq.c.
>>>>
>>>> No functional changes are intended. This is a preparation patch to
>>>> enable the use of IO page faults outside the SVM/PASID use cases.
>>> Do we want to guard it under a new config option e.g.
>>> CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
>>> for the majority usages which don't require IOPF.
>>>
>>> Baolu?
>> The OS builder doesn't know if Linux will run on a platform with PRI-
>> capable devices. They'll probably always enable this option if we
>> provide it.
> hmm then why do we need a SVM option? In reality I haven't seen
> a platform which supports IOPF but no pasid/SVM. so the reason
> for whether to have an option should be same between IOPF/SVM.
> 
> IMHO the point of options is to allow reducing footprint of the kernel
> image and many options are probably always enabled in distributions...

To be honest, I would hope to remove the SVM option some day. It's
nothing special except listening to an external notification and
synchronize the caches when the page table is updated. It's common to
all cases where a page table is shared between the IOMMU and another
component.

As for CONFIG_INTEL_IOMMU_IOPF, my suggestion is that we don't need to
add any unnecessary options unless we see a real need.

Thanks,
baolu
