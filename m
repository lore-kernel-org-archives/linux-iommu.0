Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479516DEAA
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962531; cv=none; b=dIc5hMTsjdF58w6IvxHWE7LZNJgvYjvdk8ZNpD7UMHwnYhdU1GQghrdlqYlKCBSASGWghxElquIRbIusn7TPZW352+3rnbCNLbXvOW2BGRbPzl3KMzbw0tostHvF1kNUYlpNW0a8ftyvnNyb+jmNrCc+10/waJRtlyuN8xwK3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962531; c=relaxed/simple;
	bh=DjLX5fBkgJU8CT8xqfpFI/dbFLVg02xVhUhJ9U952wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7C5+6JQPyl7w72nw7KeGliGmhzVW9SQQ0lTjWIFZR3vsQuqOHcfOT2DrFHDro9yBlnuF7JEa2WJLQo02dPTd8g8ocb+lD9ZhxpiGqGcxHMsbNWpm1qlsS0Bzi9EawYO2CZm07YTwxeSjHIQ0dLR+DUxjy6peclV2pzKV/Ier3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mle7hv7P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mle7hv7P"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso13715291fa.3
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 20:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728962526; x=1729567326; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgc3X3B5k3iTM1+4K9yayTFXC9bD3mynK1laekJ4N5Y=;
        b=mle7hv7P7y/8KqeiK4W83Bkqx50hqhdJV4063qs+KjbAC301qnz1wkHUjZQ3Q7VLNz
         yCS2b6V4lOhadTov+DxR3KZugYnSqq7EDAx9I1guJ/lFG6QVmQDjGI5Nk1TW+rZUTGG0
         wWhsxSBNs7vA+MQxW9WsjSedbvEEE8ZMwyh/AlYOWd9CUOfgPTLCScQ+tFXYSOwB1H1w
         iT3qYUtW8/aa3WqAxNZb6hXSF00WljlJJjxRadhBBHy3QSEKvyYT2XOVTpOJ59ln1YHy
         MuwbqYg4BVymIvyCd/AQqdRgL2FZTmb3JwW/aPQ1d7DO05EzHJXOQULiaT+rS1Tbs8Q3
         d8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962526; x=1729567326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgc3X3B5k3iTM1+4K9yayTFXC9bD3mynK1laekJ4N5Y=;
        b=A0jWz2b8g/khIxmhyI/Z7Q2FXUwhqA+B6RzSveN7ZmM752PLDjiAISqbH+/3mN7qfQ
         me7uqWOe7waiuHc1HgPDU8NScEI9PM0CsApayqP1TLhqR4wBhqFQpdJAxLe92+UQUObo
         2hsGchVXbg1QYQMV37xNN6LCF2VvQ24OhpGW0yCllajjrxcPHFAb1V1FgZv37ExLXJkD
         bOn+2a/wFhPVw35gmsCPZ45h9FP/OfnEiCbAqsMpdivekAa+8Whj6N104plQfu8sXaUp
         yoEfClUcSbDw+PPTDIRKxqwHV/Pzsly3DN4J1TKn14Sa8JPd0AJ/wpnR7M0w4kbscX6L
         EfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr7SK3NOkUQLICQll4KYHlZ+DN3rLijfqtKbGBXo9LTO5/ieVsaJe3b2Rzx4IZv5k9XlxV/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL58T6g6qpsnvfBVNpER8dDppAxTJkJChr6J1wUw4iphJizsyP
	MO/EHxT8DFB7i36VeHCRKQMCIVnh8bckHDBV82sZ8o5bIi7Mr58Zz0byF4YM06IfCx42lzIddfq
	zDMNUNVlPLedzs1ltsbyo0IIsWLn/H43NCwYsGg==
X-Google-Smtp-Source: AGHT+IF5KKFkOMyYhkCoT9zofFw4RA3mLNEAwadNBcjduiYPc6MyoAx/qz66sum4SmIdy3qH5oAV2Lmd2pGB9QF/oXw=
X-Received: by 2002:a05:6512:2581:b0:539:e1ea:c298 with SMTP id
 2adb3069b0e04-539e1eac668mr5428955e87.22.1728962526175; Mon, 14 Oct 2024
 20:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <Zs5Fom+JFZimFpeS@Asurada-Nvidia> <CABQgh9HChfeD-H-ghntqBxA3xHrySShy+3xJCNzHB74FuncFNw@mail.gmail.com>
 <ee50c648-3fb5-4cb4-bc59-2283489be10e@linux.intel.com>
In-Reply-To: <ee50c648-3fb5-4cb4-bc59-2283489be10e@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 15 Oct 2024 11:21:54 +0800
Message-ID: <CABQgh9ESU51ReMa1JXRanPr4AugKM6gJDGDPz9=2TfQ3BaAUyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Initial support for SMMUv3 nested translation
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, acpica-devel@lists.linux.dev, 
	Hanjun Guo <guohanjun@huawei.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 12:29, Baolu Lu <baolu.lu@linux.intel.com> wrote:

> > Have you tested the user page fault?
> >
> > I got an issue, when a user page fault happens,
> >   group->attach_handle = iommu_attach_handle_get(pasid)
> > return NULL.
> >
> > A bit confused here, only find IOMMU_NO_PASID is used when attaching
> >
> >   __fault_domain_replace_dev
> > ret = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
> > &handle->handle);
> > curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> >
> > not find where the code attach user pasid with the attach_handle.
>
> Have you set iommu_ops::user_pasid_table for SMMUv3 driver?

Thanks Baolu

Can we send a patch to make it as default?

+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3570,6 +3570,7 @@ static struct iommu_ops arm_smmu_ops = {
        .viommu_alloc           = arm_vsmmu_alloc,
        .pgsize_bitmap          = -1UL, /* Restricted during device attach */
        .owner                  = THIS_MODULE,
+       .user_pasid_table       = 1,


Thanks
