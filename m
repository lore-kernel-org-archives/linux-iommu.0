Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848929B0
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677766830; x=1709302830;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3676zTBvU6TZnvPW7IT27dMb+Hxhu8evGp71QQAk5BI=;
  b=Is3IgV8V4HOna2dAZZJRZR9Wo1zagyY74uCpWZ23pnvMpv0i7QaFH+Cl
   XH5cTuG6xIlda0Cx+eBFfWxFImYF+HiwPfw/fBJtGrzmhWMVaShIQCkqv
   /8ODhlSjgt5stm4wVKh3Cf8eR4fV4o79VPAABE6u+GZFv5V8miAb++l75
   IGW2UNh6WF3+Jn+/MFZIVezdBV7KlpiesMIGgQorCr3hrFp0PwwzcspXy
   jUQN+ar0ouPqGzGrUnZH9LqCzWnITof2cC/UzUfEA8FDG7NsKV0jIHKUg
   3P3JKPVOkvsC6T96szaUCsZne9jAqK8KpJcW3UjylMS7IvkyXJO6WEPFt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397299718"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="397299718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="739086119"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="739086119"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:11:39 -0800
Message-ID: <0afa8e6e-1676-d6a5-d679-173351fe439c@linux.intel.com>
Date: Thu, 2 Mar 2023 22:11:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Use non-privileged mode for all PASIDs
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-3-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230302005959.2695267-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/2 8:59, Jacob Pan wrote:
> For in-kernel DMA, use non-privileged access for all PASIDs to be
> consistent with RID_PASID.
> There's no need to differentiate user and kernel for in-kernel DMA. >
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a0cb3bc851ac..9e3c056e392d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2334,8 +2334,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>   	if (level != 4 && level != 5)
>   		return -EINVAL;
>   
> -	if (pasid != PASID_RID2PASID)
> -		flags |= PASID_FLAG_SUPERVISOR_MODE;

With above removed, PASID_FLAG_SUPERVISOR_MODE is not used anywhere?
Perhaps you can cleanup it to avoid dead code?

>   	if (level == 5)
>   		flags |= PASID_FLAG_FL5LP;
>   

Best regards,
baolu
