Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E836B07B
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417898; cv=none; b=TdOHkBPCLvA2Ic9cVccgmgv9sjaLYcBNfRRrvjxKN78c8IlnYxpA9pNirBzN9muEVR4I4BwCim0rP2/C/AN/lHF3hZJ8sSHh0j4eVl+yj3TwYxaH8vjc4smixEFkZY8Yl4Su5In3SGB35u+OmTH82g8LX2kmMHUXG37ros7xofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417898; c=relaxed/simple;
	bh=CSTC02ii0lruepODLI+iYCJNiDatC6zL7czgc+P0mCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re5D8KMjF17HGygsAzZ1lkygnyQLcETcuVIhYapXeeoV67QHCUdAUUKx5a887qBXaBRxSR/3So+fG3lZkmZLmNng0hlsE9ozf8k6JlIw2B2bcGVOIh5yscbg35ER6ocnqeNdhh8OyApTwvxZ+t8Cd/nJ151jUiWgjS/pExj0FKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5EzFHSl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5EzFHSl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso85e9.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780417895; x=1781022695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlRHqIhFldT/P3WJ4jK0htPSdl8EjLN6zWd/GbTbNRM=;
        b=B5EzFHSl9tl0ffuGCzdHPojQzK7fludsG2H/vIzxIsuYBpAtcJ3APROAtgcgVq9Kfv
         3sMybEuOMdoKvf0GuBMkpoolJqFO4ci35h9XEJTnSR6Q4p1lXmx/TnJtWmzOSiaIrLAm
         bbn0AIRazGQgupNfU2jaOGvrdjIt6EAwjD3C00MOrmLpPlA1s6ubIiN/w2nriOKcjy+W
         O61kb+zoqHo2VzrwJVL4iSgjY9rUu5FdWvyBbxGypuzC7vMzDhIN+a3QpFCsQRM2j5rL
         zQvWKrug44pbuekA5X4INUUBi74JvM9icApYGszXVhbodUdY73TKw34Fk0ulb0BRblJG
         Dc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417895; x=1781022695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlRHqIhFldT/P3WJ4jK0htPSdl8EjLN6zWd/GbTbNRM=;
        b=on7FyHr7Wd2qmeYEnQkv6LrBZ7PaWDu+6Hxj8F4eUZD3AVPc1zbwEy+lxUhI/RD/Qn
         l3g1VCdRB31MJM0hzT118aA7UL7NpcIyPZKxfKRR3SklgJ6fo269cGZICDbk3AOp9Jp3
         ODXuoAq9l7SuIHbgLjDTpW6zsMW0F7ROiVCGsjpWaem/yLcFEL0o7PELyyqLNKvFHMi8
         oBvwG3GfZ0ACM9jFmf8aKVlxxw90d6UzvULhdO5Ai2O5KZWKfwCjFza6+aO/HloLeLAr
         L0m4jEKwYbTo0agyDdscTUtbIVBDQ/TluzHSw3PrKinNbZJtu9YaAg6RTF4n7Jjmnv5/
         XPcw==
X-Forwarded-Encrypted: i=1; AFNElJ+m+T8ZeNKdsw4B4lN8bZ7SQgtSxLceIblkXnsNomF48KKxgKFiWVVn3GLgmSZI242fV1vzsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQq11hTgS3eA1aBLRyoSwUl61J9TS4Z8+HHF1gm2GpWTYTVWhq
	lJZn1aKRR9u21ydTP4OOJsMR+l0zSnPdOF5ehzxNkRYqpEQwwdgrFwFerd+Lcdy3Lg==
X-Gm-Gg: Acq92OEw6/DbeLWtfgXecaGKw04a1aXSUC8UYtn9CmypE/cog/rfNnef6NBipSqt5d7
	dQ/uAQ2huoqe0+dqhhiFsR93HTAlkIMDjdi8XhdzhdqhBSexLCz9GDefVgCHxI+NcCp182Bf58d
	0p6ORy9XIennyaRYDYw64ys87neSZ/no9UOizyRVWu6NxrIEHePM2ObfqlKzIXmt499dfq3QFTm
	isqssOM9vfpUh9ORus0gDh+u8FNHUZd4JIDMGU/jqPxe9HQfbHR2heJdNwtZAFXQYP6ZdkeUzph
	7TqK0FoB6PtzW0Nt+C3Rj7PH5xeRbv6Z+2kZor4J4YPWBH5p2RqL7dSR0SUk0WkeJ2s2qSpGXHC
	rYEf5MTGt/aYC2WKwEtPyaNmmFieNOtqrimc3OVHhGq5Eto0AVB44xheXHvI1HznQnUHmbzKMem
	rD/FfLSUSy2xadydicVOShKLmHdD2JvQxBQBNTzVoLzk8DDvxeYXLTMN4StVQNnBcRpR+sq41R
X-Received: by 2002:a05:600c:5716:b0:490:b0f1:3422 with SMTP id 5b1f17b1804b1-490b11655c0mr1634475e9.10.1780417894903;
        Tue, 02 Jun 2026 09:31:34 -0700 (PDT)
Received: from google.com (203.80.140.34.bc.googleusercontent.com. [34.140.80.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b29f49b8sm50555595e9.15.2026.06.02.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:31:34 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:31:29 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
Message-ID: <ah8FYa0hdkkAFQVp@google.com>
References: <20260601104845.995005-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601104845.995005-1-amhetre@nvidia.com>

On Mon, Jun 01, 2026 at 10:48:42AM +0000, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice. The
> second issue must execute only after the first issue's CMD_SYNC has
> completed, giving the sequence:

This seems quite intrusive, will the TLB entry survive if you push a
full invalidation instead?

Thanks,
Mostafa

> 
>     TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
> 
> ATC_INV is not affected and must not be doubled.
> 
> This series implements the workaround by hooking the duplication into
> arm_smmu_cmdq_issue_cmdlist(), the single chokepoint that every
> synchronous CMDQ submission flows through.
> 
> Patch 1 is a preparatory refactor that factors the existing batch
> force-sync conditions out of arm_smmu_cmdq_batch_add_cmd_p() into a
> new arm_smmu_cmdq_batch_force_sync() helper. No functional change.
> 
> Patch 2 detects affected instances using the existing
> "nvidia,tegra264-smmu" compatible string, exposes the condition via a
> new ARM_SMMU_OPT_TLBI_TWICE option bit, and adds a static-inline
> arm_smmu_cmd_needs_tlbi_twice() classifier in arm-smmu-v3.h so that
> both the in-tree CMDQ path and the iommufd VSMMU path can share a
> single predicate.
> 
> Patch 3 wires the workaround in. arm_smmu_cmdq_issue_cmdlist() becomes
> a thin wrapper that re-issues a synced cmdlist a second time when the
> first command needs doubling. The Tegra264 condition is added to
> arm_smmu_cmdq_batch_force_sync() so a full batch carrying CFGI/TLBI
> commands flushes with sync=true and is then doubled. The iommufd
> VSMMU path (arm_vsmmu_cache_invalidate()) is also taught to split the
> user-supplied batch at every "needs doubling" / "doesn't need
> doubling" transition via a new arm_vsmmu_can_batch_cmd() predicate,
> since that path can otherwise mix CFGI/TLBI with ATC_INV in a single
> submission.
> 

> The series is based on Jason Gunthorpe's "Remove SMMUv3
> struct arm_smmu_cmdq_ent" series [1], specifically commit 13428b0bf794
> ("iommu/arm-smmu-v3: Directly encode TLBI commands") which is the
> final patch of that series in linux-next.
> 
> [1] https://lore.kernel.org/all/177919957385.1012282.14787407041669291032.b4-ty@kernel.org/
> 
> Changes since v2:
> - Add new prep patch 1/3 that factors the existing force-sync
>   conditions into arm_smmu_cmdq_batch_force_sync() (from Nicolin).
> - Move arm_smmu_cmd_needs_tlbi_twice() to arm-smmu-v3.h as static
>   inline taking (smmu, cmd*) and folding in the option check.
> - Plug the Tegra264 condition into arm_smmu_cmdq_batch_force_sync()
>   instead of carrying a separate need_sync in batch_add_cmd_p().
> - Fix iommufd batching: arm_vsmmu_cache_invalidate() can mix
>   CFGI/TLBI with ATC_INV in one batch. Split at the boundary via a
>   new arm_vsmmu_can_batch_cmd() predicate.
> - Patch 2 wording: "next patch wires" -> "a subsequent change will
>   wire".
> 
> v2: https://lore.kernel.org/all/20260529140830.629738-1-amhetre@nvidia.com/
> 
> 
> Nicolin Chen (1):
>   iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
> 
> Ashish Mhetre (2):
>   iommu/arm-smmu-v3: Detect Tegra264 erratum
>   iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
> 
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 23 ++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 66 +++++++++++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 40 +++++++++++
>  3 files changed, 117 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 13428b0bf7947098daf9a1db14a74d33eb1b5079
> -- 
> 2.50.1
> 
> 
