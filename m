Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751161C2AF
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SFhtN3rZgz9yLp8
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 16:29:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.218.151])
	by APP1 (Coremail) with SMTP id LxC2BwC3D5GR1Thl3bvhAg--.19648S2;
	Wed, 25 Oct 2023 09:45:14 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH] swiotlb: Do not try to allocate a TLB bigger than MAX_ORDER pages
Date: Wed, 25 Oct 2023 10:44:25 +0200
Message-Id: <20231025084426.2739-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3D5GR1Thl3bvhAg--.19648S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF18Ar1rKF43Ary8Grg_yoW8XF13pa
	4fZayrKayYqFyIyryDC3ykCFy5Kw4v9rW3WFZ5Wrn3Zr1qqayrCas7KrWaqFWaqrWkGFW5
	tFZ0qFyYqw1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hNVDUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

When allocating a new pool at runtime, reduce the number of slabs so that
the allocation order is at most MAX_ORDER. This avoids a kernel WARNING in
__alloc_pages().

The warning is relatively benign, because the pool size is subsequently
reduced when allocation fails, but it is silly to start with a request that
is known to fail, especially since this is the default behavior if the
kernel is built with CONFIG_SWIOTLB_DYNAMIC=y and booted without any
swiotlb= parameter.

Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/netdev/4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com/
Fixes: 1aaa736815eb ("swiotlb: allocate a new memory pool when existing pools are full")
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 01637677736f..dff067bd56b1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -678,6 +678,11 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	size_t pool_size;
 	size_t tlb_size;
 
+	if (nslabs > SLABS_PER_PAGE << MAX_ORDER) {
+		nslabs = SLABS_PER_PAGE << MAX_ORDER;
+		nareas = limit_nareas(nareas, nslabs);
+	}
+
 	pool_size = sizeof(*pool) + array_size(sizeof(*pool->areas), nareas);
 	pool = kzalloc(pool_size, gfp);
 	if (!pool)
-- 
2.42.0

