Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DF37267E
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060241; cv=none; b=un3nOGHlFrdR+NipNgTFWwwT+d6mKrzvunKl2sjCfnxgv7X77LiZCkzVOQk5Qj/iAQgD05xRMVsUOGSru3LJkFEDlVIYcYns4lfpIDURQjKldRlZHUhAfWjAJtodAkunDQh10+i2Vrj0IB8RfWLTrkv014iAMiVjEUW60zM0nFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060241; c=relaxed/simple;
	bh=Kz9XeK25k841297cPqD210/bA3iaqEXTDrvRnP+1/yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHpX9WYjsSNWar+B3JSM/MQt1Gqw3sP8YidsYi7bn4Aq1qEAA2MIw65R/HiBHr4U62TRVIyUl4vwiA7yYoZ5y4x57c2ik94Z8KbggThUORAUXyoAAirPkjoi4V4ZFr9UohSCWqp/Z+Z8tefvlIk6eWVNeb7Xy4PJ3nF7QSHeG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OXjZvtoz; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OXjZvtoz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790060228; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wsj0O5bkjoy8IbmWNVJCqX6+ZVUE5t5Oc6nFsv1ksXk=;
	b=OXjZvtoz9v2IqmixerJlfp8i6dy9vMa5DiQ0k6I6fGPoFpata4fZDGMklgjBjEE7TTN4r5bTjGHrJD6FNltV+KNXW3T3Jj31smZja/yWWOS8D6NGG0zxVR86qa//VJBYGlw6KDlv7l5rbJb5uUx6+V2m/VGWDAg2NLR4qHzvz3w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XBT.zS4_1790060225;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBT.zS4_1790060225 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 14:57:06 +0800
Message-ID: <a999cd33-c857-4c3a-9643-4c0add9679ae@linux.alibaba.com>
Date: Tue, 22 Sep 2026 14:57:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/24] iommu/amd: Program IOMMU DTE with the private
 IPA domain
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-14-suravee.suthikulpanit@amd.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260914184750.222939-14-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/15 02:47, Suravee Suthikulpanit 写道:
> The IOMMU PCI function does not go through the normal device attach
> path, so it has no iommu_dev_data. Add amd_iommu_alloc_dev_data()
> and amd_iommu_free_dev_data() for a synthetic object that is not
> interned in pci_seg->dev_data_xa. Program that DTE with the private
> IPA domain's v1 page table so the IOMMU can DMA to its own vIOMMU
> backing store.
>
> Leave the synthetic DTE off pdom->dev_list and with no struct
> device so clone_aliases() is skipped; it is only iommu->devid.
> Rewrite it from amd_iommu_change_top() when the IPA table grows
> so later high maps remain reachable.
>
> Do this after viommu_private_space_init() so viommu_pdom exists.
> Clear the DTE and free the object on teardown. Failed self DTE
> allocation unwinds through amd_viommu_uninit().
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   4 ++
>  drivers/iommu/amd/amd_iommu_types.h |   2 +
>  drivers/iommu/amd/iommu.c           | 102 +++++++++++++++++++++++++---
>  drivers/iommu/amd/viommu.c          |  48 +++++++++++++
>  4 files changed, 148 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 9cc5da745a73..6ac64524208b 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -50,6 +50,10 @@ extern u8 amd_iommu_hpt_vasize;
>  extern unsigned long amd_iommu_pgsize_bitmap;
>  extern bool amd_iommu_hatdis;
>  
> +struct iommu_dev_data *amd_iommu_alloc_dev_data(u16 devid);
> +void amd_iommu_free_dev_data(struct amd_iommu *iommu,
> +			     struct iommu_dev_data *dev_data);
> +
>  /* Protection domain ops */
>  void amd_iommu_init_identity_domain(void);
>  struct protection_domain *protection_domain_alloc(void);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index d02f49a39a90..4b48ec8bacd6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -814,6 +814,8 @@ struct amd_iommu {
>  	struct ida gid_ida;		 /* guest IDs for this IOMMU */
>  
>  	/* HW vIOMMU support */
> +	/* Synthetic IOMMU-self DTE; not in pci_seg->dev_data_xa or pdom->dev_list */
> +	struct iommu_dev_data *viommu_dev_data;
>  	struct protection_domain *viommu_pdom;
>  	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
>  };
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2b039f38f9ef..bcbd5af75d00 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -217,7 +217,12 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
>  			     struct dev_table_entry *new)
>  {
>  	update_dte256(iommu, dev_data, new);
> -	clone_aliases(iommu, dev_data->dev);
> +	/*
> +	 * Synthetic DTEs (vIOMMU self, translate-device-id) leave
> +	 * dev_data->dev NULL so clone_aliases() is skipped.
> +	 */
> +	if (dev_data->dev)
> +		clone_aliases(iommu, dev_data->dev);
>  	device_flush_dte(iommu, dev_data);
>  	iommu_completion_wait(iommu);
>  }
> @@ -391,14 +396,13 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
>  }
>  
>  /*
> - * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
> - * These are never erased: amd_iommu_release_device() keeps them for
> - * replug, and IRQ/DTE paths look them up locklessly via xa_load().
> + * Allocate a synthetic DTE object that is not inserted into
> + * pci_seg->dev_data_xa. Lifetime is owned by the caller (vIOMMU
> + * self DTE or translate-device-id).
>   */
> -static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
> +struct iommu_dev_data *amd_iommu_alloc_dev_data(u16 devid)
>  {
> -	struct iommu_dev_data *dev_data, *old;
> -	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> +	struct iommu_dev_data *dev_data;
>  
>  	dev_data = kzalloc_obj(*dev_data);
>  	if (!dev_data)
> @@ -408,6 +412,22 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
>  	spin_lock_init(&dev_data->dte_lock);
>  	dev_data->devid = devid;
>  	ratelimit_default_init(&dev_data->rs);
> +	return dev_data;
> +}
> +
> +/*
> + * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
> + * These are never erased: amd_iommu_release_device() keeps them for
> + * replug, and IRQ/DTE paths look them up locklessly via xa_load().
> + */
> +static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
> +{
> +	struct iommu_dev_data *dev_data, *old;
> +	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> +
> +	dev_data = amd_iommu_alloc_dev_data(devid);
> +	if (!dev_data)
> +		return NULL;
>  
>  	old = xa_cmpxchg(&pci_seg->dev_data_xa, devid, NULL, dev_data,
>  			 GFP_KERNEL);
> @@ -428,6 +448,22 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
>  	return xa_load(&iommu->pci_seg->dev_data_xa, devid);
>  }
>  
> +void amd_iommu_free_dev_data(struct amd_iommu *iommu,
> +			     struct iommu_dev_data *dev_data)
> +{
> +	if (!dev_data)
> +		return;
> +
> +	/*
> +	 * PCI/alias objects in the xarray are immortal. Never kfree
> +	 * those; synthetics must not be stored there.
> +	 */
> +	if (WARN_ON_ONCE(search_dev_data(iommu, dev_data->devid) == dev_data))
> +		return;
> +
> +	kfree(dev_data);
> +}
> +
>  static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
>  {
>  	struct dev_table_entry new;
> @@ -1826,7 +1862,11 @@ static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_
>  	u16 alias;
>  	int ret;
>  
> -	if (dev_is_pci(dev_data->dev))
> +	/*
> +	 * Synthetic DTEs leave dev_data->dev NULL; flush iommu->devid
> +	 * rather than walking PCI DMA aliases.
> +	 */
> +	if (dev_data->dev && dev_is_pci(dev_data->dev))
>  		pdev = to_pci_dev(dev_data->dev);
>  
>  	if (pdev)
> @@ -2770,6 +2810,51 @@ static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
>  	return &pdom->lock;
>  }
>  
> +#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
> +/*
> + * The vIOMMU private IPA domain programs a synthetic DTE for the
> + * IOMMU's own requester ID so hardware can DMA to backing store.
> + * That object is not on pdom->dev_list: it is not an IOMMU-API
> + * attach, and walkers such as rlookup and clone_aliases assume a
> + * real struct device.
> + *
> + * amd_iommu_change_top() therefore misses it. Early maps fit under
> + * the initial page-table top (PT_FEAT_DYNAMIC_TOP). Later DevID and
> + * DomID maps at high IPA call increase_top(); the old root stays
> + * live as a child of the new one, but the self DTE still holds the
> + * old MODE and would not translate those IOVAs.
> + *
> + * Walk iommu_array (from amd_iommu_pdom_bind_iommu()) and rewrite
> + * iommu->viommu_dev_data when this domain is that IOMMU's private
> + * IPA table. set_dte_entry() skips clone_aliases() because the
> + * synthetic DTE has no struct device.
> + */
> +static void update_viommu_self_dte(struct protection_domain *pdom,
> +				   phys_addr_t top_paddr,
> +				   unsigned int top_level)
> +{
> +	struct pdom_iommu_info *pdom_iommu_info;
> +	unsigned long i;
> +
> +	lockdep_assert_held(&pdom->lock);
> +
> +	xa_for_each(&pdom->iommu_array, i, pdom_iommu_info) {
> +		struct amd_iommu *iommu = pdom_iommu_info->iommu;
> +
> +		if (iommu->viommu_pdom != pdom || !iommu->viommu_dev_data)
> +			continue;
> +		set_dte_entry(iommu, iommu->viommu_dev_data, top_paddr,
> +			      top_level);
> +	}
> +}
> +#else
> +static inline void update_viommu_self_dte(struct protection_domain *pdom,
> +					  phys_addr_t top_paddr,
> +					  unsigned int top_level)
> +{
> +}
> +#endif
> +
>  /*
>   * Update all HW references to the domain with a new pgtable configuration.
>   */
> @@ -2792,6 +2877,7 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
>  		device_flush_dte(iommu, dev_data);
>  	}
>  
> +	update_viommu_self_dte(pdom, top_paddr, top_level);
>  	domain_flush_complete(pdom);
>  }
>  
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 89d6dc520b2c..3ec907a498c2 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -40,11 +40,55 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>  	}
>  }
>  
> +
> +static void viommu_free_self_dev_data(struct amd_iommu *iommu)
> +{
> +	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
> +	struct dev_table_entry new = {};
> +
> +	if (!dev_data)
> +		return;
> +
> +	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
> +	amd_iommu_update_dte(iommu, dev_data, &new);
Should check viommu_cmdbuf_enabled() first? If enabled then update dte.

Best Regards,
Guixin Liu
> +	amd_iommu_free_dev_data(iommu, dev_data);
> +	iommu->viommu_dev_data = NULL;
> +}
> +
> +static int viommu_alloc_self_dev_data(struct amd_iommu *iommu)
> +{
> +	struct protection_domain *pdom = iommu->viommu_pdom;
> +	struct pt_iommu_amdv1_hw_info pt_info;
> +	struct iommu_dev_data *dev_data;
> +	struct dev_table_entry new = {};
> +
> +	dev_data = amd_iommu_alloc_dev_data(iommu->devid);
> +	if (!dev_data) {
> +		pr_err("%s: Failed to allocate dev_data\n", __func__);
> +		return -ENOMEM;
> +	}
> +	/*
> +	 * Synthetic DTE for iommu->devid only: no struct device, so
> +	 * amd_iommu_update_dte() skips clone_aliases(), and not on
> +	 * pdom->dev_list (not an IOMMU-API attach).
> +	 */
> +	dev_data->dev = NULL;
> +	dev_data->domain = pdom;
> +	iommu->viommu_dev_data = dev_data;
> +
> +	amd_iommu_make_clear_dte(iommu, iommu->devid, &new);
> +	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
> +	amd_iommu_set_dte_v1(dev_data, pdom, pdom->id, &pt_info, &new);
> +	amd_iommu_update_dte(iommu, dev_data, &new);
> +	return 0;
> +}
> +
>  static void viommu_private_space_uninit(struct amd_iommu *iommu);
>  
>  void __init amd_viommu_uninit(struct amd_iommu *iommu)
>  {
>  	iommu->flags &= ~AMD_IOMMU_FLAG_VIOMMU_EN;
> +	viommu_free_self_dev_data(iommu);
>  	viommu_private_space_uninit(iommu);
>  	amd_viommu_vf_vfcntl_unmap(iommu);
>  }
> @@ -319,6 +363,10 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
>  	if (ret)
>  		goto err;
>  
> +	ret = viommu_alloc_self_dev_data(iommu);
> +	if (ret)
> +		goto err;
> +
>  	iommu->flags |= AMD_IOMMU_FLAG_VIOMMU_EN;
>  	return 0;
>  err:

