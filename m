Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4F185D;
	Thu, 30 Mar 2023 06:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157429; x=1711693429;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QhAC1vwDMW1GIq+NTKB3C3Zw1A2OK5e0DFzcAoTbNpM=;
  b=Zh2YJBWQG/R7EzWRKAhD7HtsXWz+4RO8KKwq6PUYZqHuSCU6iqWy0vOE
   lSAx8h4n+twoLtXgMHJ06lW3ldaw2GDs9/FUhnBHrfOf0aN1Eh+HTwMY9
   ekMvpuSwt2SpgQANrih8SAhlK1bWLdh+zpSveKQ+kDInnlWp06Oj26zk4
   8q9zR18077XvQp+QEH9p6oFHdUG2Bf6cXOv1wRC/OTpgnnaPABvpfovDj
   w+JPWPps4wCXM38XC4vhuHSlEbErYYszGaN01+z1Acif5mayhEBIN++rC
   RASLWmvk9jZMmiuF4MkpS0CD75AnhkbqGweuNnYMeybHKkXRZ2h6EaqKq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="325003280"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="325003280"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773866215"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="773866215"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2023 23:23:45 -0700
Message-ID: <fc04d104-9680-38bb-691f-34594a39ef8f@linux.intel.com>
Date: Thu, 30 Mar 2023 14:24:02 +0800
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
Subject: Re: [PATCH v2 05/14] iommu: Use __iommu_group_set_domain() in
 iommu_change_dev_def_domain()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <5-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> This is missing re-attach error handling if the attach fails, use the
> common code.
> 
> The ugly "group->domain = prev_domain" will be cleaned in a later patch.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
