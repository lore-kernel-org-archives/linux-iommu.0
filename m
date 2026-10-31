Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793426181;
	b=sj1wref12LH03UK0i/9ofUXHWElt+C/MR/vrzZ6bOz14hDuG5G5HoRL6Og9gIYnMmOYv
	 rcmtXGTdeYc4aluSDI1eBZi0ev1QdrwQw9tlAyUvmi7iXfiWTFmqGQdCH6UM+cYkrUpTn
	 HxRD8x/gMkj0EyYoMohD57DwcVW0lZXWqHRxq6b6QVPZiHEE0g33qHWUwu4r5d30S4qeu
	 4yYmYFoNw32+dOlZDwJkpImZoMWZlTHHG8y6OLZAWEioglO1eTx0adYbxKArs/FQIoaV3
	 U3GwdUSXmDviBvrqdBPM3l5XvWMgXr1AwHqyf5SpyMBhcA5Fg9JPKEaXMgqUwzkJx1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426181;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=N7ZwaJ7vbMee9aorv3youp0owlQKKiWsc6xwL1/KdJ4=;
	b=rH9wxhbtwy8Bljs051nhNDfr88PUERZEhzFPY7zPJDIlEEGI/jCDSqKUlY15um/v8XKo
	 sebTlnZUnVim0sk6Bm2/SqUb9blZfm7Kw7NFtHaDRM27w/P/zTGAZJJAD5/953eZcNpgy
	 RC4wrwc/6CXwH2+sUZMUF3UF/OHPUTPuLFi5VnlYY5KEQEzta4Ta4K1Ebzw19wAc6uPmg
	 AmCrjyLmjeFZMfJ95pR2vtu0WYhisDU2mmX9eFoU9YojUwtjeVCY+XPKWkvUZ2sQXMtk2
	 sXPogdZUPQXia0fJR5ze3ma10so2HCX4SPWMKhs3QEO+K/tbSkzKsKgXH72RnjX9rUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aKLdi0PH;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E4606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 05:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aKLdi0PH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793426181; x=1824962181;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n/Ma+Vo5Cq0vdWeRsNkNZSUCDb5boMlJRuQWnHLIVzk=;
  b=aKLdi0PH1cSOc14ptDhanrOGD7MCHaYKmohyIQmz94qWaunfzNls7AlU
   1aURrWG3o7RlV3/LQOE45JntFM0fXpldYwCkr0keUiZ2bRJgZMwJDohcV
   A+EYracqNdQCPbXBYI0ReeSzTDQGHAvH/SuqePoFdGuU/Z1A/pxu4pzzm
   YFJNIIa8wbhiRV/imdr9ooOBuZ4R+k3abECH0xc/Kgm4FSDd7s5/HS5f2
   WMPrTUMR6lhkvg2ZEnejPeKg9KIISRWkxAwm4U1zTHvCyZQLCMgol5NnO
   xaw0ktCtdXc/HbtZH85FhsT0nIWrcMz9lKNHqGBSsHAg8mJs8W3adAVsS
   g==;
X-CSE-ConnectionGUID: 6AfWD2+2R2qRA8mVla42eg==
X-CSE-MsgGUID: PZowqVnQTriYu1ONRG/02w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2220901"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2220901"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 22:56:20 -0700
X-CSE-ConnectionGUID: IxzEUO4USva7/99YVRagNw==
X-CSE-MsgGUID: uXSHQduPTyaAZA2NJIELYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5502480"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 22:56:15 -0700
Message-ID: <2574cbc8-8c2b-4458-9fcd-b077190084a3@linux.intel.com>
Date: Sat, 31 Oct 2026 13:56:12 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 17/18] vfio/pci: Preserve the iommufd state of the vfio
 cdev
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-18-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-18-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> If the vfio cdev is attached to an iommufd, preserve the state of the
> attached iommufd also. Basically preserve the iommu specific state of
> the device and also the attach iommu HW unit.
> 
> Once the device and its iommufd attachment is preserved, it cannot be
> detached or attached to another IOAS until it is unpreserved.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/vfio/device_cdev.c             | 10 +++++++++
>   drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
>   2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index b818aab92f76..4eb7ffd489bd 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -284,6 +284,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>   	}
>   
>   	mutex_lock(&device->dev_set->lock);
> +	if (iommufd_device_is_preserved(device->iommufd_device)) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>   	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
>   		ret = device->ops->pasid_attach_ioas(device,
>   						     attach.pasid,
> @@ -342,6 +347,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>   	}
>   
>   	mutex_lock(&device->dev_set->lock);
> +	if (iommufd_device_is_preserved(device->iommufd_device)) {
> +		mutex_unlock(&device->dev_set->lock);
> +		return -EBUSY;
> +	}
> +
>   	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
>   		device->ops->pasid_detach_ioas(device, detach.pasid);
>   	else
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index f0ea37d98696..fb2141ee8942 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -106,6 +106,7 @@
>   
>   #include <linux/errno.h>
>   #include <linux/file.h>
> +#include <linux/iommufd.h>
>   #include <linux/kexec_handover.h>
>   #include <linux/kho/abi/vfio_pci.h>
>   #include <linux/liveupdate.h>
> @@ -114,6 +115,8 @@
>   
>   #include "vfio_pci_priv.h"
>   
> +MODULE_IMPORT_NS("IOMMUFD");
> +
>   static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>   					     struct file *file)
>   {
> @@ -154,15 +157,25 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>   	struct vfio_pci_core_device_ser *ser;
>   	struct vfio_pci_core_device *vdev;
>   	struct pci_dev *pdev;
> -	int ret;
> +	u64 iommufd_token;
> +	int ret = 0;

nit: no need to initialize ret.

>   
>   	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>   	pdev = vdev->pdev;
>   
> -	ret = pci_liveupdate_preserve(pdev);
> +	mutex_lock(&device->dev_set->lock);
> +	ret = iommufd_device_preserve(args->session,
> +				      device->iommufd_device,
> +				      &iommufd_token);
> +	mutex_unlock(&device->dev_set->lock);
> +
>   	if (ret)
>   		return ret;
>   
> +	ret = pci_liveupdate_preserve(pdev);
> +	if (ret)
> +		goto err_iommufd_unpreserve;
> +
>   	ser = kho_alloc_preserve(sizeof(*ser));
>   	if (IS_ERR(ser)) {
>   		ret = PTR_ERR(ser);
> @@ -177,6 +190,12 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>   
>   err_unpreserve:
>   	pci_liveupdate_unpreserve(pdev);
> +
> +err_iommufd_unpreserve:
> +	mutex_lock(&device->dev_set->lock);
> +	iommufd_device_unpreserve(args->session,
> +				  device->iommufd_device);
> +	mutex_unlock(&device->dev_set->lock);
>   	return ret;
>   }
>   
> @@ -184,6 +203,11 @@ static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>   {
>   	struct vfio_device *device = vfio_device_from_file(args->file);
>   
> +	mutex_lock(&device->dev_set->lock);
> +	iommufd_device_unpreserve(args->session,
> +				  device->iommufd_device);
> +	mutex_unlock(&device->dev_set->lock);
> +
>   	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
>   	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>   }

Unpreservation isn't the exact reverse of preservation. Anything special
here?

Otherwise, this patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
