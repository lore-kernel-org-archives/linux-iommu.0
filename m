Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5924404
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LykXMoJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697508759; x=1729044759;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9r7TvSUocLpq3Lg382G+iJaeI1HhRtaUjULozWB9NEI=;
  b=LykXMoJvZHGJr2y9mNI0nY33T6YwavLP/5rg9Ry4TspR1msr4vgvFNDf
   mBpSkac8KA9opDCU5OU4RkES9hKSCfw4tTh0JwSOgJ396qe7EMjjr/5cm
   LH1jz9rnTo2UmBax0DVIIZrS5nl2r+2rfCXVgqsqhR7XWxmwjaMkhTlk1
   cK8pG3xYKCRweP1slusSK9j9IwZZlhfHlV4YxshWxGaj4IuiYcw8JY8KK
   yXZUGFJ0fKVfa1mbhysXtHaeAjjseRI2lC1oFIDjaQ8xehNzGmNxnI1Jb
   s0iZzhNjcNmHZ6CD5Si17y2K8XE/7+i2rCRhuTzIC98x0R3IzcubCfKVc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384556009"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="384556009"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 19:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="3884179"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2023 19:12:40 -0700
Message-ID: <a83cb9a7-88de-41af-8ef0-1e739eab12c2@linux.intel.com>
Date: Tue, 17 Oct 2023 10:08:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
 <d8553024-b880-42db-9f1f-8d2d3591469c@linux.intel.com>
 <83f9e278-8249-4f10-8542-031260d43c4c@oracle.com>
 <10bb7484-baaf-4d32-b40d-790f56267489@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10bb7484-baaf-4d32-b40d-790f56267489@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/23 12:00 AM, Joao Martins wrote:
>>> The iommu_dirty_bitmap is defined in iommu core. The iommu driver has no
>>> need to understand it and check its member anyway.
>>>
>> (...) The iommu driver has no need to understand it. iommu_dirty_bitmap_record()
>> already makes those checks in case there's no iova_bitmap to set bits to.
>>
> This is all true but the reason I am checking iommu_dirty_bitmap::bitmap is to
> essentially not record anything in the iova bitmap and just clear the dirty bits
> from the IOPTEs, all when dirty tracking is technically disabled. This is done
> internally only when starting dirty tracking, and thus to ensure that we cleanup
> all dirty bits before we enable dirty tracking to have a consistent snapshot as
> opposed to inheriting dirties from the past.

It's okay since it serves a functional purpose. Can you please add some
comments around the code to explain the rationale.

Best regards,
baolu
