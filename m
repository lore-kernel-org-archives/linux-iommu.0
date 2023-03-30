Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F41FC4;
	Thu, 30 Mar 2023 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680180055; x=1711716055;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YC8xyIjHZePzPnsOGngyZ4S5gleiyp9L0o+a7GrAhyA=;
  b=hf/07PokJdyHYccAphCD9TxZ7b13iQxXGEqFi3vI1Kj33n4fE9/25f/X
   6BTqNK20xGDQfUKCuFa0tkWoIBbaXO7zcCOLNUUTjtUC/9nraZln4Oli5
   41L6JojUleW6B4Vn3IHVpExsuaVgtI2pw85ti1Q/u3nVsjH/1VQaieOWy
   TG3VPY8zc7CFFGXUlym/oUZucV0JyWZ4sf8g3Wp25sV6jPpGj+hF20YsL
   EpBncq4YMliXfsTfrgFSWtmsgoW7Mw1564b2/CPSQXPyYqYn8G+1WFSLm
   Y/ZTdI4ElqG+L+KoVXYrJX36K1zFjFyETGCh5z44gLII34K9opsZFuokg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341170522"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="341170522"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="678172120"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="678172120"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.251]) ([10.255.30.251])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:40:51 -0700
Message-ID: <ca824eb2-7976-831c-7c3c-43122277e219@linux.intel.com>
Date: Thu, 30 Mar 2023 20:40:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 13/14] iommu: Remove __iommu_group_for_each_dev()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <13-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <13-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/30 7:40, Jason Gunthorpe wrote:
> The last two users of it are quite trivial, just open code the one line
> loop.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
