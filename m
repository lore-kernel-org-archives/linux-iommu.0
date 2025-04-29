Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BD2D0AC9;
	Tue, 29 Apr 2025 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970776; cv=none; b=q2lut++TipTLVSAJ6XzdWxhtY3lNaB+zZ6N4YDpE9cFhKUESCXYrut02uTfAHxxGYjcOY+CrXOPqGjXtGbHOIk7AAZ6nDIgAvsZeIawHYRqMnkZWNUeFHNbz81bUZhBJTEllAB1pqa4PWw5XDeIwhbTTY6nLap7Uh7r+oEhABgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970776; c=relaxed/simple;
	bh=SvRORt/Po+26R8xM2JqpnmfipkjLY0SHV6edGO+4tTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFVWIeT3mJyInPjNbgSirbelWNRiXpU7RMeW1i3mr7wDMuJYjMrzAhVftZAuOpDNJd02DQv5J+HZkEURp4GHdCw4fL+fcVRqET7bmgngDu7iIduogUNH3C600ZVoAHLY58w9gkJ97xj6DsQ5R2Tzh5bNuFm3DJ2L9aGaf+P7JFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf3xNXX8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf3xNXX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4BFC4CEEB;
	Tue, 29 Apr 2025 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970776;
	bh=SvRORt/Po+26R8xM2JqpnmfipkjLY0SHV6edGO+4tTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kf3xNXX83i+4sG9YlrkidUj8hjZ5bEye4e7H4hmy/QZFPH1ZKAVAdWD2WsOPBSlwJ
	 lIeQavqGK18DMSnV65dxXb2UuhttufyTiCUMw5Fm6448fY1V7DoHS9v90CnFMtIG5y
	 szozx26EYYD94+b6ZTEZqqNeS68k83BF33JrovpvTtOi7Rw3+kWh5chH3GLY9ma10T
	 +faBI7otyTK3h5gIXiABElLLZUdmwc8XQuseJfaPRRS328iag5m+Q7w2S8Wp7Ha5CA
	 PpC0yxC5HKbs+6FEkdhpwTrfhCT4s1euBBu7VUe5rlOmq8cMy3aicE7vRt0unLNDu/
	 dvLOyWUkqbWEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 11/21] dma-mapping: avoid potential unused data compilation warning
Date: Tue, 29 Apr 2025 19:52:23 -0400
Message-Id: <20250429235233.537828-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
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
index f0ccca16a0aca..608e8296ba206 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -600,10 +600,14 @@ static inline int dma_mmap_wc(struct device *dev,
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

