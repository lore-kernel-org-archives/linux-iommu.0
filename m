Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAC4C86
	for <iommu@lists.linux.dev>; Wed, 27 Sep 2023 02:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695780493; x=1727316493;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jiTLn3Vg5DjW5KMS+3IRSYx4PUzUN/fR9h6uUPmnC/8=;
  b=GEHgB80JDhn5TeJE/wff5fenkPFPKF+6Y1B11tRgkGnkdSq0xrO28mW6
   gB0ZXPME7mxHIs9bgCSlzWmCe/ZzviAm/bnYMx0kVT9kLeuFT0nxKh6lS
   VhPuLNghdMekH7V54onL/Vy/fJU46ccrnhoG4QAbEX65Xc/c3P+N/haTu
   XsXJ6z9X/mdLX/pLzCIQdA7kKN+ad6m3ETTeElSqZJ/IxX7O07kiK9XRY
   mhzHxunKY0zdOeIt14MmbBGQMRawe+9Tl0nM2ExGWAPNWUNZz7U4uFLdg
   pSpR+X3nLHFz59CyG5XQ4nCrX7FfK9GJFWxy6ZuY/es2cy00P0KaZiOUc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361963138"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361963138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="373163"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 26 Sep 2023 19:07:35 -0700
Message-ID: <a5e18b46-cccc-a2f7-91ae-aa5c942cd887@linux.intel.com>
Date: Wed, 27 Sep 2023 10:04:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [RFC 1/8] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230926092651.17041-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/23 5:26 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Provide a high-level API to allow replacements of one domain with
> another for specific pasid of a device. This is similar to
> iommu_group_replace_domain() and it is also expected to be used
> only by IOMMUFD.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu-priv.h |  2 ++
>   drivers/iommu/iommu.c      | 73 ++++++++++++++++++++++++++++++--------
>   2 files changed, 60 insertions(+), 15 deletions(-)
> 

[...]

> @@ -3433,8 +3443,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>    * The @domain must have been attached to @pasid of the @dev with
>    * iommu_attach_device_pasid().
>    */
> -void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> -			       ioasid_t pasid)
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)

Above change is irrelevant.

>   {
>   	struct iommu_group *group = iommu_group_get(dev);
>   
> @@ -3447,6 +3457,39 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
>   
> +/**
> + * iommu_replace_device_pasid - replace the domain that a pasid is attached to
> + * @domain: new IOMMU domain to replace with
> + * @dev: the physical device
> + * @pasid: pasid that will be attached to the new domain
> + *
> + * This API allows the pasid to switch domains. Return 0 on success, or an
> + * error. The pasid will roll back to use the old domain if failure. The
> + * caller could call iommu_detach_device_pasid() before free the old domain
> + * in order to avoid use-after-free case.

The comment does not match the actual behavior of the code. We need to
discuss and agree on which state the PASID should park in if replacing
the domain fails.

> + */
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	int ret;
> +
> +	if (!domain)
> +		return -EINVAL;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	__iommu_remove_group_pasid(group, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	ret = __iommu_group_attach_pasid(domain, group, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
> +
>   /*
>    * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
>    * @dev: the queried device

Best regards,
baolu
