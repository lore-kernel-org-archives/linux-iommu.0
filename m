Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8642A96;
	Thu, 29 Aug 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939547; cv=none; b=VbcfdQpIlV45ZDj9VX7KTGcgTbOVCY/Pf6piIUcTrMjGe0f3IKb3ZtpA39Z+DZRn21osUKOBN84TASiPnalhawrGq4JXJrOfWvLwyl18npd6RK/b9KgO71Iqcigj+JqX9TA6NW+rQb0Cx7iGZVDDqTRNMUXN7f0eFxyanjd4FY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939547; c=relaxed/simple;
	bh=CxaRUm1xmAc/Nz+bbv3fyT0GhN/57FUzKVaw8fm7Fws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTg/jDSWGRzgoPW4auYJ9nrp6e4p8ZuxevqRxyRVMPhT+jPUV0QPbwKTKX6oMmfnYBz04YmGsMncVckhorR34LBvrD0moHF3c9j6uAObsYY7ufinRKqOnIYvId4fXD7+L3IjnB1GAMFXevRff/BThNd0lc8AEzh7XCPAEPxW84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W39eQQ08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W39eQQ08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1510C4CEC1;
	Thu, 29 Aug 2024 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724939547;
	bh=CxaRUm1xmAc/Nz+bbv3fyT0GhN/57FUzKVaw8fm7Fws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W39eQQ08+NOiy6UAt3IYcC/aTAtBhwKAwQ8IGFQRmDYkcyRl+U0DSPxjKCd8Yei1S
	 8RYwFVftWiCFfgBTxMj5m4VZqlo69xIaIUyx7/ZdZ+wJpAMxQyMwgCy+QNngMtzmAj
	 HtT7Hda/5pTtVv/6sgXFeBiLbYOcCPH4+9ffK6VI=
Date: Thu, 29 Aug 2024 15:52:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sachin Parekh <sachinparekh@google.com>
Cc: rafael@kernel.org, will@kernel.org, robin.murphy@arm.com,
	lokeshvutla@google.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH] driver core: platform: Call iommu_release_device in
 dma_cleanup
Message-ID: <2024082941-lagging-escapade-d9d8@gregkh>
References: <20240829120504.2976612-1-sachinparekh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829120504.2976612-1-sachinparekh@google.com>

On Thu, Aug 29, 2024 at 12:05:04PM +0000, Sachin Parekh wrote:
> Installing a kernel module that has an iommu node in its
> device tree increments corresponding iommu kernel module
> reference count during driver_register.
> Removing the same kernel module doesn't decrement the
> iommu reference count resulting in error while
> removing the iommu kernel module

Please wrap kernel changelog text at 72 columns like your editor asked
you to :)

>     $ modprobe arm-smmu-v3
>     $ modprobe test_module
>     $ modprobe -r test_module
>     $ modprobe -r arm-smmu-v3
>     modprobe: can't unload module arm_smmu_v3: Resource temporarily unavailable

Does this happen for any in-kernel driver?

Why has this not been noticed before?

> 
> Cause:
>     platform_driver_register
>         ...
>         -> platform_dma_configure
>             ...
>             -> iommu_probe_device (Increments reference count)
> 
>     platform_driver_unregister
>         ...
>         -> platform_dma_cleanup
>             ...
>             -> No corresponding iommu_release_device call
> 
> Fix:
>     Call iommu_release_device in platform_dma_cleanup to remove the
>     iommu from the corresponding kernel module
> 
> Signed-off-by: Sachin Parekh <sachinparekh@google.com>

What commit id does this fix?

> ---
>  drivers/base/platform.c | 3 +++
>  drivers/iommu/iommu.c   | 3 +--
>  include/linux/iommu.h   | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4c3ee6521ba5..c8125325a5e9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1467,6 +1467,9 @@ static void platform_dma_cleanup(struct device *dev)
>  
>  	if (!drv->driver_managed_dma)
>  		iommu_device_unuse_default_domain(dev);
> +
> +	if (dev_of_node(dev))
> +		iommu_release_device(dev);

Are you sure that all devices that pass this should have this call made?
How well was this tested on different systems?

thanks,

greg k-h
