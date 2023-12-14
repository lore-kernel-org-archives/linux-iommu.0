Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A667B73
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrLEmrPh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d0b40bb704so5995ad.0
        for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576799; x=1703181599; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9x6kLcBYiEdBJWGUfxINmlIVM3g2sEltrcooCIdH0=;
        b=vrLEmrPhzFeS6HA6QpBRU1jVZDUXE1ejz4madxke2CwOR0j5dHM70cggJh9f4O62wm
         MddIo4fXTktwKXtZORBMxUx7leykNAjK8lqtonty1YoXRG+ICpUqRQtxTjWESV3wmXA2
         056kktH8Y+1amsUcxRLUEnogcbU/m3YM1iv6zPUQviqmD1ziJn0geljNy6iVrHxcnLAp
         9BEJx1Jq1le/+hQzg2P5EklNjw9o3H0D2sPMNSaeKdWuOzc2Pw5agnV+xo6U0u4s2qSj
         sC7VKY23tKnozp4arpS2MeBc1tLYN1H7++N35IeoptIISVJT91nTqi5tWv40BPmS8E1U
         2lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576799; x=1703181599;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9x6kLcBYiEdBJWGUfxINmlIVM3g2sEltrcooCIdH0=;
        b=uQStPNaAtuKBF2YFFpmVWkchdlfxsDUgSRqwCBmlKb/2orkY482hU3CT/SmIHbf+78
         ajMIuGxJekG0/Zo9HHtRCNdD4amVbmB8y0HdswA1az59No9wp7QhZGFbXviZ4f/R//l6
         ZC8WiQN1mMbCLGXbuh0MycltgofSSEb9P10GrdsUzf17JYsws5DN+JySwVmtxwprYqtt
         0WH6HDmIH1uimH+ck3dK1EfGB8CexuzodYIYVfqW68s7Qa/YM2/JsCF7R0JuoEuSj+UN
         RyCSSxy6G25tzQCSPnk+rYQxtCmiTzPsqgV8Nj68auU+JStrsQseALsemzbL+pyNCqdb
         kX/Q==
X-Gm-Message-State: AOJu0YxjpYFzf06YUA6jAPTFHSx0WiVKUNb8Ew6KYQHZSjgxGqSZLGtp
	MKRIzEo1ieosmQyZkGn60r8b/Q==
X-Google-Smtp-Source: AGHT+IH5RplbwvbCKQv+ptuR7ZWj127uLmsE7SQkvEwRe0Gbuexa/KME9clMyovQW6MkVTsfPUZxog==
X-Received: by 2002:a17:902:d2d2:b0:1d3:7d54:be3d with SMTP id n18-20020a170902d2d200b001d37d54be3dmr49997plc.6.1702576798577;
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001cfc2e0a82fsm12675679plr.26.2023.12.14.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Date: Thu, 14 Dec 2023 09:59:57 -0800 (PST)
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
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 09/10] iommu: observability of the IOMMU allocations
In-Reply-To: <20231130201504.2322355-10-pasha.tatashin@soleen.com>
Message-ID: <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-10-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
> that are allocated by the IOMMU subsystem.
> 
> The allocations can be view per-node via:
> /sys/devices/system/node/nodeN/vmstat.
> 
> For example:
> 
> $ grep iommu /sys/devices/system/node/node*/vmstat
> /sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
> /sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464
> 
> The value is in page-count, therefore, in the above example
> the iommu allocations amount to ~428M.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
