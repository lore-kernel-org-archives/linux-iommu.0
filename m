Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF13F1ABF
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135226; cv=none; b=tm0cAxSMIExJjMunHAHb90LURweexKsvCR4qsDklzod8yoWaFyHacs1FUjd4bRJnT9GgV9qtUdZKZwy6hL0faJckc4NTPzteKEzypDX1RgXv1lenJDZPo0ZW95zG+vBfdcybCvwMpvyiEzNyhXQREYFzFiLrP3lDiYJP3BYQAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135226; c=relaxed/simple;
	bh=2K12G+UsxWvuT6PI+vBdCRiSAFfj9IaB21wxk9MChhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dm/sRQ6Z4gbUl/By7CmrsOHBGv+/mP+EkLp1YN+0b6TPMMiaERShgg9FsG5gmFodiHT3jmEgl+7L3m/3xhyqHj/NGn//HeHrITMineeQGuZqyvbQa4sxiyuhGvqUh5N8k8RQhgfdgb4DT6to0O9KBlfiJ51s1AAHYB1Tsdc5aVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f6wJ+xl+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f6wJ+xl+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787135220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KTI//5fzqAJt4l+xabp82wR7XBF9tGw/atv4GgSp4tU=;
	b=f6wJ+xl+glrg8yi4TD25juLnGevr+KqvzqIPbC1ECXalBCVzAg0KjBZSVZplFDbMpuJ8ra6Q2czroCZfXvu8zoEkpKdqmck2Povu9LWzvjvTHu4KwaFuxSGFLXaysZvUXsnhLEQ55ORhM2G8YoMTpiDSyOqNgvfTMfwxmjhcGfA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9GKhBe_1787135219;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9GKhBe_1787135219 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 18:26:59 +0800
Message-ID: <fbfc7a4a-3108-4cc0-b6d4-d89f56393aba@linux.alibaba.com>
Date: Wed, 19 Aug 2026 18:26:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] iommu/amd: Introduce helper function for updating
 device ID mapping table
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
> AMD vIOMMU hardware uses the Device ID mapping table to map Guest Device ID
> (GDevID) to Host Device ID when it virtualises guest IOMMU commands.
> It uses GID and GDevID to indexe into the table to look up host device ID.
>
> Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Device
> Map Control Register.
>
> Introduce amd_viommu_set/clear_device_mapping(), which are used to set
> the entry when initialize the IOMMUFD vDevice.  Clearing the entry is
> done during VM destroy.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_viommu.h | 10 +++++++
>   drivers/iommu/amd/iommufd.c    |  9 ++++++
>   drivers/iommu/amd/viommu.c     | 53 +++++++++++++++++++++++++++++++++-
>   3 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index b6fd5ffc3b82..ca09a9856938 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -6,6 +6,8 @@
>   #ifndef AMD_VIOMMU_H
>   #define AMD_VIOMMU_H
>   
> +#define VIOMMU_MAX_GDEVID	0xFFFF
> +
>   #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
>   
>   int amd_viommu_init(struct amd_iommu *iommu);
> @@ -20,6 +22,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *vio
>   
>   int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
>   				u16 hdom_id, u16 gdom_id);
> +
> +void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
> +				   u16 guestId, u16 gDevId);
>   #else
>   
>   static inline int amd_viommu_init(struct amd_iommu *iommu)
> @@ -45,6 +50,11 @@ static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iom
>   {
>   }
>   
> +static inline void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
> +						 u16 guestId, u16 gDevId)
> +{
> +}
> +
>   #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>   
>   #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 1975b2932107..7e070f72f02e 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -136,12 +136,18 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
>   	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
>   	struct iommufd_viommu *viommu = vdev->viommu;
>   	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>   
>   	if (!pdev) {
>   		pr_err("%s: not a PCI device\n", __func__);
>   		return -EINVAL;
>   	}
>   
> +	if (vdev->virt_id > VIOMMU_MAX_GDEVID) {
> +		pr_err("%s: Invalid virtual ID (virt_id=%#llx)\n", __func__, vdev->virt_id);
> +		return -EINVAL;
> +	}
> +
>   	dev_data = dev_iommu_priv_get(&pdev->dev);
>   	if (!dev_data) {
>   		pr_err("%s: Device not found (devid=%#x)\n",
> @@ -152,6 +158,9 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
>   	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
>   		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
>   
> +	amd_viommu_set_device_mapping(iommu, pci_dev_id(pdev), aviommu->gid,
> +				       (u16)vdev->virt_id);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 708f2c7496a4..eb3f5217d856 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -29,7 +29,6 @@
>   /*
>    * Guest Device ID Mapping Table
>    */
> -#define VIOMMU_MAX_GDEVID	0xFFFF
>   #define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
>   #define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
>   
> @@ -40,6 +39,7 @@
>   #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
>   #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
>   
> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
>   #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
>   
>   LIST_HEAD(viommu_devid_map);
> @@ -422,6 +422,53 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
>   	*entry = NULL;
>   }
>   
> +#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
> +#define DEVID_ENTRY_HDEVID_MASK		GENMASK_ULL(29, 14)
> +#define DEVID_ENTRY_WRITE		BIT_ULL(63)
> +#define DEVID_ENTRY_VALID		BIT_ULL(0)
> +
> +/*
> + * Program the DevID via VFCTRL registers
> + * This function will be called during VM init via VFIO.
> + */
> +void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
> +				   u16 guestId, u16 gDevId)
> +{
> +	u64 val;
> +	u8 __iomem *vfctrl;
> +
> +	pr_debug("%s: iommu_devid=%#x, gid=%#x, hDevId=%#x, gDevId=%#x\n",
> +		__func__, pci_dev_id(iommu->dev), guestId, hDevId, gDevId);
> +
> +	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
> +	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, hDevId) |
> +	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
> +
> +	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
> +
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
> +}
> +
> +/*
> + * Clear the DevID via VFCTRL registers
> + * This function will be called during VM destroy via VFIO.
> + */
> +static void clear_device_mapping(struct amd_iommu *iommu, u16 guestId, u16 gDevId)
> +{
> +	u64 val;
> +	u8 __iomem *vfctrl;
> +
> +	/*
> +	 * Clear the DevID in VFCTRL registers
> +	 */
> +	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
> +	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
> +	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
> +
> +	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
> +}


The clear path sets Vld=1 with hDevID=0. This semantics is ambiguous:
Vld=1 marks the entry as a *valid* mapping, and hDevID=0 is a legal PCI
BDF (Bus 0, Dev 0, Func 0), instead of treating the entry as invalid. To 
actually invalidate the mapping,
please use Vld=0

	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
	      DEVID_ENTRY_WRITE;

Alternatively, during the clear dev mapping process, you might directly 
specify the original hdevid being used.


> +
>   static void viommu_clear_mapping(struct amd_iommu *iommu,
>   				 struct amd_iommu_viommu *aviommu)
>   {
> @@ -436,6 +483,10 @@ static void viommu_clear_mapping(struct amd_iommu *iommu,
>   	 */
>   	for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
>   		amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
> +
> +	for (i = 0; i <= VIOMMU_MAX_GDEVID; i++)
> +		clear_device_mapping(iommu, gid, i);
> +
>   }
>   
>   void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
