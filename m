Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065F1101
	for <iommu@lists.linux.dev>; Sat,  5 Nov 2022 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667610578; x=1699146578;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=055nwbvQLu4HeNy3wpjTtPCuFAGV9ueI6JYtKrhOUF0=;
  b=EtPKvGSECXM3bOd1A1XTYT5wdDwkUI7W+y5FZbuSOROczlCNeil4j/14
   9fHoprmQxLg86zc6PBxlf95ZnBRROX4STKq79JXWjPA0XRCuUR++PEldC
   0gUSsrlKnv41jvAM/Xz4UAMRqdCzuVXwJ9JRaTPWaYJDADG5RzVUQRvNH
   L10itG5kt0cMl0ttgbacGu6gcGZSnOKy8DLqEB1+H/+evM9/VSatXi9H3
   10pr1EkSlKaBrPnCTzLsaJXSRplYPml2kSijn73V0d9+re4gK18YIIUUv
   Paj/3LzK4Ystx5sxV9XDoqaC4sNEnr+GpY/Ok0FsNfN1kyfNTs44E2cyv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293439273"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="293439273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:09:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668543882"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="668543882"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.180]) ([10.254.213.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:09:35 -0700
Message-ID: <cf157186-1ee1-0981-5425-d9cd186df57f@linux.intel.com>
Date: Sat, 5 Nov 2022 09:09:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe path
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52765902DF41858EF445E5BC8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765902DF41858EF445E5BC8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/4 10:06, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 3, 2022 1:53 PM
>>
>> @@ -4513,6 +4506,16 @@ static struct iommu_device
>> *intel_iommu_probe_device(struct device *dev)
>>
>>   	dev_iommu_priv_set(dev, info);
>>
>> +	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>> +		ret = intel_pasid_alloc_table(dev);
>> +		if (ret) {
>> +			dev_err(dev, "PASID table allocation failed\n");
>> +			dev_iommu_priv_set(dev, NULL);
>> +			kfree(info);
>> +			return ERR_PTR(ret);
>> +		}
>> +	}
>> +
> 
> move the added lines before dev_iommu_priv_set()

intel_pasid_alloc_table() needs to reference info and store the pasid
table into it.

Best regards,
baolu
