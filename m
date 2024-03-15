Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953F548F4
	for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538438; cv=none; b=WJq4pAs6YOoSPjNPPkD9VLz9RA1l7+L4CyzQAHFBVH03bF0aVHOxG/E3hPTisdrrTl6u89IB9hZ4YawWQVV9tmxir/kbtnvWgiUMU37vlyKeLNTJXhHVXeSOxA1aQhmrbjgT/EaX3JA2nUo8uIO6xAF8JjAi6dR+I7e+hmk6tw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538438; c=relaxed/simple;
	bh=0F2XERw7B5j+mPxmlsSoCMnEowgGmNL23b1OGvmX7Uo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CDayUBYPJdTi2GhEfjHUnzsvWkdP+TVSvVksNpZtGEfpSZZijVmjA+Mh1QJQjPvWYF15IzkTOrmhWD9Bn5G7bINCqAgIVI1miUsuY9WEU2rDwsXyY1wwKQ33tlBi0q/e+nu0W6Gv04nncEXaLdqRYx0XD+cn28zPl84ddTV9N+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIy6QaHe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIy6QaHe"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dee917abd5so18995ad.1
        for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710538435; x=1711143235; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0fR8S5zvFKWxYVHlf5dgazwtBnwp1HgnsQ4yUvybtw=;
        b=LIy6QaHeD+yIJLg2u91HZu8/xhEMxrAHN1rWobOule+Qm0pR25MtXza/HxHj2Ru6qY
         Y23LslTT958E9mPUW7Z7gJSdRwFJLjslbDftLg9zc7AZWYODQRh/jUZMY13ouGcwvgKQ
         Kl/h086fFaboki3wRj9CQnzGmDd5BssoPSYZFMfdPHn7QdzznqGVCn7RvJW8gCkPfcQx
         Q5fbsjFvHtQr6ipufoHDKhIACcBiR3z0fy6jQ8BgGeWKvvVqPYKBCbIpO+3SxtzT50wj
         rCiejHTunPoqJE6WouVoRpsFcJU2NwO1UpfgIXRpRwS30za70qRaDzemalBzqZzE3MFv
         wAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538435; x=1711143235;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0fR8S5zvFKWxYVHlf5dgazwtBnwp1HgnsQ4yUvybtw=;
        b=hJuzjOu5bLOsb1fPzTQhqjVch1Iqt2Sm8tNW5pdT5bkFefRlyhLPn8g1oz9S3ZRCMu
         TUyPepTYaHXt0KzL6svsoM8BZRQdwLrabKmyBcbZmSEwJrj28LmEj6mh4sEZg9f4mzIv
         yaDtiON5/bRsVsyfwgXnDfrvvW/Ki5ohqSTrrkJ0VhguLbTo7lmW0Y+kktmFBJMRO0+Z
         3cBRtth3VAZS/PfYxNPtGNDmWlmKmRqnd6livyJxF5Rzkv3KOy1Fh11Vb0jjxQmrVV0F
         NqpazJIumoRzuPfnddRrp3Xt4R+GF5WiE602nWjST9G+U4Nd8e2xpktkeZav89R2mpAp
         DKtA==
X-Forwarded-Encrypted: i=1; AJvYcCV2vukiOYGmylOEv1RnKuFD8PN0K75Uqtc1nJO3AF6vRoljTGTGRpJlX9ykCri3wX0bLycAvUkcETEgWq0LCeHk6hdCQKM=
X-Gm-Message-State: AOJu0YxP7myAQUlKim0YPosPwvXRtosO9WkTpR2zTVfs3qla7pxT7p6E
	9LrqoAnGWf51QwiJi4Y+s26zm8gldUiYmfQSJpuCZ9ALJ9iUvEoKhzJBU7jqaw==
X-Google-Smtp-Source: AGHT+IGXgrCyapbX6lCjIYimjaGV/xGhnyUP0IGlJg+FRlRNpmX3AgagAydyQ+EpK396sF48foPkSw==
X-Received: by 2002:a17:902:cec9:b0:1dd:e26f:1363 with SMTP id d9-20020a170902cec900b001dde26f1363mr534470plg.15.1710538434920;
        Fri, 15 Mar 2024 14:33:54 -0700 (PDT)
Received: from [2620:0:1008:15:59e5:b9a4:a826:c419] ([2620:0:1008:15:59e5:b9a4:a826:c419])
        by smtp.gmail.com with ESMTPSA id hq16-20020a056a00681000b006e6c8ed17bdsm3829728pfb.100.2024.03.15.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:33:54 -0700 (PDT)
Date: Fri, 15 Mar 2024 14:33:53 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, joro@8bytes.org
cc: Andrew Morton <akpm@linux-foundation.org>, alim.akhtar@samsung.com, 
    alyssa@rosenzweig.io, asahi@lists.linux.dev, baolu.lu@linux.intel.com, 
    bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net, 
    david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com, 
    bagasdotme@gmail.com, mkoutny@suse.com
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Message-ID: <00555af4-8786-b772-7897-aef1e912b368@google.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Pasha Tatashin wrote:

> Pasha Tatashin (11):
>   iommu/vt-d: add wrapper functions for page allocations
>   iommu/dma: use iommu_put_pages_list() to releae freelist
>   iommu/amd: use page allocation function provided by iommu-pages.h
>   iommu/io-pgtable-arm: use page allocation function provided by
>     iommu-pages.h
>   iommu/io-pgtable-dart: use page allocation function provided by
>     iommu-pages.h
>   iommu/exynos: use page allocation function provided by iommu-pages.h
>   iommu/rockchip: use page allocation function provided by iommu-pages.h
>   iommu/sun50i: use page allocation function provided by iommu-pages.h
>   iommu/tegra-smmu: use page allocation function provided by
>     iommu-pages.h
>   iommu: observability of the IOMMU allocations
>   iommu: account IOMMU allocated memory
> 
>  Documentation/admin-guide/cgroup-v2.rst |   2 +-
>  Documentation/filesystems/proc.rst      |   4 +-
>  drivers/iommu/amd/amd_iommu.h           |   8 -
>  drivers/iommu/amd/init.c                |  91 ++++++------
>  drivers/iommu/amd/io_pgtable.c          |  13 +-
>  drivers/iommu/amd/io_pgtable_v2.c       |  20 +--
>  drivers/iommu/amd/iommu.c               |  13 +-
>  drivers/iommu/dma-iommu.c               |   7 +-
>  drivers/iommu/exynos-iommu.c            |  14 +-
>  drivers/iommu/intel/dmar.c              |  16 +-
>  drivers/iommu/intel/iommu.c             |  47 ++----
>  drivers/iommu/intel/iommu.h             |   2 -
>  drivers/iommu/intel/irq_remapping.c     |  16 +-
>  drivers/iommu/intel/pasid.c             |  18 +--
>  drivers/iommu/intel/svm.c               |  11 +-
>  drivers/iommu/io-pgtable-arm.c          |  15 +-
>  drivers/iommu/io-pgtable-dart.c         |  37 ++---
>  drivers/iommu/iommu-pages.h             | 186 ++++++++++++++++++++++++
>  drivers/iommu/rockchip-iommu.c          |  14 +-
>  drivers/iommu/sun50i-iommu.c            |   7 +-
>  drivers/iommu/tegra-smmu.c              |  18 ++-
>  include/linux/mmzone.h                  |   5 +-
>  mm/vmstat.c                             |   3 +
>  23 files changed, 361 insertions(+), 206 deletions(-)
>  create mode 100644 drivers/iommu/iommu-pages.h
> 

Joerg, is this series anticipated to be queued up in the core branch of 
git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git so it gets into 
linux-next?

This observability seems particularly useful so that we can monitor and 
alert on any unexpected increases (unbounded memory growth from this 
subsystem has in the past caused us issues before the memory is otherwise 
not observable by host software).

Or are we still waiting on code reviews from some folks that we should 
ping?

Thanks!
