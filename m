Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12C1F3BA5
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381883; cv=none; b=ZpXFaNv4D1yu7tTawGT7riTqTyYWTk97EttPURBWkpTCimr8rQZuRftH0xglsCcbCkrQCj5DGGbmxb512lfqHI47U/VYOe6bILaZFMTCj5uImWNzKWBlOhhT8N4J3Cra1sGxZ+4M+gJpIC9kPXX/vmk0ltSVTCtis71tHBl/l7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381883; c=relaxed/simple;
	bh=cR0MT7SIQsZS0BIRcyRHwHriDkdMJJMU+eMrzLmaREU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SJY3BsXtJTmNMwqAfaj9ZMuHAcnKOlsb4m6AAWDzSf2O6bm5ArUKbgR3qR15hCr0eL4yZuJ7p9GUq2SBwROU2vuJMs1TWVJNO34XxGV9ok4MfLMrfkHswY0dCM4P8/QCiYQxDf9zgZxdAkzwD1rhOYvJ1O0onxaBzn/J+v9HhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Eqfq7KUF; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Eqfq7KUF"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 123A347F1E;
	Fri, 11 Apr 2025 16:31:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744381880;
	bh=cR0MT7SIQsZS0BIRcyRHwHriDkdMJJMU+eMrzLmaREU=;
	h=Date:From:To:Cc:Subject:From;
	b=Eqfq7KUF1hdvzAztdS6DA1TZugK0wED97mI9mkRTLOmxyBmaOIPZ1TgunhBlufqvm
	 pu9YSTdeA3LQMhkNVCIAjP9XETen2jA0Im2KV53GsDVS8tpj9bnxdcDWrjani9Y0qW
	 KrlO0xD2AhoRoohidRsoRUKY8GAv62DOXeGDTf2qHEt0YWlZxoWO/8Jdi22kuvQ1+v
	 rRWsVUdTks5lLoMfijHuJaIShaejjFoEgXjReWdxO+/NfMA10EjP696kSK2MiyogXw
	 GPU4OpFx1ELrszlsWiQxSQQuucmL2J2T4zR4pXLOrH6+IyNnptuYJwdWA95JHYxPkk
	 Xj03A0G/j61pA==
Date: Fri, 11 Apr 2025 16:31:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.15-rc1
Message-ID: <Z_kntkZxksOfGwpt@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc1

for you to fetch changes up to 767e22001dfce64cc03b7def1562338591ab6031:

  iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent() (2025-04-11 12:44:27 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.15-rc1

Including:

	- Fix two crashes, one in core code and a NULL-ptr dereference in the
	  Mediatek IOMMU driver.

	- Dma_ops cleanup fix for core code.

	- Two fixes for Intel VT-d driver:
	  - Fix posted MSI issue when users change cpu affinity.
	  - Remove invalid set_dma_ops() call in the iommu driver.

	- Warning fix for Tegra IOMMU driver.

	- Suspend/Resume fix for Exynos IOMMU driver.

	- Probe failure fix for Renesas IOMMU driver

	- Cosmetic fix

----------------------------------------------------------------
Fedor Pchelkin (1):
      iommu: Fix crash in report_iommu_fault()

Louis-Alexis Eyraud (1):
      iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group

Marek Szyprowski (1):
      iommu/exynos: Fix suspend/resume with IDENTITY domain

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()

Pei Xiao (1):
      iommu: remove unneeded semicolon

Petr Tesarik (1):
      iommu/vt-d: Remove an unnecessary call set_dma_ops()

Robin Murphy (2):
      iommu: Clear iommu-dma ops on cleanup
      iommu/ipmmu-vmsa: Register in a sensible order

Sean Christopherson (1):
      iommu/vt-d: Wire up irq_ack() to irq_move_irq() for posted MSIs

 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 32 ++++----------------------
 drivers/iommu/dma-iommu.c                      |  4 ++--
 drivers/iommu/exynos-iommu.c                   |  4 ++--
 drivers/iommu/intel/iommu.c                    |  1 -
 drivers/iommu/intel/irq_remapping.c            | 29 ++++++++++++-----------
 drivers/iommu/iommu.c                          |  6 ++++-
 drivers/iommu/ipmmu-vmsa.c                     | 27 ++++++++--------------
 drivers/iommu/mtk_iommu.c                      | 26 ++++++++++-----------
 8 files changed, 52 insertions(+), 77 deletions(-)

Please pull.

Thanks,

	Joerg
