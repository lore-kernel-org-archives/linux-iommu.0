Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62936A008
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162078; cv=none; b=loJBhWciANwdeeyFxye+pcnuyw+dgsbxqSOvHfZzpglzYWaXrrY8nxi4MjhY7p5fHsNxY8+WA61zUQgSn7cVcmwHk6KBkd17ZTs5GpOqLy59EdqVT2dM8Il75WuhhtkHHoF0Tf9Ne+l9ipfI1i8K7r8Jt0xgXSQvvY+U9L8CHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162078; c=relaxed/simple;
	bh=yS34eCWhJevPo3JfyA1B+jCS3iWnz5mtqUIcRXUUaFg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G9lqsqTVV36/1mDDvr5Vl/bdMzs3CjNLMdAm3oKnsH4hJf6qulFEEr1afk5Volx+qkWH9AxYLbJT1lIYBrdsf5pqjnIhoxBQpYHnWnGT1Pj1WAg54EbGA3WDOIKtLKAjOLUBaI1GHeVuiG8EawZ1DuHrck+ZtshBhjJB6DegKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTSYig/T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTSYig/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778162076; x=1809698076;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yS34eCWhJevPo3JfyA1B+jCS3iWnz5mtqUIcRXUUaFg=;
  b=RTSYig/TdDhWDIhKy7IYr/xcwmVAhMjtlaGcOWNKa4m94XQ0YbpyS9i4
   cma9KWzeXnBTJsOTBym4Uj0Z3YKbD5mhk9F6mfYJNP1V6QC4E1osJjzPO
   Tp0gFaek6tSXS9wGVm+tkIugGYQBFFm+4j1amEBaLvqUnJB31CE1IxADA
   3ONt+FN13EwRoPU4z3ERKZfOGqphGTFZvYuVMS39ldK6BzE/hq62shDOU
   MTqf2140Yqee1PS2hawr8tiL9EMUE8Xt/BSe4cQqDHD3LK1m/VUlGP4uQ
   69Bp8Qi3+QS2B4FX8n6qJeqUVjiI4IoimAzR9Cgle53XL1yM+EWWMLZI5
   g==;
X-CSE-ConnectionGUID: OQufqQ33RX2gJop6vIh2jw==
X-CSE-MsgGUID: +p98vfSiRAqJtB3kLT6Lew==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96680226"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="96680226"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:54:35 -0700
X-CSE-ConnectionGUID: Tn+PfUXZQfas1ItJE7XPnA==
X-CSE-MsgGUID: bX3fTkKbQ0q/bpv5cjjxUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="231929933"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:54:30 -0700
Message-ID: <a88649ec-de69-43ed-a364-dcbfef09dfa6@linux.intel.com>
Date: Thu, 7 May 2026 21:54:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 10/16] iommu: Restore and reattach preserved domains to
 devices
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-11-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260427175633.1978233-11-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2026 1:56 AM, Samiullah Khawaja wrote:
> Restore the preserved domains by restoring the page tables using restore
> IOMMU domain op. Reattach the preserved domain to the device during
> default domain setup. While attaching, reuse the domain ID that was used
> in the previous kernel. The context entry setup is not needed as that is
> preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      | 49 ++++++++++++++------
>   drivers/iommu/intel/iommu.h      |  3 +-
>   drivers/iommu/intel/nested.c     |  2 +-
>   drivers/iommu/iommu.c            | 61 ++++++++++++++++++++++++-
>   drivers/iommu/liveupdate.c       | 78 ++++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h | 50 ++++++++++++++++++++
>   6 files changed, 224 insertions(+), 19 deletions(-)

Please split the changes in the Intel iommu driver and the iommu core
into different patches.

> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4118a0861f38..b90757164cd8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1031,7 +1031,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>   	return true;
>   }
>   
> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
> +			int restore_did)

How about using a new helper for restored domain? For example,

	int domain_reattach_iommu(...)

or

	int domain_restore_iommu(...)

>   {
>   	struct iommu_domain_info *info, *curr;
>   	int num, ret = -ENOSPC;
> @@ -1051,8 +1052,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>   		return 0;
>   	}
>   
> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
> +	if (restore_did >= IDA_START_DID)
> +		num = restore_did;

For a preserved domain ID, do we need to check whether it has been
reserved from the ida pool?

> +	else
> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>   	if (num < 0) {
>   		pr_err("%s: No free domain ids\n", iommu->name);
>   		goto err_unlock;
> @@ -1320,10 +1324,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
> +	struct device_ser *device_ser = NULL;
>   	unsigned long flags;
>   	int ret;
>   
> -	ret = domain_attach_iommu(domain, iommu);
> +	device_ser = dev_iommu_restored_state(dev);
> +
> +	ret = domain_attach_iommu(domain, iommu,
> +				  dev_iommu_restore_did(dev, &domain->domain));

What is the expected behavior if there is a mismatch between the
restored state and the availability of a domain ID? Specifically, if
device_ser is found but dev_iommu_restore_did() fails (returns -1), how
should the driver proceed in that case?

>   	if (ret)
>   		return ret;
>   
> @@ -1336,16 +1344,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   	if (dev_is_real_dma_subdevice(dev))
>   		return 0;
>   
> -	if (!sm_supported(iommu))
> -		ret = domain_context_mapping(domain, dev);
> -	else if (intel_domain_is_fs_paging(domain))
> -		ret = domain_setup_first_level(iommu, domain, dev,
> -					       IOMMU_NO_PASID, NULL);
> -	else if (intel_domain_is_ss_paging(domain))
> -		ret = domain_setup_second_level(iommu, domain, dev,
> -						IOMMU_NO_PASID, NULL);
> -	else if (WARN_ON(true))
> -		ret = -EINVAL;
> +	if (!device_ser) {
> +		if (!sm_supported(iommu))
> +			ret = domain_context_mapping(domain, dev);
> +		else if (intel_domain_is_fs_paging(domain))
> +			ret = domain_setup_first_level(iommu, domain, dev,
> +						       IOMMU_NO_PASID, NULL);
> +		else if (intel_domain_is_ss_paging(domain))
> +			ret = domain_setup_second_level(iommu, domain, dev,
> +							IOMMU_NO_PASID, NULL);
> +		else if (WARN_ON(true))
> +			ret = -EINVAL;
> +	}
>   
>   	if (ret)
>   		goto out_block_translation;
> @@ -3170,6 +3180,15 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
>   	struct intel_iommu *iommu = info->iommu;
>   	int ret = -EINVAL;
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/*
> +	 * Restored IOMMU domains are already attached to the device and can
> +	 * only be freed. So no need to check the compatibility.
> +	 */
> +	if (iommu_domain_restored_state(domain))
> +		return 0;
> +#endif
> +
>   	if (intel_domain_is_fs_paging(dmar_domain))
>   		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
>   	else if (intel_domain_is_ss_paging(dmar_domain))
> @@ -3647,7 +3666,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
>   	if (!dev_pasid)
>   		return ERR_PTR(-ENOMEM);
>   
> -	ret = domain_attach_iommu(dmar_domain, iommu);
> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>   	if (ret)
>   		goto out_free;
>   
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index b0ec0b471a43..8e37acf7de12 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1182,7 +1182,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>    */
>   #define QI_OPT_WAIT_DRAIN		BIT(0)
>   
> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
> +			int restore_did);
>   void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>   void device_block_translation(struct device *dev);
>   int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 2b979bec56ce..6e13f697b463 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>   		return ret;
>   	}
>   
> -	ret = domain_attach_iommu(dmar_domain, iommu);
> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>   	if (ret) {
>   		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
>   		return ret;

Thanks,
baolu
