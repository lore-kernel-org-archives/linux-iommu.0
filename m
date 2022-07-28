Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134C10F6
	for <iommu@lists.linux.dev>; Thu, 28 Jul 2022 06:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658989658; x=1690525658;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=jOlcrF54BgdoCTWPvBjjzQ5jHjfAyaaVLW7zTceQpag=;
  b=FPxOgcZKk8B/ASgpWGL9yBdPkhrXhTFrCGHMGpWe5Z8eskxb2x4cDZJC
   98cXf9GE2HtaNV+v83PUMGhOWPaEAP7BlKZ29EA2EBPuc7/XhMBZyGJ+B
   86X6tnfN05AkusTrnWMcNhOV3O0U9Os6UbANCiWuSq1nmaMvt9MrKzkRN
   oYcurZeNOhkX5moYxQtZEh4n3pfydEsSOJMwV4Law5aMOvD1A2J1CyFzK
   qzSpAdhErRHSrVE7a7mjnAvN7ABpAS2k9xfCKnkkdVWBFdzxplgd/VD/7
   RexFIu4hG3G/5CHiZ9jBQda8tieezbArtUbTCfT3pLGmFeXKUpCuaXG93
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="350138725"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="350138725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:27:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="928137045"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.160]) ([10.254.213.160])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:27:32 -0700
Message-ID: <ccba785d-9000-09f0-7ca8-b21834924ced@linux.intel.com>
Date: Thu, 28 Jul 2022 14:27:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <cf370e4a-9391-4dd3-1e0a-3c7ea70d9ed2@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
In-Reply-To: <cf370e4a-9391-4dd3-1e0a-3c7ea70d9ed2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/28 10:44, Baolu Lu wrote:
>>
>> If the fabric routes PASID properly then groups are not an issue - all
>> agree on this?
> 
> I still think the singleton group is required, but it's not related to
> the PCI fabric routing discussed here.
> 
> We have a single array for PASIDs in the iommu group. All devices
> sitting in the group should share a single PASID namespace. However both
> the translation structures for IOMMU hardware or the device drivers can
> only adapt to per-device PASID namespace. Hence, it's reasonable to
> require the singleton group.

Further, conceptually, we cannot support pasid attach/detach on multi-
device groups. If multiple devices cannot be isolated, it is difficult
to ensure that their pasid spaces are isolated from each other.
Therefore, it is wrong to attach a domain to the pasid of a device. All
devices in the group must share a domain.

Best regards,
baolu
