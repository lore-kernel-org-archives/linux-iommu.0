Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76D322B99
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044665; cv=none; b=fthcgWpL4K1egUWnQYNL0dzCliNZhfCb6AF8zIUdTlnkR8sstvcBi3U0i7+7RhadzTAOqSc481VNTa4cvBlN27ZUdpFRAuOqHyIaHvlS2i2gJ45iNDjVGBj9nXvOGao9gjH51co2l7+s2dlZoNMvHDc3DUJIqaOIAnXJ9EeF6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044665; c=relaxed/simple;
	bh=X/ZqB3F3uxrlq5fnYhJF9YmflnuXgYbIuIyXLKPZrBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/7aaaZLi4gg/EbvuPtlmNkPDMn+9l0khc0Z9TsHx+RLQCd6+lD6UOfqPPb6+vNjthYuUXQa7HEX+RftWKVlgeuY22YKsbR7t8fN9fdsmTXJBVT9lHlNOlouplAGLKWvTZJYSqpeyyFGF94Gz4I61LDH4KpkkZQiJKed2gZoxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMCsRNsR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMCsRNsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769044662; x=1800580662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X/ZqB3F3uxrlq5fnYhJF9YmflnuXgYbIuIyXLKPZrBg=;
  b=lMCsRNsRnPVxSJ50mPPx5eeZck77cy/yJ8lJFDL5mpH51H504w/W9DcW
   1ZZ8mQbFfC0NT6mdkVqHF8HQHlpte0BqdM5OOUluB/uxYsqQxs/4eCXxQ
   uDn+sxK1FfKEd0MotZ3eAkL02QkIihrlSWFhgWo8x1t7jQhkuGPMtRu0m
   ELd/c9djPfSASLf3T3NISUPry3YgmsvQ4vUrnwRJ/Ev8I0UjhKYxr/SCM
   zLYcUuT0hzVY2GEqJJk2xx1VcH7iZdybTNSRhxasqw6YLQN2Va/WsC4Lc
   cp8ExnnjdmckWE7ATtPmEinej+axStySTG8/68Pg95xOr7XlPxxDSc3iy
   Q==;
X-CSE-ConnectionGUID: 5a2xHfG5R4mgRghXGqVOlg==
X-CSE-MsgGUID: DiiuCExeQeyungg7S7PDgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69480625"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="69480625"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:17:38 -0800
X-CSE-ConnectionGUID: TRMk+zZkTl2jUQY/JKcenQ==
X-CSE-MsgGUID: dNgfp8zFQiqosj5IRWLZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211449798"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:17:34 -0800
Message-ID: <fa3e55e1-3cf4-4b73-8b5e-192a19a18f3b@linux.intel.com>
Date: Thu, 22 Jan 2026 09:17:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
 "miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-cxl@vger.kernel.org
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com> <20260121130315.GE1134360@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260121130315.GE1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 21:03, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
>> On Wed, 21 Jan 2026 08:01:36 +0000
>> "Tian, Kevin"<kevin.tian@intel.com> wrote:
>>
>>> +Dan. I recalled an offline discussion in which he raised concern on
>>> having the kernel blindly enable ATS for cxl.cache device instead of
>>> creating a knob for admin to configure from userspace (in case
>>> security is viewed more important than functionality, upon allowing
>>> DMA to read data out of CPU caches)...
>>>
>> +CC Linux-cxl
> A cxl.cache device supporting ATS will automatically enable ATS today
> if the kernel option to enable translation is set.
> 
> Even if the device is marked untrusted by the PCI layer (eg an
> external port).

I don't follow here. The untrusted check is now in pci_ats_supported():

/**
  * pci_ats_supported - check if the device can use ATS
  * @dev: the PCI device
  *
  * Returns true if the device supports ATS and is allowed to use it, false
  * otherwise.
  */
bool pci_ats_supported(struct pci_dev *dev)
{
         if (!dev->ats_cap)
                 return false;

         return (dev->untrusted == 0);
}
EXPORT_SYMBOL_GPL(pci_ats_supported);

The iommu drivers (intel/amd/arm-smmuv3) all call pci_ats_supported()
before enabling ATS on a device. Anything I missed?

> 
> Yes this is effectively a security issue, but it is not really a CXL
> specific problem.
> 
> We might perfer to not enable ATS for untrusted devices and then fail to
> load drivers for "ats always on" cases.
> 
> Or maybe we can enable one of the ATS security features someday,
> though I wonder if those work for CXL..

Thanks,
baolu
