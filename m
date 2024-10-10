Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE61C245C;
	Thu, 10 Oct 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560547; cv=none; b=EWVBp0N5kr1rjLR0E6AdIEibAn35SI69TxnxGnt//89iIn7k3sbtHeVUGu8UZiYVPiIKfjksyVYfzuVDpIHToAK/wI2ax1wGVyIkc6msF/2Yh5ptnbOpIbDd/UGiPAuBM1Jeou3axO307yb9GjkMYBiiUqd8ohc++j8WWihy4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560547; c=relaxed/simple;
	bh=ZfoVzNMfjGzbh5wETqGwoOdK7krPhEN+2Z42yHsSf00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c0tFkU6sgq6UZFjexwkjRbhUM4YEWL/5y5LNdbGfyd0+XcA4gROEKlmt8knWOyvZXNk089E+xHQAAMRMqNA+YIOZEa/7p09of6AiIebIaRQyb4cp1qjM4AMrWttRLWm1YgZlvqxJ9WhbUZHmI8NVyHDE2R4TMDHf6Z7h7R5Va0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf/7uvEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf/7uvEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBC7C4CECC;
	Thu, 10 Oct 2024 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728560546;
	bh=ZfoVzNMfjGzbh5wETqGwoOdK7krPhEN+2Z42yHsSf00=;
	h=Date:From:To:Cc:Subject:From;
	b=Jf/7uvEsiL4CmiHAA4ccf5SRvoVv+6Ea/u/ljbGt4yLiI8PBRT3aCW2FfZ1UbcCfS
	 cxhgZaLghCQtm4z3onTqLikNLCTGuR8/yYSAyJYobBF447HO9b6Tm6X1U82ILX3amP
	 uQs2Fa5OrkehXPVNc/ecBNQfIgKezDvhS7eCQ32ev00mLtA79hhww83fsVc1HA9v42
	 YZhKcq+p1k1+gf8J4pU2Ml2fkBkYM6GTuh9LAU5wknpE+jNHbzzD3sGANj6ly2BJ3l
	 btsl78AM1b5VA5o3J6wTsqIgzLJ2bNgfEvQfdUrCuf6rMdMm1DAFkxjp4hwbtVIior
	 /CKpNy6CBxs+A==
Date: Thu, 10 Oct 2024 12:42:21 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 6.12-rc
Message-ID: <20241010114221.GA13611@willie-the-truck>
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

Please can you pull these three Arm SMMU fixes for 6.12-rc? The summary
is in the tag but the main thing is fixing SMMUv3 for hardware with
support for 32-bit StreamIDs.

Cheers,

Will

--->8

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to 7de7d35429aa2e9667e51b88ff097be968feaf8f:

  iommu/arm-smmu-v3: Convert comma to semicolon (2024-10-08 18:38:34 +0100)

----------------------------------------------------------------
Arm SMMU fixes for 6.12

- Clarify warning message when failing to disable the MMU-500 prefetcher

- Fix undefined behaviour in calculation of L1 stream-table index when
  32-bit StreamIDs are implemented

- Replace a rogue comma with a semicolon

----------------------------------------------------------------
Chen Ni (1):
      iommu/arm-smmu-v3: Convert comma to semicolon

Daniel Mentz (1):
      iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32

Robin Murphy (1):
      iommu/arm-smmu: Clarify MMU-500 CPRE workaround

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
