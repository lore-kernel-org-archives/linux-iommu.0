Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8D1C04
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 06:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686724114; x=1718260114;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1wKswdQWTmMLrmurBwSiSGa9SMCPySL7GQdL1voI1SM=;
  b=O0MwPrcrYvQD5GpPbzv89LF1BItu4PuAXhOhtgraRDyl+JfSErOZ7YG2
   ANHEMlQ3z3h0GqWPwTu+iRaKopShFWAnNX6tf6ABVv5QX5ic+nucdDfXc
   yO3aReKeicZbcKPDEJki79yTe75WSN69nTAT3KP3UTdjq1ux4AiOz/GSz
   kYMs3+d9hch23Afd4yr2kB7gRxlIyu4befwC49Q41weYVlSpimaHeSUCC
   j0Nb97jIDhdmpNAntzTwVcfEzr7FmdtDF5TI0Yll+dJqUEZ+df8jJ9YKQ
   puPmaIm2/eAsBpaUvghUVm1V7Knbfi1yMCdxRBdJAnFgXwWOUleYjoQCt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444906234"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444906234"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662277524"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="662277524"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2023 23:28:30 -0700
Message-ID: <851e7760-94e2-9691-f059-e48aac9d51ca@linux.intel.com>
Date: Wed, 14 Jun 2023 14:27:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20230614055627.27286-1-vasant.hegde@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230614055627.27286-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/23 1:56 PM, Vasant Hegde wrote:
> Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> accidently restored "group->domain" to "old_domain" while keeping
> "group->default_domain" to new domain. Also freed new domain.
> 
> This works fine during boot as 'old_domain' is NULL. But if we try
> change domain via sysfs using below command then kernel crashes with
> "kernel NULL pointer dereference".
> 
> Change domain command :
>    - Assumed we have single device in the IOMMU group

Nit: The requirement for singleton group has been removed.

>    - unbind device driver
>    - echo "<dom type>" > /sys/kernel/iommu_groups/<group id>/type
> 
> Fix above described issue by handling error path properly.
> 
> Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Hi Joerg,
>    This patch is on top of iommu/next branch.
> 
> -Vasant
> 
>   drivers/iommu/iommu.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9e0228ef612b..d21d0a217bdf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2880,7 +2880,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   	}
>   
>   	/* We must set default_domain early for __iommu_device_set_domain */

Is the above comment still relevant? If yes, this fix seems to be
problematic. Or no?

> -	group->default_domain = dom;
>   	if (!group->domain) {
>   		/*
>   		 * Drivers are not allowed to fail the first domain attach.
> @@ -2896,7 +2895,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   		ret = __iommu_group_set_domain(group, dom);
>   		if (ret) {
>   			iommu_domain_free(dom);
> -			group->default_domain = old_dom;
>   			return ret;
>   		}
>   	}
> @@ -2915,16 +2913,20 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   		}
>   	}
>   
> +out_free:
> +	group->default_domain = dom;
> +
> +	if (old_dom) {
> +		iommu_domain_free(old_dom);
> +		old_dom = NULL;
> +	}
> +
>   err_restore:
>   	if (old_dom) {
>   		__iommu_group_set_domain_internal(
>   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>   		iommu_domain_free(dom);
> -		old_dom = NULL;
>   	}
> -out_free:
> -	if (old_dom)
> -		iommu_domain_free(old_dom);
>   	return ret;
>   }
>   

It's better to split the error path from the successful one.

Best regards,
baolu
