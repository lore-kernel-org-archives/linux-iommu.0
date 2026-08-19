Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98908442390
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134733; cv=none; b=ecHDfP6ax1+tiliyKAkZSz7zr9ZDSpTtNZZjWkaXhmZhPs55dPxLGXAdx20MwBrtxAd9Y4IhUE96fIGCMzDGuKyQ9PAWBHiQB8SixZd12QcWHRzR7wScoWKWsBa0Ch2tdv47SdhAbwi0STdbsUkeXnIMYG6pD+lsT29u9kknSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134733; c=relaxed/simple;
	bh=onWjRpZablLVS+yv5pHlETJf/pR+xQVMR6JNIffkkvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/675Fbp8G2fhQrv2rbuVJ7kJUU419bzWE4jq0doqooe9R8hmHF2l5x9WiFvXK9jSD4lum+Ej9S0Bd2DA3TeviW4U6EUIdZ+HAEGvs/MVYj5l+h7mtaroYjegQCmhdU2lzLa2e4GMdlwHA36mIWQSbM+DwmZ8XYkAZMyIPx92oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d1q6/2kF; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d1q6/2kF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787134719; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BwIPHXhR5K346v+/H8G6qGs8DRyMrp5gOIxwHTiEyZA=;
	b=d1q6/2kFHNAO9mhgsp0H8/LYfA/wEXP21vwUAozanQmcB03yqL6a9UKsSRm1Rgcm9bBFtbQ1mNOyYCjbCUTrIo/LnOTLlKVacnfzVoxdsuCNloUJylnGZxvDYWFkcftwcpGhx/br9qDSEduUtguwDJxkhqnHZRd3mlWMNQrUKD8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9GKf0X_1787134717;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9GKf0X_1787134717 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 18:18:38 +0800
Message-ID: <23d80e6f-b4dc-45f9-856f-fb21b1905304@linux.alibaba.com>
Date: Wed, 19 Aug 2026 18:18:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] iommu/amd: Assign per-vIOMMU translate device ID
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-24-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-24-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
> Allocate one translate-device-id per IOMMUFD vIOMMU instance from the
> per-segment pool on init.  Program translation DTE and VFctrl TransDevID
> after MMIO reset; clear both on init error and destroy.
>
> Add per-vIOMMU trans_devid_lock to serialize DTE and VFctrl updates
> during teardown.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  7 ++++++
>   drivers/iommu/amd/iommufd.c         | 35 +++++++++++++++++++++++++++++
>   drivers/iommu/amd/viommu.c          |  2 ++
>   3 files changed, 44 insertions(+)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index f288a7b384d0..39cf2c588106 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -559,6 +559,13 @@ struct amd_iommu_viommu {
>   	u64 *domid_table;
>   	u16 trans_devid;
>   
> +	/*
> +	 * Serializes translate-device-id hardware changes (DTE, VFctrl) and
> +	 * coordinates with pool relocation during PCI attach.  Lock ordering:
> +	 * pci_seg->trans_devid_mutex, then trans_devid_lock.
> +	 */
> +	struct mutex trans_devid_lock;
> +
>   	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
>   	unsigned long vfmmio_mmap_offset;
>   };
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 7e070f72f02e..43575af59bba 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -48,11 +48,15 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>   	int ret;
>   	phys_addr_t page_base;
>   	unsigned long flags;
> +	u16 trans_devid;
> +	bool trans_devid_allocated = false;
> +	bool trans_dte_set = false;
>   	struct iommu_viommu_amd data = {};
>   	struct protection_domain *pdom = to_pdomain(parent);
>   	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>   	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
>   
> +	mutex_init(&aviommu->trans_devid_lock);
>   	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>   	aviommu->parent = pdom;
>   
> @@ -81,9 +85,22 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>   
>   	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
>   
> +	ret = amd_iommu_trans_devid_alloc(iommu->pci_seg, aviommu);
> +	if (ret < 0)
> +		goto err_trans_devid;
> +	trans_devid = ret;
> +	trans_devid_allocated = true;
> +	aviommu->trans_devid = trans_devid;
> +
>   	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
>   	iommu_reset_vmmio(iommu, aviommu->gid);
>   
> +	ret = amd_iommu_set_translate_dte(viommu);
> +	if (ret)
> +		goto err_init;
> +	trans_dte_set = true;
> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, trans_devid);
> +
>   	ret = amd_viommu_init_one(iommu, aviommu);
>   	if (ret)
>   		goto err_init;
> @@ -102,6 +119,18 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>   
>   	return 0;
>   err_init:
> +	if (trans_dte_set) {
> +		mutex_lock(&aviommu->trans_devid_lock);
> +		amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
> +		amd_iommu_clear_translate_dte(iommu, trans_devid);
> +		mutex_unlock(&aviommu->trans_devid_lock);
> +	}
> +	if (trans_devid_allocated) {
> +		mutex_lock(&aviommu->trans_devid_lock);
> +		amd_iommu_trans_devid_free(iommu->pci_seg, trans_devid, aviommu);
> +		mutex_unlock(&aviommu->trans_devid_lock);
> +	}
> +err_trans_devid:
>   	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>   err_mmap:
>   	amd_iommu_gid_free(iommu, aviommu->gid);
> @@ -124,6 +153,12 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>   	xa_destroy(&aviommu->gdomid_array);
>   	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>   	amd_viommu_uninit_one(iommu, aviommu);
> +
> +	mutex_lock(&aviommu->trans_devid_lock);
> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
> +	amd_iommu_clear_translate_dte(iommu, aviommu->trans_devid);
> +	amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid, aviommu);
> +	mutex_unlock(&aviommu->trans_devid_lock);
>   	amd_iommu_gid_free(iommu, aviommu->gid);
>   }

The comment states "pci_seg->trans_devid_mutex, then trans_devid_lock"
as the lock ordering. However, examining the actual code paths:

In amd_iommufd_viommu_destroy():
   mutex_lock(&aviommu->trans_devid_lock);          /* viommu lock first */
   ...
   amd_iommu_trans_devid_free(...);                  /* takes seg_mutex 
inside */
   mutex_unlock(&aviommu->trans_devid_lock);

In amd_iommu_trans_devid_free():
   mutex_lock(&pci_seg->trans_devid_mutex);          /* seg_mutex nested */

In trans_devid_relocate() (Patch 24):
   mutex_lock(&aviommu->trans_devid_lock);          /* viommu lock first */
   mutex_lock(&pci_seg->trans_devid_mutex);          /* seg_mutex second */

All paths consistently take trans_devid_lock first, then
trans_devid_mutex (nested). The actual ordering is the opposite of
what the comment describes:

   Actual:   trans_devid_lock -> trans_devid_mutex
   Comment:  trans_devid_mutex -> trans_devid_lock

The code is consistent and there is no deadlock risk, but the
comment should be corrected to avoid confusing future readers:

   * Lock ordering: trans_devid_lock, then pci_seg->trans_devid_mutex.



>   
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index eb3f5217d856..ae4a6a2cae39 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -501,6 +501,8 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
>   			       VIOMMU_DOMID_MAPPING_BASE,
>   			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
>   			       aviommu->gid);
> +
> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
>   	viommu_clear_mapping(iommu, aviommu);
>   }
>   
