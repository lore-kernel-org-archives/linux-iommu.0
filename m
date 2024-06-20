Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B13C30
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853374; cv=none; b=i7mCf3oZM1XK+8uptl1//BusxV9Z6++B0FhaMYp2ZEfzM5Es9k1tcdJOiSxEoQcLaY2XhVee/m0LtAS0Afe5Z7LbJmPRU+haeOP+egFLPuQwMDx1yplXlHPFaVb31sYyeq0LARf1SXM4e1+vDlsPjctj8EWGRI/TlaEIChX7b3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853374; c=relaxed/simple;
	bh=37dKo2Af1BFKpky4SJWPWucDlZBzlwHRHAd48WNecaQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EXc6KcMdQ0W5dygNOKebN+lV7vxpLWE8VZ4BNbkBTamcBTjoM8g0q2JZ4rJTTc8iB/7P1vqSW9sKSLmv84oAy35bFifU4I2W4zp4z7Mwi164Fn1VqmPkzxOkRoABE1bznIMZDCW3yR1F0rBKxhlM0irC6Wxj54rm0Oc5d+yY5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5fkKpfS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5fkKpfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718853373; x=1750389373;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=37dKo2Af1BFKpky4SJWPWucDlZBzlwHRHAd48WNecaQ=;
  b=a5fkKpfSzK6kIAy44O6NgYAtIeJMLl0GZRNUHV0ajQSkOokNCPcMay3c
   b567z0DPzgqRo9Bn98glC0b4eFgDZP+kRjqkXORur+I768NBe5qus/6SP
   MNUvMoNF1xuL7YK5iBiHz6bNms9K3diCJ2G0oBFxw7eIXMgumEjkECiR2
   BeKL17d8spECc0cOtw2le2ALCiAJ6OkxhYmoYrxivy9yDFNuFYNtFcC/g
   5kAmfwpBTOOvkhgML2ybA65bgIAhSh+o0ErWXVv4vjxIo0A0errL1byH1
   D2qUab4h6IJTja6vfhKz7A4zlMtRpRCh3srFfu5vSaSHye5jGdOYU5PlG
   g==;
X-CSE-ConnectionGUID: oGZrNN+OQc+b/QnHUTg23w==
X-CSE-MsgGUID: xzJVfGabRTGfQkf54VQJpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="19688676"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="19688676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:16:13 -0700
X-CSE-ConnectionGUID: 5y1vQj6fQ7KupJQOQCD/Tw==
X-CSE-MsgGUID: H5Di2M34T12325fXgBrwfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="47047731"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 19 Jun 2024 20:16:11 -0700
Message-ID: <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
Date: Thu, 20 Jun 2024 11:13:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/24 11:04 AM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Thursday, June 20, 2024 8:50 AM
>>
>> On 6/20/24 12:46 AM, Jason Gunthorpe wrote:
>>> On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
>>>> When a domain is attached to a device, the required cache tags are
>>>> assigned to the domain so that the related caches could be flushed
>>>> whenever it is needed. The device TLB cache tag is created selectively
>>>> by checking the ats_enabled field of the device's iommu data. This
>>>> creates an ordered dependency between attach and ATS enabling paths.
>>>>
>>>> The device TLB cache tag will not be created if device's ATS is enabled
>>>> after the domain attachment. This causes some devices, for example
>>>> intel_vpu, to malfunction.
>>> What? How is this even possible?
>>>
>>> ATS is controlled exclusively by the iommu driver, how can it be
>>> changed without the driver knowing??
>> Yes. ATS is currently controlled exclusively by the iommu driver. The
>> intel iommu driver enables PCI/ATS on the probe path after the default
>> domain is attached. That means when the default domain is attached to
>> the device, the ats_supported is set, but ats_enabled is cleared. So the
>> cache tag for the device TLB won't be created.
> I don't quite get why this is specific to the probe path and the default
> domain.

The issue is with the domain attaching device path, not specific to the
probe or default domain.

> 
> dmar_domain_attach_device()
> {
> 	cache_tag_assign_domain();
> 	//setup pasid entry for pt/1st/2nd
> 	iommu_enable_pci_caps();
> }
> 
> seems that for all domain attaches above is coded in a wrong order
> as ats is enabled after the cache tag is assigned.

Yes, exactly. But simply changing the order isn't future-proof,
considering ATS control will eventually be moved out of iommu drivers.

> why is it considered
> to affect only some devices e.g. intel_vpu?

This bug was discovered during testing of the intel_vpu device and
affects devices other than the intel_vpu. The commit message is a bit
confusing. :-)

Best regards,
baolu
