Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567D257A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656416494; x=1687952494;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5sDkMOObEeUMkZBt6eVhm9iKgpXHF4MwlPjCkr+LpE=;
  b=c+uhI85zgWa50ROClu75cSR3j+sQcGno2XXkLSOxZX+zbziJ71DOTkOj
   tt6Uqe9NnqmBCqYiDWBHv8l9Q40pY14PCv9E+wf3U9jwIOiLwuAlZgDMG
   cvUE9o9/tlPUr8TzkHBCHoOVAad8ER04MWmcB2Hy7uEcVTcKYEgDA5ieO
   OQZOC5sQF7manu0J31Lv+/cNNWxShN2uVbWKFgMIQW+m10w02F7q1SR2c
   CUq3sPd8/HHTILBw2vrwBZNvMB2nwoDnxmlswtobVp3dQ5I1/i6M7R///
   3NsMLVKxFDcs4pvXcS9Wyf2YY6CiVYqQ1paIxUDeiiQoEi7wZ6fjeYpD1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270466744"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270466744"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646879736"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:41:29 -0700
Message-ID: <31116b7f-2ce5-ba18-bcc7-97076199d745@linux.intel.com>
Date: Tue, 28 Jun 2022 19:41:28 +0800
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
 <jacob.jun.pan@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628114128.JYs4mt-t7KMGYNlEynLM7vxSxFskHdZIcU-3VrxT9oQ@z>

On 2022/6/28 16:50, Tian, Kevin wrote:
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
>>>> GFP_KERNEL);
>>>> +	if (curr)
>>>> +		goto out_unlock;
>>> Need check xa_is_err(old).
>> Either
>>
>> (1) old entry is a valid pointer, or
> return -EBUSY in this case
> 
>> (2) xa_is_err(curr)
> return xa_err(cur)
> 
>> are failure cases. Hence, "curr == NULL" is the only check we need. Did
>> I miss anything?
>>
> But now you always return -EBUSY for all kinds of xa errors.

Fair enough. Updated like below.

         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {
                 ret = xa_err(curr) ? : -EBUSY;
                 goto out_unlock;
         }

Best regards,
baolu
