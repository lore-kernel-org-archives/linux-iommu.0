Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788F2727EB
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892397; cv=none; b=QiP8dX00qbZdgmGvU62WDO81qLcGjQXAEHz3nlgxs+BvK7xKfNWUYOKdPRtXtXMLsIIzvYQkWWLVK95hbFsZl9ugOx4rvj79UX5l+h759NiUGj9EmUQDTwIiyGWj8HcLPwLPF+dkuJQ3bqgC9SV8qjA9O58m81KMIZBcZdWUN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892397; c=relaxed/simple;
	bh=+yBByH+X4c1uoMXYjK5+sjqKUIapyqynpZtSyRIaqE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOYaLroF8PEEaeKBNVm6xiVDVSK1XICzCg3GIVOkooFTMtiQsHqcEuy8Pen9PWw5JMtX3DGQakPnOsnlD8JfqlXLKAYino4X0IwIVkUX0KAcOFn0suIzjKpJPXQCOoqyn1R+Z36IkuGJL7bkCVNVI+sqnjeqIqQaL4On8yqXHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3Bl88Bt; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3Bl88Bt"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-133362c30cfso6c88.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 17:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778892392; x=1779497192; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xi6UMXsamXS4nO8ukGa9Mfe0AvlJid/kwLk/3dcmb4k=;
        b=s3Bl88BtV6CehRWzjxgbmVZ88wQ7MYpN+VZRSQqL5oipiqcmjK1b+XjYJhAnujSMxQ
         B0UT2J1fGdO7P0J35OqFsWT3R6f8x+D/zB5sPHKcitZNRMjvzbia+4rqQHMzhxwbq1XZ
         QUiLguuwzpx3/ZBO/OcRngI0E4oQbfC2MvoSaDj8/9UrPChf41qceS7fTo+N1oumxKkO
         O2IImg8+hg9I+XR1Um/YRGn6l8CStiJMch72/ijWl8Hl6HAgapERqA8HSob4qS/PxO+s
         ksXBDQ0j1Q39liSFA0oQI8JU4RNVvueqpUOBUGPvTxMYdVFSazJadPGuimxJ9ERUxzAn
         hxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778892392; x=1779497192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi6UMXsamXS4nO8ukGa9Mfe0AvlJid/kwLk/3dcmb4k=;
        b=fy2ZZVafLKjtyHee8p1GCG/PhEbWgRjgx80sT38iHkv4k+DPFUpAQcSaqKN4TRN3UE
         VACYkFrNjLszul0mXeTHKsZ3jvEvwoZ8j7ekFDGGNEs93G9PxFyxGfv/ZkwgHrRt6tOO
         vye+llm9tunD/RiK2pvuNvlJCP3/CRQXqFLQoJlJxJAb4ILe+/wSrPKE5xnPYH2ipMIN
         l//9iuvqiqeN0L2ldtv9C7+Rz5V8/hXJ2urmmnshIan2wEKSWyvLWqWqp0hTrj2JwmjV
         /UCkfxE+Pg+6Tc4ljodv9Jmpp8YvJ0qNwEE4JS/yvEdJz9eEqv7EEtgxd3eeqUSS+53n
         SRqg==
X-Gm-Message-State: AOJu0YzH5cbGnmE5CJs562K1Q97Gt54DPVKaf/EXe+/DX9xUvauLgu15
	pNJNN/s+WOdp3C923zbSJzBD0lz/jAc3qTBjFM15Z/Ig6/KSjy0FrtKJSqubLFS6hg==
X-Gm-Gg: Acq92OE952MWP3Sig5IQEuZ4Hesht/IN4nKEtkn8NcghGKB2qtJeIRs840pqNCHhCMY
	Q9S6dm1OfXCniU/RbIf+LHjHz6d93M7tiNBJFYDd4GOl7aUHr/w0FpGhYEIvA/ed2oWNun4d4gm
	ftou8LzEW5Bojm8zPZ+YhJit/bG58CyobcoLP/nSaRUr1iPhhNFsW/dNFpteQKBpxHSdrdK803l
	3+aUrlldIY321/6c1LvW68hgXULYXjX8psnmVkZ+tlej70dPw78SkzEkwFmbu9uI5rvfUp0SZ3+
	3W/a4uFEVM0KCV90fKknMkpf+VCANsjVw6gLMTzSMkqp6VOcjWVEyisN2auL3Cc01oj6DdnJetG
	H+x+DncNORoibQZ8XcCC5tN6ynNDjVTQgmpLnv+tED/qfDw5n4sxiHFnCC5bxDs1oxf8+3m3ZpU
	PRA+ITeb3zJw4+Z5CAxdU2jNRWG4oNfG0n+EZETiB2XFQGC08orcCfMGX2wAsx8XzFvERL2w==
X-Received: by 2002:a05:7022:fa02:b0:134:f1e8:e59a with SMTP id a92af1059eb24-1354506413fmr21692c88.27.1778892391267;
        Fri, 15 May 2026 17:46:31 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm11830580c88.3.2026.05.15.17.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 17:46:30 -0700 (PDT)
Date: Sat, 16 May 2026 00:46:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>, 
	David Matlack <dmatlack@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 0/9] Remove SMMUv3 struct arm_smmu_cmdq_ent
Message-ID: <age-DpeiCWBj7UPu@google.com>
References: <0-v2-47b2bf710ad5+716ac-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0-v2-47b2bf710ad5+716ac-smmu_no_cmdq_ent_jgg@nvidia.com>

On Wed, May 13, 2026 at 08:57:39PM -0300, Jason Gunthorpe wrote:
>[ This is part of the patch pile to move SMMUv3 over to the generic page
>table:
>1) Introduction of new gather items and RISCV usage
>  https://patch.msgid.link/r/0-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com
>2) Remove SMMUv3 struct arm_smmu_cmdq_ent
>3) Organize the SMMUv3 invalidation flow so iommupt can use it
>4) Use the generic iommu page table for SMMUv3
>
>The whole branch is here:
>   https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
>]
>
>The invalidation logic has this multi-step process where it first
>writes the command into a 32 byte struct arm_smmu_cmdq_ent, then it
>calls a function which converts it into a 16 byte HW struct, and
>sometimes it then edits the HW struct a little bit before passing it
>off to the batch or submission functions.
>
>Instead just generate the HW struct directly by moving the FIELD_PREP
>blocks out of the big case statement and into helper functions. Call the
>right function in all the places that were building arm_smmu_cmdq_ent.
>
>Add a type for the CMDQ entry similar to the STE/CD types that wraps the
>two u64s for clarity and use it everywhere.
>
>This is intended to have no functional change. It makes the following
>patches work better and removes a bunch of LOC. I've run several AI tools
>with instruction to look for functional changes, which did find one subtle
>mistake in PRI response.
>
>The removal of arm_smmu_cmdq_build_cmd() also achieves what Mostafa is
>doing in the pkvm series by making the command formation entirely header
>based with the arm_smmu_make_cmd_*() mini inlines.
>
>This series has no dependencies. Several people have already tested this
>on various ARM systems along with the full iommupt conversion.
>
>v2:
> - Collect tags and add a commit message note about ATS
>v1: https://patch.msgid.link/r/0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com
>
>Jason Gunthorpe (9):
>  iommu/arm-smmu-v3: Add struct arm_smmu_cmd to represent the HW format
>    command
>  iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq selection functions
>  iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq submission
>    functions
>  iommu/arm-smmu-v3: Convert arm_smmu_cmdq_batch cmds to struct
>    arm_smmu_cmd
>  iommu/arm-smmu-v3: Remove CMDQ_OP_CFGI_CD_ALL from
>    arm_smmu_cmdq_build_cmd()
>  iommu/arm-smmu-v3: Directly encode simple commands
>  iommu/arm-smmu-v3: Directly encode CMDQ_OP_ATC_INV
>  iommu/arm-smmu-v3: Directly encode CMDQ_OP_SYNC
>  iommu/arm-smmu-v3: Directly encode TLBI commands
>
> .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  24 +-
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 475 +++++++-----------
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 248 +++++----
> .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  16 +-
> 4 files changed, 350 insertions(+), 413 deletions(-)
>
>
>base-commit: d8fa633ffaf43316bc3ee8d7b21366cc92c02002
>-- 
>2.43.0
>
>

Sanity tested on non-coherent rockchip rk3588s with nvme.

Tested-by: Samiullah Khawaja <skhawaja@google.com>
