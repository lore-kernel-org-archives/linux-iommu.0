Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0215A0
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 02:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676255806; x=1707791806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eVq7V0e9oDRa3tglIxQm8yw7Q5bc8l5Dv9QXPiPst28=;
  b=eo4u6gl32jitO44MSmG5APTLgwoU5krk5stjZXlAAUCDbLqn3eHLnhtx
   +OQanTCucgV9UW8CCzVgSqGZkaoeRmwE8tiRnmue5d6i2/XvL4x+ytmZq
   K98199nPJ3X9uSPVXxABcB3nSIzZ6FfOYyR4yd/rx06FgrYAJ4QnvlD9U
   D8oZxOka6gIhun2I7o7LhVoUdB6P4aCNPL5mLw4ajKCxZN2/nWw/uG84Y
   IdzXR1wmUNkJmJnpRXi2ib6OBsRtEPinrNx7QvzDxU7j+pEwFzUHdWNlU
   x5GFouAlHGJHIaCmK8RLXeKeU4UG2Wx5mw3wW0izG9p0OhEZq4hVL8l9C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="314433176"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="314433176"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:36:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701105234"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="701105234"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.254.214.18]) ([10.254.214.18])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:36:41 -0800
Message-ID: <aa9ee0db-c9d9-9b3f-8f63-cbc76bb3ccdd@linux.intel.com>
Date: Mon, 13 Feb 2023 10:36:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
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
 <20230209041642.9346-2-yi.l.liu@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20230209041642.9346-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/9/2023 12:16 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> Introduce a new iommu op get

get -> to get


> the IOMMU hardware capabilities for iommufd.
> This information will be used by any vIOMMU driver which is owned by
> userspace.
>
> This op chooses to make the special parameters opaque to the core. This
> suits the current usage model where accessing any of the IOMMU device
> special parameters does require a userspace driver that matches the kernel
> driver. If a need for common parameters, implemented similarly by several
> drivers, arises then there is room in the design to grow a generic parameter
> set as well. No warpper

warpper -> wrapper


>   API is added as it is supposed to be used by
> iommufd only.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h        | 8 ++++++++
>   include/uapi/linux/iommufd.h | 6 ++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index cb586d054c57..97b398d19fd2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -15,6 +15,7 @@
>   #include <linux/of.h>
>   #include <linux/ioasid.h>
>   #include <uapi/linux/iommu.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #define IOMMU_READ	(1 << 0)
>   #define IOMMU_WRITE	(1 << 1)
> @@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
>   /**
>    * struct iommu_ops - iommu ops and capabilities
>    * @capable: check capability
> + * @hw_info: IOMMU hardware capabilities. The type of the returned data is
> + *           defined in include/uapi/linux/iommufd.h. The data buffer is
> + *           allocated in the IOMMU driver and the caller should free it
> + *           after use. Return the data buffer if success, or ERR_PTR on
> + *	      failure.
>    * @domain_alloc: allocate iommu domain
>    * @probe_device: Add device to iommu driver handling
>    * @release_device: Remove device from iommu driver handling
> @@ -252,6 +258,7 @@ struct iommu_iotlb_gather {
>    */
>   struct iommu_ops {
>   	bool (*capable)(struct device *dev, enum iommu_cap);
> +	void *(*hw_info)(struct device *dev, u32 *length);
>   
>   	/* Domain allocation and freeing by the iommu driver */
>   	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> @@ -280,6 +287,7 @@ struct iommu_ops {
>   	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
>   
>   	const struct iommu_domain_ops *default_domain_ops;
> +	enum iommu_device_data_type driver_type;


How to understand the name "iommu_device_data_type"?
Is it just refer to the driver types or it has a more generic meaning?


>   	unsigned long pgsize_bitmap;
>   	struct module *owner;
>   };
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 98ebba80cfa1..2309edb55028 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -344,4 +344,10 @@ struct iommu_vfio_ioas {
>   	__u16 __reserved;
>   };
>   #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
> +
> +/**
> + * enum iommu_device_data_type - IOMMU hardware Data types
> + */
> +enum iommu_device_data_type {
> +};
>   #endif
