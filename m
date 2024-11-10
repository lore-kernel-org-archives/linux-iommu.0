Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D4233D62
	for <iommu@lists.linux.dev>; Sun, 10 Nov 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731211237; cv=none; b=cDifOliFHDVz8RsQE5C896TDNLtTnawe/Ty2Waq+lyUfAG/pI5U6OzmJQKhDqJYR0hQk8N/sTR1zZk4c8Kyn9b4bxrSNDrEYvHavWy4vWt1Qm1A3AJb/KUmIlzill2lrDyh+DqnUiOkRPr9ZTdYhs8irQRX/61DKz+kZE4XUNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731211237; c=relaxed/simple;
	bh=vMHtsZfDOuGXmmKCUjiSnoMbByeEwwcFbVjYpsFnV8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4vVdolLMFbbqFPJfCmSvpsu8YQQYOSjwtZRyaqbmgJfvO8a7NB/BGBFl7zz/c2MzuPbsl+/7PY6q9s67/MosqOgaCjM2kMVNVgWMP3DXHR1Jvo2F1so5iwZSWb4pFHFwCv1t3T87aZbolCLdV8uO38fBt0cpRlZkCO33Z/awJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuaS6vMm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuaS6vMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731211235; x=1762747235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vMHtsZfDOuGXmmKCUjiSnoMbByeEwwcFbVjYpsFnV8E=;
  b=PuaS6vMmMfyL/RUi9RCNL7mjrLbrIfodgcZ0zSNbBkqvsMsxli9Vuxao
   MW7+EvEQwey8/bpej63OlUycMHcIOb1uEvXzPuzclluX/nD75ttHEpu/l
   oDst+yJ0MvTMDxRpV294Xx6D5z+pn+ljWkXfbv+HqlNnRoP7NekPzam3d
   yKIUujNVjVKZXmiTbUkCSvKoHpHuY68lGE+pTzVHy7r0uP7yMIDC15496
   fq6CKDpQ7dpsolujB6JU+pb1fc6rK8zvTtdqhsvwS6jeGOa2n0Z7y96mj
   lWrHJ6E+gBaS/vEbYwFwdltIl7sCfeA4Clf2etI/oFl4qorDTrKSebKJ4
   g==;
X-CSE-ConnectionGUID: iKvnAQkaRA+wVjLuDf9DdA==
X-CSE-MsgGUID: i76xxArqSrKb2SgvG50CSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="48567429"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="48567429"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 20:00:34 -0800
X-CSE-ConnectionGUID: 4bWCHZ/hSB+dSOwJhNcppg==
X-CSE-MsgGUID: L9ExBUUsSDahdg1wT3Cktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="87091534"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 20:00:31 -0800
Message-ID: <facfee81-1b25-4b3e-aecd-38930ee41f7a@linux.intel.com>
Date: Sun, 10 Nov 2024 11:59:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] iommu: Prevent pasid attach if no
 ops->remove_dev_pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, willy@infradead.org
References: <20241108120427.13562-1-yi.l.liu@intel.com>
 <20241108120427.13562-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241108120427.13562-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 20:04, Yi Liu wrote:
> driver should implement both set_dev_pasid and remove_dev_pasid op, otherwise
> it is a problem how to detach pasid. In reality, it is impossible that an
> iommu driver implements set_dev_pasid() but no remove_dev_pasid() op. However,
> it is better to check it.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 13fcd9d8f2df..1c689e57928e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3352,17 +3352,19 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   			      struct iommu_attach_handle *handle)
>   {
>   	/* Caller must be a probed driver on dev */
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   	struct iommu_group *group = dev->iommu_group;
>   	struct group_device *device;
>   	int ret;
>   
> -	if (!domain->ops->set_dev_pasid)
> +	if (!domain->ops->set_dev_pasid ||
> +	    !ops->remove_dev_pasid)
>   		return -EOPNOTSUPP;
>   
>   	if (!group)
>   		return -ENODEV;

If group is NULL, calling dev_iommu_ops() will trigger a kernel NULL
pointer reference warning, which is unintended. If you need to check
ops->remove_dev_pasid, it should be done after the group check.

>   
> -	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
> +	if (!dev_has_iommu(dev) || ops != domain->owner ||
>   	    pasid == IOMMU_NO_PASID)
>   		return -EINVAL;
>   

--
baolu
