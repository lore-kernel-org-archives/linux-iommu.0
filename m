Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C38367
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 03:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657162947; x=1688698947;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zDHr4dBa22BsNwtUtrCF8oK8mc/E+IT+JoPdjpDGUbs=;
  b=e3d21Kjs/4tM3yQ5P/S/fvp77GsUwi1cq2ZQbsBY8RoNQl9EW3yiRhKK
   5RbBJwazGP/juq2BC2pYC9V+FAua4aBQzz5L0w8vOR+xPs1J2BTvI0R7+
   t56vExcpW42ByvPGoGpLuvlbwehoEDF3vKcN12v6Yi0/EpT2/soVjsg6i
   eTVTA6KGOmzaDkUwrAKta5aodwxg4iFHiaejKBsidRSEfUQpZDEVIZEQ1
   T0uNfWTcVhVsKITXRdpBmZd/AzW/Sa0epQJD8zAcJyJcK1fxKEbljmQnN
   y4NWvl/Y7lthT7IbWRgurWjLmLOetkNVTfr1yrmASQ3xU+7Vr/aBsMkQH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282668967"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="282668967"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:02:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650936330"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:02:12 -0700
Message-ID: <2547ae6f-9567-fd76-3a51-31ae769d8599@linux.intel.com>
Date: Thu, 7 Jul 2022 11:02:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Zhu, Tony" <tony.zhu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <BN9PR11MB527661C920696BCA56C064F78C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527661C920696BCA56C064F78C839@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/7 09:56, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 5, 2022 1:07 PM
>>
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>> mm_struct *mm)
>> +{
>> +	struct iommu_domain *domain;
>> +	ioasid_t max_pasids;
>> +	int ret = -EINVAL;
> 
> -EINVAL is not used.

Updated.

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 

Best regards,
baolu

