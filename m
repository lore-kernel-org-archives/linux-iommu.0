Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFE20125A
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733998; cv=none; b=vCsESFaDXixp/H14cX5IzGjxqHk6OO0eDQkJZCEDUrLzgBHmQJknkDOJ7bmBcmKHzm68R1hx2NOKjqyOKZyjuIR+j75I0XmDilAHzYyRZpu0G0ZuSkZ7qhQgcQnIKq92iesHAyi61O84dfNSm4HdrpMz2qWfMMV96UaKEJzpPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733998; c=relaxed/simple;
	bh=Q9lD0FFdsE2KuX9EExX2wAlkFfqAIiMM16sS73q7On4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4t6IGbhgIODYoqaCvb7GuJz9lq+lGeRW6Uq+jcIMUkoMUI+yp4eD2KPV9mAT/kUQEZ2T7qgmZFDt8M4jNbUKfIXFBxqauSXngrlJ5FUE7L8bysjKOSmKVncsFVyTnyFCRMHVFk52LQ9knHNQYBIpo0NStXvyyzyHhp6GMaYxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Z6mYFFjA; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Z6mYFFjA"
Received: from fpc.intra.ispras.ru (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id EDCD2518E76F;
	Wed, 27 Nov 2024 18:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EDCD2518E76F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1732733992;
	bh=IbWtycDxvF+2Dy4hwBe4BTV3k5eyFHoRBLH861A4gOI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z6mYFFjAn6JgbSPD5vF9Vm0kclH6Et4l/3KZmgaE7c7JVyqPY0YIPQtlTJn8wpS8D
	 bukRG+IeNWgKspQ/zepNoe3iv7PR1vfotYqd/KG15qx7I0xBkRhcMllYWO2UQdF6jc
	 2NiyBgbhYUPhbKBDy8WUdwdDSTue8A923iKGjZPs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] dma-debug: fix physical address calculation for struct dma_debug_entry
Date: Wed, 27 Nov 2024 21:59:26 +0300
Message-Id: <20241127185926.168102-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offset into the page should also be considered while calculating a physical
address for struct dma_debug_entry. page_to_phys() just shifts the value
PAGE_SHIFT bits to the left so offset part is zero-filled.

An example (wrong) debug assertion failure with CONFIG_DMA_API_DEBUG
enabled which is observed during systemd boot process after recent
dma-debug changes:

DMA-API: e1000 0000:00:03.0: cacheline tracking EEXIST, overlapping mappings aren't supported
WARNING: CPU: 4 PID: 941 at kernel/dma/debug.c:596 add_dma_entry
CPU: 4 UID: 0 PID: 941 Comm: ip Not tainted 6.12.0+ #288
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:add_dma_entry kernel/dma/debug.c:596 
Call Trace:
 <TASK>
debug_dma_map_page kernel/dma/debug.c:1236 
dma_map_page_attrs kernel/dma/mapping.c:179
e1000_alloc_rx_buffers drivers/net/ethernet/intel/e1000/e1000_main.c:4616
...

Found by Linux Verification Center (linuxtesting.org).

Fixes: 9d4f645a1fd4 ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 295396226f31..27ade2bab531 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1219,7 +1219,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 
 	entry->dev       = dev;
 	entry->type      = dma_debug_single;
-	entry->paddr	 = page_to_phys(page);
+	entry->paddr	 = page_to_phys(page) + offset;
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
@@ -1400,7 +1400,8 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
 	entry->paddr	 = page_to_phys((is_vmalloc_addr(virt) ?
-				vmalloc_to_page(virt) : virt_to_page(virt)));
+				vmalloc_to_page(virt) : virt_to_page(virt))) +
+				offset_in_page(virt);
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
@@ -1424,7 +1425,8 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 		return;
 
 	ref.paddr = page_to_phys((is_vmalloc_addr(virt) ?
-			vmalloc_to_page(virt) : virt_to_page(virt)));
+			vmalloc_to_page(virt) : virt_to_page(virt))) +
+			offset_in_page(virt);
 
 	if (unlikely(dma_debug_disabled()))
 		return;
-- 
2.39.5

