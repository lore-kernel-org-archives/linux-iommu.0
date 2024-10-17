Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE71DE4C5
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172118; cv=none; b=lYrSzrCMneEskOc5KZuSH2h3pr8Hl+IG4SaxW55SqhUSXSl0j9PYVCvORsJuf/aa6zEA9LfKr8tcMQQlZvHI6GgHeCCnDPUeGkXveYuqsZgm3nzg7EczkVULKxlGCRnP/+YcLmfa346uGJAS/dYR5f+aAeFJnlTTp9w0RkizERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172118; c=relaxed/simple;
	bh=O5eohXbI3x99GygmJyJkhD5cFZoid8V5cafhz8OETE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YysXRqFLHAxJLlyA+yZb1idwhJSKns1SUQdcJb88zmOfg56lYNWYaaDKoPr0+AolI0YwxG+VWVmFsCkgY9FZ/7kKxkoa/NlHCKrkwmfhC4KHwrHEjgvxK6aipRHRIviD4ouj67BtdEV/nE4bX/poTyRbmyQF9QGlb9FfmjFBsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lJM0giX0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lJM0giX0"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46098928354so7787041cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729172114; x=1729776914; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7b/TiXcYtmpskihhS9/t/QU12arE/BBMwhTVMMd9z28=;
        b=lJM0giX0qseewoUMIlBnncmFk1fHOX0CxSYLMLgU1KHShDOQKHH6x1B/UOMy73PNGM
         bV2mxjwD4GXAKjaTvjoBBogoLwe/WPw5whLwkvg8fnWYhsd6EGp9sucrVCmicKPOde/o
         hqoOfQih1hrSjhakCVw4kedROd9c5H1TSmo31oWouyTwVPTycooSkaBt46M1TnVrDIki
         cICCY5u9VNM9wH5uV5ocSLKdqUDSKr8kH3QRh2qI7Uj4skbhzytpqoMuXS4ynVBUnNIJ
         OJ6ZqUwrnVjlFm8ZSHE/MDQaEPs5VtBEVMHwN5hfDGlusth5CbBKr/6V4hm+a0wjKddX
         5f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172114; x=1729776914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b/TiXcYtmpskihhS9/t/QU12arE/BBMwhTVMMd9z28=;
        b=XRqUoHArXcBMKXu/DHQ2S7Xg4bhL77k76lIAtOsacoMkpVSKQscJniC9gepb+5i0mU
         7Vr9zZjq4sEGYhY6uV5HZJQOzoqhS8Pg1h1LHPDBPfvyXOcFiB9JoU3wPvJjlpfDZRx8
         6j9/L8yh60/GTBcMQnBOPBVbHqPPrBAUCQoJ8/mxzYOM/bSvf6/QCrs+vbQIW+Tsd3ix
         3U1XhXExzxGCdBlx/3ubNAW4h8J+xhReZDpjEaYGUgNTN/kRddgaJJxa3ViLGCs1NI+X
         1ycvA5CNlAdu/IvlxMz31Ge0++XHIN8OZUplKLFjMmUW+l98vG+ZYxHexJ6vun+d+hYN
         P1CA==
X-Gm-Message-State: AOJu0YxP5rRfsgN5OUiHOL7yqPTw/j1AQ9IX8RH/3BLgDSb9grQw5zrU
	RRV9OIOga3n0+vJh4if/USC+SuPYAmQz69EkEIQX0S+8A1M9QrcXsiPiYx6ZK9w=
X-Google-Smtp-Source: AGHT+IFwnXEXwXc0kNE9t7PStntaMpUuz1EbhhbaJFht0w7pWNYxd10u045EzFhpifSA9IzSsqFcfw==
X-Received: by 2002:a05:622a:5187:b0:460:933a:f69 with SMTP id d75a77b69052e-460933a122fmr65574111cf.13.1729172113851;
        Thu, 17 Oct 2024 06:35:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38ba69sm27857431cf.87.2024.10.17.06.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:35:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1Qem-003yAM-V1;
	Thu, 17 Oct 2024 10:35:12 -0300
Date: Thu, 17 Oct 2024 10:35:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 09/10] iommu/amd: Reorder attach device code
Message-ID: <20241017133512.GS4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-10-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:35:00AM +0000, Vasant Hegde wrote:
> Ideally in attach device path, it should take dev_data lock before
> making changes to device data including IOPF enablement. So far dev_data
> was using spinlock and it was hitting lock order issue when it tries to
> enable IOPF. Hence Commit 526606b0a199 ("iommu/amd: Fix Invalid wait
> context issue") moved IOPF enablement outside dev_data->lock.
> 
> Previous patch converted dev_data lock to mutex. Now its safe to call
> amd_iommu_iopf_add_device() with dev_data->mutex. Hence move back PCI
> device capability enablement (ATS, PRI, PASID) and IOPF enablement code
> inside the lock. Also in attach_device(), update 'dev_data->domain' at
> the end so that error handling becomes simple.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 65 +++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
