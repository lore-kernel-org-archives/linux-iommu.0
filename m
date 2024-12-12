Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664B20C004;
	Thu, 12 Dec 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997032; cv=none; b=Z5HGN9DXWEg37m08x/vmO7zXcmJatPDNcKbQozW5TviIZmnHZEulkn288yGMR3Fpr04bvUoOobZRPe9Smx3SHS17djXytr3J0Qs7ntTu1f98ZyhfOZqmIGN5Q+Z+AvUrOOayCyND7GSWnETb9NJO03tPiIz+bJNCmD0cFfdi+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997032; c=relaxed/simple;
	bh=RcPksPwuNG4Y1xIC3bF5vmeEtYYTrnsWZYZ3HfyDMRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G9yAF6xoTC6HT21y+OPvh3pa+Vi3LJ4mYAmqMuQ/eYUeSTtqMBtdioLeblAfbgLS4lxgVNavtBMX9KPsxg+6tDTsf0STAIaEDjyT2ZUlygCazmwFbkJ//C4ynvJrWfP9ZluQr9wlIl/fQ5a48/U1XyEYVKksHxXKui+ALtro15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHwISE/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHwISE/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1526DC4CECE;
	Thu, 12 Dec 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733997031;
	bh=RcPksPwuNG4Y1xIC3bF5vmeEtYYTrnsWZYZ3HfyDMRs=;
	h=Date:From:To:Cc:Subject:From;
	b=KHwISE/Q98TXg/uB9pXdcTL72yDmzbtnNZLJ2S20VIQjJl5m2Bfby6+j6FpoOqFel
	 cxNqmsFJJqkcROmODZbyaC5uUCCo1EMsH0M61NU064LLizu3DhDpG/89Cp2KDEbEqM
	 DR3I6+kI+7UsR7/xg1gsUMt+aZq/s3KK5BYPiqGk7Bw+/tsMDrAKOKi5hCUXe0h2Z7
	 eZzFuelhUm4WzZti1qTUC+vCPadwnDiIhju2ZsgKwOJwyJVTCOVA4IXD4Aa7/TA+LK
	 Xh+JY0HOcbsF6LHRkxd5ivP3q0Pxwp2UpTe6ID6CD6tLuxF2KPftMlWxWcrpfbimNG
	 pGlJ2FjfkEssw==
Date: Thu, 12 Dec 2024 09:50:26 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fix for 6.13-rc
Message-ID: <20241212095025.GA18975@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Joerg,

Please can you pull this lonely Arm SMMU fix for 6.13-rc? It addresses
an incorrect use of smp_processor_id() from a preemptible section in the
NVIDIA custom cmdq code.

Cheers,

Will

--->8

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to 1f806218164d1bb93f3db21eaf61254b08acdf03:

  iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible context (2024-12-09 23:38:30 +0000)

----------------------------------------------------------------
Arm SMMU fixes for 6.13-rc

- Use raw_smp_processor_id() when balancing traffic for NVIDIA's custom
  command queue implementation.

----------------------------------------------------------------
Luis Claudio R. Goncalves (1):
      iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible context

 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
