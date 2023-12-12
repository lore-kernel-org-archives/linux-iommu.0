Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE527F5
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyPR2qNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702358892; x=1733894892;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LCn4/xvODPorX9mTjeGLTue7GovKBlpADEjiJxDVln0=;
  b=AyPR2qNZE1IruQBU2I7LX6f+NafNi/Iml0xnCSjlj2j1fb84Wzr7VVhG
   p3Nw0t4xQiu+3GG+ysRRKwCOLWAMESw7/7IOsWSzjuF+XpdbesaM+ps2e
   b1NdH72R8/5p/Mrin7Lb3urgpLuc9/q4OfYTTkF/W/k/R4lFXAZkkeQko
   BA2sofpxytPzeVWRCJDq0QCbyQtxoaIyVGZmaouA5cHKJXG5iUpfDubct
   vXi1lvkkNOPzsL6Cyql7E7bhr4DKblqbspZ7UTLfHG13QE2hKAvebwQRS
   760cFsGdqClP7uPNFj2dnEZJ49OFmhL/UcfKX9EDdG5Ij6JbwRH+SDLKt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="393626918"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="393626918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="807612687"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="807612687"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2023 21:28:07 -0800
Message-ID: <d95e9104-e518-4aa5-8dd8-b6b7fd2294b6@linux.intel.com>
Date: Tue, 12 Dec 2023 13:23:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Longfang Liu <liulongfang@huawei.com>, Yan Zhao <yan.y.zhao@intel.com>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231211152456.GB1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
>> @@ -282,22 +313,15 @@ EXPORT_SYMBOL_GPL(iommu_page_response);
>>    */
>>   int iopf_queue_flush_dev(struct device *dev)
>>   {
>> -	int ret = 0;
>> -	struct iommu_fault_param *iopf_param;
>> -	struct dev_iommu *param = dev->iommu;
>> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
>>   
>> -	if (!param)
>> +	if (!iopf_param)
>>   		return -ENODEV;
> And this also seems unnecessary, it is a bug to call this after
> iopf_queue_remove_device() right? Just

Yes. They both are called from the iommu driver. The iommu driver should
guarantee this.

> rcu_derefernce(param->fault_param, true) and WARN_ON NULL.

Okay, sure.

Best regards,
baolu
