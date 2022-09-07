Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1757E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 01:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662514057; x=1694050057;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ZV1q+JgdPyql58iLRG4rBR7Tp9YEX2NHtfBPjMsBF2E=;
  b=L63MPp2djWZEYLc6vLHlqHS3Oo5e8J0KLnkk6mrY9F6VVisRgDBU+Lpk
   0h82RK8B7gEPoIopLUhKcXEoXEMi+mN4+bj6VqBPFLcUAPgCQWd7MWFLk
   T1IX8mIjxQTUxb/11emAEPHXzf9Xawzo/2NqHyneGdE5HoKGQIWctl0cX
   pH+rp17SBnZYQ2QrH8Y7EwacIqg5mmLY1GW/ktbkI+BQ5Pmh8Q/ZqpLMk
   ciBs/W/P1Dir9hKCsIKy2Bax3L8UqP8TE+6a0CAFB7AWUx/b4xE/x5yZW
   uTAAtgNwwWHLg9KWPofeFuqG+K6Dh4CsfGBt/E9DmX0uq9nTz/+wLakRK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297536703"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="297536703"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 18:27:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="591491033"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.40]) ([10.254.214.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 18:27:32 -0700
Message-ID: <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
Date: Wed, 7 Sep 2022 09:27:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com> <Yxd2+d/VOjdOgrR2@myrica>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
In-Reply-To: <Yxd2+d/VOjdOgrR2@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

On 2022/9/7 0:36, Jean-Philippe Brucker wrote:
> On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to mm_users
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
> This isn't true anymore. How about storing handle in the domain?

Yes, agreed. How about making the comments like this:

/**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to mm_users
  *
  * Create a bond between device and address space, allowing the device to
  * access the mm using the pasid returned by iommu_sva_get_pasid(). If a
  * bond already exists between @device and @mm, an additional internal
  * reference is taken. The reference will be released when the caller calls
  * iommu_sva_unbind_device().

Storing the handle in the domain looks odd. Conceptually an iommu domain
represents a hardware page table and the SVA handle represents a
relationship between device and the page table for a consumer. It's
better to make them separated.

In a separated series, probably we can discuss the possibility of
removing handle from the driver APIs. Just simply return the sva domain
instead.

struct iommu_domain *iommu_sva_bind_device(struct device *dev,
                                            struct mm_struct *mm);
void iommu_sva_unbind_device(struct device *dev,
                              struct iommu_domain *domain);
u32 iommu_sva_get_pasid(struct iommu_domain *domain);

If you think it's appropriate, I can send out the code for discussion.

> 
> (Maybe also drop my Reviewed-by tags since this has changed significantly,
> I tend to ignore patches that have them)

I am sorry that after your review, the SVA domain and attach/detach
device pasid interfaces have undergone some changes. They mainly exist
in the following patches. Can you please help to take a look.

iommu/sva: Refactoring iommu_sva_bind/unbind_device()
arm-smmu-v3/sva: Add SVA domain support
iommu: Add IOMMU SVA domain support
iommu: Add attach/detach_dev_pasid iommu interfaces

Best regards,
baolu
