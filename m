Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B173B29D
	for <iommu@lists.linux.dev>; Sun,  1 Sep 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725171229; cv=none; b=V6chXUgo+swRPQcY5ciXNJs01PbstllyzjGZrQL4PAnI9aKPyewDAcWWvVX/r8iUso4In6rmYvvC2QRuxaRYR/M6JhcsBRCRqwLeTY0NMbhQKRPVk9oxkcybGf8siQwUppIV0MOL+JN2G1khXJ5wCrMTZNp3t1bg955Xx79nIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725171229; c=relaxed/simple;
	bh=+DqHJLaU8lg/UL16LyVK5wZi9kSTSpPxP7netN7Dp68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GG+iC1MaId51uv/QtDDoqZU4B4xGaH5sWZM+3y3IPspRW01W1Tgvzl3S0hdz31CySjsCs4npcG/Lrm9EKe+9LzpoAlyUyfcZTQZheY6YLdRs0wndQ0QTgc4iLZ8S3iqAmDwcjCHSxosgTPnIeVqGA4oCrr/OAx8Nx9jrpblm/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=OcRDoQS5; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="OcRDoQS5"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id C33AC440EEB;
	Sun,  1 Sep 2024 09:11:38 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1725171098;
	bh=+DqHJLaU8lg/UL16LyVK5wZi9kSTSpPxP7netN7Dp68=;
	h=From:To:Cc:Subject:Date:From;
	b=OcRDoQS5mVjG4ysRzK4YEfknFkK2D9dh1xqQbkXWdKPEc1vi0rYyWY1Bsxkfs4o5T
	 N9QVSq9zsXwBkHFkjyG2dKzUIZrlVl9A8h8KU0n5LajdCxKMjQNEUuNneUde1cFYCl
	 A2U0vvzExlwAEbW5Pxby1oss1kTQvhPx/3wei+RaLawmaBrRXUh4+R50eg53NwsgoN
	 jbl0FTOB06OpHYtJaVKdyxC9xw9LrnYy/nYP91dU1t9DiQ+cLhAo78o4YHnciuSb0Q
	 tFRWNXtl/RVrMgJtSEAyP/yWpQAOO95rD5dCUWxRCM6W8UQKgnMZvf7pFkhxksiHQ7
	 P1BM/wpZOPvKg==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] arm64: mm: keep low RAM dma zone
Date: Sun,  1 Sep 2024 09:12:34 +0300
Message-ID: <3cc8abdb1d6a2d882d16dc2b9890df3ce2117d0d.1725171154.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
zone_dma_limit") optimistically assumed that device-tree dma-ranges
property describes the system DMA limits. That assumption ignores DMA
limits of individual devices that are not encoded in device tree.

Commit 833bd284a45 ("arm64: mm: fix DMA zone when dma-ranges is
missing") fixed part of the problem for platforms that do not provide
dma-ranges at all. However platforms like SM8550-HDK provide DMA bus
limit, but have devices with stronger DMA limits.
of_dma_get_max_cpu_address() does not take device limitations into
account.

These platforms implicitly rely on DMA zone in low 32-bit RAM area.
Until we find a better way to figure out the optimal DMA zone range,
restore the low RAM DMA zone we had before commit ba0fb44aed47.

Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Closes: https://lore.kernel.org/r/1a0c7282-63e0-4add-8e38-3abe3e0a8e2f@linaro.org
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/mm/init.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5710129b8033..eb76ac6d87c0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -116,8 +116,14 @@ static void __init arch_reserve_crashkernel(void)
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
-	if (zone_limit == PHYS_ADDR_MAX)
-		zone_limit = U32_MAX;
+	/**
+	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
+	 * bus constraints. Devices using DMA might have their own limitations.
+	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
+	 * DMA zone on platforms that have RAM there.
+	 */
+	if (memblock_start_of_DRAM() < U32_MAX)
+		zone_limit = min(zone_limit, U32_MAX);
 
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
-- 
2.45.2

