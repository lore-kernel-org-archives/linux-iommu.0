Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABB2D9DB9;
	Tue, 29 Apr 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970828; cv=none; b=A7tNoVrJ+NPApQBgMyCNsApg8eQnXuOtuYFmJl/dzOTikV5EYkW8cgKs3n6XNgfXXKkfn6KU4vrlPZczXpjHC1Jkpq61ersOBwodcuqWLv/j9mNmNkjF37QWvRPN4g8cq1seqMfadDscnz7qIwgUWDfB2oQMwIySEkm1/UOcgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970828; c=relaxed/simple;
	bh=j07lK2sSsTIWJ0bT1oCieVT08yYLfc0chnarUqZq9mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZQfXFhNndfd4aNrGR64Lp1dIgM5JW0dCxO9hq9B1njC+ERRT/Am3vxLx2wTYOZK6krWcQLQgzpmMCM2Jc4jTmr2j1wqNF3KwV52T/IrY1La/5sryrz7sdNhhKSjm+kBtuTt6mnWMwjdSeMMELXZgFoeCfItLfjQlr31eEavr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgyEDe6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgyEDe6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F39C4CEEB;
	Tue, 29 Apr 2025 23:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970828;
	bh=j07lK2sSsTIWJ0bT1oCieVT08yYLfc0chnarUqZq9mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgyEDe6C6tQrKhXgUfEl3DCT2hrb/4e4x1GORIoFmfbfZFj+XNLtkV9/IHHvifN1u
	 sSrfykV9tddAxurZe9H/vO/5l0N0zUHrwhc7Oagj9O73SklnDkO6BYCt1eTcq/EaBl
	 o0aituqkQTHNbiazh8AMqI/0c1+C2zLNkMyPLnoJ53yOi6INtcN40yKaAZQ0Wriull
	 j1b4hqaaoDl5CMUvPz9qQ7ZqtD3lqnUbcqGuOTEeIsS9bQiCCIzXvSdpex4Y6U3Al+
	 fwJfqbJoqAPo4oJKMeB+nkmH8FQvVXC2OCnOyRsnlFcjRbFFa4LR2w7xPvtNqCKPcE
	 i9lpNRCo8Biqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 3/7] dma-mapping: avoid potential unused data compilation warning
Date: Tue, 29 Apr 2025 19:53:34 -0400
Message-Id: <20250429235339.538269-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235339.538269-1-sashal@kernel.org>
References: <20250429235339.538269-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit c9b19ea63036fc537a69265acea1b18dabd1cbd3 ]

When CONFIG_NEED_DMA_MAP_STATE is not defined, dma-mapping clients might
report unused data compilation warnings for dma_unmap_*() calls
arguments. Redefine macros for those calls to let compiler to notice that
it is okay when the provided arguments are not used.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250415075659.428549-1-m.szyprowski@samsung.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dma-mapping.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index fe3849434b2a2..d7b91f82b0dce 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -595,10 +595,14 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
+#define dma_unmap_len(PTR, LEN_NAME)             \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
 #endif
 
 #endif /* _LINUX_DMA_MAPPING_H */
-- 
2.39.5

