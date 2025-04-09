Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D925EFB7;
	Wed,  9 Apr 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201487; cv=none; b=c0qtrVvg6q2lwxOpGajqG4LpEPKGasmyVWP7EifNNqmJPVawBAKA10sUtRlbv5f6BoaeeQLsAr6PpJP6kkZPd5O0nsmq00xadvRcuYmLCAbGjoZ7P+Z+xyFj5zwqyf+61NjAE+JRWyV21gUIVku4ptqP/NZwvJGpVUJGvES3hG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201487; c=relaxed/simple;
	bh=gKOUxkKLX+QW85WUwBRHIly4682PP17G9hudfw+8rYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3/tDJnF2tBGyH/wAjJH1IR/vmtNztf92246nT6UUoqJY39dtIouZDlsc9tNplE4ogWXMYhrbm/HFfR62J9ZQCwO3ApI+rJMaLD9wg3yxdEJtbVBz38VOIeI6MV+H2wgx+Sp6FKLnMp8GgE/u50iKXUpAPCpQQFlvNcTL9L1BJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQH5Sf+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQH5Sf+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7561C4CEE3;
	Wed,  9 Apr 2025 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744201487;
	bh=gKOUxkKLX+QW85WUwBRHIly4682PP17G9hudfw+8rYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQH5Sf+mYGy0LAtvTWB2twncUXyuaeEHDOcyHHnNnYHSlBwZIkZ+5MLmHBfwZwIQD
	 o01MT6ntmMPcLpXTut7gNNaUtG1PEo/Dg2Py2DRH2XpxeC2XXD3ztxnmpRAyHeKsQ+
	 iI+asYGYEsIJn3d3tNHvWZCOTgMwXzCXpEsiJjgCH+T9m5f/WL7PhHuGTJOl22CI31
	 50wfyMLmzv/aeEFy1aalbI8+SAB0vvrnzl/3otYpbrEGvmvDDj5ycEflA6otA8bFXr
	 Olsko/idvG0GE3Mxk0PyIAyqbVfmVkZS+qsgTzENIIwwcvBJ25Gin26swajhm67ix+
	 Qk9iBHFbGCKmw==
From: Arnd Bergmann <arnd@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] [RESEND 3] dma/contiguous: avoid warning about unused size_bytes
Date: Wed,  9 Apr 2025 14:24:33 +0200
Message-Id: <20250409122441.2875424-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250409122131.2766719-1-arnd@kernel.org>
References: <20250409122131.2766719-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with W=1, this variable is unused for configs with
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y:

kernel/dma/contiguous.c:67:26: error: 'size_bytes' defined but not used [-Werror=unused-const-variable=]

Change this to a macro to avoid the warning.

Fixes: c64be2bb1c6e ("drivers: add Contiguous Memory Allocator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: use a macro instead of constant
v2: fix spelling mistake.
---
 kernel/dma/contiguous.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..88888f4c1c73 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -64,8 +64,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
-	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+#define size_bytes (CMA_SIZE_MBYTES * SZ_1M)
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
-- 
2.39.5

