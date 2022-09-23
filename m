Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7915A3
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 02:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663900301; x=1695436301;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYyYBUYMtYbcujhE22C27QXzCyOfAQYZ1tOZo9rAkuU=;
  b=nhTOg2FKU1Q2Y5u5aWB4gePqi3KHv5H3+svJsgVaRfXAjTCq5x+Yqjbm
   ooUDW/11I4sJjqo49nxVwUepz5KR6o11K2E2qmaPZ31Z0ApjGLF9OboTx
   vxRjqdo0f8IQ+kXWHJnT/tVn7CrcBWZaToO2UUN/ivnSAGGCr3/sK6XK9
   bU2ymhQjF7LhNEcueQAx5l5u9HLu7O7pCypeP0ibpzQOpawbB2o45yHxf
   5LKGVdmed1h3Q2hUlqB31LQ6BXd6KHL2FWdU/qAb1Oj9T7dS6tG2kyvKK
   WbEOKKBi6w+4ZU1Is0PkttWH4Csv3rhBlh/RktRZI6PJ48QYud35LZX3B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326819679"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326819679"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:31:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="620051445"
Received: from ningqu-mobl1.ccr.corp.intel.com (HELO [10.254.210.156]) ([10.254.210.156])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:31:35 -0700
Message-ID: <ca854564-f231-1010-92e3-69acabde2bd1@linux.intel.com>
Date: Fri, 23 Sep 2022 10:31:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <YyyGqDP8AgjsFAkM@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YyyGqDP8AgjsFAkM@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/23 0:00, Jason Gunthorpe wrote:
> On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:
> 
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to mm_users
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
> Thsi is something else that needs cleaning up. IOMMU_DEV_FEAT_SVA
> shouldn't exist.
> 
> We need to figure out an appropriate way to allow PRI. IMHO the domain
> attach should do this, domains that require PRI should be distinct
> from domains that don't. When a PRI domain is attached the HW should
> be enabled to do PRI. The domain itself should carry the fault ops/etc
> that the caller supplies to respond to the PRI.
> 
> That is something to address in the PRI series though..

 From Intel IOMMU driver's point of view, with above done,
IOMMU_DEV_FEAT_SVA could be removed. However, it will take more time to
consider other needs.

> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Best regards,
baolu
