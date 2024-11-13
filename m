Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182829CE5
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459716; cv=none; b=E3pJZH2yM2bRkgfl2JzExHMy/dVIIkTssfUUwDvzEPeKWJ3kb4psItBmcrM6PrMqCMGPdiRrKia4XHN6AK3EdZnl6OccACRuWGb9evZs5Z75/LQjlVGgYpVX7ZHYLkVyzKw8ets/D74F/We4Lmzew55IXATQIwv8+dYgECKAJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459716; c=relaxed/simple;
	bh=5v0Pumd1wdfkWfYkDyIym/XT5Jsmn2z22aIpke3ZD48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwcHocURC/4pMmgYLU9pFNDdjcFQIbX9alfc0GsV5zlAA0e5xe0N09Ca8nTechyueDGBtQcPUREM7UoRbMYYZrys3gw9jFHmo+4NI4v9zt8ZVBXsIxgDWVJD43liZpPM1dA3ICQi/XeSRiEMd9EbIpG60S3yPbaou5kc2bNgegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUAlv8Oe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUAlv8Oe"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so372438e87.2
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 17:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731459713; x=1732064513; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/yyOuGNVIzT+zYvh4v3hplD3RNbNSCQhrz/FBYBpRw=;
        b=WUAlv8Oee8KJ+cX44lXGDjCwRCu/OVC5DjG6etP3FC+thz79YMprikjJJsgCueear9
         QzpE1xqnsPhx7a6rb805QcHH3j1N6cXAGzDlTKv5+tf2RdjslT/NBKW6ai91o1map5wb
         TRql401a1WZzcFtwoCqnzYINF8od3X33HitbgtWSZd22+VEsvx+QxrQP2qiRfEdSR9cH
         i5T40LP9Xj1jUTfEuPIdyXgWODyVOtAdQAWmPvyPciq9lPgSKcnDWQIL8iEaCQtJraE9
         ik/5FY5o8JEgGMAEGX5QpxqTXortJKvCiN7U5Q8PK1SjNIUDmv/fN+mkfDe0csE8iQoq
         E6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459713; x=1732064513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/yyOuGNVIzT+zYvh4v3hplD3RNbNSCQhrz/FBYBpRw=;
        b=SxoK13ve180WtcBrjZt5WliBSLk0jiUG4o73VRBZ2exc1mrRktHi9HfQ13clJWNWft
         nLc46jP6O+d6kXlsJWm83LKH+8xcV61bsmQjG+vdeu1Iu/5g8ophpJBvRuUkAKokq15H
         UwmXMruoDu2UIQWjWDsRoklGZOKZIBRP7ufckvcb7Abc7g/h39GNxr3c2tsfOJh2ohJ4
         IK2zSPmTpD87Ri58sxg4mojrFG4adUntVqccehbrrbdj6Doxmd75oLBXxCLTih/S3SuH
         W47vAAKfE/8kbS/A9eGHiuNEkIZadkAdsS+lBDnncFlQnZDiPslfiv6ITfIeC+m6HI1W
         0/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhDQqoZEqeVVMfrZfoiSVVNgTXCsNJgngiF9Ke7BCUp0cTXJRTWh6aL5oAyf7VOJvla0cB8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7r0Tl+Wugbb8zUCsfQCvKq/sT0ilKczzVvTkui1jRxANLaVtu
	YU8l+ESJZzA/Ao78t5UZh15LRrQ8gzMorndEvRH5VWEw151pm7iDWu26ADE6LfYgdQajqDAId5C
	qCoi8HxZ2Jzy+K6L2uzrZisklcRvIolZjMPsCNw==
X-Google-Smtp-Source: AGHT+IGrTpBP4XZN2inszS5LiWIDhaTOAjWYv1IN45jLudjPrpRKEn2OnUUglHnQBM+zZuWyWdAuDjaQVoneTf1/DNk=
X-Received: by 2002:a05:6512:ba0:b0:539:e436:f1cd with SMTP id
 2adb3069b0e04-53d862d38c5mr9315032e87.16.1731459712927; Tue, 12 Nov 2024
 17:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com> <20241112182938.GA172989@nvidia.com>
In-Reply-To: <20241112182938.GA172989@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 13 Nov 2024 09:01:41 +0800
Message-ID: <CABQgh9HOHzeRF7JfrXrRAcGB53o29HkW9rnVTf4JefeVWDvzyQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Initial support for SMMUv3 nested translation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 02:29, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 30, 2024 at 09:20:44PM -0300, Jason Gunthorpe wrote:
> > Jason Gunthorpe (7):
> >   iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
> >   iommu/arm-smmu-v3: Use S2FWB for NESTED domains
> >   iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
> >
> > Nicolin Chen (5):
> >   iommu/arm-smmu-v3: Support IOMMU_VIOMMU_ALLOC
> >   iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object
>
> Applied to iommufd for-next along with all the dependencies and the
> additional hunk Zhangfei pointed out.

Thanks Jason, I have verified on aarch64 based on your
jason/smmuv3_nesting branch

https://github.com/Linaro/linux-kernel-uadk/tree/6.12-wip
https://github.com/Linaro/qemu/tree/6.12-wip

Still need this hack
https://github.com/Linaro/linux-kernel-uadk/commit/eaa194d954112cad4da7852e29343e546baf8683

One is adding iommu_dev_enable/disable_feature IOMMU_DEV_FEAT_SVA,
which you have patchset before.
The other is to temporarily ignore S2FWB or CANWBS.

Thanks
