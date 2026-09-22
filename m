Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C84F7CA4
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061071; cv=none; b=EFMcvPY7D35nvmvVAtYtegO/PDvU+Xs6E/QULOglYQvLRebTTmHhBgNr29U8/ZsUOmrsrYgd8hHpMNDrqPrgROMtJR1g6WaTOtp+EqEaceQHkSgpyhocS6rFL4ofjfeZ8IyviyIb0dP2HuC2G8UOzTg7Z64bd0PUE5K1eNS3dIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061071; c=relaxed/simple;
	bh=FfsB0XUmoGGa7n8kwH1vAtypa2+/GT+qXUQgKp0PDTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9JRlT40Rqv3KPylCXkvHV+n/9ePhKNn1M1tQPyvwo9kTg9g76x72256TMT21KRNlAHdw5qIF3GP4w/kuwJ1lCaf5fRzYSK2afBq6iuL0M53VRpQzZ3BAA0/7OOox/W7pvnoWWshpiW9w/8croYvSSWfdPR5ivd6qf04yoYXcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vvWSSYwq; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vvWSSYwq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790061065; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kazTSKk2mO7WKQIyzJ78Q9Go0YwvZK23jXqXE5gbuLs=;
	b=vvWSSYwqHOayYh4wiXj4Q7x74mqZJM0FzafW3vKCZ8F3jv/5KKz0lAlfAZhatmmzllRtNwnRbBfQ5ps4D5Vbr4NPYdoglFCqGFO8bE8PgE+EecGOxa3V9BQgivYbDDxKXPzrhn4a9VRUvNP98BfoRjycjR+4JBeRnjo4J56helQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XBT-CpR_1790061061;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBT-CpR_1790061061 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 15:11:03 +0800
Message-ID: <a9465515-de05-4b85-891d-6cdbbd793195@linux.alibaba.com>
Date: Tue, 22 Sep 2026 15:11:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/24] iommu/amd: Program nested DTE and DomID map on
 attach
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
 <20260914184750.222939-18-suravee.suthikulpanit@amd.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260914184750.222939-18-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/15 02:47, Suravee Suthikulpanit 写道:
> On nested attach, the host DTE must enable vIOMMU and carry the guest
> device and guest IDs from the vDevice. Look up gdev_id with
> iommufd_viommu_get_vdev_id() and fail the attach if that lookup fails.
>
> Program the Domain ID mapping table through VFCTRL so hardware can
> translate gdom_id to hdom_id. Write CONTROL1 before the DTE is live
> with DTE_VIOMMU_EN so guest DMA cannot resolve against the idle
> nest-parent map.
>
> DomID CONTROL1 uses the same per-vIOMMU vfctrl_lock as DevID CONTROL0.
> Hold that lock across CONTROL1 and the DTE commit, and on last-ref
> nested_domain_free() take it before gdomid_array so idle restore
> cannot clobber a concurrent alloc+attach.
>
> CONTROL1 WRITE uses the same doorbell as CONTROL0. Poll WRITE until
> it clears; iommu_completion_wait() does not drain the table DMA.
>
> On the last nested_domain_free() for a gdom_id, restore the idle
> DomID map (nest parent, V=1) before returning hdom_id to the IDA.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 10 ++++
>  drivers/iommu/amd/amd_viommu.h      | 15 ++++++
>  drivers/iommu/amd/nested.c          | 74 +++++++++++++++++++++++++----
>  drivers/iommu/amd/viommu.c          | 49 +++++++++++++++++++
>  4 files changed, 140 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 07eaeeb72e38..b5d1b23791da 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -382,6 +382,11 @@
>  #define DTE_GPT_LEVEL_SHIFT	54
>  #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
>  
> +/* vIOMMU bit fields */
> +#define DTE_VIOMMU_EN_SHIFT		15
> +#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
> +#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
> +
>  #define GCR3_VALID		0x01ULL
>  
>  /* DTE[128:179] | DTE[184:191] */
> @@ -552,6 +557,11 @@ struct amd_iommu_viommu {
>  	 * (DevID and DomID table updates) for this gid. Those registers
>  	 * are shared by every vDevice on this vIOMMU; igroup locks are
>  	 * not. Do not nest with trans_devid_lock.
> +	 *
> +	 * nested_domain_free() last-ref takes this before
> +	 * gdomid_array's xa_lock so CONTROL1 idle restore cannot race
> +	 * a concurrent alloc+attach. Attach holds it across CONTROL1
> +	 * and the DTE commit.
>  	 */
>  	struct mutex vfctrl_lock;
>  
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index 1022ae20c170..f17ac13da213 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -23,6 +23,11 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
>  
>  void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
>  
> +void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
> +				 u16 hdom_id, u16 gdom_id);
No one call amd_viommu_domain_id_update, should removed?

Best Regards,
Guixin Liu
> +void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
> +					u16 hdom_id, u16 gdom_id);
> +
>  void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
>  				   u16 hdev_id, u16 gdev_id);
>  #else
> @@ -51,6 +56,16 @@ static inline void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviomm
>  {
>  }
>  
> +static inline void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
> +					       u16 hdom_id, u16 gdom_id)
> +{
> +}
> +
> +static inline void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
> +						      u16 hdom_id, u16 gdom_id)
> +{
> +}
> +
>  #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>  
>  #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 8bb0d1596c6c..ecdcecdc0bb7 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -10,6 +10,7 @@
>  #include <uapi/linux/iommufd.h>
>  
>  #include "amd_iommu.h"
> +#include "amd_viommu.h"
>  
>  static const struct iommu_domain_ops nested_domain_ops;
>  
> @@ -188,13 +189,16 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  	return ERR_PTR(ret);
>  }
>  
> -static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
> -			   struct iommu_dev_data *dev_data, struct dev_table_entry *new)
> +static int set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
> +			  struct iommu_dev_data *dev_data, struct dev_table_entry *new)
>  {
> +	int ret;
> +	u16 gid;
>  	struct protection_domain *parent;
>  	struct nested_domain *ndom = to_ndomain(dom);
>  	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
>  	struct pt_iommu_amdv1_hw_info pt_info;
> +	unsigned long gdev_id;
>  
>  	/*
>  	 * The nest parent domain is attached during the call to the
> @@ -202,9 +206,15 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
>  	 * of the struct amd_iommu_viommu.parent.
>  	 */
>  	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
> -		return;
> +		return -EINVAL;
>  
> +	gid = ndom->viommu->gid;
>  	parent = ndom->viommu->parent;
> +
> +	ret = iommufd_viommu_get_vdev_id(&ndom->viommu->core, dev_data->dev, &gdev_id);
> +	if (ret)
> +		return ret;
> +
>  	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
>  
>  	/* Retrieve the current pagetable info via the IOMMU PT API. */
> @@ -232,12 +242,19 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
>  
>  	/* Guest paging mode */
>  	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
> +
> +	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK, gdev_id);
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK, gid);
> +
> +	return 0;
>  }
>  
>  static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>  				struct iommu_domain *old)
>  {
>  	struct dev_table_entry new = {0};
> +	struct nested_domain *ndom = to_ndomain(dom);
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>  	int ret = 0;
> @@ -251,10 +268,23 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>  
>  	mutex_lock(&dev_data->mutex);
>  
> -	set_dte_nested(iommu, dom, dev_data, &new);
> +	ret = set_dte_nested(iommu, dom, dev_data, &new);
> +	if (ret)
> +		goto out_err;
>  
> +	/*
> +	 * Program gdom_id -> hdom_id before the DTE is live with
> +	 * DTE_VIOMMU_EN. Hold vfctrl_lock across both so a concurrent
> +	 * last-ref free cannot restore the idle map in between.
> +	 */
> +	mutex_lock(&ndom->viommu->vfctrl_lock);
> +	amd_viommu_domain_id_update_locked(ndom->viommu,
> +					   ndom->gdom_info->hdom_id,
> +					   ndom->gdom_id);
>  	amd_iommu_update_dte(iommu, dev_data, &new);
> +	mutex_unlock(&ndom->viommu->vfctrl_lock);
>  
> +out_err:
>  	mutex_unlock(&dev_data->mutex);
>  
>  	return ret;
> @@ -267,10 +297,18 @@ static void nested_domain_free(struct iommu_domain *dom)
>  	struct nested_domain *ndom __free(kfree) = to_ndomain(dom);
>  	struct amd_iommu_viommu *aviommu = ndom->viommu;
>  
> +	/*
> +	 * vfctrl_lock then gdomid_array: keep the slot empty in the
> +	 * xarray until CONTROL1 is idle so a concurrent alloc+attach
> +	 * for this gdom_id cannot publish H2 and then lose it to this
> +	 * restore. Attach takes the same lock around CONTROL1 + DTE.
> +	 */
> +	mutex_lock(&aviommu->vfctrl_lock);
>  	xa_lock_irqsave(&aviommu->gdomid_array, irqflags);
>  
>  	if (!refcount_dec_and_test(&ndom->gdom_info->users)) {
>  		xa_unlock_irqrestore(&aviommu->gdomid_array, irqflags);
> +		mutex_unlock(&aviommu->vfctrl_lock);
>  		return;
>  	}
>  
> @@ -282,14 +320,34 @@ static void nested_domain_free(struct iommu_domain *dom)
>  			    ndom->gdom_info, NULL, GFP_ATOMIC);
>  
>  	xa_unlock_irqrestore(&aviommu->gdomid_array, irqflags);
> -	if (WARN_ON(!curr || xa_err(curr)))
> +	if (WARN_ON(!curr || xa_err(curr))) {
> +		mutex_unlock(&aviommu->vfctrl_lock);
>  		return;
> +	}
>  
> -	/* success */
>  	pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
> -		__func__, ndom->gdom_id, curr->hdom_id);
> +		 __func__, ndom->gdom_id, curr->hdom_id);
> +
> +	/*
> +	 * Restore the idle DomID map before releasing hdom_id. Every
> +	 * slot stays V=1; unknown mapping raises an event. Idle is the
> +	 * nest parent CONTROL1 map, same as vIOMMU init prefill.
> +	 * amd_iommu_reset_vmmio() only resets guest MMIO.
> +	 *
> +	 * Guest INVALIDATE_IOMMU_ALL walks the HW table, not
> +	 * gdomid_array. The pdom_ids IDA is global, so a stale V=1
> +	 * entry can invalidate a recycled hdom_id that now belongs to
> +	 * another domain.
> +	 *
> +	 * Detach does not clear this slot: hdom_id stays allocated
> +	 * until this last free, so a lingering gdom_id -> hdom_id
> +	 * map cannot point at a recycled ID.
> +	 */
> +	amd_viommu_domain_id_update_locked(aviommu, aviommu->parent->id,
> +					   ndom->gdom_id);
> +	mutex_unlock(&aviommu->vfctrl_lock);
>  
> -	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
> +	amd_iommu_pdom_id_free(curr->hdom_id);
>  	kfree(curr);
>  }
>  
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 556864eaaa0d..7521f470e5d4 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -46,6 +46,7 @@ static_assert(VIOMMU_DOMID_MAPPING_ENTRY_SIZE >=
>  	      (VIOMMU_MAX_GDOMID + 1ULL) * sizeof(u64));
>  
>  #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
>  
>  static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>  {
> @@ -510,6 +511,54 @@ void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
>  	mutex_unlock(&aviommu->vfctrl_lock);
>  }
>  
> +#define DOMID_ENTRY_GDOMID_MASK	GENMASK_ULL(61, 46)
> +#define DOMID_ENTRY_HDOMID_MASK	GENMASK_ULL(29, 14)
> +#define DOMID_ENTRY_VALID		BIT_ULL(0)
> +#define DOMID_ENTRY_WRITE		BIT_ULL(63)
> +
> +/*
> + * Guest DomID table update via VFCTRL CONTROL1. Same WRITE-bit
> + * doorbell as CONTROL0.
> + */
> +static void domain_id_update_unlocked(struct amd_iommu *iommu, u16 gid,
> +				      u16 hdom_id, u16 gdom_id)
> +{
> +	u64 val;
> +	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
> +
> +	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
> +	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
> +	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
> +
> +	vfctrl_wait_write_clear(iommu, gid,
> +			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
> +	vfctrl_wait_write_clear(iommu, gid,
> +			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
> +}
> +
> +/*
> + * Program a gdom_id -> hdom_id entry through VFCTRL CONTROL1.
> + * Caller must hold aviommu->vfctrl_lock.
> + */
> +void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
> +					u16 hdom_id, u16 gdom_id)
> +{
> +	struct amd_iommu *iommu =
> +		container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
> +
> +	lockdep_assert_held(&aviommu->vfctrl_lock);
> +	domain_id_update_unlocked(iommu, aviommu->gid, hdom_id, gdom_id);
> +}
> +
> +void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
> +				 u16 hdom_id, u16 gdom_id)
> +{
> +	mutex_lock(&aviommu->vfctrl_lock);
> +	amd_viommu_domain_id_update_locked(aviommu, hdom_id, gdom_id);
> +	mutex_unlock(&aviommu->vfctrl_lock);
> +}
> +
>  void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
>  {
>  	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);

