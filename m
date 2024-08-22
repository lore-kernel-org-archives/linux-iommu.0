Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F31CCEC8
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343483; cv=none; b=MdEDK9zw4T63RshVHdZ29Q7i0DxZMFG3oT9L4inOdZLPJA5nmljZLb/8dixMpm8bOCPWTScC38cKL4gzwn7IAipKnuXGEzJGVhymkWsqRqz5NOrg9FsOEfF5i8ZKwkZrxiIbjYNOPyDMqAsMVgajCAptL9fov06+YJtayD3pfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343483; c=relaxed/simple;
	bh=pzVZClyB/Tio3abHqD3qwB+FNWLpxRxIcAYuvZ9PxoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEceucC1BGvqaSHCKFFPTOHnD5NSEGLqgr++9tPB0uPkd4FjRt12mKgHer3I6uLNMhJVyZzpmR4DzsOpGBk4imaVjAkrPauscxFvOrrnI58zA+gqQ3OYGR0+snSrc889+v1FnWDuK+0IyPk5zCS6MHRRurCNgmY5GZerdS/BszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNboG4Tl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNboG4Tl"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-714263cb074so901485b3a.1
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724343481; x=1724948281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fw2jQnFKYplOXyWl2+iotSK1aecdZdvMgRYo2XdZaM4=;
        b=jNboG4Tl3KNwCmNcAjixhsdmsAmv+bGoH5Owl4p4nud0lVmyHRrkFtbozEZLUXUfo0
         w1K4vdfjh/SFI6qM7oSRcGPXE2j5JwpH4Nk+P3gi1r2hFL1WrRtD5PhkPraPKw8SmhCH
         82jgnP5lvk2W8cKtnA8q17Vg9z/hWHEfp8RzJDyxbPAnRdpJaNM4ivef6B6MqIOhBSJX
         QbuAlUrCKufjK7engtm7vKzJe1rR1caC0fTVkij1sJKqAHuQr3PVm4HBvuWV0NvR6uZC
         Jaci/ZDjI/MvQ5GaxIm+oHLH5Mb4hk7lWGod3mXvDZRMj7S+MKdgfzk7dIFBSenMUlpP
         1zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343481; x=1724948281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw2jQnFKYplOXyWl2+iotSK1aecdZdvMgRYo2XdZaM4=;
        b=fzcIUGvxeuwaM68nHhTb8px/dgTwR15UnPNXCmnyFk/cq57lgS3UFC8ce9QMESY9ek
         5Y9HAVsMzKIw032/F7BMaSXzIn6Sd4yQZftp7X+q2021sjVRrqyxWCdqkPDVwRo5fV6e
         lNUpDl4f+N4HxUF3ld1DtiyDdJoz22eLVW9OKoKdPCGDB2j3OB35LkSgcV2HK7mTuWuI
         19XInuB+vUE1TMv55s8qxlCvrAe/9xJcJlg8vXogF7ZFE5ixMxhU2GjRhk46p/RmICwL
         e1F9HguOD55LcBeEFtHIy+yf5fODH9luC9XK0HzPGqyRFuIARg6AarCmppfHAsrKY/e0
         3ilQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOvmVJY8isAbUeTAd6BYoy3bS4GF3seCZIQkL/XJol5HnM5VXEfvhd2L7F0B7GgZbCIQvltQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw83i3ux6w976h9ri3XF9+k4drXOf9p6Wzil9u1HbVqKC+KiDAF
	smY15KHCABuvL1F043OkoXHSmDeht8OWtiUXhLQ+GihSV3GCkS2N4mgcKo/Si3I=
X-Google-Smtp-Source: AGHT+IGuZxjm5RjDz4gxgtOdv4bxrkYUPOtjFJ+HJu04rbWtzx4ldCQFpMKwqAlGokpUal4t0n5B6w==
X-Received: by 2002:a05:6a20:9f9b:b0:1c4:9ef6:499b with SMTP id adf61e73a8af0-1caeb21cd5fmr2760744637.29.1724343480886;
        Thu, 22 Aug 2024 09:18:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:778:8246:31d8:e3fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb54asm1563295a12.42.2024.08.22.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:17:59 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:17:56 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, andersson@kernel.org, afd@ti.com,
	nm@ti.com, hnagalla@ti.com, b-padhi@ti.com
Cc: Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	linux-remoteproc@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <ZsdktJEqR9BOgivK@p14s>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812072811.9737-1-baolu.lu@linux.intel.com>

Hi Baolu,

Sorry for the late reply, this slipped through the cracks.

On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in rproc_enable_iommu() and is attached to
> rproc->dev.parent in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index f276956f2c5c..eb66f78ec8b7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
>  		return 0;
>  	}
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain) {
> +	domain = iommu_paging_domain_alloc(dev);

I'm a little hesitant here.  Function iommu_domain_alloc() passes NULL two the
second argument of __iommu_domain_alloc() while iommu_paging_domain_alloc()
provides a 'dev'.  I don't have any HW to test on and I am not familiar enough
with the IOMMU subsystem to confidently more forward.

I am asking the Qualcomm (Bjorn and friends) and TI crew (Beleswar, Andrew,
Nishanth and Hari) to test this patch on their IOMMU devices and get back to me
with a "Tested-by".

Thanks,
Mathieu

> +	if (IS_ERR(domain)) {
>  		dev_err(dev, "can't alloc iommu domain\n");
> -		return -ENOMEM;
> +		return PTR_ERR(domain);
>  	}
>  
>  	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
> -- 
> 2.34.1
> 
