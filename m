Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA817F
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 02:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689043432; x=1720579432;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=upCvkfXEz663AS6MYxFBimuj/g5n8nrt9QG6bA5tcMw=;
  b=FHvLJKfbHKrPsNlIt3ZQ9OonJ9zlAUto1ErhUv36ddj97ZflTt1fTd1E
   ZTV1SmRj3FC6LQ+mubyVTWULoXgRaexiLOyPcEpmCNDDWcP3PNARSW/rF
   nJ7F2o498pvUnQ16fu6ngI6ACWq+1JwopS2wa3tzFP4MrYCcnXTY4mQkj
   QLAafca5Q28nhNCkljFpVjJP7E/ZPY85CruquWKxIU6DT/4Itv0CzVL48
   eVz/MqMMwGSm1Cc+1jToo8/xVwQlK0pMVNALwZMH8ySQCoj24X1eWNmSw
   cwQQATcGY87WpbQZkvzdRaUGERRMtvy7UcRwIoliOorjQERXACnaZiYmi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="428203570"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="428203570"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865596218"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="865596218"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.35]) ([10.252.187.35])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:43:47 -0700
Message-ID: <6e88db76-6903-cb7b-b608-811a97986592@linux.intel.com>
Date: Tue, 11 Jul 2023 10:43:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com> <ZKw/xS7wOoRvNfnH@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZKw/xS7wOoRvNfnH@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/11 1:28, Jason Gunthorpe wrote:
>> @@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   		goto out_unlock;
>>   	}
>>   
>> -	if (domain) {
>> -		domain->users++;
>> -		goto out;
>> +	if (unlikely(domain)) {
>> +		/* Re-attach the device to the same domain? */
>> +		if (domain == sva_domain) {
>> +			goto out;
>> +		} else {
>> +			/* Didn't get detached from the previous domain? */
>> +			ret = -EBUSY;
>> +			goto out_unlock;
>> +		}
>>   	}
> And if we do all of this we should just get rid of the horrible
> iommu_get_domain_for_dev_pasid() entirely.

At the core level, we have no idea about whether an sva domain allocated
for one device is compatible with another device. Hence, we should loop
the sva domains in the list and if the attach interface feeds back
-EINVAL's (not compatible), we should allocate a new domain for the
attached device and put it in the list if the new attachment is
successful.

Perhaps I'm too worried?

Best regards,
baolu
