Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847725E476;
	Wed,  9 Apr 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211767; cv=none; b=pnck+Lb427/MIsOheCJKjl/EgOXEJ5fGBC+X8ARQZ7VghF6Pn2DmcOGJN8Rk8RYvXxp9I7bdIimIZfCX/fLO4kwb6zwK2lG92wIVbQ99Uv/aZ58mRo2cbxW/TbkI4HNK/kjG5RGCKwgLY4mh04YBSsiOXAgiFMvMi9UiZyLe2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211767; c=relaxed/simple;
	bh=DKKmY2V8mvcFiDPGL8AqRokOoZks78KJFsmlJwP4lzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4sdgLScvDQV/AdX4lEE3aK9banfuT9R08Pz8P4oSuAo7u/ybSoFRTQNxzxpQ+HQKY6+Le0RSvYXLpiWGnehuCZ3uxN3K9kz1IVQ6cffsSQpZrLkEy9Q62OtLj/heMTYUP6GL3GeD0J3hTuAd1rM5zOdPptXSjEeaXYsx39ZOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prwWxa2j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prwWxa2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09C6C4CEE2;
	Wed,  9 Apr 2025 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211766;
	bh=DKKmY2V8mvcFiDPGL8AqRokOoZks78KJFsmlJwP4lzg=;
	h=From:To:Cc:Subject:Date:From;
	b=prwWxa2jeOysxWDkTt9VgGDKrkB1xLCe7tUzVro3a+2ivcoJyEDhBTgRYCedqGMsY
	 /CnEI4jUGLnsV2TUkK1rNK4WNfYFQL2Mrb2hjpNCPEZZhF0m63BxJ4bw0iQHA9ecu0
	 dHqsT1XpHVXFKNcLllHD+vC0a49v0hEnXLZdOVx0I7Cv4JTuhABuLEtTP7ae8lo7Fx
	 5pyziH8b5DwUFkkwc4mydVA5KBBFHZoLIdz6VTjVzH18YcXdQA+ymIMi4VuRNegXdJ
	 yAAjcNfasD7pqptxmXs6q7Cw5I3Rgkn7MRdgP4JPm9xKa1VNxyS1ZL3MeDpo+ym9dW
	 0jd0DHZdZbkXw==
From: Arnd Bergmann <arnd@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v4] dma/contiguous: avoid warning about unused size_bytes
Date: Wed,  9 Apr 2025 17:15:42 +0200
Message-Id: <20250409151557.3890443-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
v4: fix type mistake from v3
v3: use a macro instead of constant
v2: fix spelling mistake.
---
 kernel/dma/contiguous.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..8df0dfaaca18 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -64,8 +64,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
-	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+#define size_bytes ((phys_addr_t)CMA_SIZE_MBYTES * SZ_1M)
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
-- 
2.39.5

