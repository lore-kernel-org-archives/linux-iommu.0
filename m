Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF815A5
	for <iommu@lists.linux.dev>; Wed, 20 Sep 2023 05:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695187914; x=1726723914;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ZDObok8tPCkBhY6mmZB5GJuaJNpwpqQA9IWqa6JVVc=;
  b=cIlTPRo5ZMDfKHf1PhlDW/3Dc6mw6TGdS+bLzq4valYKCBvRE9Taqrj+
   2dCnMPKEDgxax3TiNO8LAtBJBt1NKYW51avF4e2vwNSgHR9N5mPLylNDV
   gaGm6ByQLwDD1VVIInPDYx0r+Bq9muSUPZI67TSTcaYwBiwakEj7nOuF5
   ZY/8ELuwjbf+3pO4Q/K3FvMTcrgnr0AvCg5/Xp2mzti7IlbzQruAPel7H
   SKG1HAA6nB5bFBqQBIQD+TSkbRiQ4g3rt4hffY5tMUKE5ecKsyz6XHdOD
   NvaP5lTuHcdZC0qhaZoelju2MqSyVCYNJKFrYCzJPbVhy7uxvW1R755cG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365179306"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365179306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861832052"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="861832052"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2023 22:31:48 -0700
Message-ID: <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
Date: Wed, 20 Sep 2023 13:28:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230919092523.39286-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/23 5:25 PM, Yi Liu wrote:
> This adds the domain_alloc_user op implementation. It supports allocating
> domains to be used as parent under nested translation.

Documentation/process/submitting-patches.rst:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

So how about,

Add the domain_alloc_user callback to support allocating domains used as
parent under nested translation.

?

> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5db283c17e0d..491bcde1ff96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4074,6 +4074,25 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   	return NULL;
>   }
>   
> +static struct iommu_domain *
> +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
> +{
> +	struct iommu_domain *domain;
> +	struct intel_iommu *iommu;
> +
> +	iommu = device_to_iommu(dev, NULL, NULL);
> +	if (!iommu)
> +		return ERR_PTR(-ENODEV);
> +
> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	domain = iommu_domain_alloc(dev->bus);

No need to bounce between core and driver. Just,

	intel_iommu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);

and fully initialize it before return.

> +	if (!domain)
> +		domain = ERR_PTR(-ENOMEM);
> +	return domain;
> +}
> +
>   static void intel_iommu_domain_free(struct iommu_domain *domain)
>   {
>   	if (domain != &si_domain->domain && domain != &blocking_domain)
> @@ -4807,6 +4826,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.hw_info		= intel_iommu_hw_info,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> +	.domain_alloc_user	= intel_iommu_domain_alloc_user,
>   	.probe_device		= intel_iommu_probe_device,
>   	.probe_finalize		= intel_iommu_probe_finalize,
>   	.release_device		= intel_iommu_release_device,

Best regards,
baolu
