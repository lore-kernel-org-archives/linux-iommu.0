Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701A2676E8
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550355; cv=none; b=nuRdz+i5NFGrejYwAqucYpDUa4Q9bGpsdtZQeVE6z5L4i+ibtYp1qTtmmETdeqIE9hM7qQa2H/X2OLz4UmiVbakzIbI8M2PWJzurmVN0omYKNPYC+uCOS+3nv8ujyhSzBkQX5dLngEGDNwLcpu/ZDB7C8c5SCPHpwZjIcTngp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550355; c=relaxed/simple;
	bh=xE4Njoyxxxt7h5muOvaecOz2DvQhoas6HmilLX9gMOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBVWNgb5ZI00E+uaH2x+ObmbidATZ8lW8sFRdsL8ygGv6OqCAS7WCYNVBfV0cs5XiIXo9mhM36+W9ekxT9pgqiI7HUNFdxvkRnTtpp+AZ5yPLVVX+oI6Y0eBUWuQMY7aWdK8mkwaMFuS2MgOF3nV7+m93vepqJA+lJvo4/DdGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqqYUd+I; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqqYUd+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739550353; x=1771086353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xE4Njoyxxxt7h5muOvaecOz2DvQhoas6HmilLX9gMOs=;
  b=lqqYUd+IjbTepA0kNXZSRnp8yrZQemde9hblMFpLltcra5ccjByylxvs
   laerryL8twspLx1/qj6+rderDSrUeEqwD9AQVH5MKx5cHPHvkdr+y8Oc5
   kZdrTMvfzrRTvIIYek9ARBEKvAVq7/0CW1fNtiqIQUlE4G7XIBVLGWYcl
   mmTwtNydWLByk2dW765rkbkZIkmJ9e0+CfjZsUAespb0jyJsSdw7CTsNS
   5XcfvZC4wZhwJ69k5BOlnn5u2+SPY5Zhf5b7KME9QEY54GQai8s2HjtsK
   9Rwuu7klucW/BeYuMJpqpoeCKuyRI2j+F3WE5BC8IjHtrz3OHSNM7Q0Fb
   w==;
X-CSE-ConnectionGUID: pq3umZOWR2CQYxxg/Z55Lg==
X-CSE-MsgGUID: exeat3M+SO6aoFI27493MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40447116"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40447116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:25:52 -0800
X-CSE-ConnectionGUID: QnpF+3SJQjS0E1pjW7WhkA==
X-CSE-MsgGUID: WoQgMQ7nTfiHk7j8FRVjcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113355705"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:25:52 -0800
Message-ID: <613c2726-a576-4cd8-86a2-c84529b754cd@intel.com>
Date: Fri, 14 Feb 2025 09:25:50 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 11:11 PM, Lu Baolu wrote:
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 1e5038cca22c..d44944195807 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -626,21 +626,6 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
>  	idxd->pasid = IOMMU_PASID_INVALID;
>  }
>  
> -static int idxd_enable_sva(struct pci_dev *pdev)
> -{
> -	int ret;
> -
> -	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -	if (ret)
> -		return ret;
> -	return 0;
> -}
> -
> -static void idxd_disable_sva(struct pci_dev *pdev)
> -{
> -	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -}
> -
>  static int idxd_probe(struct idxd_device *idxd)
>  {
>  	struct pci_dev *pdev = idxd->pdev;
> @@ -655,17 +640,13 @@ static int idxd_probe(struct idxd_device *idxd)
>  	dev_dbg(dev, "IDXD reset complete\n");
>  
>  	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> -		if (idxd_enable_sva(pdev)) {
> -			dev_warn(dev, "Unable to turn on user SVA feature.\n");
> -		} else {
> -			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> +		set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
>  
> -			rc = idxd_enable_system_pasid(idxd);
> -			if (rc)
> -				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
> -			else
> -				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> -		}
> +		rc = idxd_enable_system_pasid(idxd);
> +		if (rc)
> +			dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
> +		else
> +			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>  	} else if (!sva) {
>  		dev_warn(dev, "User forced SVA off via module param.\n");
>  	}
> @@ -703,8 +684,6 @@ static int idxd_probe(struct idxd_device *idxd)
>   err:
>  	if (device_pasid_enabled(idxd))
>  		idxd_disable_system_pasid(idxd);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
>  	return rc;
>  }
>  
> @@ -715,8 +694,6 @@ static void idxd_cleanup(struct idxd_device *idxd)
>  	idxd_cleanup_internals(idxd);
>  	if (device_pasid_enabled(idxd))
>  		idxd_disable_system_pasid(idxd);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(idxd->pdev);
>  }
>  
>  /*
> @@ -1248,8 +1225,6 @@ static void idxd_remove(struct pci_dev *pdev)
>  	free_irq(irq_entry->vector, irq_entry);
>  	pci_free_irq_vectors(pdev);
>  	pci_iounmap(pdev, idxd->reg_base);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
>  	pci_disable_device(pdev);
>  	destroy_workqueue(idxd->wq);
>  	perfmon_pmu_remove(idxd);

