Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBF42052
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934420; cv=none; b=Y3PLuIQKWCm9IdlujHawxNLYfO+ed2VHWsM2QxlMH8XC3BCktIXPco8X5nTYgy0ZWW9F3bD+G/gAFG8brV4cEBd0+wRiWwLFXOpF/Tutwox7qXfLxiq4kb9Uyd92TTRCFsdYh3V1zm2QmojOowFJwEDoZt05rm+p+lX39nC1Jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934420; c=relaxed/simple;
	bh=25zlymyI4qwckV9AjPiUYSWvw9kp0mp/jFTYtt1X9a0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VUTJwN1GECsMbM9h+bz0kEJS8zCSqUhomZlF5X7B6J1cZwHjbIiuvbmJCQ1bw3y0QUzHT8BhaPW+UcqB39FXkJvKrbnGKETqkhUWhaUk+SkqUz/R0RiLa7TxIQZs0zdwIgwtS/c+5vr2JCjJjPrTNIiHKEAn4T4v7hEaz7gsyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YM+u++pJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YM+u++pJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718934419; x=1750470419;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25zlymyI4qwckV9AjPiUYSWvw9kp0mp/jFTYtt1X9a0=;
  b=YM+u++pJbLo2WoeVn1w1BftFjy2y2iWoYQwF9+myo3dV5wL1mJXKQRyp
   1zHBquIzgJ3HOpvI313Zs+RRELaX0/C6cwiyaj6UkAVMAX37GjLJme4Nu
   duOVW2BZuc3BVh9Z1nSMEXwih6esaMieJBmoRVOB8m+IcR9mrv+JkpIre
   MpMDoAc7dcSDeUhMLxV+zD+TEpI+vVsLhoAfvjeEwF6hWvHsdDCnjJ3Pi
   DbAymfcF2r1KpkNe9sXsCopEyipX/gbSyDMG0aicbISw3Hri/G+tF7+Ri
   ZjE0gNURDN8VEHbPdcTusD8lUDMnOm12LeGAAA1gLyHDhojxgakKIvvBJ
   Q==;
X-CSE-ConnectionGUID: j68gDm7aRSeCKyzP2Kqyug==
X-CSE-MsgGUID: OW5S74XpQUmwN19FfapJXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16094082"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="16094082"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 18:46:59 -0700
X-CSE-ConnectionGUID: rR4hhHdZQt2vznYhFrwbnA==
X-CSE-MsgGUID: SfR8aNoPSXuhTw9ZihAZ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42297214"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 20 Jun 2024 18:46:56 -0700
Message-ID: <3d709185-2065-4cb8-9d69-a7a34edd249e@linux.intel.com>
Date: Fri, 21 Jun 2024 09:44:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
 <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
 <20240620140815.GO791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240620140815.GO791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/20/24 10:08 PM, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2024 at 04:19:46PM +0530, Vasant Hegde wrote:
>>>>>> seems that for all domain attaches above is coded in a wrong order
>>>>>> as ats is enabled after the cache tag is assigned.
>>>>> Yes, exactly. But simply changing the order isn't future-proof,
>>>>> considering ATS control will eventually be moved out of iommu drivers.
>>>> [Unrelated to this patch]
>>>>
>>>> You mean ATS setup will be moved to individual device driver? Is there any
>>>> reason for that?
>>> Not exactly to individual device drivers, but it should be out of the
>>> iommu drivers.
>>>
>>> https://lore.kernel.org/linux-iommu/BL1PR12MB51441FC4303BD0442EDB7A9CF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com/
>> Got it. Thanks.
>>
>> I remember of this discussion. May be we can provide API from IOMMU driver so
>> that individual driver can enable/disable ATS (like iommu_dev_enable_feature()).
> But I have a feeling if we do that it should be done by re-attaching
> the domain.
> 
> For instance if you look at how I structued SMMUv3, the ATSness is an
> effective property of the domain type and ATS switches on and off
> dynamically already.
> 
> Having an additional input to domain attach "inhibit ats", as a flag
> would be all the support the driver would need to provide for the core
> code to manage this with some kind of global policy.
> 
> I would suggest to steer VTD in that direction too and make the ATS
> enable be done on domain attach, and put the first ATS enable in
> attach, not in probe. The logic in smmuv3 would apply just as well to
> VTD, though you'd need the hitless update logic too 🙂

Enabling/Disabling ATS on domain attach seems like a feasible approach.
The ATS requirement information (required/disallowed/neutral) could be
included as an opt-in option in the domain attach path. This likely
applies to PASID attachments and VF/PF devices. The iommu driver
maintains the per-device ATS refcount and enables it for the first
request and disables it after the last one. The attachment fails
accordingly if the hardware capability doesn't match the domain attach
requirement.

Perhaps we could further include PRI as a domain attach option,
indicating that the domain requires IOPF functionality. This would allow
us to simplify the SVA and IOMMUFD by hiding device and IOMMU details
within the IOMMU driver.

Best regards,
baolu
