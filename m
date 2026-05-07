Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555B26A08A
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119819; cv=none; b=X+QZ8IIRuWaxsscaFQ1u0hOp9b4wg8tnPSR76r58MezfdxTofOYrt0OVXhNVnothcyi+NODq+/Bb0UbNBPJ2D21ZNGrOY9G6y7v1S4uX2Gbc1u7GvEoR7ijgnC+s7FUf4xe6aQ0JzUKd+SNv8enY7Op/KAmLVVLFQdPbMIB5AWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119819; c=relaxed/simple;
	bh=NyepB9a27hAykCXi2WMNR4qwpLX6uQ5expv6FydGVTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqwJ/ZF70R2l8FlYYlQqX1S8iD1lTcVv1ik3nIuFkdRGPoIrPFQpvL0EWnah7Cdyd4tp2y0JQnEZ1VZt5oyDdJ4ZXXUrzOku1oO+fcnq2zT1FXtQoaPpmuluqreNh7ya6O79q6KYl3AtGvZ8EOn1DJUYQyoinIAGC4iYIMKhD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dp95X6ub; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dp95X6ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778119817; x=1809655817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NyepB9a27hAykCXi2WMNR4qwpLX6uQ5expv6FydGVTg=;
  b=Dp95X6ubd9wHxg0C7yGioEk8fAp1b2WeFh+el8XIEmvrOs30k8g7+s+I
   I+A/7asFDIOYAYAXti9ar5v0ABLVtgoOVbiN0hgju9EWHI1WB+gpOrveC
   BJPD9mkF5Ziq0srVWhudwxpDffcvio1i1l6Rq3KsiO3Se8aC5OtR8prap
   SYSVKQlpHHB08mt2d/+F/2dYsnApW/7EJNj7/uyMFYRL9f9NDMiriview
   47/p0kHC9w+fcEoyc1I0Y40QETSyGDh7LqWM6ntfYtxek/fJ7FUiKIlB2
   NbA3lJ1XuXyf1EdPuvd9bqzmpSsLcIpSkj+ciGNtNwGO/C1PE8lvEgaZh
   A==;
X-CSE-ConnectionGUID: 2hEgQP9CQWudAun49EHGuQ==
X-CSE-MsgGUID: xnklCMVfRZ6gsgs6otv3wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79172192"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79172192"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 19:10:17 -0700
X-CSE-ConnectionGUID: mpXeGnDjQ6Ow/ME69xlzVg==
X-CSE-MsgGUID: idbu0OcjTZer6CMXENe4+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="236241780"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 19:10:12 -0700
Message-ID: <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
Date: Thu, 7 May 2026 10:07:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 YiFei Zhu <zhuyifei@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260427175633.1978233-5-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 01:56, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
> by the IOMMU drivers that support preservation of devices that have
> their IOMMU domains preserved. During device preservation the state of
> the associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h |  33 +++++++
>   include/linux/iommu.h            |  20 ++++
>   3 files changed, 215 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index f71f14518248..765d042e22e3 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -11,6 +11,7 @@
>   #include <linux/liveupdate.h>
>   #include <linux/iommu-liveupdate.h>
>   #include <linux/iommu.h>
> +#include <linux/pci.h>
>   #include <linux/errno.h>
>   
>   #define iommu_max_objs_per_page(_array) \
> @@ -293,3 +294,164 @@ void iommu_domain_unpreserve(struct iommu_domain *domain)
>   	domain->preserved_state = NULL;
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
> +
> +static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_iommu_array,
> +			       iommu_max_objs_per_page(flb->curr_iommu_array));
> +	if (idx < 0)
> +		return ERR_PTR(idx);
> +
> +	flb->curr_iommu_array->objects[idx].hdr.ref_count = 1;
> +	return &flb->curr_iommu_array->objects[idx];
> +}
> +
> +static int iommu_preserve_locked(struct iommu_device *iommu,
> +				 struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	int ret;
> +
> +	if (!iommu->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	if (iommu->outgoing_preserved_state) {
> +		iommu->outgoing_preserved_state->hdr.ref_count++;
> +		return 0;
> +	}
> +
> +	iommu_hw_ser = alloc_iommu_hw_ser(flb_obj);
> +	if (IS_ERR(iommu_hw_ser))
> +		return PTR_ERR(iommu_hw_ser);
> +
> +	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
> +	if (ret) {
> +		iommu_hw_ser->hdr.deleted = true;
> +		return ret;
> +	}
> +
> +	iommu->outgoing_preserved_state = iommu_hw_ser;
> +	return ret;
> +}
> +
> +static void iommu_unpreserve_locked(struct iommu_device *iommu,
> +				    struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser = iommu->outgoing_preserved_state;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	iommu_hw_ser->hdr.ref_count--;
> +	if (iommu_hw_ser->hdr.ref_count)
> +		return;
> +
> +	iommu->outgoing_preserved_state = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);
> +	iommu_hw_ser->hdr.deleted = true;
> +}
> +
> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_device_array,
> +			       iommu_max_objs_per_page(flb->curr_device_array));
> +	if (idx < 0)
> +		return ERR_PTR(idx);
> +
> +	flb->curr_device_array->objects[idx].hdr.ref_count = 1;
> +	return &flb->curr_device_array->objects[idx];
> +}
> +
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 *preserved_state)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_ser *device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (!domain->preserved_state)
> +		return -EINVAL;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->preserve_device ||
> +	    !iommu->iommu_dev->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	device_ser = alloc_iommu_device_ser(flb_obj);
> +	if (IS_ERR(device_ser))
> +		return PTR_ERR(device_ser);
> +
> +	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
> +	if (ret) {
> +		device_ser->hdr.deleted = true;
> +		return ret;
> +	}
> +
> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
> +	device_ser->devid = pci_dev_id(pdev);
> +	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
> +
> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
> +	if (ret) {
> +		device_ser->hdr.deleted = true;
> +		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +		return ret;
> +	}
> +
> +	dev->iommu->device_ser = device_ser;
> +	*preserved_state = virt_to_phys(device_ser);
> +	return 0;
> +}
> +
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_ser *iommu_device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->unpreserve_device ||
> +	    !iommu->iommu_dev->ops->unpreserve)
> +		return;

Is it considered a driver bug if it implements the preserve hooks but
not unpreserve ones? This would at least cause a silent memory leak. How
about adding a WARN like this?

     if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
                      !iommu->iommu_dev->ops->unpreserve))
         return;

?

Thanks,
baolu
