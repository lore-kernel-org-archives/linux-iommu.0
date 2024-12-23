Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEC184E
	for <iommu@lists.linux.dev>; Mon, 23 Dec 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734922416; cv=none; b=iE/SSPwl0St6c//4fGLOtzmHB6Us2w7Mxc5DLHv6Cgh9zbN9MIQ72D94uCer4tpwCE21pS0ORY/c7aIdHeo8Gur3Ga+C6OAjsir7BkUXgEb7rwYD9y7FC559XuKI5P43Q/KFJWVObNAIGBYqKXUai5q+dxqAuy0iqLCrKUI7m9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734922416; c=relaxed/simple;
	bh=nCn4iWykc+wsnZcRPakoyhlpnV4vpCfSCvvr8jm5dYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTcsI9FRu42Qrzw5RQ73fjVx7vNaSdminwXL2TpXGy/AruFMRr5x2vmunRa3SDaDQ/1lopq/wF4dd/yj8dR0ZQ1QLz0nv7NwKdvlwY4W+A9JZ9PoYmhJ82KXLTt/GEbf+RhprQ9apJE1HW4nNP+PV2MuSuSn0ZfkKyDGz81FTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf8rBQlk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf8rBQlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734922415; x=1766458415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nCn4iWykc+wsnZcRPakoyhlpnV4vpCfSCvvr8jm5dYo=;
  b=Bf8rBQlksy2KMYlf0eDeLeeNNyGTOrWCXTgeA2raP4yCZf89NePRgOv9
   FfKgwjGjtgJgmWy8OsxT6cERduQhD9V/RqPryEbN7Tj61qMgnB12E9fCD
   yDEeRm4KLJlLyQ8OmmiobZ7N5DAM4nJEv6tLhBC+4k1nSR4tzjsn+0W2a
   k5o9FVz2AVmqP41qjzPIvlP0Jsos8fCwr8lIib9aMfEuJ634OOzcvMBAt
   13ViruoOSbou7JhN9RTB/4WUpABOcoWBpUXtSTBYE7+wAzJ2Rq3k0pnkO
   N46SAfAFBTl7nrfRRAKOrElysBSHnxZTCkfiuBE3ILiDVKPiBxFt3T+HA
   g==;
X-CSE-ConnectionGUID: Ppd4HullSXG3eDPVzFQIZQ==
X-CSE-MsgGUID: rYt9euSERu6ww12ITEjMvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="45879025"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="45879025"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 18:53:34 -0800
X-CSE-ConnectionGUID: JON1ACDoQRC1WYeBStFfkg==
X-CSE-MsgGUID: TyY8mjSGRtqndXXuTmYEIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="103957310"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 18:53:32 -0800
Message-ID: <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
Date: Mon, 23 Dec 2024 10:51:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241219132746.16193-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 21:27, Yi Liu wrote:
> Intel iommu driver just treats it as a nop since Intel VT-d does not have
> special requirement on domains attached to either the PASID or RID of a
> PASID-capable device.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c  | 3 ++-
>   drivers/iommu/intel/nested.c | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cd5e339fd5bb..0a622a89d876 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3347,7 +3347,8 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>   	bool first_stage;
>   
>   	if (flags &
> -	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
> +	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +	       IOMMU_HWPT_ALLOC_PASID)))
>   		return ERR_PTR(-EOPNOTSUPP);
>   	if (nested_parent && !nested_supported(iommu))
>   		return ERR_PTR(-EOPNOTSUPP);
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index aba92c00b427..6ac5c534bef4 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
>   	struct dmar_domain *domain;
>   	int ret;
>   
> -	if (!nested_supported(iommu) || flags)
> +	if (!nested_supported(iommu) || flags & ~IOMMU_HWPT_ALLOC_PASID)
>   		return ERR_PTR(-EOPNOTSUPP);
>   
>   	/* Must be nested domain */

It's better to abort and fail a domain allocation when
IOMMU_HWPT_ALLOC_PASID is set but the iommu lacks pasid support?

Another related consideration is the support for page faults in nested
domains once PASID is available in user space. Would it be reasonable to
support page faults for nested domains?

If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?

--
baolu
