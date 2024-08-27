Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC217BEA4
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748460; cv=none; b=bIhPdfmYEsCyKJZ4oRwIxTs9M9x2Yw2lnm1ozV+lElw/Ggam2Tsgi/sCYFd5IpoUBmD9KI9PMDeJdjIRtHl8wxey7T8IFnq4UOytCftrdJ5yFCcsTreIXU3zs9bKE3m61VafjU+J1JkHedPyu+ohScrM9y9Y/bMjIzUbyb+WkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748460; c=relaxed/simple;
	bh=izAiWkQ0QMIJvlh6hdlTFfx3RH9ZwdClVZ50FgkP8I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u29olYfmmJ6pikqe2+l1+2xVFBtSCkMseOys0Xl4tZC1Gw/BgXZbWEJtmehXogvGAdY+xpY+kZnCVS1XiqPfyVE2P9jnS7DJnkMtTN57kkUlTuOtzToojNINEFdrdBDf8AHHNporkYruENblAlR79JCKUxyrr8EQk5T6ISlfSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=orrfsr2t; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="orrfsr2t"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 8CFA1440A74;
	Tue, 27 Aug 2024 11:45:43 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1724748343;
	bh=izAiWkQ0QMIJvlh6hdlTFfx3RH9ZwdClVZ50FgkP8I8=;
	h=From:To:Cc:Subject:Date:From;
	b=orrfsr2tQ9kfounZs5tm1ACHAeuMnhfIZGNsAZEf/48xdD9q/qp/3ukiHqvD0YP0Z
	 fQOHwHdSFt2bWdZ313Q1FHuEyEJ2TmubxFoKyGPgEvnfYpc3xkctXnTlRFhdUqzVKh
	 jrKnRln4lS8hICFwUz0aGL3sV7Y8Ob3WSwC7tgHjciS1VeOrfQyFmSRFIBTXBwKy8r
	 Wl2zomJlhWteN12/ztOlBkCOWO9CXbT1gf3y5A3gnE17wnKhuxKLEWhEAm86zXCig7
	 Z6LCf6wpaQRpQi1fV87FTJuV5DFkdoc7Zii6EiAe+Ef5fQOqmD1d6eWWhnVyDQWMAC
	 5cO1OtO9Mmk8w==
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
Subject: [PATCH] arm64: mm: fix DMA zone when dma-ranges is missing
Date: Tue, 27 Aug 2024 11:44:09 +0300
Message-ID: <731d204f5f556ad61bbaf004b1d984f83c90b4f5.1724748249.git.baruch@tkos.co.il>
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
zone_dma_limit"), zone_sizes_init() restricted DMA zone to low 32-bit
when there is RAM there.

Restore DMA zone 32-bit limit for platforms that have RAM in this area.

Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
This should go via the dma-mapping tree that contains the fixed commit.
---
 arch/arm64/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bfb10969cbf0..7fcd0aaa9bb6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
+	if (memblock_start_of_DRAM() < U32_MAX)
+		zone_limit = min(zone_limit, U32_MAX);
+
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
-- 
2.45.2

