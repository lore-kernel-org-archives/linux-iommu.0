Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001B448D16
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136352; cv=none; b=JH+VdxN5xiY+Fmj8BfR9S6LN07lVDbTFTaG6lK9xG2S2VJE9o1IXMiASmnxR9sFh7QjMdTt+cgIl5G6/p/K85B1CirmTwSrd/ywaydkNs0mKOmNkp7EH5yIVxMFWSirzAmU0ymiS8UWjXTUoIXlFw2thPJgOHORjHANzNvzWVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136352; c=relaxed/simple;
	bh=g5jrPRSkRs3F7TW3IvyhzqVyEeIknFx1gatRmX1Zc5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoUV2yDOLKdujztzeqP9mj3h9zFx/mxfsUaNioU56ssmwXUG7jbG9RNVso+9TrVX9aDCyjNsSkoL4gBchvTF3+kcupAdEtc8LDvjkHwDNk1bgiTRqCokYYvdRLeEvm/4XtTatWphanckEXuKZeUgm8AG6ba4HOaOQRGTt9mDb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YbXFH7wd; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YbXFH7wd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787136343; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KSTDxDhLrT908WOKXzWgLJDANqb1r9I/Uh+6QQ0jx7I=;
	b=YbXFH7wdRjz/4BWHKoBPKTPrjtSn7UCewAZVuoviSy+jirvaoBj43cpobbjFQYUMIUmWi5nxzhtKZqLiLxF8TDiwXkBWFzeZ1CTO9IekmKhcmAZ5CynTSZomnigOA+ERdR4IFvh/cpVwypLgJ131Z5Vkle9vam4BthvFUCpoMlo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9GQF.K_1787136341;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9GQF.K_1787136341 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 18:45:42 +0800
Message-ID: <c5f7f26f-ea3f-48a8-a2ac-5320155fd824@linux.alibaba.com>
Date: Wed, 19 Aug 2026 18:45:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] iommu/amd: Introduce helper function for updating
 domain ID mapping table
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-18-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-18-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
> AMD vIOMMU hardware uses the Domain ID mapping table to map Guest Domain ID
> (GDomID) to Host Domain ID when it virtualises guest IOMMU commands.
> It uses GID and GDomID to index into the table to look up host domain ID.
>
> Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Domain
> Map Control Register.
>
> Introduce amd_viommu_domain_id_update(), which is used to set the entry
> when attaching the nested device. Clearing the entry is done during VM
> destroy.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_viommu.h |  2 ++
>   drivers/iommu/amd/nested.c     |  9 ++++++-
>   drivers/iommu/amd/viommu.c     | 45 ++++++++++++++++++++++++++++++++++
>   3 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index 8b57717c22a6..b6fd5ffc3b82 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -18,6 +18,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
>   
>   void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
>   
> +int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
> +				u16 hdom_id, u16 gdom_id);
>   #else
>   
>   static inline int amd_viommu_init(struct amd_iommu *iommu)
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 6f3ae2496160..1365c67168b6 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -254,6 +254,7 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>   				struct iommu_domain *old)
>   {
>   	struct dev_table_entry new = {0};
> +	struct nested_domain *ndom = to_ndomain(dom);
>   	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>   	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>   	int ret = 0;
> @@ -267,10 +268,16 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>   
>   	mutex_lock(&dev_data->mutex);
>   
> -	set_dte_nested(iommu, dom, dev_data, &new);
> +	ret = set_dte_nested(iommu, dom, dev_data, &new);
> +	if (ret)
> +		goto out_err;
>   
>   	amd_iommu_update_dte(iommu, dev_data, &new);
>   
> +	ret = amd_viommu_domain_id_update(iommu, ndom->viommu->gid,
> +					  ndom->gdom_info->hdom_id, ndom->gdom_id);
> +
> +out_err:
>   	mutex_unlock(&dev_data->mutex);
>   
>   	return ret;
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 91d0dd3ac912..708f2c7496a4 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -40,6 +40,8 @@
>   #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
>   #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
>   
> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
> +
>   LIST_HEAD(viommu_devid_map);
>   
>   static int viommu_init_pci_vsc(struct amd_iommu *iommu)
> @@ -420,6 +422,22 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
>   	*entry = NULL;
>   }
>   
> +static void viommu_clear_mapping(struct amd_iommu *iommu,
> +				 struct amd_iommu_viommu *aviommu)
> +{
> +	int i;
> +	u16 gid = aviommu->gid;
> +
> +	/*
> +	 * IOMMU hardware uses the domain ID mapping table to map gdom ID to hdom ID.
> +	 * If the mapping does not exist, the hardware would generate error in the event log.
> +	 * Therefore, initialize all gdom ID entries to map to parent domain ID to prevent
> +	 * unknown mapping scenario.
> +	 */
> +	for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
> +		amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
> +}
> +
>   void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
>   {
>   	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
> @@ -432,6 +450,7 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
>   			       VIOMMU_DOMID_MAPPING_BASE,
>   			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
>   			       aviommu->gid);
> +	viommu_clear_mapping(iommu, aviommu);
>   }

Use-after-free in vIOMMU teardown ordering
The teardown path releases the DevID/DomID mapping table memory
BEFORE resetting the vIOMMU state:

      free_private_vm_region(iommu, &aviommu->devid_table, ...);
      free_private_vm_region(iommu, &aviommu->domid_table, ...);
      ...
      viommu_clear_mapping(iommu, aviommu);   /* too late */

    Since the IOMMU hardware may still reference these tables until the
    guest vIOMMU state is reset, freeing the backing memory first can
    result in a use-after-free by hardware.

>   
>   int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
> @@ -452,8 +471,34 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
>   	if (ret)
>   		goto err_out;
>   
> +	viommu_clear_mapping(iommu, viommu);
> +
>   	return 0;
>   err_out:
>   	amd_viommu_uninit_one(iommu, viommu);
>   	return -ENOMEM;
>   }
> +
> +/*
> + * Program the DomID via VFCTRL registers
> + * This function will be called during VM init via VFIO.
> + */
> +
> + #define DOMID_ENTRY_GDOMID_MASK	GENMASK_ULL(61, 46)
> + #define DOMID_ENTRY_HDOMID_MASK	GENMASK_ULL(29, 14)
> + #define DOMID_ENTRY_VALID		BIT_ULL(0)
> + #define DOMID_ENTRY_WRITE		BIT_ULL(63)
> +
> +int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
> +				u16 hdom_id, u16 gdom_id)
> +{
> +	u64 val;
> +	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
> +
> +	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
> +	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
> +	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
> +
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
> +	return 0;
> +}
