Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F161C05;
	Thu, 30 Mar 2023 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680158528; x=1711694528;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gn+qFcyVhmhsUaueh9YWCs/Iyn5ar9YHFrSAcq0taU4=;
  b=ceNqXDjMoCocbD7qaeGEWrYpyYywMtZmWzajvqrT9kSGLAMorYhqOm5M
   94aiqzaOOWqJHwkN6S7Om9AQgAdwJqp65liXfpk5/xD9jg+3ipA1nHdox
   k4i9rXxBdr0/ZVBxYpjKBflOBT/nN7jG60FdbE1Tc6dxheARJX6KdgsED
   X2F8GqMSdu2sq1+k8FMsw7fqdWDocmtjvw00T9OST6tMYwN9fKdJLoBH2
   r1yWEK3NgXvfHef8WzlRf5DBIoLMnfwRQkQl+YuQxN6r2jgTjEdgS4KA4
   aSzbqkpIWD66QFuEhzvKmZ/e4gEF9qVikmYXTPRKkXimswSUPS17I5ZgA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339807291"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="339807291"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634758620"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634758620"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 23:42:03 -0700
Message-ID: <5a249f94-7742-a2c8-2eff-88821783a6f2@linux.intel.com>
Date: Thu, 30 Mar 2023 14:42:20 +0800
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
Subject: Re: [PATCH v2 07/14] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> It should always attach to the current group->domain, so don't take in a
> domain parameter. Use the __iommu_device_set_domain() common code to
> handle the attach.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index af3af752c255e4..c68cf551d05dc4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -105,6 +105,10 @@ enum {
>   	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
>   };
>   
> +static int __iommu_device_set_domain(struct iommu_group *group,
> +				     struct device *dev,
> +				     struct iommu_domain *new_domain,
> +				     unsigned int flags);
>   static int __iommu_group_set_domain_internal(struct iommu_group *group,
>   					     struct iommu_domain *new_domain,
>   					     unsigned int flags);
> @@ -405,18 +409,10 @@ static bool iommu_is_attach_deferred(struct device *dev)
>   	return false;
>   }
>   
> -static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
> +static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
>   {
> -	struct iommu_domain *domain = data;
> -
> -	lockdep_assert_held(&dev->iommu_group->mutex);
> -
> -	if (iommu_is_attach_deferred(dev)) {
> -		dev->iommu->attach_deferred = 1;
> -		return 0;
> -	}
> -
> -	return __iommu_attach_device(domain, dev);
> +	return __iommu_device_set_domain(group, dev, group->domain,
> +					 IOMMU_SET_DOMAIN_WITH_DEFERRED);

Just out of curiosity, why is this group->domain instead of
group->default_domain?

>   }
>   
>   int iommu_probe_device(struct device *dev)
> @@ -449,7 +445,7 @@ int iommu_probe_device(struct device *dev)
>   	 * attach the default domain.
>   	 */
>   	if (group->default_domain && !group->owner) {
> -		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
> +		ret = iommu_group_do_dma_first_attach(group, dev);
>   		if (ret) {
>   			mutex_unlock(&group->mutex);
>   			iommu_group_put(group);
> @@ -1117,7 +1113,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   	mutex_lock(&group->mutex);
>   	list_add_tail(&device->list, &group->devices);
>   	if (group->domain)
> -		ret = iommu_group_do_dma_first_attach(dev, group->domain);
> +		ret = iommu_group_do_dma_first_attach(group, dev);

I am wondering whether we need to do dma first attach here.

iommu_group_add_device() is called from

1) drivers/vfio/group.c
    The deferred attachment is only used for kdump. In the kdump capture
    kernel, vfio should not be used. Or not?

2) arch/powerpc/kernel/iommu.c
    Is powerpc iommu implementation compatible with the generic IOMMU
    framework and provide a is_attach_deferred op? If not, no need for
    dma first attach either.

If above are true, perhaps we could simply call
__iommu_group_set_domain() here?

>   	mutex_unlock(&group->mutex);
>   	if (ret)
>   		goto err_put_group;

Best regards,
baolu
