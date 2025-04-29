Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61242D5CEF;
	Tue, 29 Apr 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970804; cv=none; b=JEits3KPn/6RFatuLPeWhQZPRgpcNkhZAtjOI7S0JVmuZawCbK6jbuZAXjg8jlAtF5EnGK1Ii195Aq3L5DB7co0GKZlqU0GE8TldBOZEq5266yk62ovEU6kYkonAdpLGny0ylyAd+G/0ELuF+hdsdEzyxyBbyUXt5k1eEMURT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970804; c=relaxed/simple;
	bh=m27ozdqFhdVmNfIPyx8z6gnhZx6NSMNS9E8ba2DZ3Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxdF+N3Bm0LFG/vjgZ+bHMJJ62Wd1XLXaITrSJWX/m3Bj5dnWq1KkNpVLL00Xkxq9JJKwGIJvvUeA9lgY+kPl6aG/WE1s/SHuSA2wLMRpV7cBDV8XJE0zDu1LQSakbV/3xRPS1jEnupcbn6rSBk5TA6xRWle6lMgnf4Tsh/Hjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuXadsgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuXadsgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D7AC4CEE3;
	Tue, 29 Apr 2025 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970804;
	bh=m27ozdqFhdVmNfIPyx8z6gnhZx6NSMNS9E8ba2DZ3Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuXadsgDZrYRB+tfE/f1tpRmL3rpmI7GgcpC1d4/CTv7sRkBbbcJFKpAiZaDRWt1F
	 WychO5jeoO/x2CHKIFZR2fhthDWYBj6UkJHFlJm5UdkbJkleeT/XLTd/LEAFX8YHo9
	 /RPyyXGflUd2+trHWp68woVxt0nFRIbNTqqkBrAoVSbNSirHU4f/LhRr65nFD2Ct7K
	 Gg+iwE9b46RpgABuxT+kyl+8wdP+21frQqECLA50Zzkn0ASkTIIEhFxV/tq1W4y8Pv
	 a9yG92IpldR1QvPe64hI8jReATIvm3br0pIG8AI4Z2kl8zHIIJvw3dcFSNejul2DL3
	 h/u3YlL0yAtGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 03/10] dma-mapping: avoid potential unused data compilation warning
Date: Tue, 29 Apr 2025 19:53:08 -0400
Message-Id: <20250429235316.538129-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235316.538129-1-sashal@kernel.org>
References: <20250429235316.538129-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.135
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
index e13050eb97771..af3f39ecc1b87 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -598,10 +598,14 @@ static inline int dma_mmap_wc(struct device *dev,
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

