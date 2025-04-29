Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0242DC13E;
	Tue, 29 Apr 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970853; cv=none; b=k8f36QA4cewSQQYb2AMSrDER1TrnBoPRZugBeWVNfjyECJ6bsUmuVM6OBVSmOOD6KP5gEMvbukbIBKHUIDpoIWUbuvuETTsHD9ls/pwsyHR57EWLoPnBZDLLctJ8eDZhBLjaX0IK5MbP1aeboZmt8pYCiVPdTT7PMqhOSvacHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970853; c=relaxed/simple;
	bh=cdrSVJK+t/2IJ1ZnwyEjnT3o63rwsICsorcHnPWG51s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9hABkB1bttB3W9ewhkCqb5WjUYGUd2AnLttIgCgmRlNFNn9OCicOHdGRA/4/lXL0ZSk0pgxvKbM2kNATBhjWp1MeiSYGj61inLyL+ggY8IBIjVhoips68QBsE+WDAJnHsjkMfltNPIdc947IuH/XtNDb0KQifRaxRRNhK9EIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc8u/4WL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc8u/4WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2636C4CEEB;
	Tue, 29 Apr 2025 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970852;
	bh=cdrSVJK+t/2IJ1ZnwyEjnT3o63rwsICsorcHnPWG51s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc8u/4WLlX8o6NOntmEGb4UzCiRYgX4EBNIlyRdkG7onj5soGYHQpoFCA5PiPGbsx
	 /kUspEM04lh9KHzqByA40OR1vecdh0uNknQctXDInqUxqxuR1s9/hpWoGqaTKuqxT6
	 LOpok1ax96dA3xEibT5M0SMfWiuf5ZyzKds98vfIJ1i4y871nhKmqddEYMdLSpOSen
	 bC02dyR1zhYq6z7E1fn6+XVftUqcefcIVEJQWRjbtQ9efu2jc49Po+IDtb4EM8K8V9
	 gvw1bv0XZD687Uf/zKdJDlEAv4t6L6TaVligNc+aT+cN5pYKAYyVaSSQWsqSWZQdyQ
	 wUucWV2iBOuhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 2/3] dma-mapping: avoid potential unused data compilation warning
Date: Tue, 29 Apr 2025 19:54:04 -0400
Message-Id: <20250429235406.538466-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235406.538466-1-sashal@kernel.org>
References: <20250429235406.538466-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.292
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
index 87cbae4b051f1..ead09620e2138 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -895,10 +895,14 @@ static inline int dma_mmap_wc(struct device *dev,
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
 
 #endif
-- 
2.39.5

