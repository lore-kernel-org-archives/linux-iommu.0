Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700103F7877
	for <iommu@lists.linux.dev>; Sat, 12 Sep 2026 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789201986; cv=none; b=YWrV24ImCi2jgHT87UD8dJ3Eeh568kUEToY2ieQqHoBTGrEB56HPyqePe3rBlkB7KFM8ug3a44QEtWiCq75zb39tiZGNtYAN+tWWhFu/aJn452+GEZot1o9XgV+FbR7H2O1RyKJV0vQCh+vzg8ZAVaW7rpMfoOmJgckcGrgScUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789201986; c=relaxed/simple;
	bh=4DJ6CupgZbGFa6TAJep5n9Vx0F32273uqkSSgt0aM6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O8Z8H4WYNETr12Xy6ksGKiXhp61IFgpPsvh0iB2DUO/nqfT4x2J6LsaVQsMEyounwMgv4MiREIKHJzBJ2DE1vx7KfTjomsq2cQoxcRbPo0HaXWL0yFU6LRNNUkN0IkX6Y+R1Fz+LIb5CSk5bNsLhm16i5ouIL8QKmN6HN+10FP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1383.dip0.t-ipconnect.de [79.254.19.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 024142062B5;
	Sat, 12 Sep 2026 10:32:56 +0200 (CEST)
Date: Sat, 12 Sep 2026 10:32:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.3-rc2
Message-ID: <aqUOFhjG7gjWfpAf@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.3-rc2

for you to fetch changes up to b63c3c26726576e2a87baeee80bc202a5a43c9e5:

  iommu/amd: Remove unused macro (2026-09-11 17:27:22 +0200)

----------------------------------------------------------------
IOMMU fixes for Linux v7.3-rc3:

- RISC-V IOMMU:
  - Serialize command queue publication to prevent concurrent producers
    from exposing incomplete or out-of-order commands to hardware.
  - Wait for queue space outside the command queue lock.
  - Avoid waiting for IOFENCE completion when command enqueue failed.

- AMD IOMMU:
  - Prevent GA log buffers from being reallocated and leaked during
    resume, where allocation also occurs in an unsuitable syscore
    callback context.
  - Fix a regression on older systems whose firmware advertises
    incorrect IOMMU features.
  - Preserve allocation errors when assigning host domain IDs to nested
    domains.

- s390 IOMMU:
  - Prevent a NULL dereference when translating an unmapped IOVA with
    five-level ZPCI translation tables.

- Miscellaneous:
  - Remove a stale MAINTAINERS entry and clean up unused or redundant
    AMD IOMMU declarations, macros, and checks.

----------------------------------------------------------------
Daasaradhi Mannava (1):
      MAINTAINERS: Drop the nonexistent vsi-iommu.h file entry

Fangyu Yu (3):
      iommu/riscv: Add command queue lock
      iommu/riscv: Serialize command queue publishing
      iommu/riscv: Avoid waiting on failed command enqueue

Hemanth Selam (1):
      iommu/amd: Fix ineffective error check in nested domain allocation

Karl Mehltretter (1):
      iommu/amd: Do not reallocate GA log buffers on resume

Niklas Schnelle (1):
      iommu/s390: Fix NULL dereference in iova_to_phys() with ZPCI_TABLE_TYPE_RFX

Vasant Hegde (5):
      iommu/amd: Fix premature break in init_iommu_one() again
      iommu/amd: Make iommu_sva_set_dev_pasid as static
      iommu/amd: Remove redundant check in irq_remapping_select()
      iommu/amd: Remove redundant checks from interrupt handler path
      iommu/amd: Remove unused macro

 MAINTAINERS                         |   1 -
 drivers/iommu/amd/amd_iommu.h       |   3 -
 drivers/iommu/amd/amd_iommu_types.h |  16 -----
 drivers/iommu/amd/init.c            |  18 ++++--
 drivers/iommu/amd/iommu.c           |   6 --
 drivers/iommu/amd/nested.c          |   7 ++-
 drivers/iommu/amd/pasid.c           |   6 +-
 drivers/iommu/amd/ppr.c             |   3 -
 drivers/iommu/riscv/iommu.c         | 117 +++++++++++++++++++++---------------
 drivers/iommu/riscv/iommu.h         |   2 +
 drivers/iommu/s390-iommu.c          |   2 +
 11 files changed, 93 insertions(+), 88 deletions(-)

Please pull.

Thanks,

	Joerg
