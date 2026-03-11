Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BC175A73
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263895; cv=none; b=kFyx9WMTlUZNaDqbNziIiY6CP5mki2419YvKEAyq69iho3tLTn2CEpsL8gOMG83IPLj51cuvcFC7Le63v9AmB2YRJI2f9yEPMlpb71XLCsEaKFCHaK1/EAs+s+C9ZRUnDWQe/aUuOmbFADvP/LRFsHWRrtwahjhrtXcHZYfiQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263895; c=relaxed/simple;
	bh=C9IWg8sPXyVZA1pXubQVzMAYJDRdSA8nas979A9wH0Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiyKHuoXH1kcPCyHVsEYRBq7ORKYxtRaMv2NhqQf3wrINMZqOrwKB6kbn3XJxzM0BAlfzau4cwBntS6mqqT52Lv/qlyfC1ziddNZWcvIhSiLR3T4eqj2dfMZDjq6Y5fZ2lSaOjJgGVghaWOcemw7ZTMZuaZA2uVk0dZb+roKttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWNrT3fM6zHnGdd;
	Thu, 12 Mar 2026 05:18:01 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DE56040569;
	Thu, 12 Mar 2026 05:18:09 +0800 (CST)
Received: from localhost (10.48.148.123) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 21:18:08 +0000
Date: Wed, 11 Mar 2026 21:18:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <20260311211742.0000391c@huawei.com>
In-Reply-To: <20260309111704.2330479-2-aneesh.kumar@kernel.org>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
	<20260309111704.2330479-2-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  9 Mar 2026 16:47:02 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
> IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
> 
> When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
> VM file and stores a referenced struct file in the vIOMMU object, so
> later iommufd operations can safely resolve the owning VM.
> 
> This is preparatory plumbing for subsequent patches that bind TDI state
> to the associated KVM VM.
> 
> The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
> EXPORT_SYMBOL_GPL so that iommu module can use that.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Steven Price <steven.price@arm.com>

Hi Aneesh,

Given we don't generally want a massive cc list in the git log,
move them below ---

If you are tracking them in your git tree, just add a --- after your sign off
and put them under that.

Also good to +CC everyone in the CC for patches on the cover letter.
I happened not be subscribed to any of the lists that went to so have to
pull it down by hand from lore.

Fairly minor stuff inline.

Thanks,

Jonathan

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 54 +++++++++++++++++++++++++++++++++-
>  include/linux/iommufd.h        |  3 ++
>  include/uapi/linux/iommufd.h   | 13 +++++++-
>  virt/kvm/kvm_main.c            |  2 +-
>  4 files changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 4081deda9b33..08f8930c86da 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -2,6 +2,45 @@
>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>   */
>  #include "iommufd_private.h"
> +#include <linux/cleanup.h>

Usually put linux includes before the local ones (though I haven't
checked local conventions in iommufd).

> +
> +#if IS_ENABLED(CONFIG_KVM)

Hmm. Really a question for Jason / Kevin, but so far this file is ifdef free.
Should we keep it that way by spinning this stuff off to a separate .c file,
or maybe use if (IS_ENABLED()) the implementation which I think means
we need a stub for file_is_kvm()?

> +#include <linux/kvm_host.h>
> +
> +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> +{
> +	int rc = -EBADF;
> +	struct file *filp __free(fput) = fget(kvm_vm_fd);
> +
> +	if (!file_is_kvm(filp))
> +		return rc;

		return -EBADF;

and drop the local variable.

> +
> +	/* hold the kvm reference via file descriptor */
> +	viommu->kvm_filp = no_free_ptr(filp);
> +	return 0;
> +}
> +
> +static void viommu_put_kvm(struct iommufd_viommu *viommu)
> +{
> +	if (!viommu->kvm_filp)
> +		return;
> +
> +	fput(viommu->kvm_filp);
> +	viommu->kvm_filp = NULL;
> +}
> +
> +#else
> +
> +static inline int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void viommu_put_kvm(struct iommufd_viommu *viommu)
> +{
> +}
> +
> +#endif

> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 6e7efe83bc5d..7c515d3c52db 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -12,6 +12,7 @@
>  #include <linux/refcount.h>
>  #include <linux/types.h>
>  #include <linux/xarray.h>
> +#include <linux/file.h>

Just based on context in this patch, this smells alphabetical.
I checked it is, so this belongs between errno.h and iommu.h


>  #include <uapi/linux/iommufd.h>
>  
