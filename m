Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504BB2AE90
	for <iommu@lists.linux.dev>; Thu, 25 Dec 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766697370; cv=none; b=XfGB2wMsEBJpESj9lCpHsMqfNwgG7ZkjV5dhqNIIJoz3rx0IYNWnecmsAxRR6uLq8mYkwYAbVKX/BLLxBP61U94wThdSdjbPohQGfdLntxhjZFREeThbuWzdg0Jxwm05dDVWH3dPNnZxy9IO4TYyKtIZLI0CMF+o0awJILircu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766697370; c=relaxed/simple;
	bh=e2MJ5Mgg1gGVofK7P1upAE0fMBnX8tmhR2TWfSaJbYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBRApsiG7SwI6tmFN8blNJp7sHcGYvlqc/QCDarALgJ4DhSNbOO6rWtGVQxi7a2IFPzCKQRN7nC4Rki2PSe8OG52rcyZFVD96OcgUqL/HtyWud3wPKfjn2BrdzpClh5fUpZlw0kGtY1MOtFUSAx42u8ztswl/6MZEMOkgWYZaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schreibt.jetzt; spf=pass smtp.mailfrom=schreibt.jetzt; dkim=pass (1024-bit key) header.d=schreibt.jetzt header.i=@schreibt.jetzt header.b=S7igpfWU; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schreibt.jetzt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schreibt.jetzt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schreibt.jetzt header.i=@schreibt.jetzt header.b="S7igpfWU"
From: Linus Heckemann <linus@schreibt.jetzt>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schreibt.jetzt;
	s=sosiego; t=1766696760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xf0mi1RAalYkilShhmhk5aLBPcaw6aHohT/tJFlfDiY=;
	b=S7igpfWUCmOZ/cAXOLfdS+hUD9EOY1yOyjBJQBC04bbbirkDLBCvK3g3+NBM9pqf9sO0KC
	6CLmofgvRbBo9LgIKhEUggBNj8iNJ4X4o2A5YQlo/aWzOf8+lV6JCd3MVecWGxqqfkM0l+
	iHCbdeP1iOn+YnAB+AI/+cECVMJeIgQ=
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 2/8] iommu: Remove IOMMU_DEV_FEAT_SVA
In-Reply-To: <20250418080130.1844424-3-baolu.lu@linux.intel.com>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
 <20250418080130.1844424-3-baolu.lu@linux.intel.com>
Date: Thu, 25 Dec 2025 22:05:59 +0100
Message-ID: <ygaqzsib7bc.fsf@localhost>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Lu Baolu <baolu.lu@linux.intel.com> writes:

> From: Jason Gunthorpe <jgg@nvidia.com>
>
> None of the drivers implement anything here anymore, remove the dead code.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/accel/amdxdna/aie2_pci.c            | 13 ++-----------
>  drivers/dma/idxd/init.c                     |  8 +-------
>  drivers/iommu/amd/iommu.c                   |  2 --
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 --
>  drivers/iommu/intel/iommu.c                 |  6 ------
>  drivers/iommu/iommu-sva.c                   |  3 ---
>  drivers/misc/uacce/uacce.c                  |  9 ---------
>  include/linux/iommu.h                       |  9 +--------
>  8 files changed, 4 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 5a058e565b01..c6cf7068d23c 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -512,12 +512,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
>  		goto release_fw;
>  	}
>  
> -	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> -	if (ret) {
> -		XDNA_ERR(xdna, "Enable PASID failed, ret %d", ret);
> -		goto free_irq;
> -	}
> -
>  	psp_conf.fw_size = fw->size;
>  	psp_conf.fw_buf = fw->data;
>  	for (i = 0; i < PSP_MAX_REGS; i++)
> @@ -526,14 +520,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
>  	if (!ndev->psp_hdl) {
>  		XDNA_ERR(xdna, "failed to create psp");
>  		ret = -ENOMEM;
> -		goto disable_sva;
> +		goto free_irq;
>  	}
>  	xdna->dev_handle = ndev;
>  
>  	ret = aie2_hw_start(xdna);
>  	if (ret) {
>  		XDNA_ERR(xdna, "start npu failed, ret %d", ret);
> -		goto disable_sva;
> +		goto free_irq;
>  	}
>  
>  	ret = aie2_mgmt_fw_query(ndev);
> @@ -584,8 +578,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
>  	aie2_error_async_events_free(ndev);
>  stop_hw:
>  	aie2_hw_stop(xdna);
> -disable_sva:
> -	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
>  free_irq:
>  	pci_free_irq_vectors(pdev);
>  release_fw:
> @@ -601,7 +593,6 @@ static void aie2_fini(struct amdxdna_dev *xdna)
>  
>  	aie2_hw_stop(xdna);
>  	aie2_error_async_events_free(ndev);
> -	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
>  	pci_free_irq_vectors(pdev);
>  }
>  
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index fca1d2924999..2d3d580b9987 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -633,17 +633,11 @@ static int idxd_enable_sva(struct pci_dev *pdev)
>  	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
>  	if (ret)
>  		return ret;
> -
> -	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> -	if (ret)
> -		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static void idxd_disable_sva(struct pci_dev *pdev)
>  {
> -	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
>  	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
>  }
>  
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dea0fed7abb0..17aab6d04a13 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2991,7 +2991,6 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
>  
>  	switch (feat) {
>  	case IOMMU_DEV_FEAT_IOPF:
> -	case IOMMU_DEV_FEAT_SVA:
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -3007,7 +3006,6 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
>  
>  	switch (feat) {
>  	case IOMMU_DEV_FEAT_IOPF:
> -	case IOMMU_DEV_FEAT_SVA:
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6cb875f98905..73f9885d20f1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3664,7 +3664,6 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>  
>  	switch (feat) {
>  	case IOMMU_DEV_FEAT_IOPF:
> -	case IOMMU_DEV_FEAT_SVA:
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -3681,7 +3680,6 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>  
>  	switch (feat) {
>  	case IOMMU_DEV_FEAT_IOPF:
> -	case IOMMU_DEV_FEAT_SVA:
>  		return 0;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 857c431d8ec5..4c3be92804e2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3956,9 +3956,6 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>  	case IOMMU_DEV_FEAT_IOPF:
>  		return intel_iommu_enable_iopf(dev);
>  
> -	case IOMMU_DEV_FEAT_SVA:
> -		return 0;
> -
>  	default:
>  		return -ENODEV;
>  	}
> @@ -3972,9 +3969,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
>  		intel_iommu_disable_iopf(dev);
>  		return 0;
>  
> -	case IOMMU_DEV_FEAT_SVA:
> -		return 0;
> -
>  	default:
>  		return -ENODEV;
>  	}
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index ab18bc494eef..944daa0dabd6 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -63,9 +63,6 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>   * reference is taken. Caller must call iommu_sva_unbind_device()
>   * to release each reference.
>   *
> - * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> - * initialize the required SVA features.
> - *
>   * On error, returns an ERR_PTR value.
>   */
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index bdc2e6fda782..2a1db2abeeca 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -479,14 +479,6 @@ static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>  		dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
>  		return flags;
>  	}
> -
> -	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> -	if (ret) {
> -		dev_err(parent, "failed to enable SVA feature! ret = %pe\n", ERR_PTR(ret));
> -		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> -		return flags;
> -	}
> -
>  	return flags | UACCE_DEV_SVA;
>  }
>  
> @@ -495,7 +487,6 @@ static void uacce_disable_sva(struct uacce_device *uacce)
>  	if (!(uacce->flags & UACCE_DEV_SVA))
>  		return;
>  
> -	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>  	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>  }
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7e8c2af89799..bfdd2e71e124 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -318,18 +318,11 @@ struct iommu_iort_rmr_data {
>  
>  /**
>   * enum iommu_dev_features - Per device IOMMU features
> - * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> - * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
> - *			 enabling %IOMMU_DEV_FEAT_SVA requires
> - *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
> - *			 Faults themselves instead of relying on the IOMMU. When
> - *			 supported, this feature must be enabled before and
> - *			 disabled after %IOMMU_DEV_FEAT_SVA.
> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall.
>   *
>   * Device drivers enable a feature using iommu_dev_enable_feature().
>   */
>  enum iommu_dev_features {
> -	IOMMU_DEV_FEAT_SVA,
>  	IOMMU_DEV_FEAT_IOPF,
>  };
>  
> -- 
> 2.43.0

Hi all,

It appears the code removed here was not in fact entirely dead; my 2024
gpd win mini ("G1617-01", with a Ryzen 8840U) fails to suspend
correctly, and I bisected the issue to this commit.

dmesg:

[  141.397168] wlp1s0: deauthenticating from 20:05:b6:ff:c4:5e by local choice (Reason: 3=DEAUTH_LEAVING)
[  141.716327] PM: suspend entry (s2idle)
[  141.783603] Filesystems sync: 0.067 seconds
[  141.895439] Freezing user space processes
[  141.896512] Freezing user space processes completed (elapsed 0.001 seconds)
[  141.896515] OOM killer disabled.
[  141.896516] Freezing remaining freezable tasks
[  141.897523] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  141.897527] printk: Suspending console(s) (use no_console_suspend to debug)
[  142.292185] ACPI: EC: interrupt blocked
[  149.879420] amd_pmc AMDI0009:00: Last suspend didn't reach deepest state
note ^
[  150.026394] ACPI: EC: interrupt unblocked
[  150.196340] [drm] PCIE GART of 512M enabled (table at 0x00000081FFD00000).
[  150.196503] amdgpu 0000:c3:00.0: amdgpu: SMU is resuming...
[  150.200585] amdgpu 0000:c3:00.0: amdgpu: SMU is resumed successfully!
[  150.228549] nvme nvme0: 16/0/0 default/read/poll queues
[  150.244609] nvme nvme0: Failed to get ANA log: 16649
[  150.319610] amdgpu 0000:c3:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[  150.319619] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  150.319621] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  150.319623] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[  150.319624] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[  150.319625] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[  150.319627] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[  150.319628] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[  150.319629] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[  150.319630] amdgpu 0000:c3:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[  150.319632] amdgpu 0000:c3:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[  150.319633] amdgpu 0000:c3:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[  150.319635] amdgpu 0000:c3:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[  150.329858] [drm] ring gfx_32773.1.1 was added
[  150.330624] [drm] ring compute_32773.2.2 was added
[  150.331491] [drm] ring sdma_32773.3.3 was added
[  150.331565] [drm] ring gfx_32773.1.1 ib test pass
[  150.331603] [drm] ring compute_32773.2.2 ib test pass
[  150.331699] [drm] ring sdma_32773.3.3 ib test pass
[  150.498226] usb 1-3: reset full-speed USB device number 2 using xhci_hcd
[  150.738138] usb 1-5: reset full-speed USB device number 4 using xhci_hcd
[  150.906575] OOM killer enabled.
[  150.906578] Restarting tasks ... 
[  150.906640] input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:c3:00.3/usb1/1-5/1-5:1.0/input/input27
[  150.907291] done.
[  150.907372] random: crng reseeded on system resumption
[  150.931675] PM: suspend exit


Let me know if there's any further information that would be helpful here.


Linus
