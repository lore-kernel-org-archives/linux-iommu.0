Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096D74E3D
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717124080; cv=none; b=TxxF6sJGIExmCnHjL3xIslremdSCoorbTNQ6skoF0Qj1YLKTO0Hhrc/sJIH7EtMKfUBzhtcPsv0JGXOGWymWKCD0WxUoO8O/N2IysK+miRe7578VXNOekIUZleh4FjEwH0vTafOLPFVyQHPrTZAKCmk7F2lApuRgomSMxQy3L5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717124080; c=relaxed/simple;
	bh=3qoAmgqtvz5n2DFxkNTr1ulFou6xmODb43pmh5+qrGU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VJzOQu5drrCYqxhCf040CDgjLFmq6RB/ISGWPb76skOgOeB91yzfq5JQQVIuq7CkAXiFlHhR9K3dMWmB4SnCdiX8jCl6WG1GSGubcegPY1M90H+PGX0jGrkGrgdVdf7R9mqZoznyKbQh6xeZAJaYNJE/TEnj7RSKS72Maa+0Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mi7WIbfA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mi7WIbfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717124078; x=1748660078;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3qoAmgqtvz5n2DFxkNTr1ulFou6xmODb43pmh5+qrGU=;
  b=Mi7WIbfA2QtJZhjofhggdccIwvvQbhPexynK/DY0PlC24WRgZ2MYCPXg
   toa7DdNgEd+hQ+J91jBguDvgbVBEj0ojVcfJoBAzsQyD1rtzEqVFw3Ope
   ChBhziKyHsfWb6ZwVvgonCcHtr0vYBmVfYrTRHWItFkPiMa3Obe1wqFAi
   ZmwGequ4vyG+vpGEHSauBheGGkDzAmj69lchvRa1JSpEWmCZi0GjkW9XW
   5nWhWVmIZjOpWqQQXtA9kROjmnLH0B3MwvHOfE6Q0SgpaI3QnPhUQXXdh
   uLzgAoQPqpQnlDzatGOBYuFSqEzE2b83XAx941YTLhCvKlwJIaYlNdvVx
   Q==;
X-CSE-ConnectionGUID: 8055vloxS6Oqje+jqH0+kg==
X-CSE-MsgGUID: QLVuhf6xTMC2rY9GhVQywg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25054817"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25054817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:54:38 -0700
X-CSE-ConnectionGUID: C4V03CkPTL2PiPlQZwr4rA==
X-CSE-MsgGUID: BRb7C+xcRqafLJFt/HMIsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36067256"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 30 May 2024 19:54:32 -0700
Message-ID: <e5543715-a331-4fce-85c9-f4211eb0fab4@linux.intel.com>
Date: Fri, 31 May 2024 10:52:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] iommu: Refactoring domain allocation interface
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <ac5d8f21-5fb7-4193-9a0b-cdaff39e8493@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ac5d8f21-5fb7-4193-9a0b-cdaff39e8493@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/24 1:59 AM, Robin Murphy wrote:
> On 29/05/2024 6:32 am, Lu Baolu wrote:
>> The IOMMU subsystem has undergone some changes, including the removal
>> of iommu_ops from the bus structure. Consequently, the existing domain
>> allocation interface, which relies on a bus type argument, is no longer
>> relevant:
>>
>>      struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>>
>> This series is designed to refactor the use of this interface. It
>> proposes two new interfaces to replace iommu_domain_alloc():
>>
>> - iommu_user_domain_alloc(): This interface is intended for allocating
>>    iommu domains managed by userspace for device passthrough scenarios,
>>    such as those used by iommufd, vfio, and vdpa. It clearly indicates
>>    that the domain is for user-managed device DMA.
>>
>>    If an IOMMU driver does not implement iommu_ops->domain_alloc_user,
>>    this interface will rollback to the generic paging domain allocation.
>>
>> - iommu_paging_domain_alloc(): This interface is for allocating iommu
>>    domains managed by kernel drivers for kernel DMA purposes. It takes a
>>    device pointer as a parameter, which better reflects the current
>>    design of the IOMMU subsystem.
>>
>> The majority of device drivers currently using iommu_domain_alloc() do
>> so to allocate a domain for a specific device and then attach that
>> domain to the device. These cases can be straightforwardly migrated to
>> the new interfaces.
> 
> Ooh, nice! This was rising back up my to-do list as well, but I concur 
> it's rather more straightforward than my version that did devious things 
> to keep the iommu_domain_alloc() name...
> 
>> However, there are some drivers with more complex use cases that do
>> not fit neatly into this new scheme. For example:
>>
>> $ git grep "= iommu_domain_alloc"
>> arch/arm/mm/dma-mapping.c:      mapping->domain = 
>> iommu_domain_alloc(bus);
> 
> This one's simple enough, the refactor just needs to go one step deeper. 
> I've just rebased and pushed my old patch for that, if you'd like it [1].

Great! With this change, we can safely replace iommu_domain_alloc().

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 52f9c56cc3cb..88c2d68a69c9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1585,9 +1585,11 @@ arm_iommu_create_mapping(struct device *dev, 
dma_addr_t base, u64 size)

         spin_lock_init(&mapping->lock);

-       mapping->domain = iommu_domain_alloc(dev->bus);
-       if (!mapping->domain)
+       mapping->domain = iommu_paging_domain_alloc(dev);
+       if (IS_ERR(mapping->domain)) {
+               err = PTR_ERR(mapping->domain);
                 goto err4;
+       }

         kref_init(&mapping->kref);
         return mapping;

> 
>> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    private->domain = 
>> iommu_domain_alloc(private->iommu_dev->bus);
> 
> Both this one and usnic_uiom_alloc_pd() should be OK - back when I did 
> all the figuring out to clean up iommu_present(), I specifically 
> reworked them into "dev->bus" style as a reminder that it *is* supposed 
> to be the right device for doing this with, even if the attach is a bit 
> more distant.

Yeah! I will cleanup these two in the next version.

> 
>> drivers/gpu/drm/tegra/drm.c:            tegra->domain = 
>> iommu_domain_alloc(&platform_bus_type);
> 
> This is the tricky one, where the device to hand may *not* be the right 
> device for IOMMU API use [2]. FWIW my plan was to pull the "walk the 
> platform bus to find any IOMMU-mapped device" trick into this code and 
> use it both to remove the final iommu_present() and for a device-based 
> domain allocation.

I am not familiar with this driver, so the solution you mentioned above
is the best option I can think of for now. I will incorporate this into
the next version.

> 
>> drivers/infiniband/hw/usnic/usnic_uiom.c:       pd->domain = domain = 
>> iommu_domain_alloc(dev->bus);
>>
>> This series leave those cases unchanged and keep iommu_domain_alloc()
>> for their usage. But new drivers should not use it anymore.
> 
> I'd certainly be keen for it to be gone ASAP, since I'm seeing 
> increasing demand for supporting multiple IOMMU drivers, and this is the 
> last bus-based thing standing in the way of that.

Agreed. With all iommu_domain_alloc() removed, iommu_domain_alloc()
could be dropped.

> 
> Thanks,
> Robin.
> 
> [1] 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commit/f048cc6a323d8641898025ca96071df7cbe8bd52
> [2] 
> https://lore.kernel.org/linux-iommu/add31812-50d5-6cb0-3908-143c523abd37@collabora.com/

Best regards,
baolu
