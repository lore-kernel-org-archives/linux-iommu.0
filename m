Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B6185D;
	Thu, 30 Mar 2023 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157366; x=1711693366;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SLtwg9hHp/3LDXIqWRGrL54epwgHbJSbiXsOW79BOqs=;
  b=Vhp0A8pel4+VN1DvBn6A7euFVtnkjh1ByN7ysShMfo/LW4081bGwarzZ
   ordAtcoyxjRgRrRBBqk5wtPw88CYE4C3F+ncYzGpTIqsA8XGD8NQbHeam
   y4EPGyX3j1UjCeFkN1lzRKMmerByWXL2Ku1CT4+tNk40klARHGgyZEQwF
   Zhw+W5a6tVJwY7zsHENMAF+l4sN3ynwLwXH0k+g+FcU8hiSRcGIXvYDJ7
   n9IThwEZm2z4FpbMlCrxPnkR6Mt+Pda+LLkdq7Szz/CgMLrN6Ez4g1nM2
   VUX5vTdWiSTAfY5Vlezo8C0T0PcgkNbw6G6l+P4cA1/Mjcu1gl+gHJlIT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403731279"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403731279"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714877873"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="714877873"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 23:22:43 -0700
Message-ID: <7bd2443e-b49a-b4ae-31e4-103688530353@linux.intel.com>
Date: Thu, 30 Mar 2023 14:23:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 02/14] iommu: Add for_each_group_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> Convenience macro to iterate over every struct group_device in the group.
> 
> Replace all open coded list_for_each_entry's with this macro.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
