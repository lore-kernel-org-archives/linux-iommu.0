Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1F1F8BB0
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426933; cv=none; b=XmrRuHC3VK4344Zia1XywgZep7YR2peevj0TTeJ0kV54XW5jS7U4SDNOFS0vkn0ceKQ0i3Ut6uJCXfX6n9YqIWZ0siYgpGH1HiBkrfUXKaC3rHgsgYnyXTbGrOC+RzoRIf8vMtPRHUf+PVpXRpUNsSnoFePG163F92v5y1OrAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426933; c=relaxed/simple;
	bh=+OBKGUBEWc/g1Gl9a7Xn2ThforE0sB8K2V6ZOvRyXn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUPtfkOP2600mnqdzssf4fqT3lEHoxJJjKP25/MOG3/So1VEFApmrfLzgM5NNGW/78iE4gppscYNBAkeaDQnd3NLc1OTfEtO9BR4QgeYRJi8zAYXdpFe0lDvILilhCSzGfdE7iOgWfi31Y4Q/+Q2l9zcRFLno0vbsnRvFcZOZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mWVt/+q3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mWVt/+q3"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso2119356d6.2
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 16:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742426930; x=1743031730; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gseEEcgxR2PUFeV7iG/jei3VTxYiomeFsvivAthjJ6c=;
        b=mWVt/+q3kJ4Ik1ZXs18+JTmIKX7cPVyimUROl3DA7orru59qqd11Uc8U2Y3ykl3pbP
         X60fL0J9D+B+YOGX8rddB85S1+YcDdX+TQKff0jyV0QDzVncEY34TLc+tGDU6fkabUER
         wFu62CZ7DFpUcfxakuLyj6gLSrYce6iJVUZBvjnFeTYokIrM92jH8v63IgP7vgFDqMqy
         gZQ35+ZJ3NoNw2mxmeFhFRQaTPaS3D06t8r0PYxdTNCbT+YJzxMfCfLTwzv7b43OkUds
         r8dzHGjEtbDzRQbrCsoNeMruYGlzCfemB2I/PY7XqsQK8jQEtTOdfirnHm3U8aT0ncdn
         yrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742426930; x=1743031730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gseEEcgxR2PUFeV7iG/jei3VTxYiomeFsvivAthjJ6c=;
        b=CslNn0r0Cs9UNi3FS+lWmuckEM00nHD2r1Ttu/pOrhwQO2hBfugdgaUujgMebJgLOS
         nJiKDr8VuBIVa6GJmW2YqEVKHXSZvIRCK+S8PITzWGH9UXVYQIfQZhuSiMk6t+RJai6k
         nX3eMAdCBKTAm0AmWGeJpq4zM/O2gNOLkvHyOgraXosixqZfd3y+0/QAwMGnTbZJ4w1l
         Yn2NFwRrbvt2Db6g0XCjIOihG8WExuS5ah0+4sX7fcFY9uxLbgrjeCPe/2VB+UkewkhS
         LVy4vSsh1Y3hXzH7CmMvEYbumY7Qum1Ma8DAw7lfwyib3y7lf2HRLEw8q6/pGuGro9qD
         IHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3EhMhujiOJGMbCfxHSzW2zvsadSH6B1PnM67iwq9r2PKMXt00/4cGHYzjmgz/659RNBg44w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIfhywGubvSGetHPPcPBoAnOYTbJYNt1dutoLKIX6226CMhCUi
	qvaJwEenkYF/id9q+VBtzbzD1L5YNkxWatmC8bExpAgS68iMlZv4J+Uf/Bgm1do=
X-Gm-Gg: ASbGncuOapJgn47gYXoVlzittLPkB0wcGMLbihdkoBuH5Fcjd5u+WlLHQqUNnIxC9E/
	Ll+5paW6iwoP8qhuIJThu9wmh4vqeJQLWMNRV6OS0fHgGCCvfkMwWkNqpMFKoz/7+PlyPrNfH1A
	iYqDVxQquf5wtYjo43CNddXhiW4rxSNuAJzUzkZahh3gO9MQpgZ01NTgfwUDGjVaNurddXoAz7o
	FpbK+UgmKTq5KU4tMB5t3J7jkTKuhtF5tN3HnELkeo0Zp2me2/GbEa3DiE99rLJzWW5H94+xTv0
	ElDjupbRZO/unG3reUvsAl7YlfNSImSP2ufp7davnp0RRqRaKEd5PuvpGgQMVJz20hpEbSQgB6Z
	1s6kWD9Lehk1nlajw0Q==
X-Google-Smtp-Source: AGHT+IGbrUJL++VHjNdJiRp2wbmBFeF1zO3i2g8SKEiaH6sIBdq4CqOBZ41CKMhKYzBCvXB+fzodAg==
X-Received: by 2002:a05:6214:4111:b0:6e4:2e5f:c03b with SMTP id 6a1803df08f44-6eb293a5ef9mr61501766d6.22.1742426930195;
        Wed, 19 Mar 2025 16:28:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24ea1dsm85642276d6.65.2025.03.19.16.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:28:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tv2q8-00000000cbM-47kn;
	Wed, 19 Mar 2025 20:28:48 -0300
Date: Wed, 19 Mar 2025 20:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org,
	oliver.upton@linux.dev, will@kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jean-philippe@linaro.org,
	jonathan.cameron@huawei.com
Subject: Re: [RFC PATCH v3 2/5] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20250319232848.GD126678@ziepe.ca>
References: <20250319173202.78988-1-shameerali.kolothum.thodi@huawei.com>
 <20250319173202.78988-3-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319173202.78988-3-shameerali.kolothum.thodi@huawei.com>

On Wed, Mar 19, 2025 at 05:31:59PM +0000, Shameer Kolothum wrote:
> Add a struct kvm * to iommufd_device_bind() fn and associate it
> with idev if bind is successful.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/iommufd/device.c          | 5 ++++-
>  drivers/iommu/iommufd/iommufd_private.h | 2 ++
>  drivers/vfio/iommufd.c                  | 2 +-
>  include/linux/iommufd.h                 | 4 +++-
>  4 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'd probably explain more in the commit message that this is to allow
VFIO to pass the KVM to iommufd so it can later be associated with
downstream objects like the viommu.

Jason
