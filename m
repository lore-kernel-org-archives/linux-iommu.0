Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AF63B5
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X51KjvT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696994542; x=1728530542;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mfGQA09nt+pjnB7NA+LILPA/SIcWHOBZ2pc/nhd6wsU=;
  b=X51KjvT1tlSKGzfkM6SXJ81b1MgXWbD/CrCWY7wdo2pxURMsbkwhvv9+
   RUvaaldCwZSjOy4pMTDhnDQxIrQAE8c5RKmn4j7HECJHY8hLdAm0F4YgU
   q2ddXtWV7uLU77iieJHs2gfC4aetmUfloyHDUc9xrAPGZ756Y8Xqtq1cT
   TwXN9qS8EOKyCs+1GemqQVCzsEMyUNk2Q7Q7DEw0sT0FQD0yGFt4qbyzt
   /21kNa0MwMYrC0XTDAUOa2iHX8JSE6i9ffmsa6KSWdecujsYD4lIglxRg
   QUpeyZRjD/kYGmzC5+/Uz4+AkIwXm4JL93IGRRnhUgQRmdVYLXesuAqhb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364852545"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364852545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 20:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877501933"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877501933"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 20:22:15 -0700
Message-ID: <558c3038-11b4-4afe-b441-fe62b646a192@linux.intel.com>
Date: Wed, 11 Oct 2023 11:18:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, alex.williamson@redhat.com,
 kevin.tian@intel.com, robin.murphy@arm.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-7-yi.l.liu@intel.com>
 <20231010164355.GA74795@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231010164355.GA74795@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/23 12:43 AM, Jason Gunthorpe wrote:
> On Thu, Sep 28, 2023 at 12:15:28AM -0700, Yi Liu wrote:
>> This adds the domain_alloc_user op implementation. It supports allocating
>> domains to be used as parent under nested translation.
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 5db283c17e0d..017aed5813d8 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4074,6 +4074,33 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>>   	return NULL;
>>   }
>>   
>> +static struct iommu_domain *
>> +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct intel_iommu *iommu;
>> +
>> +	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	iommu = device_to_iommu(dev, NULL, NULL);
>> +	if (!iommu)
>> +		return ERR_PTR(-ENODEV);
> Why isn't this just
> 
> 	struct device_domain_info *info = dev_iommu_priv_get(dev)
> 	struct intel_iommu *iommu = info->iommu
> 
> ???
> 
> Same question for almost all other calls to this function! The one in
> probe is reasonable, but I don't think it should be ever called again.
> 
> I'm going to leave this, but please make a series cleaning all the
> device_to_iommu() stuff next cycle..

Sure. I also have a plan to do this. device_to_iommu() is only needed in
the probe path. For runtime callbacks, we can just retrieve it from the
device's iommu private data.

Best regards,
baolu
