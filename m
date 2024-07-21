Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0C1FBA;
	Sun, 21 Jul 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548158; cv=none; b=k97FFw/XtprTPzJUwG5yLCywnCXW2oyO/xusqcMKM7Ag46hpjOt7pNNR2LP9XlMGqsoeAQtc/4m28/C7KRkGGkvbSO7bE5y4aUh7iWei/ctnUO4BOpGmgseinXrzSOzn/t9mmbnrg1jplD0ZNXAucewqPgLvIArBwPNF1oOuq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548158; c=relaxed/simple;
	bh=Um/A0eAivXBRLHLeq9NT1+jKAkq0WcisRsDCu/nYAY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfJEE38gwnDqLG665kKswNw60RY0OQqICe/cuxEXWR8/wl47L0gin8XPgTCtCM259IKWfgP/9kGgWSuFiUy0v9IzLKGcjnyYge3vWBeZoKCj72t7yscjn3FMEVL9dJE+Ic55H3Zzr8LqRIyfq28evEg7gggnwoi9qokacqzYnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYeJyCpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYeJyCpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D08C116B1;
	Sun, 21 Jul 2024 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721548157;
	bh=Um/A0eAivXBRLHLeq9NT1+jKAkq0WcisRsDCu/nYAY8=;
	h=From:To:Cc:Subject:Date:From;
	b=GYeJyCpazvYSydCJFTLxor4uMzGp3Lfk2DZJlBK3swdo6azutx8FdopcvLaNOXDAA
	 x989grVY5kTH10SxUXp/ZAG5L/dz9bGecnhJj8IFO6HBVAH5NAsa9idv1aOD33jtmQ
	 hdbyLqkEu9B/fATLyYxwfIGNsYIM7mrAJ3wrKdjO2yyI9u+yVMJawJHGM4VVaCw2gD
	 6wJ/N8R22jVxamxroFhlrvEgrrHjMnQjOxXKaBo1gDWm8cdMpnXO9IBF1Q5Ibk2avk
	 bAKyNsBGniKEjZq98+D7JRPkwzgmfD+T6zREf8q0vtmFOSNklNRKmTarguUMNGZEc+
	 CdQkbD8uxpAWQ==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/2] DMA IOMMU static calls
Date: Sun, 21 Jul 2024 10:49:09 +0300
Message-ID: <cover.1721547902.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v3:
 * Changed coding style as Christoph asked
 * Moved debug WARN_ON check to dma_set_mask.
 * Slightly updated commit messages
 * Added Greg to the CC list
v2: https://lore.kernel.org/all/cover.1721219730.git.leon@kernel.org/
 * Ditched dma_ops flag in favor of field in struct device (suggested by
   Christoph)
 * Removed CONFIG_DMA_OPS select from dma-iommu.c Kconfig
 * Removed flags field which exist only in default IOMMU
v1: https://lore.kernel.org/all/cover.1721041611.git.leon@kernel.org/
 * Dropped extra layer and called directly to iommu_dma_* functions
 * Added unmap_page and unmap_sg to dummy ops
 * Converted all dma-mapping calls to use iommu directly
 * Updated commit messages
v0:
https://lore.kernel.org/all/98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org/

Leon Romanovsky (2):
  dma: call unconditionally to unmap_page and unmap_sg callbacks
  dma: add IOMMU static calls with clear default ops

 MAINTAINERS                 |   1 +
 drivers/iommu/Kconfig       |   1 -
 drivers/iommu/dma-iommu.c   | 127 +++++++++++----------------
 include/linux/device.h      |   5 ++
 include/linux/dma-map-ops.h |  33 ++++---
 include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
 kernel/dma/dummy.c          |  23 +++++
 kernel/dma/mapping.c        |  84 +++++++++++++++---
 8 files changed, 338 insertions(+), 105 deletions(-)
 create mode 100644 include/linux/iommu-dma.h

-- 
2.45.2

