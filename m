Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237F1BC3C
	for <iommu@lists.linux.dev>; Wed,  3 Apr 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113539; cv=none; b=rFAUbRnVGYmnOeG5hNZyjepYaoPNRc/auZRiv79NZFxfppUc/CZ2/HPv90YsV+TcXITihA53cIYabLbEtm8D1l0YSwA8xmdPfuQAS5hSAEXjFxYIDYrs7Ve25h1zgnEQa8mzihjj8rLhr0cLjGLL2EkH29OElLtTqgpQ5Xi7/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113539; c=relaxed/simple;
	bh=70J3J67+9Xjl+EJye3ot59PHZ/kZek8NWu7BYW+0et4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dkSuan1b59hZhFi3j2oVrUrl5DqUYJWQjn2UEzw5mg8jnFcmZblWxLjHNJOhg0CQCO2AExketDXBh09jJ5JicELUJikSdEL391RVowiEiocgn3LL5zwKw0oW3Lf9eYHQOk4lBLtURG1bjksjUzvkjJRpbzvEXBn+d9Ub3f17090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGRNNlXE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGRNNlXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712113537; x=1743649537;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=70J3J67+9Xjl+EJye3ot59PHZ/kZek8NWu7BYW+0et4=;
  b=PGRNNlXE8+qxWwWIM20qJ325LfLkvfwDXhxqkAv/sfsJ6RysrJbC39Xl
   0ZSpmEJW0lvypKFsDHCjr/+7sPtl2Um5qbkTl1JJ3U7jV6HiLjXXsuJFh
   pglj/F6c7lzsDAEHWi/rSjp0skveS2krWTTRoD9OHzFlKMATqjslcPaph
   lRsFAbkVRo7npd0RHx8nt2D1EQaTUBO674jDpv2eZMd7LLoTfxGY//Ux3
   jzsGYR5TFtMyW/Fl9pHUt8TLcddx9+ch3lKNHzcDI/KEsqMFMa2H/FhAP
   bDJLSUZta+eShA+jnFSbcc9nsLoxwRSbe8WLRXxXkGiklQragknGJVxBy
   g==;
X-CSE-ConnectionGUID: 5QQXEEmWTlymIoVOPlnmWQ==
X-CSE-MsgGUID: Ey/KVBX7RiyBb7KMrUt3iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="32715367"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="32715367"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 20:05:36 -0700
X-CSE-ConnectionGUID: OWzzfIt/SV2EeoORmeGw3A==
X-CSE-MsgGUID: xZNcHIlURZCqM+t7fUzbLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22980463"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 20:05:33 -0700
Message-ID: <ffa58b7e-aada-4ff7-a645-f946e658785a@linux.intel.com>
Date: Wed, 3 Apr 2024 11:04:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 robin.murphy@arm.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 2/2] iommu: Pass domain to remove_dev_pasid() op
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240328122958.83332-1-yi.l.liu@intel.com>
 <20240328122958.83332-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240328122958.83332-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 8:29 PM, Yi Liu wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 2e925b5eba53..40dd439307e8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -578,7 +578,8 @@ struct iommu_ops {
>   			      struct iommu_page_response *msg);
>   
>   	int (*def_domain_type)(struct device *dev);
> -	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
> +	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
> +				 struct iommu_domain *domain);

Previously, this callback said "Hey, remove any domain associated with
this pasid".

Now this callback changes to "Hey, please remove *this* domain from the
pasid". What the driver should do if it doesn't match the previously
attached domain, or the pasid hasn't been attached to any domain?

Best regards,
baolu
