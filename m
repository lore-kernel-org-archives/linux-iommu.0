Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC603C05
	for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682083289; x=1713619289;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hIt+r7SzvXYzbG5XvmGzm4Tg/7HxDhCZxwACfyMji3s=;
  b=Ih0U3dp9IheGWB12wq2gwZY3tXfzDR13P8kl+3YYPaO3Ur1TLUASfxnv
   xRWJ+n2V+h4QksH8IUTcKkO4my36d9FKXztXf7uDTHiCHxfZk5As4Jg7d
   P+T6AoePTJTIcqEAEEohb03a9c/0EbWdPEiU65aaVWgQSEz5abfEoO3P5
   5m0UsCXq+6a7rzPe2FPfXRsPeNrisgU2L/hubQMYsqVCBgqunRsg7mLCK
   lgUG5Iurk90oOAtVq16PhC/PEAWQp4f91Y/8VwivKnJDWOWQrh1qEK/Py
   Ukn7R8zc3d6Am4TcbE+TGGa0HUtVmhpKLxL3H1kMcNwawzA1m1YfB/Nf6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334866782"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="334866782"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 06:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724821095"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="724821095"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.207]) ([10.254.213.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 06:21:26 -0700
Message-ID: <f0c46e67-c029-a759-5523-d598adb7fd07@linux.intel.com>
Date: Fri, 21 Apr 2023 21:21:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: RMRR device on non-Intel platform
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230420081539.6bf301ad.alex.williamson@redhat.com>
 <6cce1c5d-ab50-41c4-6e62-661bc369d860@arm.com>
 <20230420084906.2e4cce42.alex.williamson@redhat.com>
 <fd324213-8d77-cb67-1c52-01cd0997a92c@arm.com>
 <20230420154933.1a79de4e.alex.williamson@redhat.com>
 <ZEJ73s/2M4Rd5r/X@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZEJ73s/2M4Rd5r/X@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/4/21 20:04, Jason Gunthorpe wrote:
> @@ -2210,6 +2213,22 @@ static int __iommu_device_set_domain(struct iommu_group *group,
>   {
>   	int ret;
>   
> +	/*
> +	 * If the driver has requested IOMMU_RESV_DIRECT then we cannot allow
> +	 * the blocking domain to be attached as it does not contain the
> +	 * required 1:1 mapping. This test effectively exclusive the device from
> +	 * being used with iommu_group_claim_dma_owner() which will block vfio
> +	 * and iommufd as well.
> +	 */
> +	if (dev->iommu->requires_direct &&
> +	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
> +	     new_domain == group->blocking_domain)) {
> +		dev_warn(
> +			dev,
> +			"Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.");
> +		return -EINVAL;
> +	}
> +
>   	if (dev->iommu->attach_deferred) {
>   		if (new_domain == group->default_domain)
>   			return 0;

How about enforcing this in iommu_group_claim_dma_owner() and change the
iommu drivers to use "atomic replacement" instead of blocking
translation transition when switching to a new domain? Assuming that the
kernel drivers should always use the default domain, or handle the
IOMMU_RESV_DIRECT by themselves if they decide to use its own unmanaged
domain for kernel DMA.

Best regards,
baolu
