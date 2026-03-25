Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60F382F0C
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472115; cv=none; b=Ywi3uRS02YDra8X0BOMVIT4vdAiQ60K4l4l9vcRDze79M3htKHIpv6vQs7Fr/AL7n0mYnLCNRl6PWIrCTp6USxFFk8ouet2O+9SKDP+PDneUEXpUQXfuf3KlmvBYdMHMDbJZqimu00kkjmbNNCBxC2ZF2kDbyGYEu+UvUYv9nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472115; c=relaxed/simple;
	bh=+jxPirHWm4GxVwEslObRk9vkViIlq49DC7znSdbetR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkLdMqG8uTgoJCDtP5ZiN4L8xlDaY+1b7iRwoA/RBMaw1656Uim5uFEd81LNYkTYVFPeVAnmAiZK+y7duu7NMzkcmj8QuSW+NDkUZ+iJ3Mb2K3TpRu066vG9SRpiEk7LZCQAVhDSd//f3uccVdttezoeYbm9MUn0RE+wQggQJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvbHE6Rm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvbHE6Rm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so27965ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774472112; x=1775076912; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhMIGpIQFcuKvxAcvdtwqtuFZewnUju9lpglG9yLN80=;
        b=AvbHE6Rm/d8/GRI/UDDtmb7e64wnSh9QK9YaY6mBB9HvK8kOyRyDBjpMGvoN1ECfRx
         d+XcuCwGpe6yngXs4C1ajl3n9KDnDbGAuw3Jgqz4GzrtLVr6nO4yrW+LtsNb5JuFaRO5
         0okdEN7VNZVaCmdY2msQGokmQKDARiRN9emk7V2v45y/g1z5ZQv/ni70psz85TEqPq+5
         3841WCHlxwsfToeHGhlaFqH9qLtdcqeD4u6M2iS1LacO1jHNjWC+I+0lS6eD1Y/P1NnQ
         iLhig5vDASSrp8yqxgaHymr8NfjFW8MrERFyMiPYV9bK3yxsdVizbdQfnafdk8iJ3EjD
         1CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774472112; x=1775076912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhMIGpIQFcuKvxAcvdtwqtuFZewnUju9lpglG9yLN80=;
        b=nebt1y0s1xV6V1SmxPwaYzrQrb50/iBrgH3H4vu1eFej3xTLuJnWVcUnev/cVNnF4C
         D3NGPss3nKFeeSbi5X2d5p3pi2v67NsqiHrOBOAOPwlPIaGnPp0/TGECcoasRHp9Vl93
         hP956V3gT7SA4kRiuvwdUcrhge0veTF/Y9Ccydpr6MqU5ffA8kUt28x5Z04oJsffvvpr
         Jfb4HONaarstHA758ZLrSxLuLD3H+uOeMqGLHokLgeJ/gVBSoYYJ4QzyeyTuz+MYFGRv
         kSg3zdLsBS4tF0CsSLbjvey/cmvhuM8cJRyDVAlNznBXX4s2rRRIyKCPSywDeaBfrpje
         pRag==
X-Forwarded-Encrypted: i=1; AJvYcCUGCdCOTeKZkXLvSOBgTdn889Pz9mkUjgF8+KituJ2drnDmmYJz2MODPQdCAqDdjdDa4uqrsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJF+dvZFYDaGd0ZQemhsmGZz5tTma/vjVZLgj4mzIfJ4g8Q/EZ
	GPC+TfelTVN7RbFsO3X7BBXIZNZ1S8dFLB9++/4Ik1eSqzDbx2ngyO0V7Io5ljhV+Q==
X-Gm-Gg: ATEYQzy16gF0ZgPQm5JZSNXjDeccXW6UeK8NS9gx2RePbZV9ULjkhG1+80QogtbdUSY
	UiaZCMobn7Uzlksf0/COsKe8ueLCQSikNLYZC2Su9zUJ/lIByskMpT1IG3DlAFRxijdTIN419WU
	OyJwtEzzR8QNuNj30HTI8dtLelKr+wxmd3vr+EEMubFr3CIPmLzipY5nmGaucmRCTDnsH7dmvwE
	eo0xzD8JJ0yAiZh5qtAdBS0ohtH7A8I1LJZMKAQejO/SM8ncuBqutrWZizpH8iuw6YHtMhGfg4g
	xIxsXJ/Fp2Tqa48kDJ14dnw17j4CaZI9/EvFm9QuHbiS4ZmldgMrqf9AN6VjoXF6wp2EgNttea6
	JG4Qn2tWzKsx19fwUQotnUHTqiHy25KGfJNzYFuRK9CwJ7TJSkTXtNAiMAYP0sVuNAzDLCY/vfH
	5ppP58XXPfCGj7v7qGohxtmVDriBO958XYcp2yv6NSaxnF4u3cDkuaNsm8oQ==
X-Received: by 2002:a17:903:22d2:b0:2b0:5683:1cf with SMTP id d9443c01a7336-2b0bfa3715cmr503835ad.13.1774472110165;
        Wed, 25 Mar 2026 13:55:10 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc917b5fsm7349805ad.84.2026.03.25.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:55:09 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:55:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <acRLpJ2tlr7VCIhi@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-14-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
> If the vfio cdev is attached to an iommufd, preserve the state of the
> attached iommufd also. Basically preserve the iommu state of the device
> and also the attached domain. The token returned by the preservation API
> will be used to restore/rebind to the iommufd state after liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 28 +++++++++++++++++++++++++-
>  include/linux/kho/abi/vfio_pci.h       | 10 +++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index c52d6bdb455f..af6fbfb7a65c 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -15,6 +15,7 @@
>  #include <linux/liveupdate.h>
>  #include <linux/errno.h>
>  #include <linux/vfio.h>
> +#include <linux/iommufd.h>
>  
>  #include "vfio_pci_priv.h"
>  
> @@ -39,6 +40,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	struct vfio_pci_core_device_ser *ser;
>  	struct vfio_pci_core_device *vdev;
>  	struct pci_dev *pdev;
> +	u64 token = 0;
>  
>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>  	pdev = vdev->pdev;
> @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	if (vfio_pci_is_intel_display(pdev))
>  		return -EINVAL;
>  
> +#if CONFIG_IOMMU_LIVEUPDATE

Did we mean to use #ifdef or #if 

> +	/* If iommufd is attached, preserve the underlying domain */
> +	if (device->iommufd_attached) {
> +		int err = iommufd_device_preserve(args->session,
> +						  device->iommufd_device,
> +						  &token);
> +		if (err < 0)
> +			return err;
> +	}
> +#endif
> +
>  	ser = kho_alloc_preserve(sizeof(*ser));
> -	if (IS_ERR(ser))
> +	if (IS_ERR(ser)) {
> +		if (device->iommufd_attached)
> +			iommufd_device_unpreserve(args->session,
> +						  device->iommufd_device, token);

Few minor things here, we've protected the preserve call above with a
#ifdef but not the unpreserve here in the clean up path. Also, it looks
like in the previous patch we wrap both of these functions in #ifdefs
and define their #else static inline-d versions too?

> +
>  		return PTR_ERR(ser);
> +	}
>  
>  	pci_liveupdate_outgoing_preserve(pdev);
>  
>  	ser->bdf = pci_dev_id(pdev);
>  	ser->domain = pci_domain_nr(pdev->bus);
>  	ser->reset_works = vdev->reset_works;
> +	ser->iommufd_ser.token = token;
>  
>  	args->serialized_data = virt_to_phys(ser);
>  	return 0;
> @@ -66,6 +85,13 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>  {
>  	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device_ser *ser;
> +
> +	ser = phys_to_virt(args->serialized_data);
> +	if (device->iommufd_attached)
> +		iommufd_device_unpreserve(args->session,
> +					  device->iommufd_device,
> +					  ser->iommufd_ser.token);
>  
>  	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
> index 6c3d3c6dfc09..d01bd58711c2 100644
> --- a/include/linux/kho/abi/vfio_pci.h
> +++ b/include/linux/kho/abi/vfio_pci.h
> @@ -28,6 +28,15 @@
>  
>  #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>  
> +/**
> + * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
> + *
> + * @token: The token of the bound iommufd state.
> + */
> +struct vfio_iommufd_ser {
> +	u32 token;
> +} __packed;
> +
>  /**
>   * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
>   * device.
> @@ -40,6 +49,7 @@ struct vfio_pci_core_device_ser {
>  	u16 bdf;
>  	u16 domain;
>  	u8 reset_works;
> +	struct vfio_iommufd_ser iommufd_ser;
>  } __packed;
>  

Another struct alignment geekery: when we update vfio_iommufd_ser.token
to __u64 (as pointed out by other comments), putting it right after 
`reset_works` forces an unaligned 8-byte access at offset 5. Ideally, we
should add explicit padding (e.g. __u8 padding[3]) before iommufd_ser to
ensure natural alignment.

Because __packed prevents the compiler from automatically aligning 
fields, placing a 64-bit integer at an odd offset forces the CPU to
perform an unaligned memory read. While some archs handle this with a 
performance penalty, other archs could outright fault on unaligned 64-bit
accesses. Explicit padding guarantees safe, portable access across all
archs while maintaining the strict memory layout required by the KHO ABI.

Thanks,
Praan
