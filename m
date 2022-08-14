Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46861C01
	for <iommu@lists.linux.dev>; Sun, 14 Aug 2022 16:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99612C433B5;
	Sun, 14 Aug 2022 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660493987;
	bh=YhTyq8ztHRIzhCyqOa/NH29eSjBtsSbe0iDoCiRMWzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WROZvLWPbEYgPuUVIbZU1xgzC5SxpZ4un809HN7d5t+RZ7DYaNwdeL/c28OeTN1cN
	 BppG0NIuMwiDb5QPAJwrerogDJ6x1EghhshI8+fKe3Z64Ug6U58JMIVpCLXzjLPsxr
	 b0xSgV/jEL6/N+Yn6XeLfU0ou66kYU7uSegxjQN0XZ5wMft+KjHfJ6EfniCvAk0n7R
	 nvE+y4IgLAeA9NPCvAEff2AcFg8BpGkRa+/ZIneEJv+YTWU5dJTKSeii0+44s4hyZw
	 g5TdzOdsHRh14EpwnwQ/CJ4s7uqDOFQuQs6anJPiHTPYkjSdX+QULrssJ6EWNiSHLM
	 fPJnVKdiHo4YA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	hch@infradead.org,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.19 02/48] swiotlb: panic if nslabs is too small
Date: Sun, 14 Aug 2022 12:18:55 -0400
Message-Id: <20220814161943.2394452-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814161943.2394452-1-sashal@kernel.org>
References: <20220814161943.2394452-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit 0bf28fc40d89b1a3e00d1b79473bad4e9ca20ad1 ]

Panic on purpose if nslabs is too small, in order to sync with the remap
retry logic.

In addition, print the number of bytes for tlb alloc failure.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d38360..03af7c3bee71 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -242,6 +242,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
+	if (nslabs < IO_TLB_MIN_SLABS)
+		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
+
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
@@ -254,7 +257,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb) {
-		pr_warn("%s: failed to allocate tlb structure\n", __func__);
+		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
+			__func__, bytes);
 		return;
 	}
 
-- 
2.35.1

