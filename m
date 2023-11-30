Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AF4CB2D
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StbgcdQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316128; x=1732852128;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xC3dwYlDuD1hlwFCoRdZoguQbZrD/kr1AFHDGZNT2y0=;
  b=StbgcdQHHPyd7f5OSvbR2aQabj0jlk2U6jGfWdfVvcscKtfUwVXCRtbt
   Wp9YZFZ4EmD8XOzz5lZBzCJ6mWuEYWIWxGE8n5/eGQfhM5tI6cxoayO0N
   Mpaj7VrgmgWPszduTT7GIyS9iN4wLpZMSf5hvfi0oSHBA1h1hzZ0s8rhv
   /lXC/Z4g6ptTQZbGCMVGGPB0chGCl0huT9jMWD4IQygNAws5hnblpouUH
   7HZJWkOSyRBQHuQcbTlPAWqVx47a2YL8L83IARBZhllPFJdQdw3PN3sN9
   krJfICq7fuzyCS6gyk6SxKxJIG1EKy1xpXgD1JSlKCRaVPT4RwgVyt3Gl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373447807"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="373447807"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1100780499"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1100780499"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:48:45 -0800
Message-ID: <07f6d0f1-0b3d-486a-a26b-483874a93b24@linux.intel.com>
Date: Thu, 30 Nov 2023 11:48:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Support enforce_cache_coherency only for
 empty domains
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231129200834.GJ1312390@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231129200834.GJ1312390@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/30 4:08, Jason Gunthorpe wrote:
> On Tue, Nov 14, 2023 at 09:10:33AM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 65d37a138c75..ce030c5b5772 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -602,6 +602,9 @@ struct dmar_domain {
>>   					 */
>>   	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
>>   	u8 nested_parent:1;		/* Has other domains nested on it */
>> +	u8 has_mappings:1;		/* Has mappings configured through
>> +					 * iommu_map() interface.
>> +					 */
> Is it racey?
> 
> The other option is to make iommfd do this and forbid it from
> switching the enforce_cache_coherency if the IOAS has any maps
> attached. We can get the correct locking at that point.
> 
> AMD has the same issue if it ever wants to implement its per-PTE bit

Yes. It's better to do this in iommufd. With that done, we can then
remove this code.

Best regards,
baolu
