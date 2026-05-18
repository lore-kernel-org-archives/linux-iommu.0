Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278740584E
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112560; cv=none; b=DmBoMjiC239A6sTUT4JZMY6C+Z39U77MgVE2ZzyHWuXpSzLSTHidDEatSOr3WcPnlTCpONFCRyov9Fdr4qWHCcmx4h9Rt41IyC6+XjprU/c6kEZhuu0KYYK5+c6gYDbsKS938os2jLRjVVr21OaH8JUeRAWokEULtuaAsK26Lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112560; c=relaxed/simple;
	bh=z0YAAFadfH2XhcgzCUpbz1tgJixrxEta51A0Zjz3Ce0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxHCMQrOdqOnqwlpNK+hxJ1SA3q1XlKkM/nPmp+hTHtmw3FvDGPJkXVF9n7qU24mghO6SxuNUKpVLat4FBmfxK+iCYaAEZwHT+3K2PBEGEgT9wiN5O6OkbEfgJdzxtSO0VHOk2VNNtt0eWnH6jWCqjo/J38n3Np5jh2sqfQ2dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqEY1n+5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqEY1n+5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1565ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779112558; x=1779717358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpxsdrpOF4S4sGgcNrBSUgvtEzER354ji9FqhPoZM3I=;
        b=kqEY1n+58ruwCYRQaMX8siqxI408/939GF09Stkurh+x+mI0mpyb29zfbkLSOF43CS
         U9Odw84POdaZRAdXgtB+nBptL8Nt8Kf54EETh4bfPfyxrDgnWqPKT+g6IDpjHfd4l/f6
         rDHFPD/APBL4CYK07UA6HkkYd52HcfT1NSW2XOOoE9UzNyogYjdjxCBjuWqMzgOpjuaX
         6zFaBwtyosAakqY/GAYlBfHMqNAbhB52yUOgol48LaL/v90yhRqGxPEXQprSqeMjAov2
         iMJjgYPT72TOdY0f80mRUSksctNjbQ3PjSjDkO52Wdy/cJDMXMOoVvttq/yMBvj5RB9Y
         zuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112558; x=1779717358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpxsdrpOF4S4sGgcNrBSUgvtEzER354ji9FqhPoZM3I=;
        b=hWA6RheFWtd6dZnOvhPvBmLlcJ52PnbM/FdaOEPxNObIjUIlRTQ1LBOV+MJi5oscIR
         oX9IhWuhGvArjFKGyeiVXupsD7U1Rasi06JD+L2Pp72P+m1AmMpUKCbIT3pMXWHWUpTL
         hNZowGd+51y6O4Y6BkXwYwEt0LjG6dfLIsj2d+RpdaF4TyYR/A35ODPI3d3M1ScL+eF0
         VLem/1AfJAW1ol/Hq3k6mnuZ5lP5kX35oNktpx8dU+yefPfv9agDwoYJwEATxN+f2EIq
         GY3Qwf9CGegm8F0zslHj0X+oM5zhbeLSU6qJFtU/0Ja7ERMXiVudxDuR6AKKrncNff03
         nNgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rwrhCwmvsAWSaltRaQVzpy4GLXFHvVHW+DmARS5c/Q3TdtXJSqoyEq49TJEqRHTn8BGf+2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFf/4Me5wMAi2HHKqGRl7q7vV72MvwNt7izCi402SR9d+H0tL+
	eekolEPUE5DgKi6+vRH48iNbkwdr+GWgqJOYVe1pFI2AcAZv+UsFLiSz/GhA1VabTg==
X-Gm-Gg: Acq92OEqQeT7NjGxnMuHBh4D0hLiRvI7wsbyBPJGRz+S96piUDN81/6WCW/BOqLfI/z
	htw7R7Cisv9kIvq2AFpD5h136DFglqtXZ1OLljbaapoBHR+4pbjiS+SSQGAwxyWDjto9Tkd6W7I
	KTv3oTU1T++TnB/UQ9ZUev2Gpqztbo02WLxX6K7OueLG66iZxNeCzwrQHP4VW2d0DujHRKLPVEQ
	Mp5ODvhVIVScvHw5+mwqDmu2/sL5jsxt7aG9iTDeFIZd7WSNQ789pGot+M0XFDb1QsX7OQUdsQt
	cJdn1GYW3vs/jGS8R4HYJe+maxA3ScY1eaD+hZY+X6FkWxFS/ACH1vHHgcu++aikduIHzhmxk8V
	giYgxdPU8Om3GftTUQUVo0k+pqvUI4ih0jOCs0gXkjIPEEgsbeATs/wnNX9zypYOClqE//1lqUB
	k4cz8dI6xzo7sDPNrxjRKjzd5MOGVeATJXUZyAs5TMaNIrgmQngL1wnxASzGGB//TQD9Um
X-Received: by 2002:a17:902:ce85:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2bdb32bcb70mr2835105ad.19.1779112557249;
        Mon, 18 May 2026 06:55:57 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm158176915ad.46.2026.05.18.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:55:56 -0700 (PDT)
Date: Mon, 18 May 2026 13:55:47 +0000
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
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agsaY9714WS1N4Zu@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-5-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:21PM +0000, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
> by the IOMMU drivers that support preservation of devices that have
> their IOMMU domains preserved. During device preservation the state of
> the associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  33 +++++++
>  include/linux/iommu.h            |  20 ++++
>  3 files changed, 215 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index f71f14518248..765d042e22e3 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -11,6 +11,7 @@
>  #include <linux/liveupdate.h>
>  #include <linux/iommu-liveupdate.h>
>  #include <linux/iommu.h>
> +#include <linux/pci.h>
>  #include <linux/errno.h>
>  
>  #define iommu_max_objs_per_page(_array) \
> @@ -293,3 +294,164 @@ void iommu_domain_unpreserve(struct iommu_domain *domain)
>  	domain->preserved_state = NULL;
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
> +
> +static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_iommu_array,
> +			       iommu_max_objs_per_page(flb->curr_iommu_array));

Nit: Same thing about brittle casts here, shall we make them void ** and 
cast then within alloc_object_set ?


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

Shall we add a defensive if (WARN_ON(!iommu_hw_ser)) ? I'm aware we
check this on within iommu_unpreserve_device() but we don't seem to
check it before calling iommu_unpreserve_locked() in the error path of
iommu_preserve_device.

> +		return;
> +
> +	iommu->outgoing_preserved_state = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);

We seem to assume we'll always have unpreserve implemented? If so, we
should check it during the iommu registration itself and fail it, i.e.

inside iommu_device_register() we could add something like:

#ifdef CONFIG_IOMMU_LIVEUPDATE
if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
               dev_name(iommu->dev));
        return -EINVAL;
}
#endif

This prevents a half-baked iommu driver from ever spinning up, completely
eliminating the need to check for it inside the live-update session paths.

> +	iommu_hw_ser->hdr.deleted = true;
> +}
> +
> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_device_array,

Nit: Same thing about brittle casts here, shall we make them void ** and 
cast then within alloc_object_set ?

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

Nice.

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

Nit: Should these be updated to use virt_to_phys as well?

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

[...]

Thanks,
Praan

