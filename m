Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38810FA
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693447611; x=1724983611;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l68MXTZpDoORzO6V1cBKJfBxtTQt3jnhWIQZc2YuyFU=;
  b=Pr3+NwCv2DF3XguFjKIrV4tfXOiAbRoTv7lP+8IKiRM0CnEqSPYF/skN
   eI6WGSt0OUKl/nPGcznk4cCTlAAlkjkaVX5ipzr29nl6FnMhqAcuyCkh/
   7sSgVXkPUgmVvAEPY7aiqDCny1BYj+mq3JNUYcBsoe+iKWv0RQocP/ogE
   LnADTy1wAObx4ANT/fkvNpTaZjS8cr/TJJ6y00sh4DNkEa8BwQ42PwjEB
   6Qf9EEn/ycQ9SnXW+wrvkwYFriAXUX9Z8YZCiEOJDM2hmbjRqAq4TFRvL
   XLZ53jnNWDoavWKUhEfUcZuid9rBylCk/bDHywjVpSY4sf/QjpZWLdeOS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360781319"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="360781319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="913033711"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="913033711"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:06:48 -0700
Message-ID: <e16f2963-9748-7461-ca8e-d0b46a34330c@linux.intel.com>
Date: Thu, 31 Aug 2023 10:06:45 +0800
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
Subject: Re: [PATCH v2 1/5] iommu: Add mm_get_enqcmd_pasid() helper function
To: Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-2-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-2-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/27 16:43, Tina Zhang wrote:
> mm_get_enqcmd_pasid() is for getting enqcmd pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.
> 
> v2: change mm_get_pasid() to mm_get_enqcmd_pasid()

The change log should be moved under the tear line.

> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   arch/x86/kernel/traps.c | 2 +-
>   include/linux/iommu.h   | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
