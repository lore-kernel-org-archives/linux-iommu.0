Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0153BD
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 07:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693467550; x=1725003550;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T69LnpBDtRT8UV80E0X2gwzvbl16M8WGW5icyevns9Y=;
  b=FhKYDSNJfCQgX++BZwc2Tid8BZGrnCKdN0bgcu9XdjuSF7Yk1XjZuI9z
   lm8J3+8nmNts48t8RC3UKONN1Cc+gVU0153rZ38zZcIzjYp7xATYFykdD
   glVmukwxNXEeZ4L5tzkllsssjpxBLAMBsCsb81ekyGE5OXuNTY6DJ12BB
   ELkpxfOG3fG6prPGheibfHhScUWbhzJelCisPJaZ6ExwTRWMhhzs23WG1
   NNMNVppTo9Ygl0Pw/O6sLc5nMcLSqauOTMmCVWwuXrvpMlzLQeBgq7DhL
   TNw8ECMz/3vp0KVTfSQXodNMA2hIleY/TBJJbBHB03gX+V0F8TlISn4su
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462224565"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="462224565"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="862924196"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="862924196"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:39:07 -0700
Message-ID: <bb408ce0-bb11-f2ca-840d-826a124f98ae@linux.intel.com>
Date: Thu, 31 Aug 2023 15:39:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm: Deprecate pasid field
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-6-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-6-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/27 16:44, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   include/linux/mm_types.h | 1 -
>   mm/init-mm.c             | 3 ---
>   2 files changed, 4 deletions(-)

mm->pasid is dead code now. So remove it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
