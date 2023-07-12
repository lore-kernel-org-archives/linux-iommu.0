Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D3182
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 02:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689129846; x=1720665846;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iWj+6wrVCX+Ik7s49Gkyi64YGWWOKVozpQXtsPYZBfA=;
  b=WC5/Kk52ANquR1qDGcEQfH/6lw/URI+/nqbiylW2QXT4beNuNRyF+Psi
   y8HDurAHEyjtOfAJECcQk+CpwjujFJ95g6xEMXA+6ZROaAgRq2ZPDuALj
   1GcuAUfiCtnFuJB5K1sBYST5WwiFAxPY+3L8o4B/mNSzpUiTeY3ritiU0
   dN3IbmtlP+JmTP1FHG9FlD3w+hR6w6nwR83YJ3Kbb9tqw7CfEtf+SY4Dm
   3XD+365Jx+IPI6SXwoO2E4wugxAEgoNjuhii4MAu7hYhvVIIVMspXEurJ
   Cviz3SDCc5dgBwhA87fAkTnJ/4OhC7I8sEYq98QNPV4Xf36rcCbilCbgR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="451149385"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="451149385"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 19:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="756592673"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="756592673"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.60]) ([10.252.187.60])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 19:43:49 -0700
Message-ID: <c815fa2b-00df-91e1-8353-8258773957e4@linux.intel.com>
Date: Wed, 12 Jul 2023 10:43:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] iommu: Make fault_param generic
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
 <20230711010642.19707-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52763F7A1433C73CF6589F2E8C31A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763F7A1433C73CF6589F2E8C31A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/11 14:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 11, 2023 9:07 AM
>>
>> @@ -299,7 +299,15 @@ static int dev_iommu_get(struct device *dev)
>>   		return -ENOMEM;
>>
>>   	mutex_init(&param->lock);
>> +	param->fault_param = kzalloc(sizeof(*param->fault_param),
>> GFP_KERNEL);
>> +	if (!param->fault_param) {
>> +		kfree(param);
>> +		return -ENOMEM;
>> +	}
>> +	mutex_init(&param->fault_param->lock);
>> +	INIT_LIST_HEAD(&param->fault_param->faults);
>>   	dev->iommu = param;
>> +
>>   	return 0;
>>   }
> 
> Upon above changes is it slightly cleaner to call it dev_iommu_init()
> to better pair with dev_iommu_free()?

dev_iommu_init() was introduced in Jason's series. It's not landed yet.

https://lore.kernel.org/linux-iommu/0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com/

Sure. Should refine this code after above patches are landed.

Best regards,
baolu
