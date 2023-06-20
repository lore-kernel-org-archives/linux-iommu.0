Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393311119
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 06:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687242789; x=1718778789;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3JpUxoqpTN9wZrfp3qIPYCFhBF2d2LhfqEyYtHZ1p0=;
  b=HyCOBSSHweG16TJ2aB77XcA7A6OtvtrKUJbtfyIxYiESDxBDzUouuEcD
   xkVzzXcZUIkzj5qnMIRTlLaL8alWciRSqvAYgQKiT5ufPIwieinJtrTxV
   R4wI16bQDNzy17TGltxZPy7C/q5MB7GeXpx/jkMS7Z3O+kUJ1X6O9Yq+8
   D5JL5eF670QtIKp8d2Q5oFmc0YLIaga9Vz1kt+GdS2nYu2ncXq/xs5ZJI
   pGZFETD132BfRnNxio1tj95t2FoFv++Bl3IDAa9R05z5Qp8CeTt3jjvgf
   760PawOsXhTxdDEU4k/+LXpc186JdvXf7mpRNnW3lCzPa3qKpK3lGMhC8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="388961579"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="388961579"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="717116806"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="717116806"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2023 23:32:59 -0700
Message-ID: <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>
Date: Tue, 20 Jun 2023 14:31:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20230619084945.6427-1-vasant.hegde@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230619084945.6427-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/23 4:49 PM, Vasant Hegde wrote:
> Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> accidently restored "group->domain" to "old_domain" while keeping
> "group->default_domain" to new domain. Also freed new domain.
> 
> This works fine during boot as 'old_domain' is NULL. But if we try
> change domain via sysfs using below command then kernel crashes with
> "kernel NULL pointer dereference".
> 
> Change domain command :
>    - Go to /sys/kernel/iommu_groups/<group id>/
>    - Unbind device driver for all devices in the group
>    - echo "<dom type>" > /sys/kernel/iommu_groups/<group id>/type
> 
> Fix above described issue by handling error path properly.
> 
> Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Changes in v2:
>    - Addressed review comments from Baolu
> 
> @Joerg,
>    This patch applies on top of iommu/next branch.
> 
> -Vasant
>   drivers/iommu/iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9e0228ef612b..e74e45f42c75 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2915,10 +2915,15 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   		}
>   	}
>   
> +	if (old_dom)
> +		iommu_domain_free(old_dom);
> +	return ret;

Add out_free tag here and remove the duplicate code at the end of this
function.

> +
>   err_restore:
>   	if (old_dom) {
>   		__iommu_group_set_domain_internal(
>   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +		group->default_domain = old_dom;
>   		iommu_domain_free(dom);
>   		old_dom = NULL;
>   	}

The err_restore branch doesn't work if old_dom is NULL. We have no means
to restore a group from a successful first-time attaching to NULL
attaching.

Or I overlooked anything?

Best regards,
baolu
