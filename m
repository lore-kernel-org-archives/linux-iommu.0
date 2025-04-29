Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F53296FC5;
	Tue, 29 Apr 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970715; cv=none; b=sUdkNrypSIjOMcvFDt0ZijWgvE60V4UFplIKlcrpUJtwb3OwQewd0Y+b92pAM26R6t60AJjaoykSp8TuJDtSPXCWbAYCcbgnyLENJ4qv5yu1gCYNrQU6lNDoqbZI/lFIsoe01OjnLGZoLDuOzUsNnj7x38UAI4ZSMe9U+vk0rmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970715; c=relaxed/simple;
	bh=UXHGnVxGYFoKCRYp/YPA1ZcNzQmy0SWBIp7O0KSaN3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+P842+VDJNnRIjfPN57dW7sdC3ikuKNsoxG6HE/mhAzFjttCKLs0/Qvr0KOOQprdQkcB7MhwF8dfJWi8/4gOjNAv3G/ZVWaI0HIOiBcZL7qPq797RvgWsoBALS5sfF9gyWE13NCfRv4Xr8jinLK4uzHOrsvqsMmX3jJkH0oiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaqZIuvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaqZIuvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A2C4CEED;
	Tue, 29 Apr 2025 23:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970715;
	bh=UXHGnVxGYFoKCRYp/YPA1ZcNzQmy0SWBIp7O0KSaN3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaqZIuvHVDzr7vCB0YbyY8vkA+06Gj8qBK6+kuS8lUU8gdjQW7b4wLils77gZz16E
	 3K2LW3J91ttMu2WwHy110u9PCcYLgVEKw4E6+rIBGDToD5DbavXSvV6veigEZZ7CVs
	 dwVJSQfzTIg2pJPkzTk8K/37qrYO+omu98lj2UI1y/xkYk4u3wqxxi4M/RkLeCjOW4
	 qH2pCe7MoSZlSCd7SC2ftsCKiQm8seniqABXaLTra2H9G6+iqhtzNhRo+H62Te6hTX
	 rX3T6hbIfB+siL6r+lcPFLpyGClMVqvwWMDowHuwnNvp+6DCeIt2RnAUbgCg31w46k
	 WoB77URQWSlgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 17/37] dma-mapping: avoid potential unused data compilation warning
Date: Tue, 29 Apr 2025 19:51:02 -0400
Message-Id: <20250429235122.537321-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
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
index 1524da363734a..22b9099927fad 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -633,10 +633,14 @@ static inline int dma_mmap_wc(struct device *dev,
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

