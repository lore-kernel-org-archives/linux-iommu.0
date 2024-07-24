Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0915CD62;
	Wed, 24 Jul 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844315; cv=none; b=d73nmoLIAteiwwcF4+xRkW7Y8Subd0x94fiJJ3KaXg1XBoZibV+UkofbZhGv9eg1+zMfyKfS4m8843U3QuOEKIE3jhhRj2yAj9lGXmha8EAIcz76QMdg6UiCaAKIXQHBUTSFEhsoy1zh1UeVDx1/qNEQ1f82y21zVhazslixw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844315; c=relaxed/simple;
	bh=2R+HgnqbyVWT0FppJlvgkf85G43/EWzvledLcz5Q410=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9U9lx89Bdw7xXQmeDeZeBHgkz0Z3xE+R21YDXF5fxvscLsdzj8O16Fec7r2erDSsb+N5QxOJT+amtFCMwVWPfnBLFhD+FSjgrue44LjP4Qqz7Nn2YRiWEOKGarhvQXX2CBd/O8/RVpPAUTFtBPxesjWhsGXmM/eXhEbygcFrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI+afRb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI+afRb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176BBC32781;
	Wed, 24 Jul 2024 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721844315;
	bh=2R+HgnqbyVWT0FppJlvgkf85G43/EWzvledLcz5Q410=;
	h=From:To:Cc:Subject:Date:From;
	b=GI+afRb2SOArOWiu5SYcNYtVU037R/Dfsz9MfHdiNUCIeQIJUvJOghT/92LUAA2HR
	 6hl/itGE3ZrnhdysfXzfRSoAPj8K0susn7VI5A3Xhd8iTjtQKvCB7pSJ16aGth1fMp
	 YEOdvjMvz8URkHus7SlqJrUI1Y63584xotP3hZJa1XaSfiku+V8WOghlGlkFhIGFqP
	 ytjUSTL0smCfHMQ7flqlTnwB0jbnVzrJneJcPuOSd7fW2lSB0WpR0UQuclYAefTje3
	 5mpWwBOMlqmF0KWqT7q92ZZTTPEkjaR/4rFX0un5KEJp2p6oicLel0V0yE/NVm/QTA
	 o/6dBSmikN0DQ==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/2] DMA IOMMU static calls
Date: Wed, 24 Jul 2024 21:04:47 +0300
Message-ID: <cover.1721818168.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v4:
 * Added extra hidden config option to build ops_helper.c without CONFIG_DMA_OPS
 * Tried to keep dma-iommu.c function declaration style.
 * Removed "select DMA_OPS" from intel iommu kconfig. It is not needed.
v3: https://lore.kernel.org/all/cover.1721547902.git.leon@kernel.org/
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
v0: https://lore.kernel.org/all/98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org/

Leon Romanovsky (2):
  dma: call unconditionally to unmap_page and unmap_sg callbacks
  dma: add IOMMU static calls with clear default ops

 MAINTAINERS                 |   1 +
 drivers/iommu/Kconfig       |   2 +-
 drivers/iommu/dma-iommu.c   | 121 ++++++++++----------------
 drivers/iommu/intel/Kconfig |   1 -
 include/linux/device.h      |   5 ++
 include/linux/dma-map-ops.h |  39 +++++----
 include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
 kernel/dma/Kconfig          |   6 ++
 kernel/dma/Makefile         |   2 +-
 kernel/dma/dummy.c          |  21 +++++
 kernel/dma/mapping.c        |  90 ++++++++++++++++---
 11 files changed, 348 insertions(+), 109 deletions(-)
 create mode 100644 include/linux/iommu-dma.h

-- 
2.45.2

