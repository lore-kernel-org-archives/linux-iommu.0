Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21E3AD51F
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146234; cv=none; b=bYujW916JdV+dpATIA/kfbSjve0vFC9wOQBVpZ8DJbKArOXCTlgsMhS0BUEGLqU4SJFhcFAhWE5IpCPyjsw64P15567Lr7cd5any2oadHCKh9C/BZcP9hje7R7D1UVXEhmBqV2gMeqlwugeAfE0ad3LhQpVoXFoIcjyPY7JoL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146234; c=relaxed/simple;
	bh=ArPEHdsG+HlNJOTtJ1yiYtdm5xn/SFOWlhjtGbCj9ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prL/hkV3OaX0fESb8PjCR9pX2eimKumsSfJlhol6KBF6CmsdDyto8LflfmnqNMAacGnnPayw9ZYmuqctJskQjFT5HacrkCqS1x5Y8mAM2g8j7SWpDpYyf5oYzb4+pkMcOlH9LvLXadOkhYl4S2McQAAjMGubdjg8PegkZht8fRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rIFl9qME; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rIFl9qME"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787146217; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c1ANGQwwtxuV4aVHMRCORVRy/1a06/T4hXlqW/pUX4o=;
	b=rIFl9qMEzRPAfUNV1Z4wE2RxuAhux2DnIDr9LU5unpTqoKQZYTtMh9a3/0jtVVX5UY6JEZnmUCV+PDE8dODLt23XPY2UxkuAoXIP7FBfYinu/0qKsVXYqYBInKBic3fBTp1TWluZC2TUlct3kKqtlOkZDL1vV3whvh8mtve5RqY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9GeaJA_1787146215;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9GeaJA_1787146215 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 21:30:16 +0800
Message-ID: <fb4f14d0-3c80-4a77-880a-e28be558fa4d@linux.alibaba.com>
Date: Wed, 19 Aug 2026 21:30:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] iommu/amd: Add helper functions to manage DevID /
 DomID mapping tables
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-16-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-16-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
> Introduce amd_viommu_init_one() and amd_viommu_uninit_one().
> These functions are called during IOMMUFD vIOMMU initialize and destroy.
> Currently, it manages the IPA mapping for Device ID and Domain ID mapping
> tables.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  3 ++
>   drivers/iommu/amd/amd_viommu.h      | 13 ++++++++
>   drivers/iommu/amd/iommu.c           |  1 +
>   drivers/iommu/amd/iommufd.c         |  5 +++
>   drivers/iommu/amd/viommu.c          | 52 +++++++++++++++++++++++++++++
>   5 files changed, 74 insertions(+)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 340929ae776a..03346258e2dc 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -549,6 +549,9 @@ struct amd_iommu_viommu {
>   	 */
>   	struct xarray gdomid_array;
>   
> +	u64 *devid_table;
> +	u64 *domid_table;
> +
>   	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
>   	unsigned long vfmmio_mmap_offset;
>   };
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index 447692b9101c..8b57717c22a6 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -14,6 +14,10 @@ void __init amd_viommu_uninit(struct amd_iommu *iommu);
>   
>   u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
>   
> +int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
> +
> +void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
> +
>   #else
>   
>   static inline int amd_viommu_init(struct amd_iommu *iommu)
> @@ -30,6 +34,15 @@ static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
>   	return 0;
>   }
>   
> +static inline int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
> +{
> +}
> +
>   #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>   
>   #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 79698eec21dc..6895629cc8a5 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -43,6 +43,7 @@
>   #include <linux/generic_pt/iommu.h>
>   
>   #include "amd_iommu.h"
> +#include "amd_viommu.h"
>   #include "iommufd.h"
>   #include "../irq_remapping.h"
>   #include "../iommu-pages.h"
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 81e0244348a2..bfc4b0ec22a9 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -83,6 +83,10 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>   	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
>   	iommu_reset_vmmio(iommu, aviommu->gid);
>   
> +	ret = amd_viommu_init_one(iommu, aviommu);
> +	if (ret)
> +		goto err_init;
> +
>   	ret = iommu_copy_struct_to_user(user_data, &data,
>   					IOMMU_VIOMMU_TYPE_AMD,
>   					out_vfmmio_mmap_offset);
> @@ -118,6 +122,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>   	spin_unlock_irqrestore(&pdom->lock, flags);
>   	xa_destroy(&aviommu->gdomid_array);
>   	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
> +	amd_viommu_uninit_one(iommu, aviommu);
>   	amd_iommu_gid_free(iommu, aviommu->gid);
>   }
>   
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 2c1a267826dc..91d0dd3ac912 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -26,6 +26,20 @@
>   #include "amd_viommu.h"
>   #include "../iommu-pages.h"
>   
> +/*
> + * Guest Device ID Mapping Table
> + */
> +#define VIOMMU_MAX_GDEVID	0xFFFF
> +#define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
> +#define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
> +
> +/*
> + * Guest Domain ID Mapping Table
> + */
> +#define VIOMMU_MAX_GDOMID	0xFFFF
> +#define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
> +#define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
> +
>   LIST_HEAD(viommu_devid_map);
>   
>   static int viommu_init_pci_vsc(struct amd_iommu *iommu)
> @@ -405,3 +419,41 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
>   
>   	*entry = NULL;
>   }
> +
> +void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
> +{
> +	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
> +
> +	free_private_vm_region(iommu, &aviommu->devid_table,
> +			       VIOMMU_DEVID_MAPPING_BASE,
> +			       VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
> +			       aviommu->gid);
> +	free_private_vm_region(iommu, &aviommu->domid_table,
> +			       VIOMMU_DOMID_MAPPING_BASE,
> +			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
> +			       aviommu->gid);
> +}
> +
> +int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
> +{
> +	int ret;
> +
> +	ret = alloc_private_vm_region(iommu, &viommu->devid_table,
> +				      VIOMMU_DEVID_MAPPING_BASE,
> +				      VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
> +				      viommu->gid);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = alloc_private_vm_region(iommu, &viommu->domid_table,
> +				      VIOMMU_DOMID_MAPPING_BASE,
> +				      VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
> +				      viommu->gid);
> +	if (ret)
> +		goto err_out;
> +
> +	return 0;
> +err_out:
> +	amd_viommu_uninit_one(iommu, viommu);
> +	return -ENOMEM;
> +}

The err_out label overwrites the real error with -ENOMEM.
alloc_private_vm_region() (via viommu_priv_alloc_map()) can also
return -EINVAL when the pdom is not set up, and that information
gets lost on the way to iommufd. Please just "return ret;" here.

