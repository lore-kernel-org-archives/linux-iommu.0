Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05252E612D
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853686; cv=none; b=fGDHbCtfLD1FAN+6Vxgtu+4AFr7sS0BUEDF9LBOEdNN1WMQE1wdGmYQwsAfLt6yEfFGLM2HUV+iAhUn26N8e5AHXPgUt+TkPVLW2NwsF3SysulSccYY876lFYdeD0Trio+1q1A12ySYhqvtmBcqILu/SzrMMY5NS7EbbmIDXg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853686; c=relaxed/simple;
	bh=zNsikR9MK678/wLcnz+pzfRB+dtH0G9PMJUyWqEGx28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PbKc12Uik9O7Up5pG+JoG1gJFtytVMyVKR5EDZ+ZI0afkKbK3VNllVua/QkP6PYOvU58fTzsK5fr7pbGut1//5+8qyY0LolS5+dJU1tTF6q+ZtEFIWzon1XRS4xTtkGD3y30jee1Iwx8vz6NBHBXrjpftxiJGUtoLH8Is8jzj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4eRYkddp; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4eRYkddp"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 69E165248F;
	Fri, 22 Aug 2025 11:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755853682;
	bh=zNsikR9MK678/wLcnz+pzfRB+dtH0G9PMJUyWqEGx28=;
	h=Date:From:To:Cc:Subject:From;
	b=4eRYkddp4OyeRYccOsS8obmroCy2XtmVO07xi+7yKv0IpSv8BDcybPCr/c0vt/o7m
	 zjAsoYCiXNgmSYRjV5VXq6SEpa4IR3WHwNWfh9uW4PhJ8t3eX1BwgQJpzmLwgIEHKV
	 KQhByl3HgkDrsqFyrHVery5TXK1zV0gfydUc4CtgTN+ernx6nKDXS4TbxcnKxABBU3
	 2lAH1z+2rJ/gKJk4IAheUrmqaBm8sZRv93Vwkyr7zr6blolVQ8nWdqOyG4JHg01W5r
	 fKDlq/EHIBNrgSHrJp3jc1FTzwws9xdQI5aZiRhr90b8nLJ1tjluW/ESQD3BCOGaTV
	 zL05nAIH1eEgg==
Date: Fri, 22 Aug 2025 11:08:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.17-rc2
Message-ID: <aKgzcK1EldsksrPH@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc2

for you to fetch changes up to 99d4d1a070870aa08163af8ce0522992b7f35d8c:

  iommu/riscv: prevent NULL deref in iova_to_phys (2025-08-22 08:51:49 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.17-rc2:

Including:

	- AMD-Vi: Fix potential stack buffer overflow via command line.

	- NVidia-Tegra: Fix endianess sparse warning.

	- ARM-SMMU: Fix ATS-masters reference count issue.

	- Virtio-IOMMU: Fix race condition on instance lookup.

	- RISC-V IOMMU: Fix potential NULL-ptr dereference in
	  riscv_iommu_iova_to_phys().

----------------------------------------------------------------
Kees Cook (1):
      iommu/amd: Avoid stack buffer overflow from kernel cmdline

Nicolin Chen (2):
      iommu/tegra241-cmdqv: Fix missing cpu_to_le64 at lvcmdq_err_map
      iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters decrement

Robin Murphy (1):
      iommu/virtio: Make instance lookup robust

XianLiang Huang (1):
      iommu/riscv: prevent NULL deref in iova_to_phys

 drivers/iommu/amd/init.c                       |  4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  8 +++++---
 drivers/iommu/riscv/iommu.c                    |  2 +-
 drivers/iommu/virtio-iommu.c                   | 15 +++++++++------
 5 files changed, 18 insertions(+), 13 deletions(-)

Please pull.

Thanks,

	Joerg
