Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7797C
	for <iommu@lists.linux.dev>; Sat,  4 Feb 2023 03:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675481868; x=1707017868;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7/sGV1UG/zr2CwnREojEupH6s+d9jTNzHbuzjM+j/sc=;
  b=ZT6IAQe9KaLaLl64PW5oY+uNccaCcoy+Ev3lAdk1SmIqXnBYEIxzym87
   0Usy2NfNoGN4vKe2dNBrzk8JjQVhCjigIRR5vfsE8oOx0HYLf0AHK4fYX
   90Ov7Lm6iIBnEjUrXanPpuABx9jQH5o1foC4F62v48M/MWK3Be3Kw1ovr
   myXLrt/4olYzV8j/RwhlQW5JlocG4WHSDvm6PSKpNDajlQlTJ2mnM0uZl
   9SiDI8XZe1MDZnx8B91PYapornqEI1wn/twVvouc6xcAbm8HIw5apecLP
   X3Te67lfp7NEuQeknqspBglBL4aeL/Ii/k37z8yomhN/Lqi+voeuSvAju
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330204019"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="330204019"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 19:37:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="839809451"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="839809451"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.174.222]) ([10.249.174.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 19:37:46 -0800
Message-ID: <f5af1701-1707-23c8-3f62-ad4ffae21387@linux.intel.com>
Date: Sat, 4 Feb 2023 11:37:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v2 1/3] iommu: Attach device group to old domain in error
 path
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20230203173623.18308-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230203173623.18308-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/4 1:36, Vasant Hegde wrote:
> iommu_attach_group() attaches all devices in a group to domain and then
> sets group domain (group->domain). Current code (__iommu_attach_group())
> does not handle error path. This creates problem as devices to domain
> attachment is in inconsistent state.
> 
> To recover from this situation, we need force attaching all devices back
> to the old domain. This patch introduces `force` parameter to
> __iommu_group_set_domain() so that we can attach devices back to old
> domain.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..e58683cd3bf7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
>   static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain);
> +				    struct iommu_domain *new_domain,
> +				    bool force);
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev);
>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
>   	else
>   		new_domain = group->default_domain;
>   
> -	ret = __iommu_group_set_domain(group, new_domain);
> +	ret = __iommu_group_set_domain(group, new_domain, false);
>   	WARN(ret, "iommu driver failed to attach the default/blocking domain");
>   }
>   
> @@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   
>   	ret = __iommu_group_for_each_dev(group, domain,
>   					 iommu_group_do_attach_device);
> -	if (ret == 0)
> +	if (ret == 0) {
>   		group->domain = domain;
> +	} else {
> +		/*
> +		 * To recover from the case when certain device within the
> +		 * group fails to attach to the new domain, we need force
> +		 * attaching all devices back to the old domain.
> +		 */
> +		__iommu_group_set_domain(group, group->domain, true);

Adding force parameter to __iommu_group_set_domain() looks strange. Does
it work if we make above line like below?

		/*
		 * To recover from the case when certain device within the
		 * group fails to attach to the new domain, we need force
		 * attaching all devices back to the old domain. The old
		 * domain is compatible for all devices in the group,
		 * hence the iommu driver should always return success.
		 */
		old_domain = group->domain;
		group->domain = NULL;
		WARN(__iommu_group_set_domain(group, old_domain),
		     "iommu driver failed to attach a compatible domain");

Best regards,
baolu
