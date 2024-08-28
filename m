Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24715E5C8
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838724; cv=none; b=l0MKp5QloIrAI7D8r2vIruRf54oGhcpewiPlA8m/hKrgO/nrB62PThXkxBJaEAjqe+Lhrftk61hCRxovUlsl6M9EkkbFtpIUn84zHr0fW1f39wdIlNzSgyRdst+xGsS7k4y17S+sH/LRdNfmEpk0M8lJUxs4/m0HPguGOYd2dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838724; c=relaxed/simple;
	bh=CkIxrkLCCGkoStR7ogXz+1oYN4x3zeBo4yxb898ywa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMZL21ZE445u/yHP7ln32rJfgK263W8aUtBfEWdVGhohvIJU7tNH1hIOw9TCq9wdDL3pDVF+Fi0ngzFH0PuSAPrR+B+vFPi/ivv0drvbTFAhONjj/vJiD2wv2qKrYR+07F565Wa/9EiWMbXSb7A/3fYgqvN7n69MarNBkY60j7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=xyJwhkBu; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="xyJwhkBu"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 54713440F93;
	Wed, 28 Aug 2024 12:49:59 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1724838599;
	bh=CkIxrkLCCGkoStR7ogXz+1oYN4x3zeBo4yxb898ywa8=;
	h=From:To:Cc:Subject:Date:From;
	b=xyJwhkBumQtVPuky9qrM2RlOpE96CTV3GKGLzpr/pJjszRvzaiaorfoHBAEVjk5AC
	 Y+UBUU4dHM1l2KN+5+EqNPAOsIdo0WmFhISu5ELDUKdxuqFiIEJxgAj3/8OqIbkc1A
	 i5Kb28hXJTu0MIJf7uC8D/LBWEiZo/hw1u9gaR98KAlbvb+DTYcHnxtMDp9R5cj/R3
	 JmxAMlPxVw6RKc3K21FAfHiRLCea697ExJTOyqgmu3qH5xxFqumgLVWqji74YH9Yz/
	 27r3T4M5o1l5x7Hd3bwaySlNGm3wa9bYyUKtotc8n7vNC2MLxHQk3FV8o6h/M67oFr
	 6Ze/90xzLzgIg==
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
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2] arm64: mm: fix DMA zone when dma-ranges is missing
Date: Wed, 28 Aug 2024 12:51:24 +0300
Message-ID: <d8e92b14181fc815773ac4f4bba70b5d48bc390e.1724838684.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms, like Rockchip RK3568 based Odroid M1, do not provide DMA
limits information in device-tree dma-ranges property. Still some device
drivers set DMA limit that relies on DMA zone at low 4GB memory area.
Until commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
zone_dma_limit"), zone_sizes_init() restricted DMA zone to low 32-bit.

Restore DMA zone 32-bit limit when the platform provides no DMA bus
limit information.

Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/53d988b1-bdce-422a-ae4e-158f305ad703@samsung.com
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
This should go via the dma-mapping tree that contains the fixed commit.

Marek, can you test on Odroid M1? Thanks.

v2:

  * Directly check whether platform provides DMA bus limit (Robin)

  * Add Link tag
---
 arch/arm64/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bfb10969cbf0..5710129b8033 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
+	if (zone_limit == PHYS_ADDR_MAX)
+		zone_limit = U32_MAX;
+
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
-- 
2.45.2

