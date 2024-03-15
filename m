Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0E548FE
	for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538088; cv=none; b=byPgV0MkW1va9VXKjPIZFSHE6Fwwy4sFo802yHYKr+Ym8r28qTFx4kPQmlwBi6pFDUYA0InF8GijrSusGDE8W/nxskQv6XfDsnsJyvXSxuK2c0TVb8mGZBwRgsE1Lkq6TYbs3Y5wKVu8T4Awbf/w8171lPfuQIE24kfU/KibQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538088; c=relaxed/simple;
	bh=Q+XOPMRCM5h9lRk7auaVgXY8II5pi0ZuPsC/JllFwmk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l+ytvuiPZvIh7vY8kv39Mvo/yv8Zhr1M9RE1y3xq6rZO8Czgsm4HyKZ8KfrkmibtgbNyzUh+h26sJKI0VVZBIrd7IF4jTWny3zhcZFAat5yKpRVj4Z0INZxseos5GjRGfcHXD+Dt9GhekQXswBYEqXKICYsdD0BJP8huHLxqVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxHo4ROf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxHo4ROf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1deddb82b43so45135ad.0
        for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710538085; x=1711142885; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8xWPRJ3tZZgN10pKFEIYzu9dCAJ11FurTmpvR2gSvg=;
        b=VxHo4ROfVqO4DZl/ZPN65wRvmSmIY7b5r26xtqbmQPv/hT2xckvTgn9j+nykRNdFaL
         eqR3yTlPjiq/q1rR4yCS3O3mDKjL2QsywHBfBNucqgn4hd6fm6RQpzk5zRA6XRfU35zq
         iurrKbv9cyWilNrKsYNLahodHqlMxILLSekJwhYtstuttba/Q3QjMUkj1L0tR04eYubB
         xAq0QiY2rjDSvSFBqf/CsL1Q7uZPIn1gJJwpeTQS5e02JLRUH5S4P8bjEs7/QHmRZhD8
         U/VJGlvJ74wn78qk/lvnwZYK8L4iFjSfnzbJfrvFGpH0L2zHL1OIn2nhLw5jQpBKFoaM
         QP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538085; x=1711142885;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8xWPRJ3tZZgN10pKFEIYzu9dCAJ11FurTmpvR2gSvg=;
        b=pufYJ2BjVChzSFhrJgJGrvuZF3Kbu+fhGj4joH5Jth2gem7wr2kcOYXggbn0pyYLCA
         mj4qhglQAjJ3+IGicdKRfs3mQOIakbShARqlbyLit2onE+gqtKsmArXd1okNCuneB6LE
         JCBD8xwtAeH8kpahslt4P3WpIHiAIRfAUagOIycOXDJlFop1a9aVS/miWsmX7Qopkoq7
         lDgBLtocF2GZB42+UabsQFwR/QS744/WeTyPwKDeLIjqry7Dj+hpBNh53hEWQXTsx9wr
         +UfTXan4OBEQphX0kncz89gDSZLPs6bbcncXKKZpqeHDKgSfhDD6RID9ynStWeS+5K73
         dN7g==
X-Forwarded-Encrypted: i=1; AJvYcCX7FXpSAcADGJ9zZkZhWUgq5IvJ4Rs2c6itCmzUU15rDe60HEjXaJQCcP/xLwTGtKWMe2UilsiQcThhR8qIzntABnSclD0=
X-Gm-Message-State: AOJu0YyUHwbkBPCZ6izF74un+s7YkOGtMptCxC3fiWt8z/PUFYRVk02x
	l3C+5/gdftLMhwuP/BpReYw+qwkE5QcYAxhskOVL964XD83OL4edTxuPnHYTYw==
X-Google-Smtp-Source: AGHT+IFx0V9evEEHTCAL0rngEMSTSxrVQJwAPcZMZ/kTvEYdGlomkmF5ttVwWUPGQnGpzwrxLolHsQ==
X-Received: by 2002:a17:902:ea0b:b0:1dd:96e5:feae with SMTP id s11-20020a170902ea0b00b001dd96e5feaemr291145plg.16.1710538084580;
        Fri, 15 Mar 2024 14:28:04 -0700 (PDT)
Received: from [2620:0:1008:15:59e5:b9a4:a826:c419] ([2620:0:1008:15:59e5:b9a4:a826:c419])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001dddb6c0971sm4396163ple.17.2024.03.15.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:28:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 14:28:02 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
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
Subject: Re: [PATCH v5 02/11] iommu/dma: use iommu_put_pages_list() to releae
 freelist
In-Reply-To: <20240222173942.1481394-3-pasha.tatashin@soleen.com>
Message-ID: <34b593bb-796b-7657-8971-17d24dea4e99@google.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com> <20240222173942.1481394-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Pasha Tatashin wrote:

> Free the IOMMU page tables via iommu_put_pages_list(). The page tables
> were allocated via iommu_alloc_* functions in architecture specific
> places, but are released in dma-iommu if the freelist is gathered during
> map/unmap operations into iommu_iotlb_gather data structure.
> 
> Currently, only iommu/intel that does that.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
