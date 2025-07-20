Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD612B93
	for <iommu@lists.linux.dev>; Sun, 20 Jul 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004165; cv=none; b=lxQmzdtW5czEuSHxdQsAo1pON9Z6txVQwnO7teyWSQvTdpGlZbntAkSrveciVuGBQzIypthTEcamNcwddMgZ4YlbG4DXzdpN2Af79CGmOvvUUlClZEz73ZMToE6uz9JAKtzApw/LZ8f+/w7r+KcT10BE1SX4yjj7K6HzUPNfVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004165; c=relaxed/simple;
	bh=bEavD6YkBh0uIIh+7PcVZ8SHJ/cJuXPNFPo4/4S2Im4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtmrqI379C1alE1eLRnQqYMVUI8bB5lQ5Sv9vqMKdgcJs9ddFU8CQ7ZK2UUOOycZQIzNSTLgwu/ZttrL40PrmjWArRe8OZFhb0G477csSuchWzC3CA1E2v/P7IgmrBBVG/I1kyf40+OzrNEDbjjLL4Z7578yhh4Rx7gP7LFAcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INfTi4Rr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INfTi4Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4069EC4CEF6;
	Sun, 20 Jul 2025 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753004165;
	bh=bEavD6YkBh0uIIh+7PcVZ8SHJ/cJuXPNFPo4/4S2Im4=;
	h=From:To:Cc:Subject:Date:From;
	b=INfTi4Rr1lafNDp71EDcTrx2WysCZxZZb6C7U2baHUIpAxE+xNuES0g2tJcHRvXco
	 uhmCTIxBfgJFcmkbBHtDsKAZKJt4iZbVb4URipKdgOh9ujQBcWOLk5L07FvBU74ObH
	 X42i6fvIXQ7JrUhFOosDXmu9cn1YCEDZZObyo/kd+z2xVXhBBZg45a62H5vzF7xgEE
	 aFWng/th5AfsH4P2hOzUboOTo1ZKaqgF1wFX/63C1wUe6cHwD1sHgEHYUGHwvIezKD
	 Qjb0rFMPf7NU9nLA6O7TW8ro1LXKQYvuYy+AOvUvlhlX/qarvooqUloJWohrH3JcM4
	 bl5hv8UrwJL1g==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev
Subject: [PATCH v1 0/2] Preparation to .map_page and .unmap_page removal
Date: Sun, 20 Jul 2025 12:35:25 +0300
Message-ID: <cover.1753003879.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1:
 * Changed "else if" instead of "if".
v0: https://lore.kernel.org/all/cover.1752734252.git.leon@kernel.org
---------------------------------------------------------------------

This is followup to "dma-mapping: migrate to physical address-based API"
series https://lore.kernel.org/all/cover.1750854543.git.leon@kernel.org/

These preparation changes are limited to DMA subsystem to avoid possible
complications with submission to multiple trees.

Thanks

Leon Romanovsky (2):
  dma-mapping: prepare dma_map_ops to conversion to physical address
  dma-mapping: convert dummy ops to physical address mapping

 include/linux/dma-map-ops.h |  6 ++++++
 kernel/dma/dummy.c          | 13 ++++++-------
 kernel/dma/mapping.c        | 24 ++++++++++++++++++++----
 kernel/dma/ops_helpers.c    | 14 +++++++++++---
 4 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.50.1

