Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103152417FB
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732959; cv=none; b=HEFH7IQiT0zhxhUtGX6/wyOazLak87KQO4SWJchrU2yubq27GEgXqZ8QOhqrqRS/IM+rADeVz61pbbe9ETn/hWWDHo8RBjEpspreGU6ZvhW9flRS/6/BsZxDNPJ2ciWe40kLKUkNlk6zrwoZD4cgD4sgscLajXOMiYRHf8zhb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732959; c=relaxed/simple;
	bh=bR5DggZqCiEGi9he/eyi98K92BT+GaiSoLp0JFUNYKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEvdFTluB3lFkyIfk0qBtQuIY1EEWXsSIO14lbcUS//SZs5VLH22LtMv7qWTYT3eXfUoOhEPIiiNkn6UDc+CxqTmTAjIwDIuWqb65aQqFaAM7DgmYUf0Z2kc7pUHTIbJIKie/3Jt/brVVbiSGR96wbRcZXAs4wu7HQidntX4cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAo/kH58; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAo/kH58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764732958; x=1796268958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bR5DggZqCiEGi9he/eyi98K92BT+GaiSoLp0JFUNYKI=;
  b=LAo/kH58KDkZ48csMqBVHO+/35hDkV7ObuEK77SJ2qpOvi4rY9qWNaE+
   flaqIKtCFgSP+/FcMUJvRmMozu7EiqKbnxzTHNAQliR2uFhJc2J4aQtU4
   nmFEbNnhdzmZIiHSEwp/Px38ZB10WvOm7RJNKYjIyr+TkYxX5KNcGwmFR
   eG7d3z2EH7C8OzSgCbPgY0YN+jJDlKe7iP1r+8WHV8EDfmlgy4fTgf6n7
   tDpI9w9RcDpgghnq39g6MCfCGNsIvz9+2eo8vSyImmIlr/4Qn3oOKs3eQ
   TOZgtr20w+BN3EwmTudVaPQjHRS0igvZcHyYRRcs42uix2ZMIXUux3VjO
   A==;
X-CSE-ConnectionGUID: 8VeX2F+5SJ2hCaPicL8Nqg==
X-CSE-MsgGUID: Fq7NCZZ2TbaZML67HYmDXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="89371812"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="89371812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:35:57 -0800
X-CSE-ConnectionGUID: 7e3xdHeeRTmGxoAVYj/3IA==
X-CSE-MsgGUID: xv8HRGN2SC+ELvcCaBqK8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194977649"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:35:53 -0800
Message-ID: <64a01f42-9231-481a-b8f7-5c5dfed4b095@linux.intel.com>
Date: Wed, 3 Dec 2025 11:31:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com,
 Zhang Yu <zhangyu1@linux.microsoft.com>,
 Jean Philippe-Brucker <jean-philippe@linaro.org>,
 David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
 <20251201173012.18371-3-jacob.pan@linux.microsoft.com>
 <f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
 <20251202160635.0000433e@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251202160635.0000433e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 08:06, Jacob Pan wrote:
> Hi Baolu,
> 
> On Tue, 2 Dec 2025 10:17:34 +0800
> Baolu Lu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Jacob,
>>
>> On 12/2/25 01:30, Jacob Pan wrote:
>>> The dummy IOMMU driver for No-IOMMU mode should only be active when
>>> no real IOMMU devices are present in the system. Introduce a helper
>>> to check this condition, ensuring that the dummy driver does not
>>> interfere when hardware-backed IOMMU support is available.
>>>
>>> Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
>>> ---
>>>    drivers/iommu/iommu.c | 10 ++++++++++
>>>    include/linux/iommu.h |  1 +
>>>    2 files changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 0df914a04064..958f612bf176 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -2895,6 +2895,16 @@ static const struct iommu_device
>>> *iommu_from_fwnode(const struct fwnode_handle * return ret;
>>>    }
>>>    
>>> +bool iommu_is_registered(void)
>>> +{
>>> +	bool registered;
>>> +
>>> +	spin_lock(&iommu_device_lock);
>>> +	registered = !list_empty(&iommu_device_list);
>>> +	spin_unlock(&iommu_device_lock);
>>> +	return registered;
>>> +}
>>
>> IOMMU devices might be added by calling iommu_device_register() at any
>> time. Therefore, an empty iommu_device_list does not necessarily mean
>> that "no real IOMMU devices are present in the system."
> Good point. My intention was that the noiommu dummy driver should
> register only after all hardware IOMMU drivers have completed
> registration during boot. Any subsequent registration attempt, such as a
> hot-added IOMMU, should fail if noiommu mode is already active.
> 
> We could enforce this by introducing a global flag that prevents any
> iommu_device from being registered after the noiommu driver has been
> initialized.
> 
> However, as you pointed out there seems to be no standard ordering
> for iommu device registration across platforms. e.g. VT-d hooks up with
> x86_init, smmuv3 does that in platform driver probe. This patchset puts
> dummy driver under early_initcall which is after both but not a
> guarantee for all platforms. Any suggestions?

Could we add a helper call inside the IOMMU detection path (e.g., within
pci_iommu_alloc()) to set a flag, such as platform_iommu_present, after
successful hardware detection?

void __init pci_iommu_alloc(void)
{
         if (xen_pv_domain()) {
                 pci_xen_swiotlb_init();
                 return;
         }
         pci_swiotlb_detect();
         gart_iommu_hole_init();
         amd_iommu_detect();
         detect_intel_iommu();
         swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
}

Thanks,
baolu
