Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7637F
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 03:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686625637; x=1718161637;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P/VoxzPYJGKVWcFbYSel2k5NLgVhyd1yXneHuuZGDj4=;
  b=dMH1ldJi4vSfS7MFV/f1KJ/Hdj1/99WxYkXP2JkfMvfmf+ChS8DBCUOd
   PmgYzEUy1d8X2LCFXYHuCqBDwHmqjcFlGOvO9oAqJw1oZDUuaQ7TnPRHS
   ZjoOluIrLkbD5TdgmTRsdrXH+yoXfeFU6mUYMVyb1c+igwghDt4LNWrTb
   LIdBy6frC3y8ffhY64S2OtNvzpR+KRTFdSBLP9BklkATTBG9jLZH1RcY5
   zKFuUj5rbkkgZn0yzrzWFvrb94GaNeA156GMsBspuKGKVOSlcP5k9kqQS
   3S49EFNV7j14pe624q9VbTHT+LOvhFgqtXJnDTVOBvFDLeN/a2axdMhVx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="424098735"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="424098735"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 20:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041594701"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="1041594701"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2023 20:07:09 -0700
Message-ID: <b5a6a7ad-bfad-b550-f4be-f5ec0679f3d2@linux.intel.com>
Date: Tue, 13 Jun 2023 11:06:03 +0800
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
 <08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/23 8:13 PM, Baolu Lu wrote:
> On 6/3/23 2:22 AM, Jacob Pan wrote:
>> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
>> +{
>> +    int ret;
>> +    ioasid_t max;
>> +
>> +    max = dev->iommu->max_pasids;
>> +    /*
>> +     * max_pasids is set up by vendor driver based on number of PASID 
>> bits
>> +     * supported but the IDA allocation is inclusive.
>> +     */
>> +    ret = ida_alloc_range(&iommu_global_pasid_ida, 
>> IOMMU_FIRST_GLOBAL_PASID, max - 1, GFP_KERNEL);
>> +    if (ret < 0)
>> +        return IOMMU_PASID_INVALID;
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
> 
> "dev->iommu->max_pasids == 0" indicates no pasid support on the device.
> The code should return IOMMU_PASID_INVALID explicitly. Perhaps we can
> make this function like this:
> 
> ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> {
>          int ret;
> 
>          if (!dev->iommu->max_pasids)
>                  return IOMMU_PASID_INVALID;
> 
>          /*
>           * max_pasids is set up by vendor driver based on number of 
> PASID bits
>           * supported but the IDA allocation is inclusive.
>           */
>          ret = ida_alloc_range(&iommu_global_pasid_ida, 
> IOMMU_FIRST_GLOBAL_PASID,
>                                dev->iommu->max_pasids - 1, GFP_KERNEL);
> 
>          return ret < 0 ? IOMMU_PASID_INVALID : ret;
> }
> EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
> 
> Other change in this series looks good to me.
> 
> I hope I can queue this series including above change as part of my VT-d
> update for v6.5 to Joerg if no objection.
> 
> Let's try to re-enable this key feature of Intel idxd driver in v6.5.

This series didn't pass my test.

The first time when I run "idxd_ktest.sh -c 1 -t 1 -i 100 -m shared", it
passed. But when I run it again, the idxd hardware operation resulted in
timed-out issues.

I have removed this series from my queue.

Best regards,
baolu
