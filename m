Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44E1FBF
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679328657; x=1710864657;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIjFZ6/taO8KY+JO3vybOuikqks1nhOIhIEiBvcrbJg=;
  b=Giei/3MzW1U8NJrvuBaif//iCSsA9TNn5W8bMwXDcCUqPdT3o1iDk3zw
   8UOgZtFfS5X+TMPYwezw48MZwO8RSWClQ1OZG1yIBzsH+rxZ9RLvNi0ew
   UJwozEcOrk3PwLCMzzx/wDGO6Ds8fedYZKHj3a6ga/SmxaQVLX3L3yikb
   akmn6quSi+ycc2E3vRq0/SuG3kwjDq3yj/slXho2PbJe0zewd4Dfj2PFK
   8UwiBIOKZ7RW+6eV9xZ6OM3DzuSh6nuq1wdWTsvkJX8t/E/7h2GCJfY2/
   9xJMKhCJq2dWW0gjHH1R2EuEHjZZuWuNxyddSyBTOXzPzI0TYxQOLma4j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366423394"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366423394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713630339"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713630339"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:07:29 -0700
Date: Mon, 20 Mar 2023 09:11:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, dmaengine@vger.kernel.org, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Vinod Koul
 <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 4/5] iommu/vt-d: Move pfsid and ats_qdep calculation
 to device probe path
Message-ID: <20230320091127.63dec1fa@jacob-builder>
In-Reply-To: <20230309025639.26109-5-baolu.lu@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
	<20230309025639.26109-5-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi BaoLu,

On Thu,  9 Mar 2023 10:56:38 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> They should be part of the per-device iommu private data initialization.
> 
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ada12bf38dd..fb64ab8358a9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1406,20 +1406,6 @@ static void iommu_enable_pci_caps(struct
> device_domain_info *info) return;
>  
>  	pdev = to_pci_dev(info->dev);
> -	/* For IOMMU that supports device IOTLB throttling (DIT), we
> assign
> -	 * PFSID to the invalidation desc of a VF such that IOMMU HW can
> gauge
> -	 * queue depth at PF level. If DIT is not set, PFSID will be
> treated as
> -	 * reserved, which should be set to 0.
> -	 */
> -	if (!ecap_dit(info->iommu->ecap))
> -		info->pfsid = 0;
> -	else {
> -		struct pci_dev *pf_pdev;
> -
> -		/* pdev will be returned if device is not a vf */
> -		pf_pdev = pci_physfn(pdev);
> -		info->pfsid = pci_dev_id(pf_pdev);
> -	}
>  
>  	/* The PCIe spec, in its wisdom, declares that the behaviour of
>  	   the device if you enable PASID support after ATS support is
> @@ -1438,7 +1424,6 @@ static void iommu_enable_pci_caps(struct
> device_domain_info *info) !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>  		info->ats_enabled = 1;
>  		domain_update_iotlb(info->domain);
> -		info->ats_qdep = pci_ats_queue_depth(pdev);
>  	}
>  }
>  
> @@ -4521,6 +4506,17 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev) dmar_ats_supported(pdev,
> iommu)) { info->ats_supported = 1;
>  			info->dtlb_extra_inval =
> dev_needs_extra_dtlb_flush(pdev); +
> +			/*
> +			 * For IOMMU that supports device IOTLB
> throttling
> +			 * (DIT), we assign PFSID to the invalidation
> desc
> +			 * of a VF such that IOMMU HW can gauge queue
> depth
> +			 * at PF level. If DIT is not set, PFSID will be
> +			 * treated as reserved, which should be set to 0.
> +			 */
> +			if (ecap_dit(iommu->ecap))
> +				info->pfsid =
> pci_dev_id(pci_physfn(pdev));
> +			info->ats_qdep = pci_ats_queue_depth(pdev);
>  		}
>  		if (sm_supported(iommu)) {
>  			if (pasid_supported(iommu)) {


Thanks,

Jacob
