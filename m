Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24D1CB514;
	Mon,  2 Sep 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290261; cv=none; b=mneeIHPnxGStCOPLz+tsdqDE+50YQKXmw8HR0//Wm9HN9eVyencsGGCSFuvh5eoDJX1/GJPJFjmmnPAfHaArVmA9MwvCgDqfB+ezyReOaWxwRazUTXuAzClqXY0cAqBy6ggP8kPG36GTnY5QjC8tLXiYIs+bhKEZPozkKC504TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290261; c=relaxed/simple;
	bh=jpst8VD6A28WpnSei3VKILPWI/NAoyJNFmbGI/OAD8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKqgQ7Ai1yIDHjgOtENd2Ylm56uu0+vzd3oRYEc/zO/8MDKKksKlhDol7CZTnxW4W0RnEETwuQkBN9GW6CxjWqHoqq4GsuBVMJ/Z0qCfL4rS5gixN17bskn1TQT0/wri/6sA+eIIztn/bkeBdr7RITKb9bdegaTtlg7vYedIOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF/wvFwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF/wvFwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D09C4CEC2;
	Mon,  2 Sep 2024 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725290261;
	bh=jpst8VD6A28WpnSei3VKILPWI/NAoyJNFmbGI/OAD8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oF/wvFwIkEPM1DNHvHuLj07hrNdTvHsluqU/wgnmL41GPXK+onJf8szI0QfycztrV
	 3AFbJWtg/prkDQqtmvMx1z+RAzlzhe5dtlxMHxzVLrrFKVKf6qVee1zJ0VgeoqI1cr
	 xc9+at29BVcncSiWdq/ykDBFnJRBi4K3ttIM8vZYetZepBYAjNHuSYi6BDFTvsC3T7
	 BvuREjYY8LI7sjZ66SwSkEpJNzEerjp9C+xUlDfMvzrOCdUmxlcVTUsPsEMhZO5VTX
	 WdjrTAQmokuxfUeeeur5ol1BmxTKAJ8WNw7sZ8tt2onF+YQPosQeKG3Gc5x9CB7gIT
	 ec+vtCz41NEoQ==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/tegra241-cmdqv: Fix -Wformat-truncation warnings in lvcmdq_error_header
Date: Mon,  2 Sep 2024 16:17:34 +0100
Message-Id: <172527350346.3175637.9296819868165905950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240902055745.629456-1-nicolinc@nvidia.com>
References: <20240902055745.629456-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 01 Sep 2024 22:57:45 -0700, Nicolin Chen wrote:
> Kernel test robot reported a few trucation warnings at the snprintf:
> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:
> 	In function ‘tegra241_vintf_free_lvcmdq’:
> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:239:56:
> 	warning: ‘%u’ directive output may be truncated writing between 1 and
> 	5 bytes into a region of size between 3 and 11 [-Wformat-truncation=]
>   239 |         snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
>       |                                                        ^~
> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:239:32: note: directive argument
> 	in the range [0, 65535]
>   239 |         snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:239:9: note: ‘snprintf’ output
> 	between 25 and 37 bytes into a destination of size 32
>   239 |         snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   240 |                  vcmdq->vintf->idx, vcmdq->idx, vcmdq->lidx);
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/tegra241-cmdqv: Fix -Wformat-truncation warnings in lvcmdq_error_header
      https://git.kernel.org/will/c/db184a1ced56

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
