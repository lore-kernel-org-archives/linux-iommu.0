Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2D154A9
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SQMYm30tKz9xrdY
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 19:00:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.195.35.156])
	by APP2 (Coremail) with SMTP id GxC2BwDX1V9HbUtlqNFEAA--.11872S2;
	Wed, 08 Nov 2023 12:13:23 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik.ext@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations with CONFIG_SWIOTLB_DYNAMIC
Date: Wed,  8 Nov 2023 12:12:49 +0100
Message-Id: <20231108111249.261-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDX1V9HbUtlqNFEAA--.11872S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF48Ar4UGw43KFW8Crg_yoW8Gw43pa
	43Aw45GayjqF18Aw1qk3WUC3W8K3yDZrW7uFZ0q343ZryDWry5WF9a93y5K3s3Xr4v9F4a
	kryFvr4rKayUZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8c_-DUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Limit the free list length to the size of the IO TLB. Transient pool can be
smaller than IO_TLB_SEGSIZE, but the free list is initialized with the
assumption that the total number of slots is a multiple of IO_TLB_SEGSIZE.
As a result, swiotlb_area_find_slots() may allocate slots past the end of
a transient IO TLB buffer.

Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Closes: https://lore.kernel.org/linux-iommu/104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com/
Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 26202274784f..ec82524ba902 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -283,7 +283,8 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 	}
 
 	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		mem->slots[i].list = min(IO_TLB_SEGSIZE - io_tlb_offset(i),
+					 mem->nslabs - i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
-- 
2.42.1

