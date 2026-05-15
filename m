Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3630568D
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867879; cv=none; b=VmTpJxWVlOXqZcHWJR0NXxT+B/Lac07+Dk4M5IgzDzDyzTcwX3bBI5PKya+1mxNxqM3F66rxb3YovFHhMNeSf91wgaHK2NPOMPVuVByOkcXeQtNQYu/MkGCpC/b9aOGjVR40IMrrWMVe+87yZ5EPxFpj4IbKqdEvNvYH21Jgw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867879; c=relaxed/simple;
	bh=h5bIEhEA5xmwd5SPLa7RarIaKRLrl7jYEdNmDpO9iik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hxj9/zp/rG8HRnR1lEiNRBujdCAG+61tgAEqT+LelaMRC5SZaeURP9TwygorAWbnMLF2oD42hkJiB6KebsbVJPq/9XZ0rSwVqOKzASms2ygDuoLUs8tN86Ciscb5AgCX9BYO5cVl5MZH1hdrHig7AxxcFEyrS9H2EB82lfI/4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=LIIqX4Lt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LIIqX4Lt"
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7FD341C48AB;
	Fri, 15 May 2026 19:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778867875;
	bh=h5bIEhEA5xmwd5SPLa7RarIaKRLrl7jYEdNmDpO9iik=;
	h=Date:From:To:Cc:Subject:From;
	b=LIIqX4LtGBJHlJAW7Av3HJw+WZiWUxYl3WCA4DvYIngpY4tCqhKgQNyIjZBZJ74TX
	 TQF+myGZERzC4QUIjkXyjc3EmpTKhLpdk8MWwrzngakaKeAv3TVu5gtn/O8ssbyUKb
	 zSig9Oc+ERYknSUut6aYMdXqbL/6STS5/msg6/v5BcoX9WSgFz7Z6x99/3DAfbRjct
	 wRrdSE2wqza4qLNWDenAoUVFevYuZINk9XCSkmX8iu5i5qIGO0bqJisdlRBInY5Ggn
	 1ZgztReql+usc/H/Hu8kGxEA0uebSgNDE3KEhtFsO0T90isGoyrnhsndZ1Y5wmOixb
	 lFf6Y5CeGM5YA==
Date: Fri, 15 May 2026 19:57:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.1-rc3
Message-ID: <og4pb7fwmfp5ogjssmsl6uk5ies4t7wba6l2l2gi7ek76tpfji@jhvxjh4rx5in>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

This is probably the largest fixes pull-request ever sent for IOMMU. I
partially blame it to AI code review which found some issues but there is also
some rework in here to fix issues in the iommu parts of PCI device reset. I
hope that is okay, if not I can send a smaller PR, just let me know.

With that said:

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc3

for you to fetch changes up to 1bb54043ff309795c90ccadd8a6e6b13ac40ec4e:

  MAINTAINERS: update Tomasz Jeznach's email address (2026-05-15 07:30:28 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.1-rc3:

Including:

	- AMD-Vi:
	  - Add bounds checks to debugfs and table lookups

	- Intel VT-d:
	  - Apply an existing quirk for Q35 graphic device.
	  - Skip dev_pasid teardown for the blocked domain to avoid out-of-bounds
	    access.
	  - Return early if dev_pasid is missing to prevent NULL dereference or
	    UAF.

	- Core:
	  - Fix bugs and corner cases in the pci_dev_reset_iommu_prepare/done()
	    code. This are some bigger changes including some re-work,
	    hopefully okay for -rc.
	  - Fix various issues found by AI in iommupt code.

	- MAINTAINERS email address update for RISCV IOMMU.

----------------------------------------------------------------
Eder Zulian (1):
      iommu/amd: Remove latent out-of-bounds access in IOMMU debugfs

Jason Gunthorpe (5):
      iommu: Fix loss of errno on map failure for classic ops
      iommu: Fix up map/unmap debugging for iommupt domains
      iommu: Handle unmap error when iommu_debug is enabled
      iommupt: Check for missing PAGE_SIZE in the pgsize_bitmap
      iommupt: Fix the end_index calculation in __map_range_leaf()

Jose Fernandez (Anthropic) (1):
      iommu/amd: Bounds-check devid in __rlookup_amd_iommu()

Naval Alcalá (1):
      iommu/vt-d: Disable DMAR for Intel Q35 IGFX

Nicolin Chen (8):
      iommu: Fix NULL group->domain dereference in pci_dev_reset_iommu_done()
      iommu: Fix kdocs of pci_dev_reset_iommu_done()
      iommu: Replace per-group resetting_domain with per-gdev blocked flag
      iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
      iommu: Fix nested pci_dev_reset_iommu_prepare/done()
      iommu: Fix ATS invalidation timeouts during __iommu_remove_group_pasid()
      iommu: Fix WARN_ON in __iommu_group_set_domain_nofail() due to reset
      iommu: Warn on premature unblock during DMA aliased sibling reset

Tomasz Jeznach (1):
      MAINTAINERS: update Tomasz Jeznach's email address

Zhenzhong Duan (2):
      iommu/vt-d: Fix oops due to out of scope access
      iommu/vt-d: Avoid NULL pointer dereference or refcount corruption

 .mailmap                            |   1 +
 MAINTAINERS                         |   2 +-
 drivers/iommu/amd/debugfs.c         |   9 +-
 drivers/iommu/amd/iommu.c           |   8 +-
 drivers/iommu/generic_pt/iommu_pt.h |  24 +--
 drivers/iommu/intel/iommu.c         |  16 +-
 drivers/iommu/iommu.c               | 305 +++++++++++++++++++++++++-----------
 7 files changed, 255 insertions(+), 110 deletions(-)

Please pull.

Thanks,

	Joerg
