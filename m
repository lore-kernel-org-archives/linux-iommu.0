Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85455185A
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 03:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676257788; x=1707793788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mx8hjkquFcdwVnwjv95J9hNvyTNxMHzbXHuu8sq9qEI=;
  b=SmoTw1dyhECTZjl7kgKjJ42qcuiUYf1ySvGAYzeC2CAQnWU+ji0YLWJV
   Xci9dC1f0HK6zXb3xNMlMmNQ6zzbFkIK1eqKpEc20i19LFVm3FklftUFL
   jX5ZMebn+pLWIs1s660xHo4cP51zy1m5egQP5pZLqjCL2sf0a9KQJdRY+
   6EiuCQYlIm3UXf7fQsdXFg1I0JNKwgG6UbQyJ5ZgBM5jor38gIkgjTG5t
   A+CjZC0RSNcem1kXYrvXeBsdupaz4QyYd1YtX9ASiXVgGAUFY4/uonmBd
   q8hjdM3aB77aQ4SGLMLaBtKp7pMNKQcZYY+paShX7CqgSg+7+xHTlVQiK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="329424704"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="329424704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:09:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842621921"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="842621921"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.254.214.18]) ([10.254.214.18])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:09:41 -0800
Message-ID: <0581875e-f0af-582e-82fb-62cf03ba39b2@linux.intel.com>
Date: Mon, 13 Feb 2023 11:09:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
Cc: cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 baolu.lu@linux.intel.com
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20230209041642.9346-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/9/2023 12:16 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> To support nested translation in the userspace, it should check the
> underlying hardware information for the capabilities.
>
> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>   drivers/iommu/intel/iommu.h  |  1 +
>   include/uapi/linux/iommufd.h | 21 +++++++++++++++++++++
>   3 files changed, 41 insertions(+)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 59df7e42fd53..929f600cc350 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4760,8 +4760,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>   }
>   
> +static void *intel_iommu_hw_info(struct device *dev, u32 *length)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct iommu_device_info_vtd *vtd;
> +
> +	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
> +	if (!vtd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vtd->cap_reg = iommu->cap;
> +	vtd->ecap_reg = iommu->ecap;
> +	*length = sizeof(*vtd);
> +
> +	return vtd;
> +}
> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
> +	.hw_info		= intel_iommu_hw_info,
>   	.domain_alloc		= intel_iommu_domain_alloc,
>   	.probe_device		= intel_iommu_probe_device,
>   	.probe_finalize		= intel_iommu_probe_finalize,
> @@ -4774,6 +4792,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.def_domain_type	= device_def_domain_type,
>   	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
>   	.pgsize_bitmap		= SZ_4K,
> +	.driver_type		= IOMMU_DEVICE_DATA_INTEL_VTD,
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   	.page_response		= intel_svm_page_response,
>   #endif
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 06e61e474856..2e70265d4ceb 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -22,6 +22,7 @@
>   #include <linux/ioasid.h>
>   #include <linux/bitfield.h>
>   #include <linux/xarray.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/iommu.h>
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 2309edb55028..fda75c8450ee 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -347,7 +347,28 @@ struct iommu_vfio_ioas {
>   
>   /**
>    * enum iommu_device_data_type - IOMMU hardware Data types
> + * @IOMMU_DEVICE_DATA_INTEL_VTD: Intel VT-d iommu data type
>    */
>   enum iommu_device_data_type {
> +	IOMMU_DEVICE_DATA_INTEL_VTD = 1,
> +};
> +
> +/**
> + * struct iommu_device_info_vtd - Intel VT-d device info
> + *
> + * @flags: Must be set to 0

Could you add more description about the usage of flags here?


> + * @__reserved: Must be 0
> + * @cap_reg: Value of Intel VT-d capability register defined in chapter
> + *	     11.4.2 of Intel VT-d spec.
> + * @ecap_reg: Value of Intel VT-d capability register defined in chapter
> + *	     11.4.3 of Intel VT-d spec.
> + *
> + * Intel hardware iommu capability.
> + */
> +struct iommu_device_info_vtd {
> +	__u32 flags;
> +	__u32 __reserved;
> +	__aligned_u64 cap_reg;
> +	__aligned_u64 ecap_reg;
>   };
>   #endif
