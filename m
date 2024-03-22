Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741E82877
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148206; cv=none; b=qmOi6u/JhsXaqD3yAB+L48JJg9hlm/XiUYHqXcZAakpZMIDgPfq/rhWcdR8/muVwLkBKOOQk+F/L+M9JI1en4FwhXWEnpkchMFXy0vUBCIXP2OVTZNb67eKu7YhJRcGzyfXr7sSSYJdMomxyWdtfZNT8+a1GqneZ0+9p6Q9fC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148206; c=relaxed/simple;
	bh=NWjST7AfhmWDCfO6EyHsfoZ7s5rcMP33bA0hV91Yn1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czkBNLreYpy6szUI53RXIdrJOl9TRc8BJywHoYd5QEwqCmrKjm8LDDa/PxUumT6ua4aquc4IxMLBINLZfq7LOBFslJPBvmeyqyd7ZnVgeGaBYBWn3uzF39GKq1e8beecrvpYp7bzS/Eycih1DxUFbdjv/XlDzSsp42AhMRJRMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hv7SkGd2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hv7SkGd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711148205; x=1742684205;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NWjST7AfhmWDCfO6EyHsfoZ7s5rcMP33bA0hV91Yn1g=;
  b=Hv7SkGd2jiqyeiGdwRzWSA+XD1ERNZYQmGicdKzmcHl6fVYrK72A6xy8
   qn730m7C79ROGvUKa/1uKZoTi9D2rsXP77WMJbcffQY+8Q7QIUn1u+Sv1
   u7KsamgGVJE/8rEhXCg2KhZkqSZCChrGcla2gMpU5t2jZGozushXpwZVD
   oh0WSOOGPWzwxLkKaAQ9w74gWdyw/bp0F0gKWYI3Upl/X46VSvvIZMMPM
   6HcrYWAu6Kv/dOqgb+IDzd1+EPtCnwwT8/kbvUomG307cFp1hIZUO8tCi
   tTAygu9N2T3iU1zQWF59ac7QEgkaL/EfESj7MAe7z2bSAxw7uxc8rPMS2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6048049"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6048049"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 15:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="14950844"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 15:56:44 -0700
Date: Fri, 22 Mar 2024 16:01:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnd
 Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Message-ID: <20240322160104.22af19bd@jacob-builder>
In-Reply-To: <Zfydpp2Hm+as16TY@hpe.com>
References: <Zfydpp2Hm+as16TY@hpe.com>
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

Hi Dimitri,

On Thu, 21 Mar 2024 15:50:46 -0500, Dimitri Sivanich <sivanich@hpe.com>
wrote:

> The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
> vectors on the boot cpu.  On large systems with high DMAR counts this
> results in vector exhaustion, and most of the vectors are not initially
> allocated socket local.
> 
> Instead, have a cpu on each node do the vector allocation for the DMARs on
> that node.  The boot cpu still does the allocation for its node during its
> boot sequence.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> ---
> 
> v2: per Thomas Gleixner, implement this from a DYN CPU hotplug state,
> though this implementation runs in CPUHP_AP_ONLINE_DYN space rather than
>     CPUHP_BP_PREPARE_DYN space.
> 

I tested on a dual socket system (192 core) successfully with the following:
1. After boot DMAR-MSI spread from BSP to the first CPU of the second numa
node
2. Offline/Online all CPUs in the 2nd node

Code looks good to me.


Thanks,

Jacob

>  drivers/iommu/amd/amd_iommu.h | 2 +-
>  drivers/iommu/amd/init.c      | 2 +-
>  drivers/iommu/intel/dmar.c    | 9 +++++++--
>  drivers/iommu/irq_remapping.c | 5 ++++-
>  drivers/iommu/irq_remapping.h | 2 +-
>  include/linux/dmar.h          | 2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index f482aab420f7..410c360e7e24 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -33,7 +33,7 @@ int amd_iommu_prepare(void);
>  int amd_iommu_enable(void);
>  void amd_iommu_disable(void);
>  int amd_iommu_reenable(int mode);
> -int amd_iommu_enable_faulting(void);
> +int amd_iommu_enable_faulting(unsigned int cpu);
>  extern int amd_iommu_guest_ir;
>  extern enum io_pgtable_fmt amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index e7a44929f0da..4782f690ed97 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3389,7 +3389,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(void)
> +int __init amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 36d7427b1202..7644a42f283c 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2122,7 +2122,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
>  	return ret;
>  }
>  
> -int __init enable_drhd_fault_handling(void)
> +int enable_drhd_fault_handling(unsigned int cpu)
>  {
>  	struct dmar_drhd_unit *drhd;
>  	struct intel_iommu *iommu;
> @@ -2132,7 +2132,12 @@ int __init enable_drhd_fault_handling(void)
>  	 */
>  	for_each_iommu(iommu, drhd) {
>  		u32 fault_status;
> -		int ret = dmar_set_interrupt(iommu);
> +		int ret;
> +
> +		if (iommu->irq || iommu->node != cpu_to_node(cpu))
> +			continue;
> +
> +		ret = dmar_set_interrupt(iommu);
>  
>  		if (ret) {
>  			pr_err("DRHD %Lx: failed to enable fault,
> interrupt, ret %d\n", diff --git a/drivers/iommu/irq_remapping.c
> b/drivers/iommu/irq_remapping.c index ee59647c2050..2f7281ccc05f 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -151,7 +151,10 @@ int __init irq_remap_enable_fault_handling(void)
>  	if (!remap_ops->enable_faulting)
>  		return -ENODEV;
>  
> -	return remap_ops->enable_faulting();
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> "dmar:enable_fault_handling",
> +			  remap_ops->enable_faulting, NULL);
> +
> +	return remap_ops->enable_faulting(smp_processor_id());
>  }
>  
>  void panic_if_irq_remap(const char *msg)
> diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
> index 8c89cb947cdb..0d6f140b5e01 100644
> --- a/drivers/iommu/irq_remapping.h
> +++ b/drivers/iommu/irq_remapping.h
> @@ -41,7 +41,7 @@ struct irq_remap_ops {
>  	int  (*reenable)(int);
>  
>  	/* Enable fault handling */
> -	int  (*enable_faulting)(void);
> +	int  (*enable_faulting)(unsigned int);
>  };
>  
>  extern struct irq_remap_ops intel_irq_remap_ops;
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index e34b601b71fd..499bb2c63483 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -117,7 +117,7 @@ extern int dmar_remove_dev_scope(struct
> dmar_pci_notify_info *info, int count);
>  /* Intel IOMMU detection */
>  void detect_intel_iommu(void);
> -extern int enable_drhd_fault_handling(void);
> +extern int enable_drhd_fault_handling(unsigned int cpu);
>  extern int dmar_device_add(acpi_handle handle);
>  extern int dmar_device_remove(acpi_handle handle);
>  


Thanks,

Jacob
