Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DF3AF646
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280881; cv=none; b=BshMhFmhjp/P13U1WmX+ZPGCU4e8U3kv5H40B5wT+mfwtr1zyHbFOBgmZVEsxo/d9ImdMEZF1CvwBWz9O8hCYdKv5KmF8OKQjpzAsvaG/T97BUJ5g/TrLY0P5gNXLZWQ/17sXbT0BbfuilT0p2EvSk5lWI9hTYjHrIHiu97MEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280881; c=relaxed/simple;
	bh=TEBtvs1vjKigMWsFOX5/bn4bMwkHFLIVZrCdKPxfiwE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H3+vN4DHOyQBv20K8AVx+TG4U4LH9t2bZkwQKOm742dW+n034iDnQ6bPEWol6zkVPn/A0qkd3zjD8sP+rlOZ6MV0iPPzioD3HMUAmSZEtazEld8yVcKc0UQqqNn0/Rer3cnAQkdWcteQ++4jRNdOwMFnJE1vTEIOlczWcmGbi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0aKA/uC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0aKA/uC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777280879; x=1808816879;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TEBtvs1vjKigMWsFOX5/bn4bMwkHFLIVZrCdKPxfiwE=;
  b=m0aKA/uCIqGLyhA+iewUK/wx2m70X2tTpOcAOqtSR/I83b9P1D+gN8Xk
   g2RbVQ+O1cPLwHVSy2V53kT09X5tPIB40KrxynNHm/anBLaCiXZbhWMAQ
   ML070mR0zGqzokctAYMYCVFrt53RY/H3rPHaYPTaohLcFMDfTIqHTa6TB
   LuHQQEkQA/B1zuvyK1Pg3PTnl24S8S6avnpyYMJo1K5GgTEVSPtf+0U51
   ZOJtmgjq42K8mrgOkGCTqLtCpb1BJe/yCkIklarvsgHhg+KZsPGa01Ekx
   FT5auZENcr/nYXRcSo4EQ2nh1EcQ9cuXv+GVY9AajSH0NT9FHcNtw1y1d
   w==;
X-CSE-ConnectionGUID: jXSPdWhxS6mkiomgH9e7pw==
X-CSE-MsgGUID: wnUuziFrSMqhIUpF7NL3yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="103626088"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="103626088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:07:59 -0700
X-CSE-ConnectionGUID: FYDd+31MR7KHd2Ni80r5sQ==
X-CSE-MsgGUID: iHfbtUdjQheofsbPE6IWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="227055600"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:07:54 -0700
Message-ID: <f5f2bd86-4cde-4efe-b824-d9f1c82357ac@linux.intel.com>
Date: Mon, 27 Apr 2026 17:07:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Alexey Kardashevskiy <aik@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260427061005.901854-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/27/2026 2:10 PM, Aneesh Kumar K.V (Arm) wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Add a struct kvm * to iommufd_device_bind() fn and associate it
> with idev if bind is successful.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: fix build error in iommufd_test_mock_domain()]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   drivers/iommu/iommufd/device.c          | 5 ++++-
>   drivers/iommu/iommufd/iommufd_private.h | 2 ++
>   drivers/iommu/iommufd/selftest.c        | 2 +-
>   drivers/vfio/iommufd.c                  | 2 +-
>   include/linux/iommufd.h                 | 4 +++-
>   5 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 344d620cdecc..453fbceb9219 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -203,6 +203,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>    * iommufd_device_bind - Bind a physical device to an iommu fd
>    * @ictx: iommufd file descriptor
>    * @dev: Pointer to a physical device struct
> + * @kvm: Pointer to struct kvm if device belongs to a KVM VM
>    * @id: Output ID number to return to userspace for this device
>    *
>    * A successful bind establishes an ownership over the device and returns
> @@ -216,7 +217,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>    * The caller must undo this with iommufd_device_unbind()
>    */
>   struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev, struct kvm *kvm,
> +					   u32 *id)
>   {
>   	struct iommufd_device *idev;
>   	struct iommufd_group *igroup;
> @@ -266,6 +268,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	if (!iommufd_selftest_is_mock_dev(dev))
>   		iommufd_ctx_get(ictx);
>   	idev->dev = dev;
> +	idev->kvm = kvm;
>   	idev->enforce_cache_coherency =
>   		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
>   	/* The calling driver is a user until iommufd_device_unbind() */
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..c48a568c6cbb 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -488,6 +488,8 @@ struct iommufd_device {
>   	struct list_head group_item;
>   	/* always the physical device */
>   	struct device *dev;
> +	/* ..and kvm if available */
> +	struct kvm *kvm;
>   	bool enforce_cache_coherency;
>   	struct iommufd_vdevice *vdev;
>   	bool destroying;
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 7823142097d4..76a2f83f430c 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -1100,7 +1100,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
>   		goto out_sobj;
>   	}
>   
> -	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
> +	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev, NULL,
>   				   &idev_id);
>   	if (IS_ERR(idev)) {
>   		rc = PTR_ERR(idev);
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a38d262c6028..c1c58194fd3a 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -119,7 +119,7 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
>   {
>   	struct iommufd_device *idev;
>   
> -	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
> +	idev = iommufd_device_bind(ictx, vdev->dev, vdev->kvm, out_device_id);
>   	if (IS_ERR(idev))
>   		return PTR_ERR(idev);
>   	vdev->iommufd_device = idev;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 6e7efe83bc5d..5cdcb8d2f305 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -24,6 +24,7 @@ struct iommufd_ctx;
>   struct iommufd_device;
>   struct iommufd_viommu_ops;
>   struct page;
> +struct kvm;
>   
>   enum iommufd_object_type {
>   	IOMMUFD_OBJ_NONE,
> @@ -59,7 +60,8 @@ struct iommufd_object {
>   };
>   
>   struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id);
> +					   struct device *dev, struct kvm *kvm,
> +					   u32 *id);
>   void iommufd_device_unbind(struct iommufd_device *idev);
>   
>   int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,

iommufd_device_unbind() is an asynchronous teardown operation. Is it
possible for idev->kvm to persist or be accessed within the iommufd
subsystem after iommufd_device_unbind() has returned? Should we add the
change below to prevent this potential UAF case?

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..dac39cb5e7cc 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -333,6 +333,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, "IOMMUFD");
   */
  void iommufd_device_unbind(struct iommufd_device *idev)
  {
+       idev->kvm = NULL;
         iommufd_object_destroy_user(idev->ictx, &idev->obj);
  }
  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, "IOMMUFD");

Otherwise, it looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
