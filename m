Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62C3438A4
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238671; cv=none; b=L9Ers/IyS2GYQqLnpxhsLe+dW7VUA232fKgYkZ/JrWrPB6hwTxvIH+Q+YZWkm6E6PDNaKkoFBkCUI0CEyA2kVRob1dugT9V7WU2+LIIvXqZopBUOD8FpxXw2gOb0lAiHQ2e1OfNDk/Aj6F5OFC2NSCW7csoi8pQK7/E4+SNddK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238671; c=relaxed/simple;
	bh=rceh66Pponv1tSes2XewX1UpKl2PvawtpHJAfW8PCk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv1nNWXDjjveBH+fkZJOQI4lfFcK5CEewn9mHD1V/2ZdyOdLwWFOjVH65zg2rnGyt1FEoDteLQuHIyOat4LDQHKB+ef2SP/sXKE4p/tSB/9h9ujuieUExyqEEqPFPw/anlTlwhMt2ln6ws0kv9G0b9qUnBe5oS4QuwZ3aCki7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcvMxzDb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcvMxzDb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b46da8c48eso1565ad.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779238669; x=1779843469; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDjXGwvUV0o1PWjFjzRXgYRcX8kLOq1Q/1XsDjbDTWQ=;
        b=IcvMxzDbZk84t8A78FkV+glnUf8IHM6smtfxswMUn9ESxGnx1JasAFMnotyfuUOiVV
         BQTnU3FT7arVcVq+ySfISlHL88i1b1jKkyf8fyloI67Zo+nx5MPTCxQzc0PC9OLpdvbU
         TjJ2YHsPeKjI6JrotGOlkvF99Cmrxvdkld3f0yuMJXAevNAsIsg6zYwTXlzpo8rhMv4c
         VS4jlO4F0yAdNjeYOdBf/kzzvPbgrUEV+p5rNKaMvoYiIvurULt0eP6yqo5tWv70Rpfe
         PlTAi/wT5WfLdbz4CewQXuINR9XBGRjnkm+Dmaxj+4g4CSGs+sweEiTnmRqVDGR4JVx1
         aX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238669; x=1779843469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDjXGwvUV0o1PWjFjzRXgYRcX8kLOq1Q/1XsDjbDTWQ=;
        b=rZP6z5yZQ1FUDUTOsrnCLMGnO89gZ/kKOiqAo275yukralRLoetJTU9rvvAbf2vFRY
         IHCkd+Z3QBm2z2HCGC6DYONavwwoxw0BAvKByhgtZftP7o9IHS5UDGdP2rA52ogA7jgO
         qsQaZCFnpzkISWAP8cwtIK/JQ0ozy3VfgCKjZSanqqHKN0+pAck3Z6VMqu+LAdX7hfjW
         Q0Ixlq3qSjZLL86+iTRp09yXzMCsL939x8epWZ1rn2+adGcwUUd+uzs9TW/GxnNC5NVy
         kMjkCGrLrdZesaAKJdr5P0hahtCrV+y/fQuaKJ978VEmhpTLvVLy1MNUvKVd0FEqYgC5
         EGqg==
X-Forwarded-Encrypted: i=1; AFNElJ/CLWu8iWTAJ8mE6ZFKahMwtFKDwVxMx/clNZC5Sgtxm4ZWwOa1oUwLHnO3VpTe/2tuV0G8mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIs+yTURyNRiJHmbOvdTZvAK0UAkh7D4Yew98E4cawtkN/BN7/
	FRMfv8tmgg/DoDfHwjJWnqWBBYYkLL3/sxtnp5bDorbb7XVRpPQUdtLcCy4uq40Q9A==
X-Gm-Gg: Acq92OEdyhQxR+pkrJpu2liVCOKbj43irjy5uqBhIjPSwAbHrOTBzhr/+3/ndeedWFk
	mr0qaB/yzWHcA7QAAymvqoLiMQhbGxJYFBRvcPFJgHgiuHn+RMcQ6iYfoczUvNmHzCrjnkggKH5
	BrJ++HWxcnIGXCq6NK6l+tF4603LjNnQ9jdpNEZgelzoSmoVF04aCdUaudpK2K8UH3v/SMwMeCj
	Mzra3n5WtqZObmoHOQ6yu37RVu0ooRcck16J5t3OY/A7SVU58Yoz0cu6utN+Z1I2KKcR1oA7Pjf
	TriAJRaJkAQy6vo3J3EU0O1j4GfOkVpMPV9U1r+9N0LS4Y0u7cuUNIGDqCVgxnoEuMB17FLryYZ
	djCYg05T11CBq+dZ7OGJKcQeGPdOJfXfegHtloPDbSZPhOE7e6F7Bg0toUFPg1LJMqW05ep5stW
	efpq3RxVAovI/aZvPpeWPWUUhhkLQhWN9BvvXsAi0Qr36u26R9fqxI44vEG2CU2JyLDYV1
X-Received: by 2002:a17:903:1b67:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bdb03a2d5dmr7879775ad.2.1779238669067;
        Tue, 19 May 2026 17:57:49 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb17sm194753605ad.1.2026.05.19.17.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:57:48 -0700 (PDT)
Date: Wed, 20 May 2026 00:57:40 +0000
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
Subject: Re: [PATCH v2 15/16] vfio/pci: Preserve the iommufd state of the
 vfio cdev
Message-ID: <ag0HBChHOn_czixb@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-16-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-16-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:32PM +0000, Samiullah Khawaja wrote:
> If the vfio cdev is attached to an iommufd, preserve the state of the
> attached iommufd also. Basically preserve the iommu specific state of
> the device and also the attach iommu HW unit.
> 
> Once the device and its iommufd attachment is preserved, it cannot be
> detached or attached to another IOAS until it is unpreserved.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/vfio/device_cdev.c             | 10 ++++++++
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 33 +++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 

[...]

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index 976ef17e6103..b56d80379ffc 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -108,10 +108,13 @@
>  #include <linux/kho/abi/vfio_pci.h>
>  #include <linux/liveupdate.h>
>  #include <linux/errno.h>
> +#include <linux/iommufd.h>
>  #include <linux/vfio.h>
>  
>  #include "vfio_pci_priv.h"
>  
> +MODULE_IMPORT_NS("IOMMUFD");
> +
>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>  					     struct file *file)
>  {
> @@ -153,9 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>  	pdev = vdev->pdev;
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/* If iommufd is attached, preserve the underlying domain */
> +	mutex_lock(&device->dev_set->lock);
> +	if (device->iommufd_attached) {
> +		u64 token, preserved_state;
> +
> +		ret = iommufd_device_preserve(args->session,
> +					      device->iommufd_device,
> +					      &token, &preserved_state);
> +		if (ret) {
> +			mutex_unlock(&device->dev_set->lock);
> +			return ret;
> +		}
> +	}
> +	mutex_unlock(&device->dev_set->lock);
> +#endif
> +
>  	ret = pci_liveupdate_preserve(pdev);
>  	if (ret)
> -		return ret;
> +		goto err_iommufd_unpreserve;

Nit: Would we hit the WARN in patch 14 if (device->iommufd_attached) was
false here? Should we check if (device->iommufd_attached) below before
calling unpreserve?

>  
>  	ser = kho_alloc_preserve(sizeof(*ser));
>  	if (IS_ERR(ser)) {
> @@ -170,6 +190,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	args->serialized_data = virt_to_phys(ser);
>  	return 0;
>  
> +err_iommufd_unpreserve:
> +	iommufd_device_unpreserve(args->session, device->iommufd_device);
> +
>  err_unpreserve:
>  	pci_liveupdate_unpreserve(pdev);
>  	return ret;

With that nit:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
