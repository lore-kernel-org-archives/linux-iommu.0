Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1E1E3780
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035190; cv=none; b=R1OyI4HB5/4PZbXruPJiA+vd9VIgEdR3sidoaHIR3tCjfLMLbGDgU6qX8AZNYD9TAMjRvxrYJ15OKTHesuiRFrYdkLrqn4vJ4xX6n6YkvdUG+umh5KgvG4xgzWL+X3/TyfdHP3Qx4iFulwUOavd7B+Ba1TzGhFlRSl7gN1Ej1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035190; c=relaxed/simple;
	bh=lV3ebLrwRwVXrWSAsXtPmvNXTEbmZjhyBhFzYmyxgc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnfWe08Jd39CnAXPFs9tTSbGdThVl3Kseto0RIoPRBcluRP6YBjWHKoElMlJPtVNDGXD3bu8veDlzfZlWRbA1eznYgTvHNCFFIhHfKXk7MoWSGTx3WV3B47Hg7tYgdYithIfHTVMdJAcV83AMgccOUBJPz4dy3IaU5M/iTt3opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ok5MX70/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ok5MX70/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740035189; x=1771571189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lV3ebLrwRwVXrWSAsXtPmvNXTEbmZjhyBhFzYmyxgc8=;
  b=Ok5MX70/MAA5VQDqiPGeDMj7zWzRs7juT+tDcwyrkSpdWzDA4Fen89OM
   tWQmvx02CqLvoZvYovZSBmg0+i2IjPieITQ3xUlOq3u547B3KJ4yvqCm3
   5aB5oogmYY6KlmdKGRj+9fdb3tKBVVC6iaIpIVduxf79JEIh/gFUCmxlj
   h2O2NMxDZrY9k5pAu8vCNlzJPbTpRqrmBJaob+qVdCOI3CjaCp+fwYgnv
   NInO3oS+2uAUNsjmnWfqknK97T4Fbbp5lGZlb6pYe4ot8HncutMHER6oX
   f55oV6eFxKtHsWnZYSd5x1PaP/lTER0ClN9ZqDi4EWiZLvVebS5C91uX0
   Q==;
X-CSE-ConnectionGUID: g1LdBYpcS3e1RXDDqlD8Ow==
X-CSE-MsgGUID: dutJKejsREW+IuQugoRPbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41057780"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="41057780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:06:29 -0800
X-CSE-ConnectionGUID: J7H2QhwgSd6TcTQcLppbUg==
X-CSE-MsgGUID: 4VeUkJpMQdmmXPk2MYn51w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="114937450"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:06:26 -0800
Message-ID: <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
Date: Thu, 20 Feb 2025 15:03:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250220010250.GQ3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 09:02, Jason Gunthorpe wrote:
> On Fri, Feb 14, 2025 at 02:11:00PM +0800, Lu Baolu wrote:
>> @@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
>>   	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
>>   		return -EINVAL;
>>   
>> +	return mock_dev_enable_iopf(dev, domain);
>> +}
> 
> This isn't going to work for a replace type operation? Maybe like:
> 
> if (old_domain->iopf_handler && !domain->iopf_handler)
> 	return mock_dev_disable_iopf(dev, domain);
> if (old_domain->iopf_handler && domain->iopf_handler)
>          return 0;
> return mock_dev_enable_iopf(dev, domain);
> 
> ?

The iommufd mock device driver appears not to support replacement. The
replacement operation on this driver is likely handled as follows:

- attach domain_a
- attach blocking_domain
- attach domain_b

The mock_dev_disable_iopf() is called in attach_dev of the blocking
domain.

There seems to be a bug in this patch. The existing domain should be
passed to mock_dev_disable_iopf().  It requires something similar to the
following:

diff --git a/drivers/iommu/iommufd/selftest.c 
b/drivers/iommu/iommufd/selftest.c
index a6b12cee7b00..54a6f0851758 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -168,6 +168,7 @@ struct mock_dev {
         int id;
         u32 cache[MOCK_DEV_CACHE_NUM];
         unsigned int iopf_refcount;
+       struct iommu_domain *domain;
  };

  static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -197,17 +198,24 @@ static int mock_domain_nop_attach(struct 
iommu_domain *domain,
                                   struct device *dev)
  {
         struct mock_dev *mdev = to_mock_dev(dev);
+       int ret;

         if (domain->dirty_ops && (mdev->flags & 
MOCK_FLAGS_DEVICE_NO_DIRTY))
                 return -EINVAL;

-       return mock_dev_enable_iopf(dev, domain);
+       ret = mock_dev_enable_iopf(dev, domain);
+       if (ret)
+               return ret;
+
+       mdev->domain = domain;
  }

  static int mock_domain_blocking_attach(struct iommu_domain *domain,
                                        struct device *dev)
  {
-       mock_dev_disable_iopf(dev, domain);
+       struct mock_dev *mdev = to_mock_dev(dev);
+
+       mock_dev_disable_iopf(dev, mdev->domain);

         return 0;
  }

Thanks,
baolu
