Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4A20DF4
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726115162; cv=none; b=KQg7EfIXw8QwyyOos4X2IB5pt87sPXQpp4ow6vYDSNysJMZKkt9lyRlMmHDyf369CE0jPxWFLtcGrX1BwK9hZY2pyKfraMu2OuXOYgVg5r2itXmc7oJDArDnnia6W7uDM7Q4YWx7sSP0uNorXL1IjlTNgD2m4RU0Li2FwWHny+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726115162; c=relaxed/simple;
	bh=xyQE2gfxqTLxiYV5xveoltC/aFuv60BdDvSHOVM/TD0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qANFL+WHW1oAOcyDLvKjFnvb/LI0vHNLY60jJzhTK+SUZbUStQkynwy4ueZa0IfqPaZXymAQkPBoVSozewvpG2N+85DbVAxOB8CeVTmJxYSdlDVEnDTP8JvDFNXZp++k9fuDPW11iPsV7C25I0GiOpwrswKQgX/vPrOaPOdUFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5kOC/gT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5kOC/gT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726115161; x=1757651161;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xyQE2gfxqTLxiYV5xveoltC/aFuv60BdDvSHOVM/TD0=;
  b=a5kOC/gTpeTjigx2BQ1cTygI2vkTgkm1/aDG3drnwa01f93NfcsVv9Qo
   kk4iMBdl+UJ8QW6e2EcpefumSjEjo/tAqguIUAj1NFJWRqs/EEi8TFYcZ
   8mB2N7rs+peO8qeE3BMMONDBV61tSAzFNThsWYJ0AYwGuPGcOkv6KtzRS
   wzpPrsYGkIlBWw87spWpWPZrkeo0ilN+IJ+TxYV/+ZimkMAa3l3QSKlSy
   sv8HDIfl36pW6CEQnM1DwFuCFaZk6jdfYpoICz0ugL+h/SxDMV+Yc684y
   hLUUFHjrJ372esR1zBIl3mkRVC1Lvg3J3a9fcemG7WXPOkL1O+31kdEVk
   A==;
X-CSE-ConnectionGUID: gOVkOrUqRySKOZGrI6YIxg==
X-CSE-MsgGUID: EStFLblcRSa62LqGsaYqIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28725255"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28725255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 21:26:01 -0700
X-CSE-ConnectionGUID: zpmbRlnQQCmvIL+aZltn8w==
X-CSE-MsgGUID: G4YwYM1rSwyIPZD7ACm+/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="68369594"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 11 Sep 2024 21:25:58 -0700
Message-ID: <b7a68539-3a3c-4cd9-922b-bfb9db8e7e0b@linux.intel.com>
Date: Thu, 12 Sep 2024 12:21:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
To: Joel Granados <j.granados@samsung.com>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
 <CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
 <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
 <20240911105657.iesajd4d5va3wc5y@joelS2.panther.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240911105657.iesajd4d5va3wc5y@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 6:56 PM, Joel Granados wrote:
> On Thu, Sep 05, 2024 at 11:30:05AM +0800, Baolu Lu wrote:
>> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
>>> From: Joel Granados<j.granados@samsung.com>
>>>
>>> iommu_report_device_fault expects a pasid array to have an
>>> iommu_attach_handle when a fault is detected.
>> The iommu_attach_handle is expected only when an iopf-capable domain is
>> attached to the device or PASID. The iommu_report_device_fault() treats
>> it as a fault when a fault occurs, but no iopf-capable domain is
>> attached.
>>
>>> Add this handle when the
>>> replacing hwpt has a valid iommufd fault object. Remove it when we
>>> release ownership of the group.
>> The iommu_attach_handle is managed by the caller (iommufd here for
>> example). Therefore, before iommu_attach_handle tries to attach a domain
>> to an iopf-capable device or pasid, it should allocate the handle and
>> pass it to the domain attachment interfaces.
> What do you mean here?
> 1. Do you want to move the iommufd_init_pasid_array call up to
> iommufd_hwpt_replace_device?
> 2. Do you want to move it further up to iommufd_device_do_replace?

I'm having trouble understanding the need for iommu_init_pasid_array()
in the core.

> 
> Note that all this implemented on a call to replace HWPT. So a
> non-iopf-capable VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl has already been
> completed before the one that calls iommufd_device_do_replace.
> 
>> Conversely, the handle can
>> only be freed after the domain is detached.
> Do you have a function in specific where you would put the free handle
> logic?

drivers/iommu/iommufd/fault.c

void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
                                      struct iommufd_device *idev)
{
         struct iommufd_attach_handle *handle;

         handle = iommufd_device_get_attach_handle(idev);
         iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
         iommufd_auto_response_faults(hwpt, handle);
         iommufd_fault_iopf_disable(idev);
         kfree(handle);
}

Thanks,
baolu
