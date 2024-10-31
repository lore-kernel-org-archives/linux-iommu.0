Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1E1A0BF8;
	Thu, 31 Oct 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386617; cv=none; b=a/Y5izKX/swXqJdB1Yo4ucJTLJ2YiFj6qyHQY72o8mBnplAcP/PVGtTIwJSJ4pYq/8L53wj4ehA/yUnpdRXACCro+QFyCq8mZG5AS17tNkJRqmikTruut1tF129KU4qz2GG/qMj4v5d9T2dCCeYLXe18BheGDUYT0GCqeexLC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386617; c=relaxed/simple;
	bh=RYQD2k4t+eyKClYERlXtusVj0Pc67h5VYy59QS4+vVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbERkVTB/wZAf6zyz2wmXBzZn1w3/ZeV6KZ8V58GVOumA8tVm5b4f7RVgF/khreCWy2qPQ23eQYerd7DD+iWTiyHF6rw8mmhoesTcFQzy+OeC/YT55rSxIB+VKMNgvuZ/goTMH5vLUnEbUR9EMYTgXxMUyElfcAvpSxEVX389oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lypHGX20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lypHGX20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8630C4FE14;
	Thu, 31 Oct 2024 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730386616;
	bh=RYQD2k4t+eyKClYERlXtusVj0Pc67h5VYy59QS4+vVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lypHGX20DvAPT4T4VePAdclHYWUYpdJ1hHA/RkIyIWCVbLgIfkcLBwBzCr9PAGbnb
	 t5+nY9QFF/4G/2ArDljN26hKU3+hSc22AaxvahJjVndjBD3xKtRYpgfa1iMYfLwby0
	 su3vtOePY7tdPQLIIYwCbeC3HSHndsrIjSUmVEUUgCmUN6YnrOwD4zmtsCLZ8ibGAp
	 wOTmQ1JUJbG3Zq9EZObYdgGGshf8FvhLwBaRhgAOUDzeeYNkJYf8juK96OOeqXqACz
	 4vGj+7eBG6oVOM4B3fngswws4Oidq7NlUwk2fpTERrS6QRtZGeurJjHMTyTpz6tvHg
	 kM2d/10rTPQ1Q==
Date: Thu, 31 Oct 2024 15:56:48 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Drain PRQs when domain removed from RID
Message-ID: <oaho6355qyb7mjs7taturs6dkvtqhv2xlhoc6wgike7uodjbia@k5k6qltfhigi>
References: <20241031095139.44220-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031095139.44220-1-baolu.lu@linux.intel.com>

On Thu, Oct 31, 2024 at 05:51:39PM +0800, Lu Baolu wrote:
> As this iommu driver now supports page faults for requests without
> PASID, page requests should be drained when a domain is removed from
> the RID2PASID entry.
> 
> This results in the intel_iommu_drain_pasid_prq() call being moved to
> intel_pasid_tear_down_entry(). This indicates that when a translation
> is removed from any PASID entry and the PRI has been enabled on the
> device, page requests are flushed in the domain detachment path.
> 
> The intel_iommu_drain_pasid_prq() helper has been modified to support
> sending device TLB invalidation requests for both PASID and non-PASID
> cases.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c |  1 -
>  drivers/iommu/intel/pasid.c |  1 +
>  drivers/iommu/intel/prq.c   | 22 +++++++---------------
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 87a3563dfe54..3878f35be09d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4069,7 +4069,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>  	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>  	kfree(dev_pasid);
>  	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> -	intel_iommu_drain_pasid_prq(dev, pasid);
>  }
>  
>  static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 7e76062a7ad2..31665fb62e1c 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>  
>  	devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	intel_iommu_drain_pasid_prq(dev, pasid);
>  }
>  
>  /*
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index 3c50c848893f..ae7f6f34462f 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -66,12 +66,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>  	struct pci_dev *pdev;
>  	int head, tail;
>  	u16 sid, did;
> -	int qdep;
>  
>  	info = dev_iommu_priv_get(dev);
> -	if (WARN_ON(!info || !dev_is_pci(dev)))
You do this on purpose because
1. It is not possible to go through this path without an iommu set in
   the device
2. PRI within the intel driver is only relevant for PCI
3. There will always be a struct device_domain_info related to the
   device iommu when doing PRI.
right?

Best

-- 

Joel Granados
