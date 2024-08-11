Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBC1C6B2
	for <iommu@lists.linux.dev>; Sun, 11 Aug 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723360191; cv=none; b=Tx1VMY8xghdD7RTLOqDyL9WTEDtAd21O5HZO4TGeAo8tg//3RuznnkDpX5q/W/4nEbwX+PjcVKrH6ca/o7fvheUMrk32h/Sz97xpUaBsT+mT30mCejZFr3Qt5Qa+0gKo6UB4CVylaQv+U6oloWoY26fTEfzhQkMxhV+qjzni0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723360191; c=relaxed/simple;
	bh=pqfXeuMc5R7Cx8Hid5iZqoJG0UKfN0CUSBnJMj912kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKSxGNHLG0Y+mKQSCm43F1mMAZ1ZJxuNvRd/fZm8vxPP/1TQLgcg9zch1qij5mXOHpoI1wCM7ndYnpWwUV+Z0wghmH81zG9WPg97j9JA8+SM5jLv1k5hrQnMkPMPbyOLKaw1GvgmZuJ+JmaAkuQvdyplNYvJ0o2EHXYRE6Kvbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=pBEfRS8x; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="pBEfRS8x"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 6A446440F3B;
	Sun, 11 Aug 2024 10:08:14 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1723360094;
	bh=pqfXeuMc5R7Cx8Hid5iZqoJG0UKfN0CUSBnJMj912kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBEfRS8xozYVHxDal+gom0LyLB920TA7DI9cqTsHU5ILxbyt7u+dY4RfcEY+4/wyF
	 7LwF366blZnFauh86x/n2HR0tjQXkXbk9qevQKPEw1caWQU1UjaMMd5gCnZPXTM8Z9
	 WO95iZM1puJh1BcslCTIUO8hQBhxLfHG3RShfPqIBSMCByHsfYdY9W4KLkqYNTOV9I
	 da2LavlA/IfDoVBclyGoAd2u/hHA4hL78QJ2P5v/eyzStSkarZ0El3yT7gI9wmeu8L
	 Fs2fGP8eyR0NwvmNEGA5c/GPKb+GBC6LWa1tFFyv0Ui0w3q8PHxJ4SY1RF9P4IBJwT
	 UFNNHeOE/rw/g==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH v6 RESED 2/2] arm64: support DMA zone above 4GB
Date: Sun, 11 Aug 2024 10:09:36 +0300
Message-ID: <70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723359916.git.baruch@tkos.co.il>
References: <cover.1723359916.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
max_zone_phys() calculation") made arm64 DMA/DMA32 zones span the entire
RAM when RAM starts above 32-bits. This breaks hardware with DMA area
that start above 32-bits. But the commit log says that "we haven't
noticed any such hardware". It turns out that such hardware does exist.

One such platform has RAM starting at 32GB with an internal bus that has
the following DMA limits:

  #address-cells = <2>;
  #size-cells = <2>;
  dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;

That is, devices under this bus see 1GB of DMA range between 3GB-4GB in
their address space. This range is mapped to CPU memory at 32GB-33GB.
With current code DMA allocations for devices under this bus are not
limited to DMA area, leading to run-time allocation failure.

This commit reinstates DMA zone at the bottom of RAM. The result is DMA
zone that properly reflects the hardware constraints as follows:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[baruch: split off the original patch]
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/mm/init.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c45e2152ca9e..bfb10969cbf0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -114,20 +114,8 @@ static void __init arch_reserve_crashkernel(void)
 				    low_size, high);
 }
 
-/*
- * Return the maximum physical address for a zone given its limit.
- * If DRAM starts above 32-bit, expand the zone to the maximum
- * available memory, otherwise cap it at 32-bit.
- */
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
-	phys_addr_t phys_start = memblock_start_of_DRAM();
-
-	if (phys_start > U32_MAX)
-		zone_limit = PHYS_ADDR_MAX;
-	else if (phys_start > zone_limit)
-		zone_limit = U32_MAX;
-
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
-- 
2.43.0

