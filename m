Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5441A08B8
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542977; cv=none; b=nzfgY3UbjSm6/cRfJ+OEpdYdnYOKxAKN6thou3LhWBPtoXRDCxJgAHtRkur0mP74lWU8E86z8FaWAY38N0qIJgZbEYj51Em+7UxvbxBz2MS1krO8jjPas9RuYoT2V4/oSazh3z6TW4nAppU6ryAKiTYD9+GycpF3HHbRFDEVpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542977; c=relaxed/simple;
	bh=cP3PR+OlwzJA3fBVfk6ajcn/yRjvqWqrQ7H6/+u/gao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+EywCLASzSDsoMC6ynhulC5Fsftrb56oAIcUVJBuh3KY4I1OYNvdpzWstyU+bxicwtciZ1QEVNdhRNlcILgJ0GXro64uCq1n76c8hNfyG6AeEilktEtOFhb0KAdoRfmz2x5P6ir8rtc/xuS/6LsIvn22OQKTD8P9psGN3Babac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ri4t/Kn0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ri4t/Kn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740542977; x=1772078977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cP3PR+OlwzJA3fBVfk6ajcn/yRjvqWqrQ7H6/+u/gao=;
  b=Ri4t/Kn0SySXnTdbTcv98+VUrxr/6cSDI5ZiBHnXGEgDjnfG7y1p1s4A
   EJionmBwHQI+Ue+k/Qz+l0PZMtL7mfA8c/9+OXaXkX92OH5pGxn4hdD4R
   8aLG+1ZWjVeyAkoNswxeeJqBzZIhD8KzGnfMsr2FtmQiG7P2V8w2ip14F
   tnZPRgnZtQSgpd+Rx+AgQVc6VjPeFFfcGjBK92PP2HDWFQKFyiJjHeeWO
   nLtubt4M9kBDi7DTlQmtNSBSeGcD7XO3Tl6uWlBbEuekRt49j/jV+sL1/
   dRtX4+0zHA6fCmfAw7OMe14mTHVcS0IujZHj50oS5j6f6E94zwq8oxbgg
   A==;
X-CSE-ConnectionGUID: Odddif6DQXWDVguP1lICtg==
X-CSE-MsgGUID: FahKRl/LTPCAneBME5ZbSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44199202"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="44199202"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 20:09:36 -0800
X-CSE-ConnectionGUID: HZBvsV2rQxmmgzEbsRuIkQ==
X-CSE-MsgGUID: L0c1mKTiSm6Ov0/dfL5lFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116394288"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 20:09:33 -0800
Message-ID: <a4d650cf-c8e4-4590-ab6f-f464a17125d1@linux.intel.com>
Date: Wed, 26 Feb 2025 12:06:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276852398C05D067FEFB2DF8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276852398C05D067FEFB2DF8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 16:16, Tian, Kevin wrote:
>> +	ret = mock_dev_enable_iopf(dev, domain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mock_dev_disable_iopf(dev, mdev->domain);
> You could use the same trick to simplify iopf_for_domain_replace()
> in patch7?

Yes, simplify it like this,

static inline int iopf_for_domain_replace(struct iommu_domain *new,
                                           struct iommu_domain *old,
                                           struct device *dev)
{
         int ret;

         ret = iopf_for_domain_set(new, dev);
         if (ret)
                 return ret;

         iopf_for_domain_remove(old, dev);

         return 0;
}

Thanks,
baolu
