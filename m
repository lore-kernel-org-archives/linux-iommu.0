Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118015AB
	for <iommu@lists.linux.dev>; Sat, 26 Aug 2023 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693037443; x=1724573443;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jlu0jGsz3YUaNHKDYc4hDn69ED5yf7AXMnsAeLD1XTY=;
  b=b+ck2E9Gst/4kpB/ME68nFsnM/itHxTR6KakSeqhLS6Ly8Lzeyj6QD89
   KueAwGgz903ExrpCJV/sg/rH1dlhe+qWpHv8PCeMTGn68PSWFzX/D77YO
   zxzYtXm73Px0+ybBT8WXxWht0AygXX4DtPqovsKPdtBQaqVPO1RIqd0qz
   yN6pmd8kGdAq3e65b0RyUvJK4+PAjwgRKXF0K7S10JUFPZ+5wTkwG7wHW
   bYWzqzFYHXMJdUJ9WKjZgYsrsUPOSOJjsSu7uWSoLXCTyzpmCjlm5/3gO
   t0KSDd5wWBG7ED+QpAao87Nx5uFkFhjuQZel61d78xsFh3isiDZ9M2BVR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405853121"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="405853121"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 01:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772735780"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="772735780"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2023 01:10:39 -0700
Message-ID: <3b893bf4-a566-9a1f-49da-17efdd7e4661@linux.intel.com>
Date: Sat, 26 Aug 2023 16:08:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] iommu: Make iommu_queue_iopf() more generic
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230825023026.132919-1-baolu.lu@linux.intel.com>
 <20230825023026.132919-10-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A33BC9F41AB424915688CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762A33BC9F41AB424915688CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/23 4:17 PM, Tian, Kevin wrote:
>> +
>> +	list_for_each_entry(iopf, &iopf_param->faults, list) {
>> +		if (WARN_ON(iopf->fault.prm.pasid == pasid))
>> +			break;
>> +	}
>> +	mutex_unlock(&iopf_param->lock);
>> +}
>> +
>>   void iommu_detach_device(struct iommu_domain *domain, struct device
>> *dev)
>>   {
>>   	struct iommu_group *group;
>> @@ -1959,6 +1980,7 @@ void iommu_detach_device(struct iommu_domain
>> *domain, struct device *dev)
>>   	if (!group)
>>   		return;
>>
>> +	assert_no_pending_iopf(dev, IOMMU_NO_PASID);
>>   	mutex_lock(&group->mutex);
>>   	if (WARN_ON(domain != group->domain) ||
>>   	    WARN_ON(list_count_nodes(&group->devices) != 1))
>> @@ -3269,6 +3291,7 @@ void iommu_detach_device_pasid(struct
>> iommu_domain *domain, struct device *dev,
>>   {
>>   	struct iommu_group *group = iommu_group_get(dev);
>>
>> +	assert_no_pending_iopf(dev, pasid);
> this doesn't look correct. A sane driver will stop triggering new
> page request before calling detach but there are still pending ones
> not drained until iopf_queue_flush_dev() called by
> ops->remove_dev_pasid().
> 
> then this check will cause false warning.
> 

You are right. It is not only incorrect but also pointless. The iommu
driver should flush the iopf queues in the path of detaching domains. I
will remove it if no objection.

Best regards,
baolu
