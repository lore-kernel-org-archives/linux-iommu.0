Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F738F9C
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101699; cv=none; b=JFJPRuhk7KzxZPxaNMoRJWZHh7Kjr1GPSuFF6A+xWqa4PYqRRy+/K+Pmx1NGaDBk5WwmoT2z6XWpx+pyVHSqNXQGHRzzU3PxerMWtzOgpQMMZ3zfWV/uVYltDHkYuDGfJXl2T5X0UyN335gyEZWLYutrHCcx9aMSTALOO0updPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101699; c=relaxed/simple;
	bh=hKrAcz0hp1e5z9BC5Nn9C/ns9jezqIclfR/AJu6y0Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5h4og2nNx4IO9YE9bPrTroxokPYgoqus1HCeOre7gdO7zeY18eIrFeWLiQFO8CL0eNumQd2lbH0s/q4cm/NZCkf950xVRiYxCwS8SwddkntqcB5mQ7MG/i23nm7KLV9VX8u/NLgCVMvUpA1ZlwAoadKwEJQRMqviyWKMbBExcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQDSAFHB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQDSAFHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740101697; x=1771637697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hKrAcz0hp1e5z9BC5Nn9C/ns9jezqIclfR/AJu6y0Gk=;
  b=LQDSAFHBLRXrxz88CqFQYePneTg0US7faRiztVIckrcmSWffV/q4Me4l
   UG7EqPSjIEXLebM/ZSELVH79IUn/+To8ev5n0YSpCHCwe2nCKQ1GT+679
   XCtZEGB2UUcpe44bfEPTRSPLkBUHEsUoS0lFaT1F85kqh1I1mH1l5XT7/
   Q4ea+yQI8DLVDgc1d/VMgL0/48PA1ZcYp6EHfCEAAofJBNQwy0Mo8RScT
   c57ur1RAl3D6eP/3yaS0wbHbhEgwvgkTl5VdnL6HLAq82sYsYVQsTtKtt
   8nKCgD81J9qAVF9C/9OsCPCjSaP7fXuAqbhdEzRhWIJr2eo7yfegSvaMz
   Q==;
X-CSE-ConnectionGUID: 9ZlGTcwlSVW/XN8ViwhCWw==
X-CSE-MsgGUID: ZBdBgiIcSluX6Yp8nHXxoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41170996"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="41170996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:34:56 -0800
X-CSE-ConnectionGUID: QLxN4gFzQxiLHza53Bfugg==
X-CSE-MsgGUID: CnlBtwsXSoqTBGZcD9fqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="115763674"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:34:54 -0800
Message-ID: <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>
Date: Fri, 21 Feb 2025 09:31:48 +0800
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
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
 <20250220180004.GX3696814@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250220180004.GX3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/25 02:00, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2025 at 03:03:21PM +0800, Baolu Lu wrote:
>> On 2/20/25 09:02, Jason Gunthorpe wrote:
>>> On Fri, Feb 14, 2025 at 02:11:00PM +0800, Lu Baolu wrote:
>>>> @@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
>>>>    	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
>>>>    		return -EINVAL;
>>>> +	return mock_dev_enable_iopf(dev, domain);
>>>> +}
>>> This isn't going to work for a replace type operation? Maybe like:
>>>
>>> if (old_domain->iopf_handler && !domain->iopf_handler)
>>> 	return mock_dev_disable_iopf(dev, domain);
>>> if (old_domain->iopf_handler && domain->iopf_handler)
>>>           return 0;
>>> return mock_dev_enable_iopf(dev, domain);
>>>
>>> ?
>> The iommufd mock device driver appears not to support replacement.
> That's not technically a choice the driver gets to have ..

Yes.

> 
>> The
>> replacement operation on this driver is likely handled as follows:
>>
>> - attach domain_a attach blocking_domain attach domain_b
> Nothing actually does that though?

Ah! you are right.

This driver allows a new domain to be set even if a domain already
exists. This is different from what vt-d driver does, which removes the
old domain first. So perhaps we need to enhance it in two ways:

- Store the existing domain (a.k.a. old domain).
- Handle iopf enablement, taking the existing domain into account.

How about below change?

diff --git a/drivers/iommu/iommufd/selftest.c 
b/drivers/iommu/iommufd/selftest.c
index a6b12cee7b00..5ffbd4e3f372 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -168,6 +168,7 @@ struct mock_dev {
         int id;
         u32 cache[MOCK_DEV_CACHE_NUM];
         unsigned int iopf_refcount;
+       struct iommu_domain *domain;
  };

  static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -197,17 +198,28 @@ static int mock_domain_nop_attach(struct 
iommu_domain *domain,
                                   struct device *dev)
  {
         struct mock_dev *mdev = to_mock_dev(dev);
+       int ret;

         if (domain->dirty_ops && (mdev->flags & 
MOCK_FLAGS_DEVICE_NO_DIRTY))
                 return -EINVAL;

-       return mock_dev_enable_iopf(dev, domain);
+       if (mdev->domain)
+               mock_dev_disable_iopf(dev, mdev->domain);
+
+       ret = mock_dev_enable_iopf(dev, domain);
+       if (ret)
+               return ret;
+
+       mdev->domain = domain;
+       return 0;
  }

Thanks,
baolu
