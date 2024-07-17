Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3C14B07B;
	Wed, 17 Jul 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219838; cv=none; b=JijV/eFrSdvniKVDooGrAY5x3RS4evZDop881ZuJ7hFZAeyrL307QlAIDOt3txwhozM6Didak7y8LaPc/LaCEAzun3SRqQ4+h6Bd6LmTuomLPrU+a2VMPX2ZzGZydsIF+5US9PAuWQpPFeBicYyDtd8hA3T4QB4XSyPmhy6o8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219838; c=relaxed/simple;
	bh=mFG8s4kD0eTiYLgNABfx3y573q3jH45lh4+DFomHsAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJXZbiVT/mp2Ibkz/qbZ6bvjqdoTfOysxggZNdT4Cvl0GRLFPi8NTOes1ea809Ug2jN3lEvej6AHcJz06ElvEjM/WDGu5TplnPdA5+ACENiMpzmPjA5Pd15GqDmHh6n4tb6S/eQtl/GWWYqM6c5+VhYgbpnhRY7aiMZS2RdOZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQC1VdEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQC1VdEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E798AC4AF0B;
	Wed, 17 Jul 2024 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721219838;
	bh=mFG8s4kD0eTiYLgNABfx3y573q3jH45lh4+DFomHsAI=;
	h=From:To:Cc:Subject:Date:From;
	b=FQC1VdEcgyca6sGcZjfbXGQip/0bsqa3qNu5OGRrLh+a63DdeK5DmgQudDxAYprWc
	 yJHdXBCvrKdIy2AZLIFVEKAP4AeOO+ziOB1YJ4Q5mvvmvp9IfW+AvTwWzKS/nJsymy
	 pYCC9otkQNZ8Fz9Q51rFrtUxAYwvvw407YDkkTSEXFxsJIPEhMMdqzIe6c6TNSupo9
	 PFWp0PrPMNhk/Q0ezqRfjwzFzrUrHU8RzSBTheD590dUkQa0URYOZNDN9RtM9GceZH
	 w1vUsYIloLh1d8gB4HgoeoKPCOVD9lauCl3V9WRKn6aGxec30Py6ZpYY5vAtf1JyS+
	 lBoZpwdKfFGBg==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 0/2] DMA IOMMU static calls
Date: Wed, 17 Jul 2024 15:37:09 +0300
Message-ID: <cover.1721219730.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2:
 * Ditched dma_ops flag in favor of field in struct device (suggested by Christoph)
 * Removed CONFIG_DMA_OPS select from dma-iommu.c Kconfig
 * Removed flags field which exist only in default IOMMU
v1: https://lore.kernel.org/all/cover.1721041611.git.leon@kernel.org/
 * Dropped extra layer and called directly to iommu_dma_* functions
 * Added unmap_page and unmap_sg to dummy ops
 * Converted all dma-mapping calls to use iommu directly
 * Updated commit messages
v0: https://lore.kernel.org/all/98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org/

Leon Romanovsky (2):
  dma: call unconditionally to unmap_page and unmap_sg callbacks
  dma: add IOMMU static calls with clear default ops

 MAINTAINERS                 |   1 +
 drivers/iommu/Kconfig       |   1 -
 drivers/iommu/dma-iommu.c   | 117 ++++++++++---------------
 include/linux/device.h      |   3 +
 include/linux/dma-map-ops.h |  13 ---
 include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
 kernel/dma/dummy.c          |  21 +++++
 kernel/dma/mapping.c        |  88 ++++++++++++++++---
 8 files changed, 315 insertions(+), 98 deletions(-)
 create mode 100644 include/linux/iommu-dma.h

-- 
2.45.2

