Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4A15ECCE
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841769; cv=none; b=XEjmuslrEtsp8EZm2yz0IuOC0lB95aNHu2BtHIkoDxtn8zA2Mv/9Cw+dc4Pu5S8xe7VEGHPyCHA3vmDH3fIKY6p6yJdssUu4Om35pQ+YK8+4M9xq37LkbxxL+9hoUa7klrpe7V2XE5ZrNZSQDehdtXXQaiu3LH1c8C/7Umkhdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841769; c=relaxed/simple;
	bh=VNdxMse+Oe9mdLojU0mCGXeQ+DZJWA0+7HJj8kVIBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se5ybLs+lnJbDunsXFCoSXsySHolhWAHN8CMteConTSodyylMbhR5YLRTuHEeImThK0kSD2kGR/syIYktklu6md0AdQOGHq/D3WF2YPNeol039iSzNtT2pDFLqwFh3bcSFDGqLgOu2Io+GybwHQTT95ThNz9Y9vjMwZv8otCr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBHtZxC6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBHtZxC6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso27400495e9.3
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719841766; x=1720446566; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSHA3q4477yqFVwlHVRNBlCXfb85cUCdbiSbrNOhrjA=;
        b=LBHtZxC6KnXwRq58CPGkKkAJgxqWWuXHE/Zw+gpkWnPEz/ESQNy9GoWZQWTS6xIKAN
         LzgncPCeLrhVwKFJw/BA33IOFtgndjk9djJuGINaKa31fPmlTiR/0ssR/0izILIBaAv9
         EW4XSCoWMWJU5BqCqSQ5sDuz24QanL0UpzHwjG47n4NhbKA1HTFdjUfeKF3IM/rm/4L6
         Ze6YndQGrB57Apr+b6mfan/fr26S4ZFbfPGs7m857EqLmeL+Qw+EeFyQhp7gXlbXi09j
         rbIrrbbiIJHg9jE5iATXjxTy6ev1He2WKWhtAhPVfHN/OmzRAXqs9JQ4namTNBghBFsU
         EUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841766; x=1720446566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSHA3q4477yqFVwlHVRNBlCXfb85cUCdbiSbrNOhrjA=;
        b=xNVx6gf5Dl5JGsGXAzFS8q4Gkv0p/JkCpnMfSreUzBTuG/RgzZjWXGuyfMyctBPv5g
         jybEvTdcF2NYolWR7NimTnqiPzR25F5u/w+8FluPWnvBLcEh2BIThi9kxGrYUhizuVwa
         JBTjOziPNfHmTEUtyPjLc0Qc2ytdesLSuKOdG8Aq81v7qUhKcIg2yBkeKu6Azd4A2j0i
         9/iRGq9u6CeQC6JmeVMaX4FjmJccOXRp3wRewDmLAxFJu4SLIcup7uQdl41vPSEsN+CP
         s3k4gSkOAWPJSdd9R1kjcFrM+n/++Udx3Hav0IwQAVzgJTQv8Q1xIMO+JdccmJ4oPyr1
         xBVw==
X-Forwarded-Encrypted: i=1; AJvYcCUVfSzUhCPjvXx1uoAe9/BqgnKfi4JWJAQGT+FSM7sphNRwskil3BC6jFEXC6zumpn5WrvGW0Ek65nDrELvdMGBksvo7Bo=
X-Gm-Message-State: AOJu0YyiU/8uduFYtBUi5Xglxr/vHxK8lNcaIhINhOwOyqYXzUyw0sH9
	BxtiuU33BxSaMDKhw/JxcUCLr60Sd3Sa/L+7rfs1juLAtuCj+2VuVEneDHMwJno=
X-Google-Smtp-Source: AGHT+IEpUblqE9v0NeLJXlJ5ozpWe9TPxae1ZcK0gTo7GHEOOUFGF+Khzv2YHvZ8TnyhE/LhRgJFOA==
X-Received: by 2002:a05:600c:47c7:b0:425:5f73:e2e1 with SMTP id 5b1f17b1804b1-4257a00c088mr49663315e9.22.1719841766025;
        Mon, 01 Jul 2024 06:49:26 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257fc934b2sm58300515e9.44.2024.07.01.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:49:25 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:49:42 +0100
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
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/4] iommu: Remove iommu_fwspec ops
Message-ID: <20240701134942.GC2414@myrica>
References: <cover.1718994350.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718994350.git.robin.murphy@arm.com>

On Fri, Jun 21, 2024 at 07:46:35PM +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-iommu/cover.1713523251.git.robin.murphy@arm.com
> 
> Hi all,
> 
> Here's v2 of this little cleanup, with acks and the additional cosmetic
> tweak suggested by Andy. There were some slightly non-trivial changes in
> the rebase so I've left off Jean-Philippe's tested-by from v1, but I've
> given it a quick spin on arm64 ACPI and DT and all seems well still.

virtio-iommu arm64/x86 DT/ACPI still work as well

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> 
> Thanks,
> Robin.
> 
> 
> Robin Murphy (4):
>   iommu: Resolve fwspec ops automatically
>   ACPI: Retire acpi_iommu_fwspec_ops()
>   OF: Simplify of_iommu_configure()
>   iommu: Remove iommu_fwspec ops
> 
>  drivers/acpi/arm64/iort.c             | 19 +++-------
>  drivers/acpi/scan.c                   | 36 +++++--------------
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
>  12 files changed, 65 insertions(+), 133 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
