Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A832DE6E3
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397590; cv=none; b=d4ZZy3cr27/fKFH0XQDcbO/ehZmSkHGFr+Nn0BDivkZ7J84aq8X5KvzfZxlrZbHTe+Q66IV0OM5kaUe3pkYhkg4zwMEOuPGyrAGO2bRmtj2eQZNnp5m+8UNZA/oWJ/yHcQDl8UtFQs/U2dVsq3/l27YUqzV5r7yGpFyntttY3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397590; c=relaxed/simple;
	bh=U3/ZdRLyIxtFch2MKYSLy1jlpj6OJwWg3XVYW9w+UG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XqBjLJYjHOmN9QklOr//MgN66nEtI7xycVtBCnCEb6RGNp5h4bp8faFH675cI7mhpWtS7xGj2jPsgblnlMYDr76iEP6ZfMcUNIGw9ooiFWADerLxdGyhvNFNj7uSQwYaVyzaWdvWcUqhTzbMutFlcjMGe53jSeQU7BtBDTZ6efk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=EEeYwj2K; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="EEeYwj2K"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2BA4B56349;
	Thu,  2 Oct 2025 11:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1759397580;
	bh=U3/ZdRLyIxtFch2MKYSLy1jlpj6OJwWg3XVYW9w+UG0=;
	h=Date:From:To:Cc:Subject:From;
	b=EEeYwj2Km3D+DHklnprutEIQlq6zoX0UJoa38UAL95uljK4VjIJgSuos9Z1KBv9ar
	 I6kRXeZyjyyUF50xwHMYokCspSA7iAa0JYDy7APN3ZBbJFNPdqx8bMk9YbPe3QecAR
	 2iyFQvTkgup1OxQqbF3wu0Txx+ia8ZvpNBTkYhuF8gjDHSiRWiBR2jyqxwkT4FuPZL
	 NO4ixkdsXNqkCHe0Uykn1IbUk8ilZrNHRon1MZivIns8BYkAS35S6js4u12Ti79BzE
	 Ocatu58teQ8m7MgfIcOBe6+4QeUZd45CWO491vii1ghi1OyUlcWUojf53rYsjQF1Km
	 EPlMAejfqworg==
Date: Thu, 2 Oct 2025 11:32:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.18
Message-ID: <wkxilefpezz4bnwm33rcffdvqiufeengtujjpkr65wrdtluj2u@co4fqyct6ot5>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.18

for you to fetch changes up to 5f4b8c03f41782f37d278946296d9443a7194153:

  Merge branches 'apple/dart', 'ti/omap', 'riscv', 'intel/vt-d' and 'amd/amd-vi' into next (2025-09-26 10:03:33 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.18:

Including:

	- Inte VT-d:
	 - IOMMU driver updated to the latest VT-d specification.
	 - Don't enable PRS if PDS isn't supported.
	 - Replace snprintf with scnprintf.
	 - Fix legacy mode page table dump through debugfs.
	 - Miscellaneous cleanups.

	- AMD-Vi:
	  - Support kdump boot when SNP is enabled.

	- Apple-DART:
	  - 4-level page-table support.

	- RISC-V IOMMU:
	  - ACPI support.

	- Small number of miscellaneous cleanups and fixes.

----------------------------------------------------------------
Ashish Kalra (4):
      iommu/amd: Add support to remap/unmap IOMMU buffers for kdump
      iommu/amd: Reuse device table for kdump
      crypto: ccp: Skip SEV and SNP INIT for kdump boot
      iommu/amd: Skip enabling command/event buffers for kdump

Hector Martin (4):
      iommu/apple-dart: Make the hw register fields u32s
      iommu/io-pgtable-dart: Add 4-level page table support
      iommu/apple-dart: Add 4-level page table support
      iommu/apple-dart: Clear stream error indicator bits for T8110 DARTs

Janne Grunau (1):
      iommu/io-pgtable-dart: Fix off by one error in table index check

Joerg Roedel (1):
      Merge branches 'apple/dart', 'ti/omap', 'riscv', 'intel/vt-d' and 'amd/amd-vi' into next

Lu Baolu (5):
      iommu/vt-d: Remove LPIG from page group response descriptor
      iommu/vt-d: PRS isn't usable if PDS isn't supported
      iommu/vt-d: Removal of Advanced Fault Logging
      iommu/vt-d: debugfs: Avoid dumping context command register
      iommu/vt-d: Disallow dirty tracking if incoherent page walk

Qianfeng Rong (1):
      iommu/omap: Use int type to store negative error codes

Seyediman Seyedarab (1):
      iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()

Sunil V L (3):
      ACPI: RISC-V: Add support for RIMT
      ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
      iommu/riscv: Add ACPI support

Vineeth Pillai (Google) (1):
      iommu/vt-d: debugfs: Fix legacy mode page table dump logic

Xichao Zhao (1):
      iommu/amd: use str_plural() to simplify the code

Yury Norov (NVIDIA) (1):
      iommu/vt-d: Drop unused cap_super_offset()

 MAINTAINERS                          |   1 +
 arch/riscv/Kconfig                   |   1 +
 drivers/acpi/Kconfig                 |   4 +
 drivers/acpi/riscv/Kconfig           |   7 +
 drivers/acpi/riscv/Makefile          |   1 +
 drivers/acpi/riscv/init.c            |   2 +
 drivers/acpi/riscv/init.h            |   1 +
 drivers/acpi/riscv/rimt.c            | 520 +++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   4 +
 drivers/crypto/ccp/sev-dev.c         |  10 +
 drivers/iommu/amd/amd_iommu_types.h  |   5 +
 drivers/iommu/amd/init.c             | 284 +++++++++++++------
 drivers/iommu/amd/iommu.c            |   5 +-
 drivers/iommu/apple-dart.c           |  55 ++--
 drivers/iommu/intel/debugfs.c        |  29 +-
 drivers/iommu/intel/iommu.c          |   2 +-
 drivers/iommu/intel/iommu.h          |   7 +-
 drivers/iommu/intel/perf.c           |  10 +-
 drivers/iommu/intel/perf.h           |   5 +-
 drivers/iommu/intel/prq.c            |   7 +-
 drivers/iommu/io-pgtable-dart.c      | 139 ++++++----
 drivers/iommu/omap-iommu.c           |   2 +-
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/linux/acpi_rimt.h            |  28 ++
 include/linux/io-pgtable.h           |   1 +
 26 files changed, 959 insertions(+), 198 deletions(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

Please pull.

Thanks,

	Joerg
