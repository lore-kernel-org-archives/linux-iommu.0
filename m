Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC01EA66
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 11:41:00 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4910D16C948;
	Wed, 13 Sep 2023 13:40:58 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1694605258; bh=fDWYLZeBVPE3npmnjbfNLHr443yf2rmfhZ/PTRyKFM4=;
	h=From:To:Cc:Subject:Date:From;
	b=ropWT1y2V2EQ84W2/uFY7BqKyVhtxmSUAUf7ab8/Ycampu0oCXTWoo82ctzYORx4i
	 hKf8neARCNvZIRIB0Qim/zo2oHegc0Firfu7K11hLCauq77UotY76yKf/vBunI4SHJ
	 m7CkAhRHNZIwwj7gTdzUDuO1r/JSmMJVSiwHTUCegK5Go5jO9iz7PtcF42Z2Z3h+UD
	 /sVzWqNpyZkekOv07HC+KwhmnenU91C88st4KZSlMfN31prIno6lrGHDPRJxTZA0Kv
	 ntOd4vj432w/2gKUe+lofQC11fQRMGqAhnEg1sZW4y+lbaokbCiQDR1wrJqvQ+bnIL
	 aRekgSUwY7K3w==
From: Petr Tesarik <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] swiotlb: fix the check whether a device has used software IO TLB
Date: Wed, 13 Sep 2023 13:40:16 +0200
Message-ID: <20230913114016.17752-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_SWIOTLB_DYNAMIC=y, devices which do not use the software IO TLB
can avoid swiotlb lookup. A flag is added by commit 1395706a1490 ("swiotlb:
search the software IO TLB only if the device makes use of it"), the flag
is correctly set, but it is then never checked. Add the actual check here.

Note that this code is an alternative to the default pool check, not an
additional check, because:

1. swiotlb_find_pool() also searches the default pool;
2. if dma_uses_io_tlb is false, the default swiotlb pool is not used.

Tested in a KVM guest against a QEMU RAM-backed SATA disk over virtio and
*not* using software IO TLB, this patch increases IOPS by something between
2% and 3%.

Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
Reported-by: Jonathan Corbet <corbet@lwn.net>
Closes: https://lore.kernel.org/linux-iommu/87a5uz3ob8.fsf@meer.lwn.net/
Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 include/linux/swiotlb.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b4536626f8ff..c94f7f205174 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -172,14 +172,16 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 	if (!mem)
 		return false;
 
-	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
-		/* Pairs with smp_wmb() in swiotlb_find_slots() and
-		 * swiotlb_dyn_alloc(), which modify the RCU lists.
-		 */
-		smp_rmb();
-		return swiotlb_find_pool(dev, paddr);
-	}
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	/* Pairs with smp_wmb() in swiotlb_find_slots() and
+	 * swiotlb_dyn_alloc(), which modify the RCU lists.
+	 */
+	smp_rmb();
+	return READ_ONCE(dev->dma_uses_io_tlb) &&
+		swiotlb_find_pool(dev, paddr);
+#else
 	return paddr >= mem->defpool.start && paddr < mem->defpool.end;
+#endif
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
-- 
2.42.0

