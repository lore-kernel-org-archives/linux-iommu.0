Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B291C2BE
	for <iommu@lists.linux.dev>; Sat, 16 Mar 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612551; cv=none; b=u5sEFsdSgyqm0PftyM4Q8sAnOTZu/6zYRuYrs3y5LP+ep/lVTBNC3WJT3Ba/UI9FVdCrx5cFvWGcW+vzlaWV9FjzjPf+PZzzNMX99KSMyOsMeo7L8Q4J3UfYb89CK/4T5WbqYM54f6XmUw5ETThQXbYnU+FRgHy4ZKrrjJnWqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612551; c=relaxed/simple;
	bh=M7W36AatepxpI7O/RYN4Jn7eJzFKlEBpR4hpZSIFnfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BLGMnFFIO5YU35wvRDRgP2rcMcbBRJk3rIjaRWXfrySFa6uLOdnYcZMbm4FYldKnIeg/Mj3b1sH9lfdEfSv5MHJvIWguB7c5DMTohGj897wkyoK/0aSa1WVuyKMRWuFdE/kLU0+TZzhQVBBDittKsoAy32NlGHjvtVQXYNF4RxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ashH/6JZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ashH/6JZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd041665bso49277027b3.0
        for <iommu@lists.linux.dev>; Sat, 16 Mar 2024 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710612548; x=1711217348; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZOJ0NGBpMpECnkD/VQIyE+fDv/YQu1vFH8W0copv1o=;
        b=ashH/6JZSx1+KquLxjUAtlTlJEcorvJQUr9HgoflkouV+Y7wFYbPFmZDnEoKFQLyXR
         TPVnwP/xmCq/U+aaIo9WAKF1C7ndZf+zmOxWso/kVJ7CEIOBGgMk5rkfH2IkCiFvZM9J
         FKfkiIC1TG475bhXAhGpSxE5UQHEa+l7DMow21gRIaWUBntq1UX/t2Lfn7TCMtHJM7C/
         rk7pAEEqGOWwKgx9s/YBfNNBiLxKIfF0OwczTl15FqaNdpamK4qVxEQ7LmOCvlbMteVA
         HOH1u33T9KNLgjY0ySByj8QOYQruO1+DQL7Esp7ymNIGxo9waW5+wK79b/Q2JFelT+Es
         GDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710612548; x=1711217348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZOJ0NGBpMpECnkD/VQIyE+fDv/YQu1vFH8W0copv1o=;
        b=W1yVbuUSbCjLS0NgRQPRB6wBWCGiAaTZ52A90lJljVIwvg0yiWrRmaei2ri5ASl8bM
         bJSCllRR93xnzmSL8ncsxPzueymFj8YpOVb4AMEYYMKqiZHVNKAUI8FJvMIZYH98gMzl
         mJz3ZFuVdBNJW720UVRppbzFZMDVEXDydL7Hy4yiINTunoE6QTjKDHOHOhrbToE6F3v+
         oGFgg3eNGd+g9M6085d3Zero9xxcbY8Vo4UzdM9AxVQB/K7vHGB9rbm6WbIuhMAPxnBP
         Pn7r6xuqF3U6yuue/N+85z9hri6w0Gp7qbTPhpGre8b3bLQ80g/KR5pTJl1i/JtNM6Tt
         tXLw==
X-Gm-Message-State: AOJu0Yy3q8z2tOCb0lD1dwHd+ja/CkD4vHQRGtad6r6flCAJ4R2JQh1Y
	YbGyFPb60Cisx/Okkjma/DsmZTRSFUBPAqJ2ccbYfZrJHLyLTmtQ3uHNVzRj4faLKQTfKOrA2hY
	UdXTTfg==
X-Google-Smtp-Source: AGHT+IF/87+SyaxRYuFWEJM5b0xude9H3KA3kNZ6OvcJC93YOurGx6gSCgAPGka/YmjB3TvZd+wEIU5A/MOr
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a81:5295:0:b0:60c:29b9:78e3 with SMTP id
 g143-20020a815295000000b0060c29b978e3mr1660353ywb.6.1710612548651; Sat, 16
 Mar 2024 11:09:08 -0700 (PDT)
Date: Sat, 16 Mar 2024 18:09:07 +0000
In-Reply-To: <2-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <2-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Message-ID: <3ibp3i7bbpxl4tb3ghmqkl4uay62fx7rq6s5y5rp6c2264mdht@p3skloafagxv>
Subject: Re: [PATCH v5 02/27] iommu/arm-smmu-v3: Do not ATC invalidate the
 entire domain
From: Moritz Fischer <moritzf@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Mon, Mar 04, 2024 at 07:43:50PM -0400, Jason Gunthorpe wrote:
> At this point we know which master we are going to change the PCI config
> on, this is the only device we need to invalidate. Switch
> arm_smmu_atc_inv_domain() for arm_smmu_atc_inv_master().

> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Moritz Fischer <moritzf@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c  
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d1bc151a5dff8c..9e9233331c4636 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2447,7 +2447,10 @@ static void arm_smmu_enable_ats(struct  
> arm_smmu_master *master,
>   	pdev = to_pci_dev(master->dev);

>   	atomic_inc(&smmu_domain->nr_ats_masters);
> -	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
> +	/*
> +	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> +	 */
> +	arm_smmu_atc_inv_master(master);
>   	if (pci_enable_ats(pdev, stu))
>   		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>   }
> --
> 2.43.2

