Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750950129B
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061008; cv=none; b=sryRdZLYj2Q4vHw23VO4dTPmq6xaU9DCf26r24ARve56z7gtrcrkOzaGEbX4+CC8/tbVPVlLoy/1NKXNIhXytXKiRI8C4YCQxnOwbX7vxPOU673cUYHze64oZgotm28CCgghioIlaVUh988U2dPzXTqIcBv5L8pDvktqUrjsup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061008; c=relaxed/simple;
	bh=l4ETgjoi9sLVdEUOvHOO9DwcohkqbndYpHAAUEXbE6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFWzmgDtXuGBjPwcI8OKGhWNHAKIk3DY9hzsLOSL5DvIx1fGVVAPdAT14VB5Hvt28bmH6qVMiCwiKi534S7H9hsl4qLoJvtKK8vAVXHDtAew5QcJuKYcA+OoExWIW/60M65Z9cG4Y+w0KtMLnNUnhbRuK8aykLNGDk4jXn6RxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FB5q73m4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FB5q73m4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790060992; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Oo8Dq0mN2ZDYBVRnEYfmR+J/FTRcTErPirL0m9RByFs=;
	b=FB5q73m45h9jMtb+8GYSGSTE/vO9DD4LM/XyfFax/WyuCcND0L0OYi6ZYK4iSkd2jiK/CgPML/ZnLaGYuoUUvFHPoaF2xPZhj4C8vBjElJA7FUQwOzqwoFO0N4TLke7ybMmzKwrvtvXwKxWL4iIhnGdxBS3woVhriCAGWqlRoqU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XBT-CI9_1790060989;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBT-CI9_1790060989 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 15:09:51 +0800
Message-ID: <d4a0360a-fae1-484d-81ca-c926e4450265@linux.alibaba.com>
Date: Tue, 22 Sep 2026 15:09:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/24] iommu/amd: Assign per-vIOMMU translate device ID
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
 <20260914184750.222939-24-suravee.suthikulpanit@amd.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260914184750.222939-24-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/15 02:47, Suravee Suthikulpanit 写道:
> Allocate one translate-device-id per IOMMUFD vIOMMU instance from the
> per-segment pool on init.  Reset MMIO first, then program translation
> DTE and VFctrl TransDevID under trans_devid_lock so PCI-probe relocate
> cannot interleave.  Clear both on init error and destroy, and drop the
> id before amd_viommu_uninit_one().
>
> Initialize pdom_list before set_translate_dte() so list_empty() is
> valid. Drop the late list_add; set_translate_dte() already publishes
> the vIOMMU on viommu_list under pdom->lock. list_del_init() on init
> error if that add ran.
>
> Free the synthetic translate-device-id DTE object on init error and
> destroy; it is not stored in the per-segment xarray.
>
> Add per-vIOMMU trans_devid_lock to serialize DTE and VFctrl TransDevID
> updates on init and teardown.  VFctrl TransDevID is not written from
> amd_viommu_uninit_one().
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 10 +++++
>  drivers/iommu/amd/iommufd.c         | 66 +++++++++++++++++++++++++----
>  2 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5f84f25e3f37..c748bab27509 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -556,6 +556,16 @@ struct amd_iommu_viommu {
>  	/* Synthetic DTE; not stored in pci_seg->dev_data_xa */
>  	struct iommu_dev_data *trans_dev_data;
>  
> +	/*
> +	 * Serializes this vIOMMU's translation DTE and VFctrl TransDevID
> +	 * updates on init and teardown. VFctrl TransDevID is not written
> +	 * from amd_viommu_uninit_one().
> +	 *
> +	 * Nested lock order: trans_devid_lock, then
> +	 * pci_seg->trans_devid_mutex.
> +	 */
> +	struct mutex trans_devid_lock;
> +
>  	/*
>  	 * Serializes VFCTRL Guest DID map CONTROL0/CONTROL1 doorbells
>  	 * (DevID and DomID table updates) for this gid. Those registers
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 5760b183ce62..1c29d846beed 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -53,6 +53,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>  	int ret;
>  	unsigned long flags;
>  	phys_addr_t page_base;
> +	bool trans_devid_allocated = false;
> +	bool trans_dte_set = false;
> +	bool uninit_on_err = false;
>  	struct iommu_viommu_amd data = {};
>  	struct protection_domain *pdom = to_pdomain(parent);
>  	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> @@ -70,7 +73,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>  	if (ret)
>  		return ret;
>  
> +	mutex_init(&aviommu->trans_devid_lock);
>  	mutex_init(&aviommu->vfctrl_lock);
> +	INIT_LIST_HEAD(&aviommu->pdom_list);
>  	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>  	aviommu->parent = pdom;
>  
> @@ -93,31 +98,63 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>  
>  	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
>  
> -	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
> +	/* Reset vIOMMU MMIOs before the trans_devid is visible in the pool. */
>  	ret = amd_iommu_reset_vmmio(iommu, aviommu->gid);
>  	if (ret)
> -		goto err_init;
> +		goto err_trans_devid;
> +
> +	mutex_lock(&aviommu->trans_devid_lock);
> +	ret = amd_iommu_trans_devid_alloc(iommu->pci_seg, aviommu);
> +	if (ret < 0) {
> +		mutex_unlock(&aviommu->trans_devid_lock);
> +		goto err_trans_devid;
> +	}
> +	trans_devid_allocated = true;
> +	aviommu->trans_devid = ret;
> +
> +	ret = amd_iommu_set_translate_dte(viommu);
> +	if (ret)
> +		goto err_init_unlock;
> +	trans_dte_set = true;
> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid,
> +						     aviommu->trans_devid);
> +	mutex_unlock(&aviommu->trans_devid_lock);
>  
>  	ret = amd_viommu_init_one(iommu, aviommu);
>  	if (ret)
>  		goto err_init;
> +	uninit_on_err = true;
>  
>  	ret = iommu_copy_struct_to_user(user_data, &data,
>  					IOMMU_VIOMMU_TYPE_AMD,
>  					out_vfmmio_mmap_offset);
>  	if (ret)
> -		goto err_init_one;
> +		goto err_init;
>  
>  	viommu->ops = &amd_viommu_ops;
>  
> -	spin_lock_irqsave(&pdom->lock, flags);
> -	list_add(&aviommu->pdom_list, &pdom->viommu_list);
> -	spin_unlock_irqrestore(&pdom->lock, flags);
> -
>  	return 0;
> -err_init_one:
> -	amd_viommu_uninit_one(iommu, aviommu);
>  err_init:
> +	mutex_lock(&aviommu->trans_devid_lock);
> +err_init_unlock:
> +	if (trans_dte_set) {
> +		spin_lock_irqsave(&pdom->lock, flags);
> +		if (!list_empty(&aviommu->pdom_list))
> +			list_del_init(&aviommu->pdom_list);
> +		spin_unlock_irqrestore(&pdom->lock, flags);
> +		amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
> +		amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data,
> +					      aviommu->trans_devid);
> +		amd_iommu_free_dev_data(iommu, aviommu->trans_dev_data);
> +		aviommu->trans_dev_data = NULL;
> +	}
> +	if (trans_devid_allocated)
> +		amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid,
> +					   aviommu);
> +	mutex_unlock(&aviommu->trans_devid_lock);
> +	if (uninit_on_err)
> +		amd_viommu_uninit_one(iommu, aviommu);
> +err_trans_devid:
>  	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>  err_mmap:
>  	amd_iommu_gid_free(iommu, aviommu->gid);
> @@ -140,6 +177,17 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>  	spin_unlock_irqrestore(&pdom->lock, flags);
>  	xa_destroy(&aviommu->gdomid_array);
>  	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
> +
> +	mutex_lock(&aviommu->trans_devid_lock);
> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
> +	amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data,
> +				      aviommu->trans_devid);
> +	amd_iommu_free_dev_data(iommu, aviommu->trans_dev_data);
> +	aviommu->trans_dev_data = NULL;
> +	amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid,
> +				   aviommu);
> +	mutex_unlock(&aviommu->trans_devid_lock);
> +
>  	amd_viommu_uninit_one(iommu, aviommu);
>  	amd_iommu_gid_free(iommu, aviommu->gid);
>  	mutex_destroy(&aviommu->vfctrl_lock);
Should destroy trans_devid_lock too.

Best Regards,
Guixin Liu

