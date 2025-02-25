Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144821ABD3;
	Tue, 25 Feb 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495360; cv=none; b=EX0oD9poMhTPdWtCe+SBvSV6eUA6CZo/YAtdoJVLGo3C/Dd8ROrxsbkO+bFCYVsTJR9qMlv3dp+MEYKSXzWq3v9FsKE38OQr4CmxfJcmk5DgkXJohgkVByVTEt4lI/0/fdXAMIhtlaHTys+AnNnqP/R2R0C4x5Imwe5xY2nuHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495360; c=relaxed/simple;
	bh=iDV8+th/bSY9p5jEqNotgzA6sD0P1WAXqJW+aq8n/08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FC0RQaPx2+aEfihXJEXD3MdLOJz8ghLAcLdrueA3PesZNLQoac23wNISA9xQW00O4UkXDrNVkNm1w6YX4jjENQ7Hsh886v8jorapag2nhIwadSGE4xJjHJlwt9fj2OC7r5/0U/RH/HI/o0RsIwuN9GdtmdOBNZAtopUgDdymGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrm5YkDU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrm5YkDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A6C4CEDD;
	Tue, 25 Feb 2025 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495359;
	bh=iDV8+th/bSY9p5jEqNotgzA6sD0P1WAXqJW+aq8n/08=;
	h=From:To:Cc:Subject:Date:From;
	b=Xrm5YkDU5NCTI29lrs5s77q1QKEQ0SJc1pvsXAP7DpIxBwgZgAvDO+VONxb4ttu7Z
	 nBj28s6rQWGIPBCqxN2JG+wRidkcJnm8qS6+RkYr4I/7OWoUuCCY2J6MDQpdmhxpgY
	 1vf+FplB+xjeyjeKSLs4ENU3B1hlQbKlHtSuuwj0mfd29UgGCmtaWF1tL5UqOi0kMT
	 cDLv30JoXB1QPmLnT4AYWpeNo0ubBxG6EdRkxMUAEbS8+KnNtG4EN1t8nQmU3xigs8
	 qNsowrW343rqu7hRVOcCxHGfysqi8dSy5OyZIKSqx85Mm8+cLX03cjwrKhT37s87tO
	 eiu5OsdOexkNA==
From: Arnd Bergmann <arnd@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] dma/congiuous: avoid warning about unused size_bytes
Date: Tue, 25 Feb 2025 15:55:43 +0100
Message-Id: <20250225145555.1163596-1-arnd@kernel.org>
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

Mark it as __maybe_unused to avoid the warning without adding more
ifdef checks to this file.

Fixes: c64be2bb1c6e ("drivers: add Contiguous Memory Allocator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix spelling mistake.
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..c53f4f633f7f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -64,7 +64,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
+static const phys_addr_t size_bytes __initconst __maybe_unused =
 	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
-- 
2.39.5

