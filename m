Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397617B425;
	Thu, 17 Jul 2025 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734839; cv=none; b=sOdnO6D3Cn7st3wP2wDPVguBt2sVZON6lfRUnkCRsTE211Vy4PVgQQZO8Ctb6DwPSUF3LhF5tfi0SNJ+TBrinHDcIkppWCaEavmPW9FaQ0R7gekl6R32Vsvw/bHI2A7ebQzhS9SR6WRcdgCjry1RaNB3oytRX92e6g71ubaMFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734839; c=relaxed/simple;
	bh=rv/yJSxnGvbE7b6aXpl/DVc/+KZ8gY6e2sd6AiL0MM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKEgUoyxR35BzEsKDOz0YaWEjElX6RKQpRROs4SqrEfv97F7U7nD6780M8ADC12Z1d6/1JG1WH4UwFsX2nGvZEMXtcIhft48XnkhuMwcojvPqA8yaC6oWbVlDOwoqKozJN3ULFtDMq3axkBbnC4IT4KtOy1hACMeffprgBbwAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2TYCJDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2TYCJDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8AC4CEE3;
	Thu, 17 Jul 2025 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752734837;
	bh=rv/yJSxnGvbE7b6aXpl/DVc/+KZ8gY6e2sd6AiL0MM4=;
	h=From:To:Cc:Subject:Date:From;
	b=A2TYCJDrK3kn277cclTEqgRR+bGftZSHBI3YjFq65FYSDYQ/1pjK6CxIq1g2kLEn/
	 oPxeInZbwQq/VkbGe7qhKHS9cFysvXf6PmrGmWakOuI49nbYmT36XovNHe48WU3qgd
	 5agEquODytNtMpO5eMP8uljg2sZ/JcgjnYBmSRFmDbQj7DxxFhe3R2e6KgICci4i9H
	 PbXO8SdPc1lwnDmHWHBQBhnTPr/iv12SA+0QFs0h/E4EA5ccduqlYIbifc7ViWzYX+
	 anX35xw0mJr4xzndmhBfE2yklNlFGA5FMXC/LX6AYzvTc+E38lelkUM2ngRW8EtFYw
	 kPb0zgWrP9OeQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Preparation to .map_page and .unmap_page removal
Date: Thu, 17 Jul 2025 09:47:08 +0300
Message-ID: <cover.1752734252.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

