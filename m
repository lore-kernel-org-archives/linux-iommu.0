Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C0204693
	for <iommu@lists.linux.dev>; Sat, 22 Feb 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740209336; cv=none; b=VJ/ZFaIJkwdVIlHXl1VW4EF+LqLZcofHrbAeSdKmOZTjwHx1qqncL64fqbpGoP9L+G3/AdGs1XhXQLxJAAv0Q/Xove0jlotSfZcg+VB/6S61Xx1i5q4AEaEALluFYBkFB18cV7PpycUyAV6x1/5NnTGUkJMyLwl36aUWnVHt//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740209336; c=relaxed/simple;
	bh=hKWnYqDVibXovKSxdxiJl5vEV8dexi/H8/6jyPb+cnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5qNrT7jXTW1lWKNeh2ZqCQXKwN3WtBKX/LERwBNO7/Igzn83AZweU5ods6TJ7mJDR50ENIFXUf5Cz2psW3FfQ4p6Xx8HCTvAsy3/s6K/u0/u/0UK9dxCa6drbfW0S804jGVnPY9OVrnAsvlJ+Buv5BoRL+3lQKQXg97yxcZsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNfq9KbC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNfq9KbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740209335; x=1771745335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hKWnYqDVibXovKSxdxiJl5vEV8dexi/H8/6jyPb+cnc=;
  b=KNfq9KbCAKQVJzw2ge5PUG6LYyhCDztzObl8vkplFBR2PgQxHPxViBg3
   o1HwYLvCHnRfNgGQY1fQ7gOdyvfHb2TcqZZFXUjnZ8Gs6YzZ3j1qwAlMH
   8QU6EPSUVhHb24D9HH17IYIRr7WmNmPH/9kuDZ6AW7WVFnXFlsoNRbGHD
   A+7An54RZ0bAfaNoSsT5tSGZ1Ki7Xv5HYTEE62XnzDUJzghgf4TZ35gr3
   LVRczSwJe3R/JX+CrskeO60Y93Knd5WdUr4lGCHM8Qs30LrmOlAMTQEJO
   9CdaHKKmvOzWSFvnbfWop6gkqsuHH6pqFk8FnkAKQOSctxoXesQ3hJxsP
   w==;
X-CSE-ConnectionGUID: TWsBIohaQLeoAdgoi2WzoA==
X-CSE-MsgGUID: qN5AHFQdSdy5u3yS4vh4CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40742277"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="40742277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 23:28:54 -0800
X-CSE-ConnectionGUID: 371ayz7cT/aPqhHbAcbXTQ==
X-CSE-MsgGUID: 85UYNrxHTcmNBhsBWT9s3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="120490527"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 23:28:52 -0800
Message-ID: <682b5b61-e556-479e-b641-3c987360d87b@linux.intel.com>
Date: Sat, 22 Feb 2025 15:25:43 +0800
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
 <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>
 <20250221150401.GY3696814@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250221150401.GY3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/25 23:04, Jason Gunthorpe wrote:
>> -       return mock_dev_enable_iopf(dev, domain);
>> +       if (mdev->domain)
>> +               mock_dev_disable_iopf(dev, mdev->domain);
>> +
>> +       ret = mock_dev_enable_iopf(dev, domain);
>> +       if (ret)
> Though here the domain is disabled but not removed from mdev->domain,
> is it OK?

That's not okay. I can make it like below:

static int mock_domain_nop_attach(struct iommu_domain *domain,
                                   struct device *dev)
{
         struct mock_dev *mdev = to_mock_dev(dev);
         int ret;

         if (domain->dirty_ops && (mdev->flags & 
MOCK_FLAGS_DEVICE_NO_DIRTY))
                 return -EINVAL;

         ret = mock_dev_enable_iopf(dev, domain);
         if (ret)
                 return ret;

         mock_dev_disable_iopf(dev, mdev->domain);
         mdev->domain = domain;

         return 0;
}

Both mock_dev_enable/disable_iopf() will be a no-op if domain or
domain's iopf handler is empty:

         if (!domain || !domain->iopf_handler)
                 return;

Does it work for you?

Thanks,
baolu
