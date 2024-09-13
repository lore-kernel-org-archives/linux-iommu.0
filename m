Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA54A07
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192017; cv=none; b=otirQ2c2gjnaUs+wXr+fiBzafU8cu0N+eM+LVJ7ldLMZUxawIEyWk+du4+OQ2fFwhHJo8KEM1OcNJO3u16XkAw5n3f3+Rs21CEG9jk9psZmpZCPTbR+pb8lKpqkPDL5WxevvZknHOuqCjfH2qRpFTle+Z/MQq9iGVJDNLoaa4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192017; c=relaxed/simple;
	bh=6OfhCmkHFtT3tqlm7qzTod2pz5JLojTDLlUiKwepWAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t+Ikno18WDOG7ssNy/K8hGd3F0pommgCJsULe3l+oOxu46DCTv8zfSToKEZc/A/SxbEv981ZZyZlfHWFKATwY/L7qTOxhcadAescKeeWI7iSfp9JAQXds3ymbV6c21ZAM4CcCFoq0jb/Oq/PS58nNUHKrr/dH9a2g0+6BKxW+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSjBs+Tk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSjBs+Tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726192016; x=1757728016;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6OfhCmkHFtT3tqlm7qzTod2pz5JLojTDLlUiKwepWAY=;
  b=lSjBs+TkNxO6eRHqradarMtnUOcW+eu/RMUViXawkpvHeShiOoUzblPe
   KV3Wr3RHcEr862YzDvfWbSaXNYZUrgD/wUaQ9mf8/slPDncoCqwDqjqEl
   EEuYPVcJyznN6ZMKQwYydEXyaL9NjUu+ojMZK2sbXXDdiV2YIxOptMoqA
   LEFfvrBgjIf9rDQhvwG7X5PukxZtLPK/Q5cDPDyZIt4hCQPLZsUuu7TTl
   kZ+pI+U8ja2OzWKK9f2DTXWukPxJLoKQpkJSKTlTgvvLuy+3ySbzuE4sT
   zhtG9ekHhWig5o13vC7nQzXJr+Y0OQMe7NmcGP1DEmEtAXMNcIiVQ419V
   w==;
X-CSE-ConnectionGUID: 2N3NlgYCQoKgv4j64uAQDw==
X-CSE-MsgGUID: FUQaWbpKRwadxM/0G05lYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35748672"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="35748672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 18:46:55 -0700
X-CSE-ConnectionGUID: 8wI9FEvuT8mmPXeyHeDxFw==
X-CSE-MsgGUID: ivS5xelyTSeoKWKOEjHM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="105370471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 12 Sep 2024 18:46:52 -0700
Message-ID: <08e6739e-762f-4552-adbe-52259747c813@linux.intel.com>
Date: Fri, 13 Sep 2024 09:42:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130427.10119-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:04 PM, Yi Liu wrote:
> @@ -4325,24 +4363,18 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>   						     dev, pasid);
>   	if (ret)
> -		goto out_unassign_tag;
> +		goto out_undo_dev_pasid;
>   
> -	dev_pasid->dev = dev;
> -	dev_pasid->pasid = pasid;
> -	spin_lock_irqsave(&dmar_domain->lock, flags);
> -	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> -	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +	if (old)
> +		domain_remove_dev_pasid(old, dev, pasid);
>   
>   	if (domain->type & __IOMMU_DOMAIN_PAGING)
>   		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
>   
>   	return 0;
> -out_unassign_tag:
> -	cache_tag_unassign_domain(dmar_domain, dev, pasid);
> -out_detach_iommu:
> -	domain_detach_iommu(dmar_domain, iommu);
> -out_free:
> -	kfree(dev_pasid);
> +
> +out_undo_dev_pasid:
> +	domain_remove_dev_pasid(domain, dev, pasid);
>   	return ret;
>   }

Do you need to re-install the old domain to the pasid entry in the
failure path?

Thanks,
baolu
