Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E09BE50
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 12:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695298333; x=1726834333;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C2g69B99mcxWi9Q2D69yxsBnzZaEHHrRxUrs3EY2EDM=;
  b=ATZrxS9NukUqQ0Mo9iqMiKgOSXEFA5cXsTAPfUX4qfGWHtHxGF+Bz8wM
   HXZ0AcmqYRlk0zLrevTU9HnHegX8H0TQtBaLMdyg/hjtWQFs0WjnXiJ7Q
   0Xt02Ey3jDj7NU1pE6+AdqAYglpVfIM1E9oCkvl7VLVmbfMrQta8wxxza
   89Y50Uamfj9hDEzQRf9j5A+MBqYYHVoWXXDXod/p8TcfIQjStWjnyPLFm
   Eruf1/cYOP6Lx8sYXMhaNsfwDFyQswvXXynNNriQJN0yAUuvNBmrE5GOd
   GNrRNiYjGHSbnBvnreV6LZlYSu+Qjn+qVO0rOiVDDeAjKA3BWf7Y/TWT9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444606277"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444606277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920706101"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="920706101"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.213]) ([10.254.213.213])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:12:06 -0700
Message-ID: <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
Date: Thu, 21 Sep 2023 20:12:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230921075138.124099-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/9/21 15:51, Yi Liu wrote:
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 4a7c5c8fdbb4..3c8660fe9bb1 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
>   	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>   };
>   
> +/**
> + * enum iommu_hwpt_type - IOMMU HWPT Type
> + * @IOMMU_HWPT_TYPE_DEFAULT: default

How about s/default/vendor agnostic/ ?

> + */
> +enum iommu_hwpt_type {
> +	IOMMU_HWPT_TYPE_DEFAULT,
> +};
> +
>   /**
>    * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
>    * @size: sizeof(struct iommu_hwpt_alloc)

Best regards,
baolu
