Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D91843
	for <iommu@lists.linux.dev>; Sun, 21 Apr 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713663944; cv=none; b=oqC4JmL04dRVh36PzWLDyVonpPff7Y6mKVBDdMqq9xfS1ddkwy6kaGY7WF46X0xFr95FU8XrVzOiIvBhgxQuY57AFR23ZclD6j+FEWhqcHLNJ4hiewGt0LlQghzyn2W2L4/Kk7xPHrMRbVLuyqXvrsAU1mBVh/3L4COAMjDU4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713663944; c=relaxed/simple;
	bh=l6K9jv44FITenLeW/ZAOhLomRdhjzLlXC55Lo6hx1mE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QwiReqDbPYeqpgmSL3XNEt3dTfEJr6rp7GgCuHU8s6FGnS1ocwEdan0biuwMIRHF5bwh+SMr6gH8w+SwsDkNhaqteDtiURmYZn4l6kWtHRLZk30v1vjCG+Yy9QC2tGCpVgAXVojHigr9HAQGJW1PZTiEfps+Ky2RqnpbtJXrN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftOnSVfy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftOnSVfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713663943; x=1745199943;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l6K9jv44FITenLeW/ZAOhLomRdhjzLlXC55Lo6hx1mE=;
  b=ftOnSVfyLzXYxaQrrzuVdPMKSn6262sY/F90KCcTqdBWTfu6utxFmRyl
   WzGxVJLoPzLE0cvLoYGRHtzpAJRcalJuzLNTyLlNdlUoDMxCJhmEEdlrx
   kJ+lXRQ+Otj8jjpOhPbk+sxMIFSC0CRiOh64v3Vzyyb1dn/VrXJNqrAo1
   /8vDIkFbilJHuJzQktzblXV/ow0t2B1jQYMBg8Du55VqiKlace1G20zBr
   xC+kti+JVrY2K2v8iN1kpSvAiCibCESoQng2cwmfPsfGDBB6NzdJGJub9
   H7OhcL2grt4Y1F6ijvwVX2uIV4mToVWGXXYF5541F0dWtm7z0q1eYHyy7
   g==;
X-CSE-ConnectionGUID: CidWks7ORpiNEkhdBitFjg==
X-CSE-MsgGUID: th1IzKkaTO+8mvE+BevEeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="9064237"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="9064237"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 18:45:42 -0700
X-CSE-ConnectionGUID: 05SR1P1kQP+yHlwvKFuKig==
X-CSE-MsgGUID: Vz3PB/76Q8m5fUCWhdwAGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="23664747"
Received: from liyang8-mobl.ccr.corp.intel.com (HELO [10.124.225.176]) ([10.124.225.176])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 18:45:40 -0700
Message-ID: <3ef9b4c9-9b56-4c19-8f09-97f984d1d560@linux.intel.com>
Date: Sun, 21 Apr 2024 09:45:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 alexander.deucher@amd.com, Eric Wagner <ewagner12@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@kernel.org
Subject: Re: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted
 device
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20240419114715.6028-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240419114715.6028-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/19 19:47, Vasant Hegde wrote:
> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
> untrusted device. This always took precedence over driver's
> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
> iommu_get_default_domain_type() to respect def_domain_type()") changed
> the behaviour. Current code calls def_domain_type() but if it doesn't
> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
> results in IOMMU group (and potentially IOMMU itself) in undetermined
> sstate.
> 
> This patch adds untrusted check in AMD IOMMU driver code. So that it
> lets eGPUs behind Thunderbolt work again.
> 
> Fine tuning amd_iommu_def_domain_type() will be done later.
> 
> Reported-by: Eric Wagner<ewagner12@gmail.com>
> Link:https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
> Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to respect def_domain_type()")
> Cc: Robin Murphy<robin.murphy@arm.com>
> Cc: Jason Gunthorpe<jgg@ziepe.ca>
> Cc:stable@kernel.org  # v6.7+
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
> @Eric,
>    Can you please test this patch?
> 
> -Vasant
> 
>   drivers/iommu/amd/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e692217fcb28..e405714640b0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device *dev)
>   	if (!dev_data)
>   		return 0;
>   
> +	/* Always use DMA domain for untrusted device */
> +	if (to_pci_dev(dev)->untrusted)
> +		return IOMMU_DOMAIN_DMA;

Are you sure that dev always represents a pci device? If not, perhaps
here it needs a dev_is_pci() check?

Best regards,
baolu
