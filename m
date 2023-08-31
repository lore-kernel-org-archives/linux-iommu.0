Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DAC10FA
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693448676; x=1724984676;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FnMTKvdFqh9Eilp2QbYzzkev2WfWsV8F4jYo/j/hiHs=;
  b=IV+iLUZ7tXCBXzmSRCpKrqxXW+fjzbagN6qNJt4OKYgiTAF6cK6ZCXxy
   nTgWMnEQYN3uzDuSZrvpCOEU2bjErr2fFm7qnsLICYBP1JCkr9RPfEvIH
   pYFzfVUP8M9pNjqIlQTIDjj143MhAOAOs3SFHYcyn6DBV7Nft0QkEh1B0
   CIN87189WdBHiD7DEl2HJFkHfY3Dz/uys3j8MHBWGFROiFAl2eNpXd/TE
   3lNoq318oodBIL6rHNaPqV9RvkBoADa3ZaeMhREb3+FeTmghdsqniKkcm
   wAUMK4NbDHG91mXws8VNrENX3wO41HW9C272ULqnM8cuUH3e8jQll0knV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360782913"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="360782913"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="913035744"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="913035744"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:24:34 -0700
Message-ID: <4d658766-688c-cda2-b4e1-60200a60a9b3@linux.intel.com>
Date: Thu, 31 Aug 2023 10:24:31 +0800
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
Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/27 16:43, Tina Zhang wrote:
> Use the helper function mm_get_pasid() to get a mm assigned pasid
> value. The motivation is to replace mm->pasid with an iommu private
> data structure that is introduced in a later patch.
> 
> v2:
> - Update commit message
> - Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid

Ditto.

> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
>   drivers/iommu/intel/svm.c                       |  8 ++++----
>   drivers/iommu/iommu-sva.c                       | 14 +++++++-------
>   include/linux/iommu.h                           | 10 +++++++++-
>   4 files changed, 26 insertions(+), 18 deletions(-)

Eventually perhaps we should have something like sva_domain_get_pasid().

But the subsystem still needs some evolution to achieve this. In the
individual iommu driver, the mm_notifier should be wrapped in the sva
domain, hence the domain could be retrieved in the mm notifier callback.
With this done, the iommu drivers call sva_domain_get_pasid() instead of
mm_get_pasid().

Finally the iommu drivers only need mm->pgd, nothing else.

Considering that this patch will make the subsequent patches simpler, I
do not object to it. Hence,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
