Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AF1C32
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097099; x=1711633099;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sX++t6M+j5mZ0QWRv6dZzjcL61d/Jt32QU3v/r7J0fA=;
  b=AJvowT4bwJ9yI8CpA/5P/4I1sDOJkjYMM1DpY2eDGPoWmagN1tZM+P6y
   n60fYJm1J/I0IbVBu2dbow39kr+0nQCm89DAkjP2idjwOZZiV75+gbcMK
   XbotueRxj1m/LLumMS0O/K5d0O/wCi9woSqgt+WUxTtLWteJw6TpOrf6b
   wLyFSAvgEqDCnb4qY0AyXbIOn1LwVvzIxk8SRzNbCGlZ5GurH22ASLwRR
   61GKsF8Cprbe1lUQ1BSeRZMRVCNyThj4pSYyHMtbvhUVgJHrigQBpD8k2
   n2GvDO7kwdHllSZM5RcXzOUSnLcduMMWxMqMrHflRDb2dAN/g5ju7OXy3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321271671"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="321271671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773582809"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773582809"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.217]) ([10.254.214.217])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:38:17 -0700
Message-ID: <96c82f7e-89ab-afc4-32e8-10fbaca3be2a@linux.intel.com>
Date: Wed, 29 Mar 2023 21:38:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/vt-d: Fix quoted string split across lines
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-4-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230329124654.2698853-4-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/29 20:46, Tina Zhang wrote:
> This patch resolves checkpatch warnings for intel iommu driver.
> 
> WARNING: quoted string split across lines
> 	pr_err("%s: iommu width (%d) is not "
> 		"sufficient for the mapped address (%llx)\n",

We should have avoided this code style at the beginning. But it already
appears in Linus's tree. It doesn't make more sense to fix it now.

Best regards,
baolu

> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 085d31a77f6f..286bb17973a4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4294,8 +4294,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
>   		/* check if minimum agaw is sufficient for mapped address */
>   		end = __DOMAIN_MAX_ADDR(dmar_domain->gaw) + 1;
>   		if (end < max_addr) {
> -			pr_err("%s: iommu width (%d) is not "
> -			       "sufficient for the mapped address (%llx)\n",
> +			pr_err("%s: iommu width (%d) is not sufficient for the mapped address (%llx)\n",
>   			       __func__, dmar_domain->gaw, max_addr);
>   			return -EFAULT;
>   		}

