Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96C3D56D
	for <iommu@lists.linux.dev>; Wed,  3 Apr 2024 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113782; cv=none; b=oFYGCbJytSgFZFrsFI9+PnQCYgBuYZl5iXE2Q+vxBGabS4fN9nG4RVdKHXgFcgbvLS1HWYubYvrH7pzcp1eFKOTQ5zT2BxHQ+RzUj+6O4qIDL1qxqmo4B5ozlRv2kurai40E1pp+k98fqF9/ZmbzWh+CVzohEbCQjwuIW/N7gP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113782; c=relaxed/simple;
	bh=uiYDlfzFuvJ7hv9mF8sSX8yy2GvQU90BheENGiFJ5Xc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NapQ9BWixuVAmnCYxE81zjdAkc4zfIliO72cgKdV5OJk7BFU0sbg9N5HykNoT0JMHoct7s7OR2VmdM5NYq+WnVZdF1lJUR3gA8D+sfRVSB2jz7w5CENvuUr7O8iWM69bZ2oyksqX+0kxM3O08Y/kyvGjmCPbazo4/3Utv71IWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoksaYsA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoksaYsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712113781; x=1743649781;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uiYDlfzFuvJ7hv9mF8sSX8yy2GvQU90BheENGiFJ5Xc=;
  b=MoksaYsAFkrCijgdrarO1vJejqSqSzy9Zj5goefMO7pBbFRZYGB97+V5
   LyPh0mhlTag+oVsNn+x6l+X5WmOuM082BXFgvaKCL6ojmmPIxDMgEPued
   N03vpfxE9bBaiYhjoBJRgS8/2yGmph6jphzaF1OC9IAuES8Aun6cB8tOf
   nOLSAhjGlTwEQY1FNWGAAaliDaEDtIeeCLxPgMrPxNC/Y22keGGmsjuyv
   98Md9MJ6ScxTn5ipJPVro1BxZOniXnE7/gid5eIRz9KBilobbXhOHqw19
   pgRMUHRDgIe3g2nc0C50XxG74dCoH8jh/UmcziTOzaQ3EcNTODCGWvXFb
   A==;
X-CSE-ConnectionGUID: ZskAOUx8RKicar1HWQ8L9A==
X-CSE-MsgGUID: Fi8PnXITQ/y2E5Vel3nR/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24779663"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24779663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 20:09:41 -0700
X-CSE-ConnectionGUID: hiegvYEwQti7scdPsX5fdw==
X-CSE-MsgGUID: foI05s5OQH22FRdr42RCwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18711090"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 02 Apr 2024 20:09:38 -0700
Message-ID: <03a8e382-5fe0-4420-ace1-10a7107e5768@linux.intel.com>
Date: Wed, 3 Apr 2024 11:08:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 robin.murphy@arm.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 1/2] iommu: Undo pasid attachment only for the devices
 that have succeeded
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240328122958.83332-1-yi.l.liu@intel.com>
 <20240328122958.83332-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240328122958.83332-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 8:29 PM, Yi Liu wrote:
> There is no error handling now in __iommu_set_group_pasid(), it relies on
> its caller to loop all the devices to undo the pasid attachment. This is
> not self-contained and has drawbacks. It would result in unnecessary
> remove_dev_pasid() calls on the devices that have not been attached to the
> new domain. But the remove_dev_pasid() callback would get the new domain
> from the group->pasid_array. So for such devices, the iommu driver won't
> find the attachment under the domain, hence unable to do cleanup. This may
> not be a real problem today. But it depends on the implementation of the
> underlying iommu driver. e.g. the intel iommu driver would warn for such
> devices. Such warnings are unnecessary.
> 
> To solve the above problem, it is necessary to handle the error within
> __iommu_set_group_pasid(). It only loops the devices that have attached
> to the new domain, and undo it.
> 
> Fixes: 16603704559c ("iommu: Add attach/detach_dev_pasid iommu interfaces")
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
