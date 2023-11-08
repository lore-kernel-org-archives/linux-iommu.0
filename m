Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52467321B8
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="WYZBm2Gg"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id CA51A440F61;
	Wed,  8 Nov 2023 19:29:47 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699464587;
	bh=1yLvpECl2rEGKsiM0fBZ4N89l8tkzdS1xWi8lB8tcnY=;
	h=From:To:Cc:Subject:Date:From;
	b=WYZBm2Gg+ekQkqyy3/yQwk9KwZsuYzf7EPGZgq25AcBtEiQYIG9v79dlW0g7MFcOU
	 Hh8ySGKTW3Fx0e3dCwYbkJIkzEE4adqj/fzuCKT6GF6OWXm5uPMvAOpJtDD/+GPcv3
	 l3JXWD2sDN+i+jAFXUMtdp9R2vXm+qZ9eEzNs6WN2Gi88tDjetYxnUe7poiIGEBB6c
	 MKEPDl4oIEyrXJgKK2MLlbgsWvSW0CQgDmaorWljdQfs+XGTfY+Y+ngeQyBxp060jM
	 1UCzfy+cvy/JAkUjz81Nh1WfRBeb6B4pbjZJxgOgfyk3LPy+rok4L6pCKOXEC5OQDs
	 HnR/oqxVyIfRA==
From: Baruch Siach <baruch@tkos.co.il>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ramon Fried <ramon@neureality.ai>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH RFC] arm64: DMA zone above 4GB
Date: Wed,  8 Nov 2023 19:30:22 +0200
Message-ID: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My platform RAM starts at 32GB. It has no RAM under 4GB. zone_sizes_init()
puts the entire RAM in the DMA zone as follows:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000800000000-0x00000008bfffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty

Consider a bus with this 'dma-ranges' property:

  #address-cells = <2>;
  #size-cells = <2>;
  dma-ranges = <0x00000000 0xc0000000 0x00000008 0x00000000 0x0 0x40000000>;

Devices under this bus can see 1GB of DMA range between 3GB-4GB. This
range is mapped to CPU memory at 32GB-33GB.

Current zone_sizes_init() code considers 'dma-ranges' only when it maps
to RAM under 4GB, because zone_dma_bits is limited to 32. In this case
'dma-ranges' is ignored in practice, since DMA/DMA32 zones are both
assumed to be located under 4GB. The result is that the stmmac driver
DMA buffers allocation GFP_DMA32 flag has no effect. As a result DMA
buffer allocations fail.

The patch below is a crude workaround hack. It makes the  DMA zone
cover the 1GB memory area that is visible to stmmac DMA as follows:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
...
[    0.000000] software IO TLB: mapped [mem 0x000000083bfff000-0x000000083ffff000] (64MB)

With this hack the stmmac driver works on my platform with no
modification.

Clearly this can't be the right solutions. zone_dma_bits is now wrong for
one. It probably breaks other code as well.

Is there any better suggestion to make DMA buffer allocations work on
this hardware?

Thanks
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..5fe826ac3a5f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -136,13 +136,13 @@ static void __init zone_sizes_init(void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 	unsigned int __maybe_unused acpi_zone_dma_bits;
 	unsigned int __maybe_unused dt_zone_dma_bits;
-	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
+	phys_addr_t __maybe_unused dma32_phys_limit = DMA_BIT_MASK(32) + 1;
 
 #ifdef CONFIG_ZONE_DMA
 	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
 	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
 	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
-	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
+	arm64_dma_phys_limit = of_dma_get_max_cpu_address(NULL) + 1;
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
-- 
2.42.0

