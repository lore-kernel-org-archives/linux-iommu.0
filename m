Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C933236
	for <iommu@lists.linux.dev>; Sat, 10 Jun 2023 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686399253; x=1717935253;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8elPVM81BdGcGGAZYBdokG8hYC/1QRR+oygJ7EhpjR0=;
  b=Sa4/O0je2J6B7ZGsVWGfny6DWcrVefion6JAlEV2Clv3Ov5/Csk8pBCO
   v0N3bxw6lOm2skHRUNAOUtUSmGd/S8MvwqFh5o+PkTRodZ3ePciKrhZBN
   YsKEqWRTI1hVaikFoz02nd4b/11diJTRYKg2bgXZjCuo1BuGYkw64QDkM
   4IAFRRFYo852Z2aIGfDsl4Oexq8fn5DqMFVdchIrjXH8RZ//2in7W6q3T
   idsNUQqCTG2RzeT5g9sqb5IO5CfrhKYFlOdo2UWTUMissGau9aaPfu22o
   U+4W7D/sG2NvZhQc0LriFOqqhwi9OPW2TafBvJ83alMbUHaR5O9yvn4R3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338119666"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="338119666"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 05:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="884879484"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="884879484"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2023 05:14:07 -0700
Message-ID: <08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
Date: Sat, 10 Jun 2023 20:13:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 rex.zhang@intel.com, xiaochen.shen@intel.com, narayan.ranganathan@intel.com
Subject: Re: [PATCH v8 2/7] iommu: Move global PASID allocation from SVA to
 core
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, dmaengine@vger.kernel.org,
 vkoul@kernel.org
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
 <20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/23 2:22 AM, Jacob Pan wrote:
> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> +{
> +	int ret;
> +	ioasid_t max;
> +
> +	max = dev->iommu->max_pasids;
> +	/*
> +	 * max_pasids is set up by vendor driver based on number of PASID bits
> +	 * supported but the IDA allocation is inclusive.
> +	 */
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, IOMMU_FIRST_GLOBAL_PASID, max - 1, GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);

"dev->iommu->max_pasids == 0" indicates no pasid support on the device.
The code should return IOMMU_PASID_INVALID explicitly. Perhaps we can
make this function like this:

ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
{
         int ret;

         if (!dev->iommu->max_pasids)
                 return IOMMU_PASID_INVALID;

         /*
          * max_pasids is set up by vendor driver based on number of 
PASID bits
          * supported but the IDA allocation is inclusive.
          */
         ret = ida_alloc_range(&iommu_global_pasid_ida, 
IOMMU_FIRST_GLOBAL_PASID,
                               dev->iommu->max_pasids - 1, GFP_KERNEL);

         return ret < 0 ? IOMMU_PASID_INVALID : ret;
}
EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);

Other change in this series looks good to me.

I hope I can queue this series including above change as part of my VT-d
update for v6.5 to Joerg if no objection.

Let's try to re-enable this key feature of Intel idxd driver in v6.5.

Best regards,
baolu
