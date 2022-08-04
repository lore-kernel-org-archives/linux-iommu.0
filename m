Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57136F
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 02:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659580975; x=1691116975;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Kwn9O26ic+Lid5EKbbW7RQYFFn8IPW4X0XfjtRScmJk=;
  b=AJnO0lEAR3zWKQJx6GXZyWozYr0l9+A+gDbnv6rN/DHKR4az83ZAk5FX
   B+xO5L1YdvdE/BottZ4u9E6Qk7bJdU4mNdjKPBEMcIEvbtNjn+Eab1REn
   LUbFLNefcBKGJJxI8KkZd3Rne4b1qKk8SHOwC1ooEFyWpuMKpW8wWnmWW
   dJev8HUU2pfXw03l6prID+yL5cflwGjE8wqhwoEyAvEDpJWgiIo80iYkV
   zTkb84CXvajNAUyMXa3Aq6zHs4J0LYwqCO3+hUbukrnVq+TJfFIVJhYI4
   dCjjuGy7phMzqGPOl3E3oYWssxB0qYfIHtNrYu9mTRiec6aEKw6VAW1OH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351537005"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="351537005"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 19:42:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="662339151"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.46]) ([10.254.212.46])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 19:42:50 -0700
Message-ID: <8c46c7a7-dc7b-72d4-2d99-91b8967ff042@linux.intel.com>
Date: Thu, 4 Aug 2022 10:42:48 +0800
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
 <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
 <Yukac8X81CP7gDsM@nvidia.com>
 <3eb62531-fa1c-4c78-c1d2-526a3758a033@linux.intel.com>
 <YurGexaP/Q+N02dT@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
In-Reply-To: <YurGexaP/Q+N02dT@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/4 3:03, Jason Gunthorpe wrote:
> On Wed, Aug 03, 2022 at 09:07:35PM +0800, Baolu Lu wrote:
>> +/**
>> + * iommu_device_claim_pasid_owner() - Set ownership of a pasid on device
>> + * @dev: the device.
>> + * @pasid: the pasid of the device.
>> + * @owner: caller specified pointer. Used for exclusive ownership.
>> + *
>> + * Return 0 if it is allowed, otherwise an error.
>> + */
>> +int iommu_device_claim_pasid_owner(struct device *dev, ioasid_t pasid, void
>> *owner)
> 
> I don't see a use case for a special "pasid owner"
> 
> PASID is no different from normal DMA. If the calling driver already
> has the proper ownership of the device/group then it is fine for that
> driver to use any kind of IOMMU attachment, RID, PASID, whatever. It
> doesn't matter *how* the attachment is made.

Agreed again.

The Linux kernel manages a device at the device driver level, and all
PASIDs are managed by a device driver. There is really no need to manage
ownership at the PASID level. The current DMA ownership mechanism can
manage the exclusions between kernel drivers and user space drivers.
Sorry that I over considered.

> Remember the series that got dropped about converting all the drivers
> to the new ownership scheme? That is how it should work - owernship
> and domain attach are two different operations and do not get mixed
> confusingly together. (and are you going to repost that series? It
> would be great to get it done)

Yes, of cause. I have also some other pending tasks, lock-free page
table traversal, driver ATS interfaces, ownership scheme for kernel
drivers, blocking domain improvement, and etc. These are enough to keep
me busy for a while. :-) If anyone in the community is also interested
in any task, I will be grateful.

Best regards,
baolu
