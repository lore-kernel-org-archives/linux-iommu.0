Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AA216E1B
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438228; cv=none; b=LWPiD3iyJSAwKU2nty8wup7oKNNHO9gdQJJEFpjLvypLmPP8YfLRsmB0hYRNvv2dIKHUhPGnMbStFBDEcU2s0TLQusVU084Z9QeLMoUSOizOomCdNPEREwROMYc/Gp3smEUjneRF3YomGTQAjSj5VlIcDRtmOaZw6IPAbiI5lss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438228; c=relaxed/simple;
	bh=+OhzSkfo85v5F2rNZ69nrxZhMtUgUfG4tVD8lKvJN+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7cbHQhWpUigp7OQanIl67WCu68uxZwng+r+9L+CzYuZHt2yEfwl8v0XhfyZIIvfXwkDUnyFleOK5ZdwJPFnNDCpf50+a7HPBRMuosE91M3L+zjvTY/TjHIfSpEeC5aXT84vHR25N9+qfStzz/4OtuNw1AjSCjcZjSYnIFAnIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4XnwYH2jLJz4wxTM
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 19:53:39 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:78de:3cf6:79c5:d375])
	by laurent.telenet-ops.be with cmsmtp
	id butW2D00D4mJWgD01utWax; Tue, 12 Nov 2024 19:53:31 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tAw0i-006uOe-Tm;
	Tue, 12 Nov 2024 19:53:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tAw14-001tcq-Bf;
	Tue, 12 Nov 2024 19:53:30 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dma-mapping: Save base/size instead of pointer to shared DMA pool
Date: Tue, 12 Nov 2024 19:53:22 +0100
Message-ID: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241112185322.vyL_Ljv72SlqdnM2tkfKr44tyVDwtNPTjzQh3oJGXCM@z>

On RZ/Five, which is non-coherent, and uses CONFIG_DMA_GLOBAL_POOL=y:

    Oops - store (or AMO) access fault [#1]
    CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc1-00015-g8a6e02d0c00e #201
    Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
    epc : __memset+0x60/0x100
     ra : __dma_alloc_from_coherent+0x150/0x17a
    epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba20
     gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d0000
     t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa0
     s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 0000000000000000
     a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 0000000000000000
     a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a8
     s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e0
     s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e8
     s8 : 0000000000000001 s9 : 0000000000000001 s10: 0000000000000010
     s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d1
     t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
    status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 0000000000000007
    [<ffffffff8062d2bc>] __memset+0x60/0x100
    [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
    [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
    [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
    [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a
    [<ffffffff803a0694>] platform_probe+0x4c/0x8a

If CONFIG_DMA_GLOBAL_POOL=y, the reserved_mem structure passed to
rmem_dma_setup() is saved for later use, by saving the passed pointer.
However, when dma_init_reserved_memory() is called later, the pointer
has become stale, causing a crash.

E.g. in the RZ/Five case, the referenced memory now contains the
reserved_mem structure for the "mmode_resv0@30000" node (with base
0x30000 and size 0x10000), instead of the correct "pma_resv0@58000000"
node (with base 0x58000000 and size 0x8000000).

Fix this by saving the needed reserved_mem structure's contents instead.

Fixes: 8a6e02d0c00e7b62 ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/dma/coherent.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77126d..3b2bdca9f1d4b027 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -330,7 +330,8 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 #include <linux/of_reserved_mem.h>
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
-static struct reserved_mem *dma_reserved_default_memory __initdata;
+static phys_addr_t dma_reserved_default_memory_base __initdata;
+static phys_addr_t dma_reserved_default_memory_size __initdata;
 #endif
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
@@ -376,9 +377,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
 	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
-		WARN(dma_reserved_default_memory,
+		WARN(dma_reserved_default_memory_size,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
-		dma_reserved_default_memory = rmem;
+		dma_reserved_default_memory_base = rmem->base;
+		dma_reserved_default_memory_size = rmem->size;
 	}
 #endif
 
@@ -391,10 +393,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 #ifdef CONFIG_DMA_GLOBAL_POOL
 static int __init dma_init_reserved_memory(void)
 {
-	if (!dma_reserved_default_memory)
+	if (!dma_reserved_default_memory_size)
 		return -ENOMEM;
-	return dma_init_global_coherent(dma_reserved_default_memory->base,
-					dma_reserved_default_memory->size);
+	return dma_init_global_coherent(dma_reserved_default_memory_base,
+					dma_reserved_default_memory_size);
 }
 core_initcall(dma_init_reserved_memory);
 #endif /* CONFIG_DMA_GLOBAL_POOL */
-- 
2.34.1

