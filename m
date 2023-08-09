Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959814F9A
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691541086; x=1723077086;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AywbTO27cVNl/fazmIprghWONbtmeCSn9y1uvPUIl/k=;
  b=NikDXjUVmWq6FZICp1yQcamamw6s117IqGz/8A9CclY0JOxsGrVgPYYT
   8HZr9UfnSHDrJBKvZPvuE8Q29pZxcX6kOZB51RjRSsc4+asc8JI0RYnlk
   gtTbm1dYHerf2TuLdZYOIK2BOkjpckSkhi4SkWXWaI2/mCw6tLWnSB2TB
   XW8Obm4h/2zcw9PMhPbs7rbRkUZt/FEEvAoiuGLXr/Ls21TbRyDuvvv4T
   vHvgNTBngvquAtqBlX05PU5U7+piA/S0QvfCqfY1v21lUqOcdx4hgiFrI
   41Oa66GXQLJe57wjHJj+zXFrQi1ak22A8XYRZq4nLiZshe3tamDKpVfbM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437353072"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="437353072"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725156738"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="725156738"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.46]) ([10.249.169.46])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:31:23 -0700
Message-ID: <8ed60665-fb1c-cf94-ea24-5f43ce8c9903@linux.intel.com>
Date: Wed, 9 Aug 2023 08:31:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com> <ZNJY/9pwRxIkFEjD@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNJY/9pwRxIkFEjD@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/8 23:02, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 03:49:40PM +0800, Tina Zhang wrote:
>> mm_get_pasid() is for getting mm pasid value.
>>
>> The motivation is to replace mm->pasid with an iommu private data
>> structure that is introduced in a later patch.
> Maybe we should start out by calling it what it actually is:
> 
> 'mm_get_enqcmd_pasid()'
> 
> We can't actually have multiple SVA domains with different PASIDs
> until the places wrongly calling this are removed :\
> 
> eg, I would expect this series to also come with removing
> 'pasid_private' from the Intel driver.
> 
> The mmu_notifier should be placed in the singular iommu_domain that is
> the SVA domain for the mm. Drivers should not attempt to de-duplicate
> this, the core code will do it like you are showing in this series.

The two tasks mentioned above are part of our plan. They will be
conducted in stages, which is more conducive to review and testing.
This series is just the beginning.

Best regards,
baolu
