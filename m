Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E29611F
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691634636; x=1723170636;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u10rf6iFQykAk9HFSkdlXADbfhAXSl4szqQixOVoh8c=;
  b=OpNIouhwfyPNXN1nv6QA2NCAAXQeCPAxou2Q1Fg+/hmWXxfBGAU1MzQ6
   g6PDKSWUiRSNuGW3ptTKpgtRB0MBEsd6dWDCAxa3n/eYnPeJR1oL1z3wr
   0mHiOex9Iz58sGVTkVD/liqX4XNFGbn2G1/+cxpQQT+a6ZKHTiMrNX/fL
   N2UUZdHfynzlxT21R9szeeoTppf9x//suXbUIk/cTRQLgsWGRdLVZMSI8
   6z5ixRLB9Dy96xjBbJANPHA+31G67zVsdxJqQOEdHZJyEzq8s+HosW5U4
   djl8Fea3X6BW7uCYlJX7WY6FYychdegDjUyW/t2/h5K2ZLexk9tImHvun
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="437636752"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="437636752"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846192096"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="846192096"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.239]) ([10.254.214.239])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:30:30 -0700
Message-ID: <a0392d38-6a65-57a0-7f48-ac0cd8521781@linux.intel.com>
Date: Thu, 10 Aug 2023 10:30:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] iommu: Change the return value of
 dev_iommu_get()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-6-baolu.lu@linux.intel.com>
 <ZNPFxtlN/STZAMEY@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNPFxtlN/STZAMEY@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/10 0:58, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 01:48:30PM +0800, Lu Baolu wrote:
>> Make dev_iommu_get() return 0 for success and error numbers for failure.
>> This will make the code neat and readable. No functionality changes.
>>
>> Reviewed-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 19 +++++++++++--------
>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 00309f66153b..4ba3bb692993 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -290,20 +290,20 @@ void iommu_device_unregister(struct iommu_device *iommu)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_device_unregister);
> It could probably use a nicer name too?
> 
> iommu_alloc_dev_iommu() ?
> 
> Also with Joerg's current tree we can add a device_lock_assert() to
> this function, from what I can tell.

Sure. Will update them in the next version.

Best regards,
baolu
