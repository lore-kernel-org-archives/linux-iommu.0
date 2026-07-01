Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8F245008
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920220; cv=none; b=RcOxLm06NuViZPybpRQPOufrtXVx8XxoDkyKNKN4DSGuuUCEoCi/HHC+55y6ZZhzRpmoLNuAabPhJnJ8pA+o+7IMiUU+h8BNmtYnhSwaxqSl31YHqdzF6uGctEJ/rRMqYjwiFAZ9BXHwHbLwjw4uTDPlTMIxFpJLrP8eUVXboqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920220; c=relaxed/simple;
	bh=qyAuk7vvNndbZzr9c+dFli6Plk1Deun09VLbe1qJVTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkCvl4tkkb6ECc0iA6uGZr/RankgJ6vISgI1cwZTc5p6li8uwdaQwb0WC86VJSMy7BXV28f6vAI/0VLcwYidMPftPMSO7Fy71uxeI+wFaQSTttFZ0VKSGcRZdVzosaGdynHtpEpFQzJ+zBY524y7LU0yt+7E1W1empNRXxREhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktR4M2kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktR4M2kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9531F000E9;
	Wed,  1 Jul 2026 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920218;
	bh=7PMyPj49ff92f1DaqsDh3uAzfXfDvH/ocFqvDS3U5Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ktR4M2kx8zAi2arn+ibq69x76kDkmaMWw0nujrGJ0ZgnUjvN6n+VCsnXdyx4TBxqc
	 y2Q//eJ7God84zRv3Orgod57tsmFoVMzQfoEDMms+XVkq0XXwIOJh8WqW+gXehTtB+
	 Cjk03q6cKspXSJcv2K+LnLdnrR9o8h80yDFLX52Jq13FpDh9vzvIAmH2HNPAthbjkE
	 gZS6ZDZfK1ZsJ0xWKN2dt8OpU5sdV+0A9wqfRZqwp7bGfJiot3fFpP22rzVdaTGCLB
	 MxMh7rIrqu7M0fhNiwc2MXgEMrO8Dl1VMF/KH43+1SBAG7/S2jEvxlMca91OhC3b91
	 sx5FA2P/PV5eQ==
Date: Wed, 1 Jul 2026 17:36:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 0/3] drivers: Improve memory management for large
 object allocations when i915/shmem is used with iommu
Message-ID: <akUzCar-MMOMGtGB@zenone.zhora.eu>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701104437.236979-1-krzysztof.karas@intel.com>

Hi Krzysztof,

> Krzysztof Karas (3):
>   drm/i915/gem: split shared memory allocation table logic
>   drm/i915/shmem: Count mapped pages in a folio

Please move the refactoring after the fix. We don't want to
create a dependency between a fix and a code refactoring, as
that makes it harder for maintainers to backport the fix.

Thanks,
Andi

>   drivers/iommu: Catch scatterlist length overflows
> 
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 191 +++++++++++++---------
>  drivers/iommu/dma-iommu.c                 |  14 +-
>  2 files changed, 129 insertions(+), 76 deletions(-)
> 
> -- 
> 2.34.1
> 
