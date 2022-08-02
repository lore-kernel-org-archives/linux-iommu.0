Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6137F
	for <iommu@lists.linux.dev>; Tue,  2 Aug 2022 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659407048; x=1690943048;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X0+Fo5Zyxytk3rUKtAqS0oOOSdZ/wsYHzGBuKKmFi5Y=;
  b=j8+urgPFIFPs4QozcIZzDLxO94qaDpaatBADEiGmy5UaKHkDGOm28lzi
   W1N3TbhGiIqiVO4j3uV4H2400W52RmaJfWbXup1UR60YATVWvhk83UJ1t
   +RY+2qO5wEFyTSI/OTtdfCYz9erQDpgvMvmGYkPxKc+qAFrwe6XwFUvrW
   w1Oj6cnM2ZLFw3Sa9fsmCeU08WHfRKeGBb/1BZEojIIRmo5KnxklLjz6G
   s9sjSI5NqiTkuMFMnh6M6k20UwXSqUh9eEx4qMOXgV/jE6lnxulhzDFlz
   rFIfaEmzVXbjnAyH4+2Fra4M1g6/8XsE4kbI5DDwweilmjYEqrFGCUNPk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="286861774"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="286861774"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 19:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="661426081"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 19:24:02 -0700
Message-ID: <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
Date: Tue, 2 Aug 2022 10:19:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
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
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220726135722.GC4438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 7/26/22 9:57 PM, Jason Gunthorpe wrote:
>> +	/*
>> +	 * Block PASID attachment in all cases where the PCI fabric is
>> +	 * routing based on address. ACS disables it.
>> +	 */
>> +	if (dev_is_pci(dev) &&
>> +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
>> +		return -ENODEV;
> I would probably still put this in a function just to be clear, and
> probably even a PCI layer funcion 'pci_is_pasid_supported' that
> clearly indicates that the fabric path can route a PASID packet
> without mis-routing it.

I am fine with putting above in a function to make it clear. But I am
hesitant to move this part of logic into the PCI layer.

 From the perspective of IOMMU, TLPs with PASID prefix form distinct
address spaces, so it's reasonable to require ACS protection on the
upstream path.

But PCI spec doesn't require this. The interfaces defined in drivers/pci
/ats.c should work as well even the IOMMU is disabled.

> If the fabric routes PASID properly then groups are not an issue - all
> agree on this?

Yes, agreed. The iommu groups are not an issue any more. But just like
iommu_attach_device(), if multiple devices share a group, there must be
some mechanism to make sure that device drivers are aware of this fact
and only attach a shared domain to any PASID of those devices.'
Otherwise, the iommu_attach/detach_dev_pasid() might be misused.

Considering that all existing PASID use cases are singleton group case,
probably we can start our support from the simple singleton group case?

Best regards,
baolu
