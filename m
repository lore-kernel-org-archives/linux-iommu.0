Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151D2DEB94;
	Tue, 29 Apr 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970633; cv=none; b=NQ3gQ+Z12pQjkFU0HCJFacKByaELhSSqZM+4Cv0KKyQubyttRo4mdj+ayehVAcQX+bJpB9vIezZReQCY1Kv0to1+sPF3mgFOS9G/DeUUvWA4vfS6Ez0YRoKoFldck2UkqDujM44hrFiLod2yAwu56PO5SwR2VwhRnmCi9I3oArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970633; c=relaxed/simple;
	bh=EL8hjIGHHXl0nbVoLq1Lqb+5Q28JoDgbGNXpbCgl5Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BicWmvD1mm3J7wU5WzB7rngVvzHNRZMTb3gsvCOdopqPnHUaMantMVQ5zMrTh7vWAlonMuN6HJfz5b1bUA9lermS8EH7Au/9lBUCn0K5GzGb0MCLkqDlUOgom+tqz8O8DV108Qzn0qgStMIDRC6GVq9XB14oJXAfmYaLUy0R3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abs+L7W7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abs+L7W7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F34C4CEE3;
	Tue, 29 Apr 2025 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970632;
	bh=EL8hjIGHHXl0nbVoLq1Lqb+5Q28JoDgbGNXpbCgl5Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Abs+L7W7chA+qOt3PmHwAdIw2695ctD0ATo/yERiJb6PWIwXwZ+XNB110fwI1UE7k
	 CjT9fquuiwu2TbQk35hEDCQkZmWhuNST9YHMbhqhXKMbElraAbmiC4K0iOG+32VzeZ
	 GIHi+jaMo/W9KHv9mbY5k+cFXL5tCg6t6zJ4tqZ83SZDgOW2CSKNbjyAoH/egt+2io
	 Q8uEqsXm4QArYclplNp6Jef/GjxMIFFEArLyJQT2xyD01NqqoieNrkGTNdhBwMpzym
	 PFqMz/NrwDnnXPugO2PY+ehaBGaJut5JtY2FJ4Mq7ybTPlqIknciqS6Tynqb18AVGC
	 NqcNgGyQw1QSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Christoph Hellwig <hch@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 12/39] dma/mapping.c: dev_dbg support for dma_addressing_limited
Date: Tue, 29 Apr 2025 19:49:39 -0400
Message-Id: <20250429235006.536648-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Balbir Singh <balbirs@nvidia.com>

[ Upstream commit 2042c352e21d19eaf5f9e22fb6afce72293ef28c ]

In the debug and resolution of an issue involving forced use of bounce
buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
private pages in add_pages(), to not increase max_pfn and trigger
dma_addressing_limited() bounce buffers"). It would have been easier
to debug the issue if dma_addressing_limited() had debug information
about the device not being able to address all of memory and thus forcing
all accesses through a bounce buffer. Please see[2]

Implement dev_dbg to debug the potential use of bounce buffers
when we hit the condition. When swiotlb is used,
dma_addressing_limited() is used to determine the size of maximum dma
buffer size in dma_direct_max_mapping_size(). The debug prints could be
triggered in that check as well (when enabled).

Link: https://lore.kernel.org/lkml/20250401000752.249348-1-balbirs@nvidia.com/ [1]
Link: https://lore.kernel.org/lkml/20250310112206.4168-1-spasswolf@web.de/ [2]

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Christoph Hellwig <hch@infradead.org>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20250414113752.3298276-1-balbirs@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index cda127027e48a..67da08fa67237 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -918,7 +918,7 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  * the system, else %false.  Lack of addressing bits is the prime reason for
  * bounce buffering, but might not be the only one.
  */
-bool dma_addressing_limited(struct device *dev)
+static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -930,6 +930,15 @@ bool dma_addressing_limited(struct device *dev)
 		return false;
 	return !dma_direct_all_ram_mapped(dev);
 }
+
+bool dma_addressing_limited(struct device *dev)
+{
+	if (!__dma_addressing_limited(dev))
+		return false;
+
+	dev_dbg(dev, "device is DMA addressing limited\n");
+	return true;
+}
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
 size_t dma_max_mapping_size(struct device *dev)
-- 
2.39.5

