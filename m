Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855512DBB39;
	Tue, 29 Apr 2025 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970843; cv=none; b=b9O85+/3nyZWdqlCzggY+xWeHZ87Cr9RxphXH1aiucK7zg0oOcfn+NyrFxQjLw7nnVP0MsrFCCezH6CpWAiBzgROExxr9Yl6v49lbrttoeZ1U0Nk+DEsapeVzDHjsqseq0WCBW4X5mmuskluBPmo9tKq3mz0KU3RHPgWAxjPecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970843; c=relaxed/simple;
	bh=JT9FHFhUBQprzW3z2LM/M86e83u7FHmu2wCMTvXPADU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSCT6PyFPQyak/qyslp09uYNvYNPVDm/DngHUD2XOnct9MWwZ0l8nf696ZQ795aJEMtwa6cJJH2Qw9J7pJ8/KO6KH2+NLSrVRE0zg/L59RZaYsoS1xQWs0D0k7Oz1ttAHlagT0Je6n0YhJo8ClYN5aUqV6/dW1Wx6VIdgkVX/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiZ8XxpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiZ8XxpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866EFC4CEEB;
	Tue, 29 Apr 2025 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970843;
	bh=JT9FHFhUBQprzW3z2LM/M86e83u7FHmu2wCMTvXPADU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiZ8XxpWlqb+tsr55TF94dZoSwv9hHFHH/HHLb+svUXK6U3fAhIeSVyorWSvo19qg
	 VTLyb8OKCmuXdxR10XWZ6vifL7hF1XfXKgZEgV34SipvSTxoJ9lq/+9HN4u8NRKMLi
	 GEPvKOnO7DKmM7XEcpYpqkBJlQrQ/NJHMk9KVsUdS+QGHXsnrJAURj5hUW+6N7qUFd
	 vFUGV86Awy42ZC6g2gPeFI7rtPHhHd0v+EFR0uqrnNlA03V10s+vhkkySVzWWYNH8R
	 Ra7OBZbpU2kqHJkVk4xzylfRqdsbxO6zlOtRwKdhsabe9EnaZFmxjh1+XzQZYjOcg2
	 fD6gkpsEz3H5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 2/3] dma-mapping: avoid potential unused data compilation warning
Date: Tue, 29 Apr 2025 19:53:54 -0400
Message-Id: <20250429235356.538413-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235356.538413-1-sashal@kernel.org>
References: <20250429235356.538413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
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
index a7d70cdee25e3..fb48f8ba5dcc8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -568,10 +568,14 @@ static inline int dma_mmap_wc(struct device *dev,
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
 
 /*
-- 
2.39.5

