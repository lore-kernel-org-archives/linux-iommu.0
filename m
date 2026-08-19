Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF200110
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146457; cv=none; b=TckenQpl9LzLyZ2i3H6qOW9oSGoueeG5kB8iath+uyTRqoOMY7E6R2BN+4lJoPBHWIXeaynrR43QsNgoyFCjf9jpfgfBbhkcif4WF9v6LBbUtC9tmVCZ49347RRGL7iYZJ4JaqhieMc/h2i/lGOm92hj3G464zjcFeYPAE/lCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146457; c=relaxed/simple;
	bh=rlrmMp92pOovORco3AnS69Jj1lkAhO2MW/3t3araPkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQd3KUPdzcj7luS7C1Jh/wzDRh9/lrAha6Dlo3p3uNyuVWbg0NvR7UcObr83o4jwJ62G++Ibm1BVOS1xLRbCl9y0xyexPdi7GwGGWIW0DhLE7Bl9ZneScjWbQsqgeJfSprDimSvYcs9JcDSm/qR2KifL+/jfdRgLjJfF+r4WcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MbSiu8rB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MbSiu8rB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787146451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LSzR+ioQCez5XNEnsRJG+6PbQ2wRWK2ykPJNBMniWUU=;
	b=MbSiu8rB/LjiEvY8442fIG9gK8Rm5oQOiERZRH4zs2Rf00FkPWWO4OsbBBEGrpr8Iar605KB+IVkXcsNi5LrYzu4jGl8G0oLk2IQrU/Zdsd9LFgkRk/7SE8tVWv5EcZa8uFelwQ4Lu5/r8+EJ/Kicvd6AKxh/KiDMWyRyOE4Xw0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9GlYZM_1787146449;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9GlYZM_1787146449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 21:34:10 +0800
Message-ID: <916adcd5-63fd-49b2-b175-c7b509991e37@linux.alibaba.com>
Date: Wed, 19 Aug 2026 21:34:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] iommu/amd: Introduce IOMMUFD vDevice support for
 AMD
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-17-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-17-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
> Initialize vDevice for AMD vIOMMU by setting up the Device ID Mapping
> table using the guest device ID.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
>   drivers/iommu/amd/iommufd.c         | 31 +++++++++++++++++++++++++++++
>   drivers/iommu/amd/nested.c          | 27 ++++++++++++++++++++++---
>   3 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 03346258e2dc..39aa872c2741 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -388,6 +388,11 @@
>   #define DTE_GPT_LEVEL_SHIFT	54
>   #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
>   
> +/* vIOMMU bit fields */
> +#define DTE_VIOMMU_EN_SHIFT		15
> +#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
> +#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
> +
>   #define GCR3_VALID		0x01ULL
>   
>   /* DTE[128:179] | DTE[184:191] */
> @@ -895,6 +900,7 @@ struct iommu_dev_data {
>   	bool defer_attach;
>   
>   	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
> +
>   };
>   
>   /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
> @@ -1122,6 +1128,10 @@ struct amd_irte_ops {
>   	void (*clear_allocated)(struct irq_remap_table *, int);
>   };
>   
> +struct amd_iommu_vdevice {
> +	struct iommufd_vdevice core;
> +};
> +
>   #ifdef CONFIG_IRQ_REMAP
>   extern struct amd_irte_ops irte_32_ops;
>   extern struct amd_irte_ops irte_128_ops;
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index bfc4b0ec22a9..1975b2932107 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -9,6 +9,7 @@
>   #include "amd_iommu.h"
>   #include "amd_viommu.h"
>   #include "amd_iommu_types.h"
> +#include "../iommufd/iommufd_private.h"
>   
>   static const struct iommufd_viommu_ops amd_viommu_ops;
>   
> @@ -126,6 +127,34 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>   	amd_iommu_gid_free(iommu, aviommu->gid);
>   }
>   
> +/*
> + * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
> + */
> +static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
> +{
> +	struct iommu_dev_data *dev_data;
> +	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +
> +	if (!pdev) {
> +		pr_err("%s: not a PCI device\n", __func__);
> +		return -EINVAL;
> +	}
> +

to_pci_dev() is a container_of(), so it can never return NULL and the
!pdev check is dead code. Worse, for a non-PCI device it yields a bogus
pointer which is then dereferenced through dev_iommu_priv_get() below.

> +	dev_data = dev_iommu_priv_get(&pdev->dev);
> +	if (!dev_data) {
> +		pr_err("%s: Device not found (devid=%#x)\n",
> +		       __func__, pci_dev_id(pdev));
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
> +		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
> +
> +	return 0;
> +}
> +
>   /*
>    * See include/linux/iommufd.h
>    * struct iommufd_viommu_ops - vIOMMU specific operations
> @@ -133,4 +162,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>   static const struct iommufd_viommu_ops amd_viommu_ops = {
>   	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
>   	.destroy = amd_iommufd_viommu_destroy,
> +	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
> +	.vdevice_init = _amd_viommu_vdevice_init,
>   };
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 81a5ae00225e..6f3ae2496160 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -10,6 +10,7 @@
>   #include <uapi/linux/iommufd.h>
>   
>   #include "amd_iommu.h"
> +#include "amd_viommu.h"
>   
>   static const struct iommu_domain_ops nested_domain_ops;
>   
> @@ -183,13 +184,16 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>   	return ERR_PTR(ret);
>   }
>   
> -static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
> -			   struct iommu_dev_data *dev_data, struct dev_table_entry *new)
> +static int set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
> +			  struct iommu_dev_data *dev_data, struct dev_table_entry *new)
>   {
> +	int ret;
> +	u16 gid;
>   	struct protection_domain *parent;
>   	struct nested_domain *ndom = to_ndomain(dom);
>   	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
>   	struct pt_iommu_amdv1_hw_info pt_info;
> +	unsigned long gDevId;
>   
>   	/*
>   	 * The nest parent domain is attached during the call to the
> @@ -197,9 +201,15 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
>   	 * of the struct amd_iommu_viommu.parent.
>   	 */
>   	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
> -		return;
> +		return -EINVAL;
>   
> +	gid = ndom->viommu->gid;
>   	parent = ndom->viommu->parent;
> +
> +	ret = iommufd_viommu_get_vdev_id(&ndom->viommu->core, dev_data->dev, &gDevId);
> +	if (ret)
> +		return ret;
> +
>   	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
>   
>   	/* Retrieve the current pagetable info via the IOMMU PT API. */
> @@ -227,6 +237,17 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
>   
>   	/* Guest paging mode */
>   	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
> +
> +	/* vImuEn */
> +	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
> +
> +	/* GDeviceID */
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK, (u16)gDevId);
> +
> +	/* GuestID */
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK, gid);
> +
> +	return 0;
>   }
>   
>   static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
