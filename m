Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB413774C
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881274; cv=none; b=lHipAa8CvCmwFpsq8gfE7KxjJlJk0d4pWPW+3Jz7ZiIwmBqN3buEi6mifRl56OvunRDhJJM6zUD2hTPoMYkCrbsUPnB3KZex6D7HgezA32xjorRol72naHjB/sd1qISXw3v45AnIwItZJnntPEBsW83dmB1odUGOcgzogNkX0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881274; c=relaxed/simple;
	bh=SCCRcYBSUWi6YZAeBOgGaAFk9sSP20YVxD8KQauNigo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFgtpa/nrzSdbvsWI7894cj82vh36vp7KINHTTanf5VpDVpTMSxSpQxGDv5xKpkpYyQ6Q0OYK/YLsZicYBzo9eJ/Gem4BGtOdqvJszIfCdvChrHGlSxGGgZNmqw+DAbZbCO49MpPnFRBIJXoZ1eMF/LowYG6WHB3AnExzZJYLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSEk6Qxi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSEk6Qxi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso16249375e9.3
        for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713881271; x=1714486071; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivZL1KMf5HVtw/Oo+a4INAZ/yDs5tBPuPTBsYEgRcbc=;
        b=KSEk6QxiLHnbKk2/uMZGAIy7OkbzopkyKaIe4UeJtRK450Hf+nSLE9L2k81S7bc8cr
         i7bU0bEPKZB6bcj4guxWLHrg7gVBDolQ4UO3jJFdlo7j4PBwKD8OPVDpSZVh8UgKhJ2k
         OH3XaBdIm+AG+VtIdfJFgZ54T+MN52LGYlCRJe8k+oN8H3WYZAQDOUoHmsNRoJbBkUWz
         8OaQ8UDRpBb7950hSzxfu1v1ebZsHKsqy66sTUu670k6r9w92lWKgBG5CGlvmOF/GhYW
         5Ztq4rTAl7KGfn/o060kJNYwhat/jXlFBk8DeUfmtV9jyoPqvQnnbZao0b+FB/CxCOSL
         D4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881271; x=1714486071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivZL1KMf5HVtw/Oo+a4INAZ/yDs5tBPuPTBsYEgRcbc=;
        b=uFJudwmmJZTiOublwwXtqiY5TTzr/bI5aVwq1r2a6uE+CW42WczssDP/KnRtdL+BJZ
         lAwdo9f4lbJQR/xS71DCNoaDXZY57XWn6Txw609mi+mtXv0d6ASg7id5Igyex1AB5id9
         /OffkVs2XXMKbGsOy41iYIP/VwAQkO6VvAtbMVmcLNZkjL0x7bnKF3jjcl5v8GMHHrox
         ieyxllizSuxXqpv77IUy0IIIrQfHWZjd2Z8Xa2WzcIlj+HrdqnPL30/Q9ShQRvZjU0a5
         sV6KnS+yHc1/qnplkzbANCRg5W0dHVWy2hWhoC+Jf8+VWEsCr5MvkKK31mskG7fyxjtt
         fAmw==
X-Forwarded-Encrypted: i=1; AJvYcCXzsJP5CIMcmZYgwqp/SwuKp6hdCqDJsCMJm24B9j/fB8QOw7Zb3Q6n8c05JRp5T92AI1wJEA02TPhgRS3KE/P5WgoZqQ4=
X-Gm-Message-State: AOJu0Yyh1dZ8BmV6FybktXh+/2f2Jj9pvDmS8KTAUitCXNBBUicZRp0s
	tSI3zw0nEqzJJqFmZuNH6JB27emPwPQ2rP0t8huatm8yoyTYZxhTfECbOyF5Tvk=
X-Google-Smtp-Source: AGHT+IEIwm2tVBxncnsuTwhWGS/GtsX0X8yGwreFbsWOjkFsI91R+e9ti269gvGnFYpY+RoCeixbxQ==
X-Received: by 2002:a05:600c:1e1b:b0:41a:7370:85ab with SMTP id ay27-20020a05600c1e1b00b0041a737085abmr4113391wmb.33.1713881270854;
        Tue, 23 Apr 2024 07:07:50 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b00418f7605249sm18226069wmq.24.2024.04.23.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:07:50 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:08:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4] iommu: Remove iommu_fwspec ops
Message-ID: <20240423140803.GA931103@myrica>
References: <cover.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713523251.git.robin.murphy@arm.com>

On Fri, Apr 19, 2024 at 05:55:58PM +0100, Robin Murphy wrote:
> Hi All,
> 
> Building on top of the arch_setup_dma_ops() cleanup[1], the next step
> down the chain is {acpi,of}_dma_configure()... There's plenty to do
> here, but it may as well start with this fairly self-contained little
> cleanup, pruning yet more redundancy and exposed API surface.

Tested with QEMU: SMMUv3 DT/IORT, virtio-iommu builtin/module DT/VIOT arm64/x86

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> 
> Thanks,
> Robin.
> 
> [1] https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com
> 
> 
> Robin Murphy (4):
>   iommu: Resolve fwspec ops automatically
>   ACPI: Retire acpi_iommu_fwspec_ops()
>   OF: Simplify of_iommu_configure()
>   iommu: Remove iommu_fwspec ops
> 
>  drivers/acpi/arm64/iort.c             | 19 +++-------
>  drivers/acpi/scan.c                   | 38 +++++---------------
>  drivers/acpi/viot.c                   | 11 ++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
>  drivers/iommu/iommu-priv.h            |  7 ++++
>  drivers/iommu/iommu.c                 | 20 +++++------
>  drivers/iommu/mtk_iommu_v1.c          |  2 +-
>  drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
>  drivers/iommu/tegra-smmu.c            |  2 +-
>  drivers/of/device.c                   | 30 ++++++----------
>  include/acpi/acpi_bus.h               |  3 +-
>  include/linux/iommu.h                 | 15 ++------
>  12 files changed, 66 insertions(+), 134 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
