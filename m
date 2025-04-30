Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3252750E4
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043025; cv=none; b=rfBod3A+yXcFoaJJLI+0JsdVpM7vNXIynTvkzh3+iAaqcxTlHy4hsvhqaZOPMhgsBkZaMm8xT55ng/N3ZHQvvs46V5MbOd3Tl7XE7o+6QfzoYZ+XO6ya5lCe9m7RhWUbXp47a4S3UJxsmw/FOHoFNrAW5YNH93iKICwNXXwwejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043025; c=relaxed/simple;
	bh=3qDTN+MBFQnDotoSGCXSC0TIqshMNt8VgM+VnIIfAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw5VPcrXoiKQL5Enuqu5PFCn3Q/WgV/N6KC4V+8RbuUTuWM4uc70Pi1Si9WCgKAhKpjGJKLQan29e4iD481f/bgLDN7QeKpGA4dW2P5Eg4q23C5Q8360j5g4yjhfXFdG3Ods46nVFqIm9nFITmIl9tII/UGFSK2EwyYoJCsx41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1fTK7sW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1fTK7sW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso321381a91.1
        for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746043022; x=1746647822; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+qKL+MUCJJ9XsZqOZSeMflU/a6s+djka0YUBDd9w14=;
        b=m1fTK7sWzWfqXh9lXRreK3/qaEPPnn41opNvzAI7oLiD/C7iF8oIErKghN4kdlTgyd
         Ub/lWr/oeo4Fh/0jhgnCRMbivf+7vL7GbDZvHvCNITId9YeYHP5Y+0qh1QeQqHAqWlYD
         MEjXZGh01kBK+vmqZZ0hMDaSJ9o7E1OaY5sp9Lpj1lN7YCx0IQuF50kfqDI8ovSiiiEJ
         Yv09591R8/PCt65t/5lA+6Bw82GcPKfFrrKhUqrdcFqJbLPyZzHzvRyQ2Suv3JHMMkVs
         lAuUt0amSmbVvb1oWZzxiQSuAsPvCtO280auECFRuP1pyhbpv3m1R3rnELpraxa/G4Le
         C+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746043022; x=1746647822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+qKL+MUCJJ9XsZqOZSeMflU/a6s+djka0YUBDd9w14=;
        b=AZ7+PtrLdT9t9raXCLsOMt64uILUnQspX+dzQv+IcVlhGq7HaJEule5X50psfeRMf2
         uStByypmwO24OTbL3AHgtPwlizCs9rpQaZVt7khDfs0RKE3/qsYggwClL1Fx9UeaxF/a
         al9KsfEi7C9cj298qFlaHkLugzyPm+gQr77Ha9lvpDENgBGHz+rd5RX2ZKBEYP2I1+ny
         IiZGG3DWiSkvTPJq3DhB1akeZZNvagCr2w4UrTGqdEbKo5Sm79w7icxfwhsGUT/TPdrc
         JlznSmKlxWyIrmrr3I1gvsCkgqGv4yhu4pbBZbi1B8CX7cYAKg5RqulCOVJba1FDfl6w
         BshQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1frXbMxHGLYWtvmA0NhHR6//o7wwX/EwhyNUgZ1cfid0nfQhLvitvVEKQSA7kcXpiePF0pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhGJpaVvu7sGFYHxBQO1k8uaaE7JOcuJP6KRGA2Kh/9AR+GXrb
	xOYmOsXdG8MXOT3PGmRJtuXfCUFFH15Iva5zYkO+2MP+6z5Fnznb3vXW6ys32g==
X-Gm-Gg: ASbGncsbibVRuteZ/YIsy/JS+KSjxG5KaAqe6GWkcDmD9Q932xzx/t/tk/hmE0fBYRY
	ttz9WEZ4DYegg+s0axcHchLNN0PCibap/o10l4siCc6rD7GmqeSrxpQhXr219gGgU4hoaEnK1iR
	09zfmES+jfz+N86SDwjNQUBQpMcmk2Jo7lno6b8XZ7X7cUyKAsknbZABZuA6l4iFXqzHw45nImf
	ASrJDwwkaggLrGc08l5jrHf23zM9zarTqhIKK9SkHoxfWj4eJ0YE2np4eOhBB+8QDQiqoENGC/t
	Imv+P7nhjkmOwNI4+ygmwStJfygzKLPbHvWXcNZzf4MrjmtcTwOaMfRkgXYK54ArnmP3KWs7ArU
	c3/Cztg==
X-Google-Smtp-Source: AGHT+IFYLwXsSVzpZ58dXpoeXLiC5qkI9bTIycsk32TydeZra3btf6V9VE3JspqpRKaeMTjXf206sg==
X-Received: by 2002:a17:90b:3812:b0:2fe:b016:a6ac with SMTP id 98e67ed59e1d1-30a41e6c2fdmr10756a91.15.1746043022099;
        Wed, 30 Apr 2025 12:57:02 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3471ee7esm2100393a91.4.2025.04.30.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:57:01 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:56:57 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix driver_managed_dma check
Message-ID: <aBKAibjRdrYVEWAM@google.com>
References: <20250425133929.646493-4-robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425133929.646493-4-robin.murphy@arm.com>

On 04/25/2025, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_pci_driver(NULL)
> is already computed, and thus the check fails to work as intended.
> 
> Will and I both hit this with the platform bus, but the pattern here is
> the same, so fix it for correctness too.

Thanks!

Reviewed-by: Will McVicker <willmcvicker@google.com>

> 
> Reported-by: Will McVicker <willmcvicker@google.com>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/pci/pci-driver.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f7..66e3bea7dc1a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1634,7 +1634,7 @@ static int pci_bus_num_vf(struct device *dev)
>   */
>  static int pci_dma_configure(struct device *dev)
>  {
> -	struct pci_driver *driver = to_pci_driver(dev->driver);
> +	const struct device_driver *drv = READ_ONCE(dev->driver);
>  	struct device *bridge;
>  	int ret = 0;
>  
> @@ -1651,8 +1651,8 @@ static int pci_dma_configure(struct device *dev)
>  
>  	pci_put_host_bridge_device(bridge);
>  
> -	/* @driver may not be valid when we're called from the IOMMU layer */
> -	if (!ret && dev->driver && !driver->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
