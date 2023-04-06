Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED9A21;
	Thu,  6 Apr 2023 03:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680752405; x=1712288405;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bd4lSU0TDGlzogkI2gzL0DzWzBcpIdg7ITg7I+ReG2Y=;
  b=m0gRW5/+oW5TwOeZIbsECR9Lc0zkNwVeTkowme3FTm+Fl5s4XCySHRPk
   wGAd/3Wx6C2R1/c3rpAOH75bO8GfQnahqRMJPVii4sUJ0DUEtZJrzFxNd
   L3OVkiEDac1JKeyWGoFvDB3VV9GoAtNa4YeU9ugh8e5jl98sLwPqa3Unh
   uxR8HTqjTXUZQZ9ztyZgOTnTzD1uwwR2KibH54xkswd/rBANrCucBYxq1
   C9v7f4GxMRBN5qlRyGAtZUXqfzFVKhpbL0AcYc8v89PzST7GavJ485sqg
   EC3I4mkTGPs9Ik1LYD3rEYN54Ghkf+nwaBqVxY2BB2NeQP/LLZ7tXvYt6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="407721844"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="407721844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 20:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="689523749"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="689523749"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2023 20:40:01 -0700
Message-ID: <c7d5273e-5621-b681-bd6f-2e044e6db6ff@linux.intel.com>
Date: Thu, 6 Apr 2023 11:40:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 13/17] iommu: Revise iommu_group_alloc_default_domain()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <13-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <13-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/23 7:38 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8623d3edc61014..5f6aecfd92c657 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -91,8 +91,9 @@ static const char * const iommu_group_resv_type_string[] = {
>   
>   static int iommu_bus_notifier(struct notifier_block *nb,
>   			      unsigned long action, void *data);
> -static int iommu_alloc_default_domain(struct iommu_group *group,
> -				      struct device *dev);
> +static struct iommu_domain *
> +iommu_group_alloc_default_domain(struct iommu_group *group, int req_type);
> +static int iommu_get_def_domain_type(struct device *dev);
>   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   						 unsigned type);
>   static int __iommu_attach_device(struct iommu_domain *domain,
> @@ -444,13 +445,16 @@ int iommu_probe_device(struct device *dev)
>   		 * support default domains, so the return value is not yet
>   		 * checked.
>   		 */
> -		iommu_alloc_default_domain(group, dev);
> -		if (group->default_domain) {
> -			iommu_create_device_direct_mappings(group, dev);
> -			ret = __iommu_group_set_domain_internal(
> -				group, group->default_domain,
> -				IOMMU_SET_DOMAIN_WITH_DEFERRED);
> +		group->default_domain = iommu_group_alloc_default_domain(
> +			group, iommu_get_def_domain_type(dev));
> +		if (!group->default_domain) {
> +			ret = -EINVAL;
> +			goto err_unlock;
>   		}

There are still some drivers that don't support default domains. It was
allowed previously, but above seems to change that behavior. The
iommu_probe_device() fails now on those platforms. Or perhaps I
overlooked anything?

> +		iommu_create_device_direct_mappings(group, dev);
> +		ret = __iommu_group_set_domain_internal(
> +			group, group->default_domain,
> +			IOMMU_SET_DOMAIN_WITH_DEFERRED);

Best regards,
baolu
