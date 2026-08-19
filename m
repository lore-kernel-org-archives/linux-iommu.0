Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B64052CD
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132533; cv=none; b=HiNbtJHvrDdcmLYyfX/+pWUKM1lHRZskAKW2HXfWzU3QMj2AZ6u3Gyf0byeCdrbI7WfgEMAR4Rv78EBRmOLpiycwdfsN9++jkzFYm0+S0C2JevhaR3jKQ0yoZK751zHiYsZBCJ6qj80UsvesuTXUtzO2egP2aAFJuHtyAZrD7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132533; c=relaxed/simple;
	bh=8wNerltbei32ndMFDpMAuaBlzKz1LwP6RGxaRGcBcgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyMww1st2r3leu0iBzESS/NfUgCTzgMTf/k7oxJL8/KvspYqDjJPp3ZB6ehfAGEiDCCOKgdcX9jPeIrmImubZek1YQu3DuGGUmQpBs4S+cOOIS0gyIqp/UlU+h1vijXZmZXWutplryACj66zAs1BD6Ydp9FcbHC9O37DHywHyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZOWw5X1G; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZOWw5X1G"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787132526; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fDB0IcQSSrF8k4igplotbN5f0ShPeRqkSX5NffFsUS0=;
	b=ZOWw5X1Gcrdg8peEzzIUYweudF+lkkjyR6OvQWHTq3d2Ld9kGCkznL6KJVHtPI3czJ9s4NGJwlsGO3p9W7N9YrjxmnnAbhEZV2zrs5gXjpYazde5nvJmWfJ7hzcIpVgdVzh77Nb8KAsin001ITBvIG/Yk0E6d/urT2q89fRwyhM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9GKTsp_1787132524;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9GKTsp_1787132524 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 17:42:05 +0800
Message-ID: <6576c2cf-fe35-4c64-ab19-0120494d7e42@linux.alibaba.com>
Date: Wed, 19 Aug 2026 17:42:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] iommu/amd: Relocate vIOMMU translate-device-id on
 PCI reserve
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-25-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-25-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
> When PCI attach reserves a BDF already allocated to a vIOMMU, relocate
> that vIOMMU to a newly allocated translate-device-id before marking the
> BDF reserved for the device.  Reprogram translation DTE and VFctrl under
> trans_devid_lock; roll back the pool on failure.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/trans_devid.c | 116 +++++++++++++++++++++++++++++++-
>   1 file changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
> index 9d7d93c5dcdb..6fb1ba3c9444 100644
> --- a/drivers/iommu/amd/trans_devid.c
> +++ b/drivers/iommu/amd/trans_devid.c
> @@ -82,16 +82,120 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
>   	xa_destroy(&pci_seg->trans_devid_xa);
>   }
>   
> +/**
> + * trans_devid_do_relocate - move vIOMMU translation DTE from @old_id to @new_id
> + *
> + * Caller holds @aviommu->trans_devid_lock.  Pool xarray already records @new_id
> + * as allocated to @aviommu and @old_id as reserved.
> + */
> +static int trans_devid_do_relocate(struct amd_iommu_viommu *aviommu,
> +				   u16 old_id, u16 new_id)
> +{
> +	struct iommufd_viommu *viommu = &aviommu->core;
> +	struct amd_iommu *iommu =
> +		container_of(viommu->iommu_dev, struct amd_iommu, iommu);
> +	int ret;
> +
> +	aviommu->trans_devid = new_id;
> +
> +	ret = amd_iommu_set_translate_dte(viommu);
> +	if (ret)
> +		goto err_restore_id;
> +
> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, new_id);
> +
> +	if (search_dev_data(iommu, old_id))
> +		amd_iommu_clear_translate_dte(iommu, old_id);
> +
> +	return 0;
> +
> +err_restore_id:
> +	aviommu->trans_devid = old_id;
> +	return ret;
> +}
> +
> +/**
> + * trans_devid_relocate - move an allocated id to a new slot and reserve @from_id
> + *
> + * Called when PCI attach needs a BDF that a vIOMMU already owns.  Updates the
> + * per-segment pool, then reprograms DTE and VFctrl on the owning vIOMMU.
> + *
> + * Locking: takes @aviommu->trans_devid_lock, then pci_seg->trans_devid_mutex
> + * (same order as destroy).  Hardware steps run with the viommu lock held and
> + * the segment mutex dropped.
> + */
> +static int trans_devid_relocate(struct amd_iommu_pci_seg *pci_seg, u16 from_id,
> +				struct amd_iommu_viommu *aviommu)
> +{
> +	u16 new_id;
> +	int ret;
> +
> +	mutex_lock(&aviommu->trans_devid_lock);
> +
> +	mutex_lock(&pci_seg->trans_devid_mutex);
> +	if (trans_devid_xa_owner(xa_load(&pci_seg->trans_devid_xa, from_id)) !=
> +	    aviommu) {
> +		ret = -ENOENT;
> +		goto unlock_seg;
> +	}
> +
> +	if (aviommu->trans_devid != from_id) {
> +		ret = -EINVAL;
> +		goto unlock_seg;
> +	}
> +
> +	new_id = trans_devid_find_free_locked(pci_seg);
> +	if (new_id < 0) {
> +		ret = new_id;
> +		goto unlock_seg;
> +	}


This has a type-truncation bug. trans_devid_find_free_locked() returns
int and signals failure with -ENOSPC. Assigning it to a u16 truncates
-ENOSPC (-28) to 65508 (0xFFDC), and the subsequent "if (new_id < 0)"
is always false for an unsigned u16. On pool exhaustion the code would
proceed to install and program a DTE with the bogus ID 65508. Please
change new_id to int:

     int new_id;



> +
> +	ret = trans_devid_xa_install_allocated_locked(pci_seg, new_id, aviommu);
> +	if (ret)
> +		goto unlock_seg;
> +
> +	ret = trans_devid_xa_install_reserved_locked(pci_seg, from_id);
> +	if (ret) {
> +		xa_erase(&pci_seg->trans_devid_xa, new_id);
> +		goto unlock_seg;
> +	}
> +
> +	mutex_unlock(&pci_seg->trans_devid_mutex);
> +
> +	ret = trans_devid_do_relocate(aviommu, from_id, new_id);
> +	if (ret) {
> +		mutex_lock(&pci_seg->trans_devid_mutex);
> +		xa_erase(&pci_seg->trans_devid_xa, new_id);
> +		trans_devid_xa_install_allocated_locked(pci_seg, from_id,
> +							aviommu);
> +		mutex_unlock(&pci_seg->trans_devid_mutex);
> +	}
> +
> +	mutex_unlock(&aviommu->trans_devid_lock);
> +	return ret;
> +
> +unlock_seg:
> +	mutex_unlock(&pci_seg->trans_devid_mutex);
> +	mutex_unlock(&aviommu->trans_devid_lock);
> +	return ret;
> +}
> +
>   /**
>    * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
>    *
>    * Reservation is done when attaching device to a domain (see amd_iommu_attach_device()).
>    *
> - * Return: 0 on success.  A second reserve of an already-reserved @id succeeds.
> + * When @id is allocated to a vIOMMU (e.g. after PCI hot-plug), the driver relocates
> + * that vIOMMU to a newly allocated translate-device-id and reserves @id for the PCI
> + * function.
> + *
> + * Return: 0 on success, %-ENOSPC if relocation cannot find a free id, or another
> + * errno from relocation.  A second reserve of an already-reserved @id succeeds.
>    */
>   int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
>   {
>   	void *entry;
> +	struct amd_iommu_viommu *aviommu;
>   	int ret = 0;
>   
>   	mutex_lock(&pci_seg->trans_devid_mutex);
> @@ -99,6 +203,16 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
>   	if (trans_devid_xa_is_reserved(entry))
>   		goto unlock;
>   
> +	aviommu = trans_devid_xa_owner(entry);
> +	if (aviommu) {
> +		mutex_unlock(&pci_seg->trans_devid_mutex);
> +		ret = trans_devid_relocate(pci_seg, id, aviommu);
> +		if (!ret)
> +			pr_debug("%s: Reserved trans_devid %#x after relocation (seg %#x)\n",
> +				 __func__, id, pci_seg->id);
> +		return ret;
> +	}
> +
>   	ret = trans_devid_xa_install_reserved_locked(pci_seg, id);
>   unlock:
>   	mutex_unlock(&pci_seg->trans_devid_mutex);
