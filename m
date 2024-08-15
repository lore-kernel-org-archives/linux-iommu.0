Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961662A8D0
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737921; cv=none; b=n1tZ2Odb5EBTVA03Jkfj73FeURmoS6H73CB+WUb0N3rBAyS67i/wOlaISStWAICliPbHtTAURAZIy+y8shxSEI2WT1jyYPP48YOqjVpcukldESjk6Lr1Gv7VbLirfaH6xRPrUlw7e+klqOai/Z6rnkPeS8xffi06VYssjSOVIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737921; c=relaxed/simple;
	bh=SUfR+C/RB4k8Pyo/zAOs4oQmbJcMpILjXqT1HkYxWw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uo6bJhRVT62uNiCqqTjP4DqDm7lHefq4iCC8wtM7GTr9AcPVrCiSgAOrSS7MLpPutj9q1angp8N8ySKoo1Nb3lbbALwb9jl7ZOo8W+sAXFbE6jbqdWSTtedxL8A71xFgu5KlAX68DkZPSPRcXZg0YRQocv3Z21BovpjpiuqxsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KocohE3t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KocohE3t"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id D0F4920B7165;
	Thu, 15 Aug 2024 09:05:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0F4920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723737919;
	bh=17wkRLb5k5S9a17517dzFxFHsPfgQkWaxCfkGQD7LHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KocohE3tYpt12avi8fWq5oxy0sOEnjqBj3L2yPzPptuJxNeuow/2/ftagVSYU8icL
	 JRolGo56xwWR8w3aVilDwsJvFlVFFnqWM11TepPpjfJuQe1JTvT8Tof2ROWZu0P/uy
	 KmYZbwCAtbPVl2AU9NjoFiJj+DNQuQew45jk4u6c=
Date: Thu, 15 Aug 2024 09:05:17 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Alex Williamson
 <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context
 flush helper
Message-ID: <20240815090517.685fb5f7@DESKTOP-0403QTC.>
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 20:48:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The helper intel_context_flush_present() is designed to flush all
> related caches when a context entry with the present bit set is
> modified. It currently retrieves the domain ID from the context entry
> and uses it to flush the IOTLB and context caches. This is incorrect
> when the context entry transitions from present to non-present, as
> the domain ID field is cleared before calling the helper.
> 
> Fix it by passing the domain ID programmed in the context entry
> before the change to intel_context_flush_present(). This ensures that
> the correct domain ID is used for cache invalidation.
> 
> Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for
> context change") Reported-by: Alex Williamson
> <alex.williamson@redhat.com> Closes:
> https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com> ---
>  drivers/iommu/intel/iommu.h | 2 +-
>  drivers/iommu/intel/iommu.c | 8 ++++++--
>  drivers/iommu/intel/pasid.c | 7 ++++---
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index b67c14da1240..a969be2258b1 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1154,7 +1154,7 @@ void cache_tag_flush_range_np(struct
> dmar_domain *domain, unsigned long start, 
>  void intel_context_flush_present(struct device_domain_info *info,
>  				 struct context_entry *context,
> -				 bool affect_domains);
> +				 u16 did, bool affect_domains);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..4aa070cf56e7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1944,6 +1944,7 @@ static void domain_context_clear_one(struct
> device_domain_info *info, u8 bus, u8 {
>  	struct intel_iommu *iommu = info->iommu;
>  	struct context_entry *context;
> +	u16 did;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, 0);
> @@ -1952,10 +1953,11 @@ static void domain_context_clear_one(struct
> device_domain_info *info, u8 bus, u8 return;
>  	}
>  
> +	did = context_domain_id(context);
>  	context_clear_entry(context);
>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>  }
>  
>  static int domain_setup_first_level(struct intel_iommu *iommu,
> @@ -4249,6 +4251,7 @@ static int context_flip_pri(struct
> device_domain_info *info, bool enable) struct intel_iommu *iommu =
> info->iommu; u8 bus = info->bus, devfn = info->devfn;
>  	struct context_entry *context;
> +	u16 did;
>  
>  	spin_lock(&iommu->lock);
>  	if (context_copied(iommu, bus, devfn)) {
> @@ -4261,6 +4264,7 @@ static int context_flip_pri(struct
> device_domain_info *info, bool enable) spin_unlock(&iommu->lock);
>  		return -ENODEV;
>  	}
> +	did = context_domain_id(context);
>  
>  	if (enable)
>  		context_set_sm_pre(context);
> @@ -4269,7 +4273,7 @@ static int context_flip_pri(struct
> device_domain_info *info, bool enable) 
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(context, sizeof(*context));
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>  	spin_unlock(&iommu->lock);
>  
>  	return 0;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 5792c817cefa..b51fc268dc84 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -683,6 +683,7 @@ static void device_pasid_table_teardown(struct
> device *dev, u8 bus, u8 devfn) struct device_domain_info *info =
> dev_iommu_priv_get(dev); struct intel_iommu *iommu = info->iommu;
>  	struct context_entry *context;
> +	u16 did;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, false);
> @@ -691,10 +692,11 @@ static void device_pasid_table_teardown(struct
> device *dev, u8 bus, u8 devfn) return;
>  	}
>  
> +	did = context_domain_id(context);
>  	context_clear_entry(context);
>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, false);
> +	intel_context_flush_present(info, context, did, false);
>  }
>  
>  static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias,
> void *data) @@ -885,10 +887,9 @@ static void
> __context_flush_dev_iotlb(struct device_domain_info *info) */
>  void intel_context_flush_present(struct device_domain_info *info,
>  				 struct context_entry *context,
> -				 bool flush_domains)
> +				 u16 did, bool flush_domains)
>  {
>  	struct intel_iommu *iommu = info->iommu;
> -	u16 did = context_domain_id(context);
>  	struct pasid_entry *pte;
>  	int i;
>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
